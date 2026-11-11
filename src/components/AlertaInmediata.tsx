"use client";
import Link from "next/link";
import { useReloj } from "@/lib/reloj";
import { formatoRestante, minutosRestantes } from "@/lib/iperc/engine";
import { hora } from "@/lib/consultas";

export type AccionInm = {
  id: string; descripcion: string; vence_en: string; estado: string;
  responsable: { nombre: string } | null;
  fila: { codigo: string; iperc_id?: string; nivel_inicial: number; clasif_inicial: string } | null;
};

/** RF-36: banner rojo en Inicio (W1) y tarjeta fija en el celular (W7). */
export default function AlertaInmediata({ a, celular }: { a: AccionInm; celular?: boolean }) {
  const { ahora, hoy } = useReloj();
  const venc = new Date(a.vence_en);
  const min = minutosRestantes(venc, ahora);
  const dia = venc.toLocaleDateString("sv-SE", { timeZone: "America/Lima" }) === hoy ? "hoy" : venc.toLocaleDateString("es-PE", { day: "2-digit", month: "2-digit", timeZone: "America/Lima" });
  const rest = formatoRestante(min);
  const clase = a.fila?.clasif_inicial ?? "Alto";
  if (celular) {
    return (
      <Link href={`/registro/accion/${a.id}`} className="pcard urg">
        <span className="tag t-red">ACCIÓN INMEDIATA · {clase}</span><br />
        <b>{a.descripcion}</b><br />
        <small>Origen: {a.fila?.codigo ?? "—"}</small><br />
        <b className="bad">{min >= 0 ? `Quedan ${rest.replace("quedan ", "")}` : rest}</b>
        <div style={{ marginTop: 6 }}><span className="btn pri">Abrir</span></div>
      </Link>
    );
  }
  return (
    <div className="alert">
      <b>⚠ ACCIÓN INMEDIATA · Riesgo {clase} (nivel {a.fila?.nivel_inicial ?? "—"})</b> · {a.descripcion} · Responsable: {a.responsable?.nombre ?? "—"} ·{" "}
      <b>Vence {dia} {hora(a.vence_en)} · {rest}</b>{" "}
      <Link href={`/registro/accion/${a.id}`} className="btn">Ver acción</Link>
      {a.fila && <Link href={`/iperc/${a.fila.codigo}${a.fila.iperc_id ? `?v=${a.fila.iperc_id}` : ""}`} className="btn">Ver fila IPERC</Link>}
    </div>
  );
}
