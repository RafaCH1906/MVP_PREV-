"use client";
import Link from "next/link";
import { useState } from "react";
import { supabase } from "@/lib/supabase";
import { useAuth } from "@/lib/auth";
import { useCarga, ok } from "@/lib/hooks";
import { useReloj } from "@/lib/reloj";
import { Cargando, Clasif } from "@/lib/ui";
import { alertaResidual, Clasif as C, Metodologia } from "@/lib/iperc/engine";
import { fechaDM } from "@/lib/consultas";

type Fila = {
  id: string; codigo: string; iperc_id: string; nivel_inicial: number; clasif_inicial: C; significativo: boolean;
  eval_inicial: Record<string, number | string>; nivel_residual: number | null; clasif_residual: C | null;
  tarea: { nombre: string; proceso: string } | null; peligro: { peligro: string; riesgo: string } | null;
};
type Ver = { id: string; version: number; estado: string; aprobado_en: string | null };
type Ctl = { id: string; fila_id: string; descripcion: string; existente: boolean };

/** W5 · Matriz IPERC completa (I05). */
export default function MatrizIperc() {
  const { perfil } = useAuth();
  const { hoy } = useReloj();
  const met = (perfil?.empresa?.metodologia ?? "MINERIA") as Metodologia;
  const [verSel, setVerSel] = useState<string | null>(null);
  const [soloSig, setSoloSig] = useState(false);
  const [proc, setProc] = useState("");
  const [valid, setValid] = useState<string | null>(null);
  const { datos, cargando, error } = useCarga(async () => {
    const vers = ok(await supabase.from("iperc_version").select("id,version,estado,aprobado_en").order("version")) as Ver[];
    const filas = ok(await supabase.from("iperc_fila").select("id,codigo,iperc_id,nivel_inicial,clasif_inicial,significativo,eval_inicial,nivel_residual,clasif_residual,tarea(nombre,proceso),peligro:peligro_catalogo(peligro,riesgo)").order("codigo")) as unknown as Fila[];
    const ctl = ok(await supabase.from("control").select("id,fila_id,descripcion,existente")) as Ctl[];
    const act = ok(await supabase.from("actividad").select("id,control_id,estado,fecha_fin").not("control_id", "is", null)) as { id: string; control_id: string; estado: string; fecha_fin: string | null }[];
    const acc = ok(await supabase.from("accion").select("id,control_id,estado").not("control_id", "is", null)) as { id: string; control_id: string; estado: string }[];
    return { vers, filas, ctl, act, acc };
  }, [perfil]);
  if (cargando) return <Cargando />;
  if (error || !datos) return <Cargando error={error} />;
  const { vers, filas, ctl, act, acc } = datos;
  const vid = verSel ?? vers.find((v) => v.estado === "APROBADO")?.id ?? vers[0]?.id;
  const procesos = Array.from(new Set(filas.filter((f) => f.iperc_id === vid).map((f) => f.tarea?.proceso ?? "")));
  const lista = filas.filter((f) => f.iperc_id === vid && (!soloSig || f.significativo) && (!proc || f.tarea?.proceso === proc));

  const exportar = () => {
    const cab = ["N.º", "Proceso", "Tarea", "Peligro", "Riesgo", "Nivel", "Clasificación", "Significativo", "Residual"];
    const filasCsv = lista.map((f) => [f.codigo, f.tarea?.proceso, f.tarea?.nombre, f.peligro?.peligro, f.peligro?.riesgo, f.nivel_inicial, f.clasif_inicial, f.significativo ? "Sí" : "No", f.nivel_residual ? `${f.nivel_residual} ${f.clasif_residual}` : ""]);
    const csv = [cab, ...filasCsv].map((r) => r.map((x) => `"${String(x ?? "").replace(/"/g, '""')}"`).join(",")).join("\n");
    const a = document.createElement("a");
    a.href = URL.createObjectURL(new Blob(["﻿" + csv], { type: "text/csv;charset=utf-8" }));
    a.download = "iperc.csv"; a.click();
  };
  const validar = () => {
    const sinRes = lista.filter((f) => !f.clasif_residual).length;
    const sigSin = lista.filter((f) => f.significativo && !ctl.some((c) => c.fila_id === f.id && !c.existente)).length;
    setValid(`${lista.length} filas revisadas · ${sinRes} sin evaluación residual · ${sigSin} significativas sin control propuesto.`);
  };
  const destino = (c: Ctl) => {
    const a = act.find((x) => x.control_id === c.id), ac = acc.find((x) => x.control_id === c.id);
    if (ac) return { href: `/registro/accion/${ac.id}`, nota: " → acción inmediata" };
    if (a) return { href: `/registro/actividad/${a.id}`, nota: ["PROGRAMADA", "EN_CURSO"].includes(a.estado) && a.fecha_fin && a.fecha_fin < hoy ? " → actividad vencida" : " → actividad" };
    return null;
  };

  return (
    <div>
      <div className="bar" style={{ borderRadius: 8, border: "1.5px solid var(--wf)", marginBottom: 10 }}>
        <b>IPERC de línea base 2026 · Metodología {met === "MINERIA" ? "minería (formato Anexo 8)" : "MTPE (RM 050-2013-TR)"}</b><span className="sp" />
        {vers.map((v) => <button key={v.id} className={`btn ${v.id === vid ? "on" : ""}`} onClick={() => setVerSel(v.id)}>v{v.version} {v.estado === "APROBADO" ? `Aprobada · ${fechaDM(v.aprobado_en)}` : "Borrador"}</button>)}
      </div>
      <div style={{ marginBottom: 8 }} className="noprint">
        <select className="btn" value={proc} onChange={(e) => setProc(e.target.value)}><option value="">Proceso ▾</option>{procesos.map((p) => <option key={p}>{p}</option>)}</select>
        <button className={`btn ${soloSig ? "on" : ""}`} onClick={() => setSoloSig(!soloSig)}>Solo significativos</button>
        <button className="btn" onClick={validar}>Validar completitud</button>
        <button className="btn" onClick={exportar}>Exportar Excel</button>
        <button className="btn" onClick={() => window.print()}>Exportar PDF</button>
        <button className="btn" disabled>Importar plantilla</button>
      </div>
      {valid && <div className="warn">{valid}</div>}
      <div className="scroll"><table className="mini">
        <thead><tr><th>N.º</th><th>Proceso › tarea</th><th>Peligro</th><th>Riesgo</th>
          {met === "MINERIA" ? <><th>S</th><th>P</th></> : <><th>P</th><th>S</th></>}
          <th>Nivel</th><th>Clasificación</th><th>Signif.</th><th>Controles propuestos</th><th>Residual</th></tr></thead>
        <tbody>
          {lista.map((f) => {
            const e = f.eval_inicial;
            const p = met === "MINERIA" ? e.prob : Number(e.A) + Number(e.B) + Number(e.C) + Number(e.D);
            const s = met === "MINERIA" ? e.severidad : e.S;
            const cs = ctl.filter((c) => c.fila_id === f.id && !c.existente);
            const alerta = f.clasif_residual ? alertaResidual(met, f.clasif_inicial, f.clasif_residual) : false;
            return (
              <tr key={f.id}>
                <td><Link href={`/iperc/${f.codigo}`} style={{ textDecoration: "underline" }}>{f.codigo.replace("IPERC-", "")}</Link></td>
                <td>{f.tarea?.proceso} › {f.tarea?.nombre}</td><td>{f.peligro?.peligro}</td><td>{f.peligro?.riesgo}</td>
                {met === "MINERIA" ? <><td>{s}</td><td>{p}</td></> : <><td>{p}</td><td>{s}</td></>}
                <td><b>{f.nivel_inicial}</b></td><td><Clasif c={f.clasif_inicial} /></td><td>{f.significativo ? "Sí" : "No"}</td>
                <td>{cs.length === 0 ? "—" : cs.map((c, i) => { const d = destino(c); return (
                  <span key={c.id}>{i > 0 && " · "}{d ? <Link href={d.href} style={{ textDecoration: "underline" }}>{c.descripcion}{d.nota}</Link> : c.descripcion}</span>); })}</td>
                <td>{f.clasif_residual ? <>{f.nivel_residual} {f.clasif_residual}{alerta && <span className="bad"> ⚠</span>}</> : "—"}</td>
              </tr>
            );
          })}
        </tbody>
      </table></div>
      <p><small>Clic en una fila: abre la evaluación (W4). Clic en un control propuesto: lleva a su actividad del programa o a su acción inmediata (trazabilidad, RF-29). Una versión aprobada es de solo lectura: editar crea un borrador nuevo.</small></p>
    </div>
  );
}
