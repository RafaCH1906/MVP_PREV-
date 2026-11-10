"use client";
import Link from "next/link";
import { useState } from "react";
import { supabase } from "@/lib/supabase";
import { useAuth } from "@/lib/auth";
import { useCarga, ok } from "@/lib/hooks";
import { useReloj } from "@/lib/reloj";
import { Cargando, Tag, fechaCorta } from "@/lib/ui";
import { Acc, Act, SEL_ACC, SEL_ACT, accVencida, actVencida, etiquetas, fechaDM, hora, origenTag } from "@/lib/consultas";
import { esLector } from "@/lib/roles";
import AlertaInmediata, { AccionInm } from "./AlertaInmediata";

type Fila = { id: string; codigo: string; nivel_inicial: number; clasif_inicial: string; significativo: boolean };
type Ver = { version: number; estado: string };
type Hito = { tipo: string; estado: string; fecha: string | null };

/** W1 · Inicio: tablero y ruta del ciclo anual (T03). */
export default function InicioSST() {
  const { perfil } = useAuth();
  const { ahora, hoy } = useReloj();
  const [fResp, setFResp] = useState("");
  const [fOrigen, setFOrigen] = useState("");
  const { datos, cargando, error } = useCarga(async () => {
    const [sedes, tareas, cum, brechas, vers, hitos, filas, acts, accs] = await Promise.all([
      supabase.from("sede").select("id", { count: "exact", head: true }),
      supabase.from("tarea").select("id", { count: "exact", head: true }),
      supabase.from("v_cumplimiento_total").select("pct").maybeSingle(),
      supabase.from("v_brecha").select("item_n", { count: "exact", head: true }),
      supabase.from("iperc_version").select("version,estado").order("version"),
      supabase.from("hito_documento").select("tipo,estado,fecha"),
      supabase.from("iperc_fila").select("id,codigo,nivel_inicial,clasif_inicial,significativo"),
      supabase.from("actividad").select(SEL_ACT),
      supabase.from("accion").select(SEL_ACC),
    ]);
    return {
      nSedes: sedes.count ?? 0, nTareas: tareas.count ?? 0,
      pct: (cum.data as { pct: number } | null)?.pct ?? null, nBrechas: brechas.count ?? 0,
      vers: ok(vers) as Ver[], hitos: ok(hitos) as Hito[], filas: ok(filas) as Fila[],
      acts: ok(acts) as unknown as Act[], accs: ok(accs) as unknown as Acc[],
    };
  }, [perfil]);

  if (cargando) return <Cargando />;
  if (error || !datos) return <Cargando error={error} />;
  const { nSedes, nTareas, pct, nBrechas, vers, hitos, filas, acts, accs } = datos;
  const lector = esLector(perfil);
  const et = etiquetas(perfil?.empresa?.metodologia);

  const accAbiertas = accs.filter((a) => !["VERIFICADA", "RECHAZADA"].includes(a.estado));
  const inmediatas: AccionInm[] = accAbiertas.filter((a) => a.inmediata).map((a) => ({
    id: a.id, descripcion: a.descripcion, vence_en: a.vence_en, estado: a.estado, responsable: a.responsable,
    fila: filas.find((f) => f.id === a.control?.fila_id) ?? null,
  }));
  const accVenc = accAbiertas.filter((a) => accVencida(a, ahora));
  const hechas = (a: Act) => ["EJECUTADA", "VERIFICADA"].includes(a.estado);
  const aLaFecha = acts.filter((a) => a.fecha_fin && a.fecha_fin <= hoy);
  const avance = aLaFecha.length ? Math.round((100 * aLaFecha.filter(hechas).length) / aLaFecha.length) : 0;
  const actVenc = acts.filter((a) => actVencida(a, hoy));
  const diasMax = actVenc.length ? Math.max(...actVenc.map((a) => Math.round((new Date(hoy).getTime() - new Date(a.fecha_fin!).getTime()) / 86400000))) : 0;
  const sig = filas.filter((f) => f.significativo);
  const sinControl = sig.filter((f) =>
    !acts.some((a) => a.control?.fila_id === f.id && hechas(a)) && !accs.some((a) => a.control?.fila_id === f.id && a.estado === "VERIFICADA")).length;

  type Reg = { k: string; tipo: "act" | "acc"; estado: string; txt: string; origen: ReturnType<typeof origenTag>; resp: string; fecha: string; orden: number };
  const regs: Reg[] = [
    ...acts.filter((a) => ["PROGRAMADA", "EN_CURSO"].includes(a.estado)).map((a): Reg => ({
      k: a.id, tipo: "act", estado: actVencida(a, hoy) ? "VENCIDA" : a.estado, txt: a.descripcion, origen: origenTag(a),
      resp: a.responsable?.nombre ?? "Sin responsable", fecha: fechaDM(a.fecha_fin), orden: a.fecha_fin ? new Date(a.fecha_fin).getTime() : 9e15,
    })),
    ...accAbiertas.map((a): Reg => ({
      k: a.id, tipo: "acc", estado: accVencida(a, ahora) ? "VENCIDA" : a.estado, txt: a.descripcion,
      origen: a.inmediata ? { txt: `Control · ${a.control?.codigo ?? ""}`, cls: "t-red", tipo: "CONTROL" } : origenTag(a),
      resp: a.responsable?.nombre ?? "—", fecha: a.inmediata ? `Hoy ${hora(a.vence_en)}` : fechaDM(a.vence_en), orden: new Date(a.vence_en).getTime(),
    })),
  ].sort((x, y) => x.orden - y.orden);
  const responsables = Array.from(new Set(regs.map((r) => r.resp)));
  const lista = regs.filter((r) => (!fResp || r.resp === fResp) && (!fOrigen || r.origen.tipo === fOrigen));

  const planHito = hitos.find((h) => h.tipo === "PLAN");
  const vApr = vers.find((v) => v.estado === "APROBADO");
  const vBor = vers.find((v) => v.estado === "BORRADOR");

  return (
    <div>
      {!lector && inmediatas.map((a) => <AlertaInmediata key={a.id} a={a} />)}
      {!lector && (
        <div className="blk"><h4>Ruta del ciclo 2026</h4>
          <div className="steps">
            <Link href="/empresa" className="step done"><div className="n">1 · Empresa y alcance ✓</div><small>{nSedes} sedes · {nTareas} tareas en alcance</small></Link>
            <Link href="/diagnostico" className="step done"><div className="n">2 · Diagnóstico ✓</div><small>{pct != null ? String(pct).replace(".", ",") : "—"} % · {nBrechas} brechas</small></Link>
            <Link href="/iperc" className="step done"><div className="n">3 · IPERC ✓</div><small>{vApr ? `v${vApr.version} aprobada` : "sin versión aprobada"}{vBor ? <> · <b>v{vBor.version} en borrador</b></> : null}</small></Link>
            <Link href="/plan" className="step done"><div className="n">4 · {et.plan} ✓</div><small>{planHito ? `${planHito.estado} ${fechaDM(planHito.fecha)}` : "pendiente"}</small></Link>
            <Link href="/seguimiento" className="step now"><div className="n">5 · Seguimiento ●</div><small>En curso · ir →</small></Link>
          </div></div>
      )}
      <div className="row">
        <div className="kpi"><small>Avance del programa</small><div className="v">{avance} %</div><small>ejecutadas / programadas a la fecha</small></div>
        <div className="kpi"><small>Actividades vencidas</small><div className={`v ${actVenc.length ? "bad" : ""}`}>{actVenc.length}</div><small>{actVenc.length ? `la más antigua, ${diasMax} días` : "ninguna"}</small></div>
        <div className="kpi"><small>Acciones abiertas</small><div className="v">{accAbiertas.length}</div><small>{inmediatas.length} inmediata · {accVenc.length} vencida</small></div>
        <div className="kpi"><small>Riesgos significativos sin control implementado</small><div className="v">{sinControl}</div><small>de {sig.length} significativos</small></div>
      </div>
      {!lector && (
        <div className="blk" style={{ marginTop: 12 }}>
          <h4>Vencido y por vencer &nbsp;
            <select className="btn" value={fResp} onChange={(e) => setFResp(e.target.value)}><option value="">Responsable ▾</option>{responsables.map((r) => <option key={r}>{r}</option>)}</select>
            <select className="btn" value={fOrigen} onChange={(e) => setFOrigen(e.target.value)}>
              <option value="">Origen ▾</option><option value="CONTROL">Control</option><option value="HALLAZGO">Hallazgo</option><option value="BASE">Base</option><option value="BRECHA">Brecha</option></select>
          </h4>
          <div className="scroll"><table className="mini">
            <thead><tr><th>Estado</th><th>Registro</th><th>Origen</th><th>Responsable</th><th>Fecha</th></tr></thead>
            <tbody>
              {lista.map((r) => (
                <tr key={r.k}>
                  <td>{r.tipo === "acc" && r.origen.cls === "t-red" ? <Tag cls="t-red">Inmediata</Tag> : <Tag estado={r.estado} />}</td>
                  <td><Link href={`/registro/${r.tipo === "act" ? "actividad" : "accion"}/${r.k}`} style={{ textDecoration: "underline" }}>{r.txt}</Link></td>
                  <td><span className={`tag ${r.origen.cls}`}>{r.origen.txt}</span></td><td>{r.resp}</td><td>{r.fecha}</td>
                </tr>
              ))}
              {lista.length === 0 && <tr><td colSpan={5}><small>Sin registros.</small></td></tr>}
            </tbody>
          </table></div>
        </div>
      )}
      <p><small>Datos de demostración construidos a partir de entrevistas; no son cifras reales. Fecha de referencia: {fechaCorta(hoy)}.</small></p>
    </div>
  );
}
