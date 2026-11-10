import { ReactNode } from "react";
import { estadoCls, ESTADO_TXT } from "./consultas";

export function Tag({ estado, children, cls }: { estado?: string; children?: ReactNode; cls?: string }) {
  return <span className={`tag ${cls ?? (estado ? estadoCls(estado) : "")}`}>{children ?? (estado === "VENCIDA" ? "Vencida" : ESTADO_TXT[estado ?? ""] ?? estado)}</span>;
}
export const CLASIF_CLS: Record<string, string> = {
  Alto: "t-red", Intolerable: "t-red", Importante: "t-red", Medio: "t-amb", Moderado: "t-amb", Bajo: "t-grn", Tolerable: "t-grn", Trivial: "t-grn",
};
export const Clasif = ({ c, n }: { c: string; n?: number }) => <span className={`tag ${CLASIF_CLS[c] ?? ""}`}>{c}{n != null ? ` (${n})` : ""}</span>;

export function fechaCorta(iso: string | null | undefined) {
  if (!iso) return "—";
  const d = new Date(iso.length === 10 ? iso + "T12:00:00" : iso);
  return d.toLocaleDateString("es-PE", { day: "2-digit", month: "short", year: "numeric" });
}
export function cuentaRegresiva(ms: number) {
  const neg = ms < 0;
  const s = Math.floor(Math.abs(ms) / 1000);
  const p = (n: number) => String(n).padStart(2, "0");
  return `${neg ? "-" : ""}${p(Math.floor(s / 3600))}:${p(Math.floor((s % 3600) / 60))}:${p(s % 60)}`;
}
export function Cargando({ error }: { error?: string | null }) {
  return <p style={{ padding: 12 }} className={error ? "bad" : "muted"}>{error ? `Error: ${error}` : "Cargando…"}</p>;
}
