"use client";
import Link from "next/link";
import { useState } from "react";
import { supabase } from "@/lib/supabase";
import { useAuth } from "@/lib/auth";
import { useCarga, ok } from "@/lib/hooks";
import { useReloj } from "@/lib/reloj";
import { Cargando, Tag } from "@/lib/ui";
import { Act, SEL_ACT, actVencida, etiquetas, fechaDM, origenTag } from "@/lib/consultas";

const MESES = ["E", "F", "M", "A", "M", "J", "J", "A", "S", "O", "N", "D"];
const MESES_L = ["enero", "febrero", "marzo", "abril", "mayo", "junio", "julio", "agosto", "septiembre", "octubre", "noviembre", "diciembre"];

/** W6 · Plan anual: objetivos, origen y cronograma (P02 / P04). */
export default function Plan() {
  const { perfil } = useAuth();
  const { hoy } = useReloj();
  const et = etiquetas(perfil?.empresa?.metodologia);
  const [vista, setVista] = useState<"lista" | "cal" | "cron">("lista");
  const [fOrigen, setFOrigen] = useState(""); const [fResp, setFResp] = useState(""); const [fEstado, setFEstado] = useState("");
  const { datos, cargando, error } = useCarga(async () => {
    const acts = ok(await supabase.from("actividad").select(SEL_ACT).order("fecha_fin")) as unknown as Act[];
    const h = await supabase.from("hito_documento").select("estado,fecha").eq("tipo", "PLAN").maybeSingle();
    return { acts, hito: h.data as { estado: string; fecha: string | null } | null };
  }, [perfil]);
  if (cargando) return <Cargando />;
  if (error || !datos) return <Cargando error={error} />;
  const est = (a: Act) => (actVencida(a, hoy) ? "VENCIDA" : a.estado);
  const resps = Array.from(new Set(datos.acts.map((a) => a.responsable?.nombre ?? "Sin responsable")));
  const lista = datos.acts.filter((a) => (!fOrigen || origenTag(a).tipo === fOrigen) && (!fResp || (a.responsable?.nombre ?? "Sin responsable") === fResp) && (!fEstado || est(a) === fEstado));
  const objetivos = Array.from(new Set(lista.map((a) => a.objetivo ?? "Sin objetivo")));
  const hecha = (a: Act) => ["EJECUTADA", "VERIFICADA"].includes(a.estado);
  const mesHoy = Number(hoy.slice(5, 7)) - 1;

  return (
    <div>
      <div className="bar" style={{ borderRadius: 8, border: "1.5px solid var(--wf)", marginBottom: 10 }}>
        <b>{et.plan} 2026 · v1 {datos.hito ? `${datos.hito.estado} ${fechaDM(datos.hito.fecha)}` : ""}</b><span className="sp" />
        <button className={`btn ${vista === "lista" ? "on" : ""}`} onClick={() => setVista("lista")}>Lista</button>
        <button className={`btn ${vista === "cal" ? "on" : ""}`} onClick={() => setVista("cal")}>Calendario</button>
        <button className={`btn ${vista === "cron" ? "on" : ""}`} onClick={() => setVista("cron")}>Cronograma</button>
        <button className="btn" onClick={() => window.print()}>Exportar</button>
      </div>
      <div style={{ marginBottom: 8 }} className="noprint">
        <select className="btn" value={fOrigen} onChange={(e) => setFOrigen(e.target.value)}><option value="">Origen: todos ▾</option><option value="BRECHA">Brecha</option><option value="CONTROL">Control</option><option value="BASE">Base</option><option value="HALLAZGO">Hallazgo</option></select>
        <select className="btn" value={fResp} onChange={(e) => setFResp(e.target.value)}><option value="">Responsable ▾</option>{resps.map((r) => <option key={r}>{r}</option>)}</select>
        <select className="btn" value={fEstado} onChange={(e) => setFEstado(e.target.value)}><option value="">Estado ▾</option><option value="VENCIDA">Vencida</option><option value="PROGRAMADA">Programada</option><option value="EN_CURSO">En curso</option><option value="EJECUTADA">Ejecutada</option><option value="VERIFICADA">Verificada</option></select>
      </div>

      {vista === "lista" && objetivos.map((o, i) => {
        const l = lista.filter((a) => (a.objetivo ?? "Sin objetivo") === o);
        const h = l.filter(hecha).length;
        return (
          <div className="blk" key={o}><h4>Objetivo {i + 1} · {o} · <small>Indicador: ejecutadas / programadas · avance {h}/{l.length} ({l.length ? Math.round((100 * h) / l.length) : 0} %)</small></h4>
            <div className="scroll"><table className="mini"><thead><tr><th>Origen</th><th>Actividad</th><th>Responsable</th><th>Fecha</th><th>Estado</th></tr></thead><tbody>
              {l.map((a) => { const t = origenTag(a); return (
                <tr key={a.id}><td><span className={`tag ${t.cls}`}>{t.txt}</span></td>
                  <td><Link href={`/registro/actividad/${a.id}`} style={{ textDecoration: "underline" }}>{a.descripcion}</Link></td>
                  <td>{a.responsable?.nombre ?? "Sin responsable"}</td><td>{fechaDM(a.fecha_fin)}</td><td><Tag estado={est(a)} /></td></tr>); })}
            </tbody></table></div></div>);
      })}

      {vista === "cal" && (
        <div className="blk"><h4>Calendario · {MESES_L[mesHoy]} 2026</h4>
          {lista.filter((a) => a.fecha_fin && Number(a.fecha_fin.slice(5, 7)) - 1 === mesHoy).map((a) => (
            <div key={a.id} style={{ margin: "4px 0", fontSize: 13 }}><b>{fechaDM(a.fecha_fin)}</b> · {a.descripcion} · <small>{a.responsable?.nombre}</small> <Tag estado={est(a)} /></div>))}
          {lista.filter((a) => a.fecha_fin && Number(a.fecha_fin.slice(5, 7)) - 1 === mesHoy).length === 0 && <small>Sin actividades este mes.</small>}
        </div>
      )}

      {vista === "cron" && (
        <div className="blk"><h4>Vista de cronograma</h4>
          <div className="scroll"><div className="cron">
            <div className="h" style={{ textAlign: "left" }}>Actividad</div>{MESES.map((m, i) => <div key={i} className="h">{m}</div>)}
            {lista.map((a) => (<div key={a.id} style={{ display: "contents" }}>
              <div>{a.descripcion.slice(0, 40)}</div>
              {MESES.map((_, i) => { const en = a.fecha_fin && Number(a.fecha_fin.slice(5, 7)) - 1 === i; const e = est(a);
                return <div key={i} className={en ? (hecha(a) ? "x" : e === "VENCIDA" ? "xr" : "xo") : ""} />; })}</div>))}
          </div></div>
          <small>■ ejecutada · <span className="bad">■</span> vencida · □ programada.</small>
        </div>
      )}
      <p><small>El plan no se aprueba si hay actividades sin responsable o sin fecha. Para registrar avance y evidencia, abre la actividad.</small></p>
    </div>
  );
}
