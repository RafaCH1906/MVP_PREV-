"use client";
import Link from "next/link";
import { useParams } from "next/navigation";
import { useEffect, useState } from "react";
import { supabase } from "@/lib/supabase";
import { useAuth } from "@/lib/auth";
import { useCarga, ok } from "@/lib/hooks";
import { useReloj } from "@/lib/reloj";
import { puedeGestionar } from "@/lib/roles";
import { Cargando, Clasif } from "@/lib/ui";
import { JERARQUIA } from "@/lib/consultas";
import { alertaResidual, requiereAccionInmediata, Clasif as C, Metodologia } from "@/lib/iperc/engine";
import { crearAccionInmediata, tieneAccionInmediata } from "@/lib/iperc-db";
import EvalForm, { Factores, calcular, paraGuardar } from "@/components/EvalForm";
import AccionInmediataForm, { AccInm, Usr } from "@/components/AccionInmediataForm";

type Det = {
  id: string; codigo: string; iperc_id: string; peligro_id: string; n_expuestos: number | null; eval_inicial: Factores; eval_residual: Factores | null;
  nivel_inicial: number; clasif_inicial: C; nivel_residual: number | null; clasif_residual: C | null;
  iperc: { version: number; estado: string } | null;
  tarea: { codigo: string; nombre: string } | null; peligro: { codigo: string; peligro: string; riesgo: string; consecuencia: string } | null;
};
type Ctl = { id: string; jerarquia: string; descripcion: string; existente: boolean };
type Cat = { id: string; jerarquia: string; descripcion: string };

/** W4 · Evaluar una fila IPERC (I03). El bloque central cambia según la metodología. */
export default function EvaluarFila() {
  const { codigo } = useParams<{ codigo: string }>();
  const { perfil } = useAuth();
  const { ahora } = useReloj();
  const met = (perfil?.empresa?.metodologia ?? "MINERIA") as Metodologia;
  const [v, setV] = useState(0);
  const { datos, cargando, error } = useCarga(async () => {
    const vParam = new URLSearchParams(window.location.search).get("v");
    const filas = ok(await supabase.from("iperc_fila")
      .select("id,codigo,iperc_id,peligro_id,n_expuestos,eval_inicial,eval_residual,nivel_inicial,clasif_inicial,nivel_residual,clasif_residual,iperc:iperc_version(version,estado),tarea(codigo,nombre),peligro:peligro_catalogo(codigo,peligro,riesgo,consecuencia)")
      .eq("codigo", codigo)) as unknown as Det[];
    const f = (vParam ? filas.find((x) => x.iperc_id === vParam) : undefined) ?? [...filas].sort((a, b) => (b.iperc?.version ?? 0) - (a.iperc?.version ?? 0))[0];
    if (!f) throw new Error("Fila no encontrada");
    const c = ok(await supabase.from("control").select("id,jerarquia,descripcion,existente").eq("fila_id", f.id)) as Ctl[];
    const cat = ok(await supabase.from("control_catalogo").select("id,jerarquia,descripcion").eq("peligro_id", f.peligro_id)) as Cat[];
    const usr = ok(await supabase.from("usuario").select("id,nombre,roles").order("nombre")) as Usr[];
    const tiene = await tieneAccionInmediata(f.id);
    return { f, c, cat, usr, tiene };
  }, [codigo, perfil, v]);

  const [m, setM] = useState<Factores>({});
  const [mr, setMr] = useState<Factores | null>(null);
  const [ai, setAi] = useState<AccInm>({ descripcion: "Restringir el acceso y evaluar la labor antes de reanudar el trabajo", responsableId: "" });
  const [msg, setMsg] = useState<string | null>(null);
  useEffect(() => { if (datos) { setM({ ...datos.f.eval_inicial }); setMr(datos.f.eval_residual ? { ...datos.f.eval_residual } : null); } }, [datos]);

  if (cargando && !datos) return <Cargando />;
  if (error || !datos) return <Cargando error={error} />;
  const { f, c, cat, usr, tiene } = datos;
  const borrador = f.iperc?.estado === "BORRADOR";
  const edita = puedeGestionar(perfil) && borrador;
  const ci = Object.keys(m).length ? calcular(met, m) : { ok: true, nivel: f.nivel_inicial, clasif: f.clasif_inicial, formula: "", sevFinal: 0, signif: false };
  const cr = mr ? calcular(met, mr) : null;
  const nuevaInm = edita && ci.ok && requiereAccionInmediata(met, ci.clasif) && !tiene;
  const alerta = cr && cr.ok && ci.ok ? alertaResidual(met, ci.clasif, cr.clasif) : false;
  const verTxt = `v${f.iperc?.version}`;

  const guardar = async () => {
    setMsg(null);
    try {
      const reg = nuevaInm ? ahora.toISOString() : undefined;
      const { error: e } = await supabase.from("iperc_fila").update({
        eval_inicial: paraGuardar(met, m), nivel_inicial: ci.nivel, clasif_inicial: ci.clasif, significativo: ci.signif,
        eval_residual: mr ? paraGuardar(met, mr) : null, nivel_residual: cr?.ok ? cr.nivel : null, clasif_residual: cr?.ok ? cr.clasif : null,
        ...(reg ? { registrado_en: reg } : {}),
      }).eq("id", f.id);
      if (e) throw new Error(e.message);
      if (nuevaInm) {
        if (!ai.responsableId || !ai.descripcion) throw new Error("Indica la acción y su responsable");
        await crearAccionInmediata({ empresaId: perfil!.empresa_id, filaId: f.id, codigo: f.codigo, clasif: ci.clasif, registradoEn: ahora, descripcion: ai.descripcion, responsableId: ai.responsableId });
      }
      setMsg(nuevaInm ? "✓ Evaluación guardada y acción inmediata creada" : "✓ Evaluación guardada");
      setV(v + 1);
    } catch (e) { setMsg(`No se pudo guardar: ${(e as Error).message}`); }
  };
  const agregarCat = async (x: Cat) => {
    const { error: e } = await supabase.from("control").insert({ id: crypto.randomUUID(), empresa_id: perfil!.empresa_id, fila_id: f.id, codigo: f.codigo, jerarquia: x.jerarquia, descripcion: x.descripcion, existente: false });
    setMsg(e ? `No se pudo agregar: ${e.message}` : "✓ Control agregado"); setV(v + 1);
  };
  const propuestos = c.filter((x) => !x.existente), existentes = c.filter((x) => x.existente);
  const faltan = cat.filter((x) => !c.some((y) => y.descripcion === x.descripcion));

  return (
    <div>
      <p><Link href="/iperc" style={{ textDecoration: "underline" }}>← Matriz IPERC</Link> <small>· IPERC 2026 {verTxt} {borrador ? "(borrador)" : "(aprobada, solo lectura)"} · fila {f.codigo.replace("IPERC-", "")}</small></p>
      <div className="row">
        <div className="col" style={{ flex: 1.3 }}>
          <div className="blk"><small>Tarea</small><br /><b>{f.tarea?.codigo} · {f.tarea?.nombre}</b><br />
            <small>Peligro</small> <b>{f.peligro?.codigo} · {f.peligro?.peligro}</b><br />
            <small>Riesgo:</small> {f.peligro?.riesgo} · <small>Consecuencia:</small> {f.peligro?.consecuencia}</div>
          {existentes.length > 0 && <div className="blk"><h4>Controles existentes</h4>{existentes.map((x) => <div key={x.id} style={{ fontSize: 13 }}>{JERARQUIA[x.jerarquia]} · {x.descripcion}</div>)}</div>}
          <div className="blk"><h4>Evaluación inicial</h4>
            {Object.keys(m).length > 0 && <EvalForm met={met} m={m} onChange={setM} dis={!edita} nExpuestos={f.n_expuestos} marcaMatriz="sel" matrizOtra={cr?.ok ? { sev: cr.sevFinal, prob: String(mr?.prob) } : undefined} />}
            {nuevaInm && <AccionInmediataForm clasif={ci.clasif} usuarios={usr} value={ai} onChange={setAi} />}
            {!nuevaInm && tiene && <div className="alert" style={{ marginTop: 8 }}>Esta fila generó una <b>acción inmediata</b> (plazo desde el registro de la evaluación).</div>}
            {edita && <div><button className="btn pri" onClick={guardar}>Guardar evaluación</button></div>}
            {msg && <small>{msg}</small>}
            {!edita && <small>{borrador ? "Tu rol solo permite consultar." : "Una versión aprobada es de solo lectura: para editar, crea un borrador nuevo desde la matriz."}</small>}
          </div>
        </div>
        <div className="col">
          <div className="blk"><h4>Controles propuestos</h4>
            {propuestos.length === 0 && <small>Sin controles propuestos.</small>}
            {Object.keys(JERARQUIA).map((k) => propuestos.filter((x) => x.jerarquia === k).map((x) => <div key={x.id} style={{ fontSize: 13, margin: "3px 0" }}>{JERARQUIA[k]} · {x.descripcion}</div>))}
            {edita && faltan.length > 0 && (<><h4 style={{ marginTop: 10 }}>Sugeridos del catálogo</h4>
              {faltan.map((x) => <div key={x.id} style={{ fontSize: 13, margin: "3px 0" }}>{JERARQUIA[x.jerarquia]} · {x.descripcion} <button className="btn" onClick={() => agregarCat(x)}>Aceptar</button></div>)}</>)}
          </div>
          <div className="blk"><h4>Evaluación residual (esperada)</h4>
            {edita && !mr && <button className="btn" onClick={() => setMr({ ...m })}>Agregar evaluación residual</button>}
            {!mr && !edita && <small>Sin evaluación residual.</small>}
            {mr && <EvalForm met={met} m={mr} onChange={setMr} dis={!edita} nExpuestos={f.n_expuestos} marcaMatriz="res" matrizOtra={ci.ok ? { sev: ci.sevFinal, prob: String(m.prob) } : undefined} />}
            {mr && cr?.ok && ci.ok && (alerta
              ? <div className="warn"><b>⚠ {cr.formula} → <Clasif c={cr.clasif} /></b> · no baja de clasificación ({ci.clasif} → {cr.clasif}). Revisar los controles (RF-17).</div>
              : <div className="okb">{cr.formula} → <b>{cr.clasif}</b> · baja de clasificación ✓ ({ci.clasif} → {cr.clasif})</div>)}
          </div>
        </div>
      </div>
    </div>
  );
}
