"use client";
import Link from "next/link";
import { useRouter } from "next/navigation";
import { useEffect, useState } from "react";
import { supabase } from "@/lib/supabase";
import { useAuth } from "@/lib/auth";
import { useCarga, ok } from "@/lib/hooks";
import { useReloj } from "@/lib/reloj";
import { puedeGestionar } from "@/lib/roles";
import { Cargando } from "@/lib/ui";
import { JERARQUIA, etiquetas } from "@/lib/consultas";

type Prop = {
  key: string; origen: "BRECHA" | "CONTROL" | "BASE"; desc: string; objetivo: string; fecha: string; resp: string; sel: boolean; etiqueta: string;
  brecha_item?: number; control_id?: string; plantilla_codigo?: string; nc?: boolean;
};
type Usr = { id: string; nombre: string };

const OBJ = { BRECHA: "Cerrar brechas del sistema de gestión", CONTROL: "Controlar los riesgos significativos", BASE: "Cumplir las actividades periódicas de ley" };
const sumar = (iso: string, d: number) => { const x = new Date(iso + "T12:00:00"); x.setDate(x.getDate() + d); return x.toISOString().slice(0, 10); };

/** P01 · Generar plan (vista previa): brechas + controles propuestos + actividades base, con su origen y los campos pendientes. */
export default function GenerarPlan() {
  const { perfil } = useAuth();
  const { hoy } = useReloj();
  const router = useRouter();
  const et = etiquetas(perfil?.empresa?.metodologia);
  const [filas, setFilas] = useState<Prop[] | null>(null);
  const [verP, setVerP] = useState(false);
  const [msg, setMsg] = useState<string | null>(null);
  const [guardando, setGuardando] = useState(false);

  const { datos, cargando, error } = useCarga(async () => {
    const br = ok(await supabase.from("v_brecha").select("item_n,estado,indicador,accion_sugerida").order("item_n")) as { item_n: number; estado: string; indicador: string; accion_sugerida: string | null }[];
    const act = ok(await supabase.from("actividad").select("brecha_item,plantilla_codigo,control_id")) as { brecha_item: number | null; plantilla_codigo: string | null; control_id: string | null }[];
    const filasIperc = ok(await supabase.from("iperc_fila").select("id,codigo,significativo,clasif_inicial,iperc:iperc_version(estado)")) as unknown as { id: string; codigo: string; significativo: boolean; clasif_inicial: string; iperc: { estado: string } | null }[];
    const ctl = ok(await supabase.from("control").select("id,fila_id,codigo,jerarquia,descripcion,existente")) as { id: string; fila_id: string; codigo: string | null; jerarquia: string; descripcion: string; existente: boolean }[];
    const acc = ok(await supabase.from("accion").select("control_id").not("control_id", "is", null)) as { control_id: string }[];
    const plant = ok(await supabase.from("actividad_base_plantilla").select("codigo,sector,actividad,frecuencia_por_empresa,objetivo")) as { codigo: string; sector: string; actividad: string; frecuencia_por_empresa: Record<string, string> | null; objetivo: string | null }[];
    const emp = ok(await supabase.from("empresa").select("codigo,sector").limit(1)) as { codigo: string; sector: string }[];
    const usr = ok(await supabase.from("usuario").select("id,nombre").order("nombre")) as Usr[];
    return { br, act, filasIperc, ctl, acc, plant, emp: emp[0], usr };
  }, [perfil]);

  useEffect(() => {
    if (!datos || !hoy) return;
    const { br, act, filasIperc, ctl, acc, plant, emp } = datos;
    const yaBrecha = new Set(act.map((a) => a.brecha_item).filter(Boolean));
    const yaBase = new Set(act.map((a) => a.plantilla_codigo).filter(Boolean));
    const conActividad = new Set([...act.map((a) => a.control_id), ...acc.map((a) => a.control_id)].filter(Boolean) as string[]);
    const clavesCubiertas = new Set(ctl.filter((c) => conActividad.has(c.id)).map((c) => `${c.codigo}|${c.descripcion}`));
    const sigAprob = new Map(filasIperc.filter((f) => f.significativo && f.iperc?.estado === "APROBADO").map((f) => [f.id, f]));
    const out: Prop[] = [];
    br.filter((b) => !yaBrecha.has(b.item_n)).forEach((b, i) => {
      const nc = b.estado === "NC";
      out.push({ key: `b${b.item_n}`, origen: "BRECHA", desc: b.accion_sugerida ?? b.indicador, objetivo: OBJ.BRECHA, nc, brecha_item: b.item_n,
        fecha: sumar(hoy, (nc ? 30 : 120) + (i % 6) * 15), resp: "", sel: nc, etiqueta: `Brecha · ítem ${b.item_n}${nc ? " (No cumple)" : " (Parcial)"}` });
    });
    ctl.filter((c) => !c.existente && sigAprob.has(c.fila_id) && !conActividad.has(c.id) && !clavesCubiertas.has(`${c.codigo}|${c.descripcion}`)).forEach((c, i) => {
      out.push({ key: `c${c.id}`, origen: "CONTROL", desc: c.descripcion, objetivo: OBJ.CONTROL, control_id: c.id, fecha: sumar(hoy, 30 + (i % 4) * 15), resp: "", sel: true,
        etiqueta: `Control · ${c.codigo ?? ""} (${JERARQUIA[c.jerarquia]?.replace(/^\d\. /, "") ?? c.jerarquia})` });
    });
    plant.filter((p) => !yaBase.has(p.codigo) && (p.sector === "General" || p.sector === emp.sector) && (p.frecuencia_por_empresa?.[emp.codigo] ?? "") !== "No aplica").forEach((p, i) => {
      out.push({ key: `p${p.codigo}`, origen: "BASE", desc: p.actividad, objetivo: p.objetivo || OBJ.BASE, plantilla_codigo: p.codigo, fecha: sumar(hoy, 30 + (i % 4) * 30), resp: "", sel: true, etiqueta: `Base · ${p.codigo}` });
    });
    setFilas(out);
  }, [datos, hoy]);

  if (!puedeGestionar(perfil)) return <p className="muted">Tu rol no permite generar el plan.</p>;
  if (cargando && !datos) return <Cargando />;
  if (error || !datos || !filas) return <Cargando error={error} />;

  const vis = filas.filter((f) => verP || f.origen !== "BRECHA" || f.nc);
  const sel = filas.filter((f) => f.sel);
  const pend = sel.filter((f) => !f.resp || !f.fecha).length;
  const upd = (k: string, c: Partial<Prop>) => setFilas(filas.map((f) => (f.key === k ? { ...f, ...c } : f)));
  const total = (o: string) => sel.filter((f) => f.origen === o).length;

  const generar = async () => {
    setGuardando(true); setMsg(null);
    try {
      const rows = sel.map((f) => ({
        id: crypto.randomUUID(), empresa_id: perfil!.empresa_id, objetivo: f.objetivo, origen: f.origen, control_id: f.control_id ?? null,
        plantilla_codigo: f.plantilla_codigo ?? null, brecha_item: f.brecha_item ?? null, descripcion: f.desc, responsable_id: f.resp || null, fecha_fin: f.fecha || null, estado: "PROGRAMADA",
      }));
      const r = await supabase.from("actividad").insert(rows);
      if (r.error) throw new Error(r.error.message);
      await supabase.from("hito_documento").update({ estado: "Borrador" }).eq("tipo", "PLAN");
      router.push("/plan");
    } catch (e) { setMsg(`No se pudo generar: ${(e as Error).message}`); setGuardando(false); }
  };

  return (
    <div>
      <p><Link href="/plan" style={{ textDecoration: "underline" }}>← {et.plan}</Link></p>
      <h1>Generar actividades (vista previa)</h1>
      <p className="muted">Propuesta con tres orígenes: brechas del diagnóstico, controles propuestos de la IPERC aprobada y actividades base de ley. Lo que ya está en el plan no se repite. Completa responsable y fecha antes de aprobar.</p>
      <div className="row">
        <div className="kpi"><small>Brechas</small><div className="v">{total("BRECHA")}</div></div>
        <div className="kpi"><small>Controles</small><div className="v">{total("CONTROL")}</div></div>
        <div className="kpi"><small>Base</small><div className="v">{total("BASE")}</div></div>
        <div className="kpi"><small>Pendientes (sin responsable)</small><div className={`v ${pend ? "bad" : ""}`}>{pend}</div></div>
      </div>
      <div style={{ margin: "10px 0" }}>
        <button className={`btn ${verP ? "on" : ""}`} onClick={() => setVerP(!verP)}>{verP ? "Ocultar brechas Parcial" : "Mostrar también brechas Parcial"}</button>
        <button className="btn" onClick={() => setFilas(filas.map((f) => ({ ...f, sel: vis.includes(f) })))}>Marcar visibles</button>
        <button className="btn" onClick={() => setFilas(filas.map((f) => ({ ...f, sel: false })))}>Quitar todas</button>
      </div>
      <div className="scroll"><table className="mini"><thead><tr><th></th><th>Origen</th><th>Actividad</th><th>Responsable</th><th>Fecha</th></tr></thead><tbody>
        {vis.map((f) => (
          <tr key={f.key} style={{ opacity: f.sel ? 1 : 0.5 }}>
            <td><input type="checkbox" checked={f.sel} onChange={(e) => upd(f.key, { sel: e.target.checked })} /></td>
            <td><span className={`tag ${f.origen === "CONTROL" ? "t-amb" : f.origen === "BRECHA" ? "t-acc" : ""}`}>{f.etiqueta}</span></td>
            <td>{f.desc}</td>
            <td><select className="btn" value={f.resp} style={f.sel && !f.resp ? { borderColor: "var(--amber)", background: "var(--amber-soft)" } : undefined} onChange={(e) => upd(f.key, { resp: e.target.value })}><option value="">Pendiente</option>{datos.usr.map((u) => <option key={u.id} value={u.id}>{u.nombre}</option>)}</select></td>
            <td><input type="date" className="btn" value={f.fecha} onChange={(e) => upd(f.key, { fecha: e.target.value })} /></td>
          </tr>))}
        {vis.length === 0 && <tr><td colSpan={5}><small>No hay actividades nuevas por proponer.</small></td></tr>}
      </tbody></table></div>
      <div style={{ marginTop: 10 }}>
        <button className="btn pri" disabled={sel.length === 0 || guardando} onClick={generar}>{guardando ? "Generando…" : `Agregar ${sel.length} actividades al plan`}</button>
        {msg && <p className="bad" style={{ fontSize: 13 }}>{msg}</p>}
        <p><small>Las actividades se crean como «Programada». El plan vuelve a borrador hasta que lo apruebes en la pantalla del plan.</small></p>
      </div>
    </div>
  );
}
