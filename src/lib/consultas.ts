// Consultas y tipos compartidos por las pantallas.
import { Metodologia } from "./iperc/engine";

export const SEL_ACT =
  "id,descripcion,fecha_fin,estado,origen,plantilla_codigo,brecha_item,objetivo,responsable_id,responsable:usuario!responsable_id(nombre),control(codigo,fila_id),hallazgo(fecha)";
export const SEL_ACC =
  "id,descripcion,inmediata,vence_en,estado,hallazgo_id,control_id,responsable_id,verificada_por,responsable:usuario!responsable_id(nombre),control(codigo,fila_id),hallazgo(fecha)";

export type Resp = { nombre: string } | null;
export type Act = {
  id: string; descripcion: string; fecha_fin: string | null; estado: string; origen: string;
  plantilla_codigo: string | null; brecha_item: number | null; objetivo: string | null; responsable_id: string | null;
  responsable: Resp; control: { codigo: string | null; fila_id: string } | null; hallazgo: { fecha: string } | null;
};
export type Acc = {
  id: string; descripcion: string; inmediata: boolean; vence_en: string; estado: string; hallazgo_id: string | null;
  control_id: string | null; responsable_id: string; verificada_por: string | null;
  responsable: Resp; control: { codigo: string | null; fila_id: string } | null; hallazgo: { fecha: string } | null;
};

export const etiquetas = (m?: string) =>
  m === "MINERIA"
    ? { plan: "Programa anual de SSO", comite: "Comité de SSO" }
    : { plan: "Plan anual de SST", comite: "Comité de SST" };

export const ROL_NOMBRE: Record<string, string> = {
  ADMIN: "Administrador", SST: "Responsable de SST", ACTIVIDAD: "Responsable de actividad", LECTOR: "Lector",
};

export const fechaDM = (iso: string | null | undefined) => {
  if (!iso) return "—";
  const [y, m, d] = iso.slice(0, 10).split("-");
  void y;
  return `${d}/${m}`;
};
export const hora = (iso: string) =>
  new Date(iso).toLocaleTimeString("es-PE", { hour: "2-digit", minute: "2-digit", hour12: false, timeZone: "America/Lima" });

/** Etiqueta de origen: Control · IPERC-C02, Hallazgo · 20/08, Base · AB-M01, Brecha · ítem 53. */
export function origenTag(a: { origen?: string; control: { codigo: string | null } | null; hallazgo: { fecha: string } | null; plantilla_codigo?: string | null; brecha_item?: number | null }) {
  if (a.control) return { txt: `Control · ${a.control.codigo ?? ""}`, cls: "t-amb", tipo: "CONTROL" };
  if (a.hallazgo) return { txt: `Hallazgo · ${fechaDM(a.hallazgo.fecha)}`, cls: "", tipo: "HALLAZGO" };
  if (a.brecha_item) return { txt: `Brecha · ítem ${a.brecha_item}`, cls: "t-acc", tipo: "BRECHA" };
  if (a.plantilla_codigo) return { txt: `Base · ${a.plantilla_codigo}`, cls: "", tipo: "BASE" };
  return { txt: a.origen ?? "—", cls: "", tipo: "OTRO" };
}

export const ESTADO_TXT: Record<string, string> = {
  PROGRAMADA: "Programada", EN_CURSO: "En curso", EJECUTADA: "Ejecutada", VERIFICADA: "Verificada",
  ASIGNADA: "Asignada", EN_IMPLEMENTACION: "En implementación", POR_VERIFICAR: "Por verificar", RECHAZADA: "Rechazada",
};
export const estadoCls = (e: string) =>
  e === "VENCIDA" ? "t-red" : e === "VERIFICADA" ? "t-grn" : e === "EJECUTADA" || e === "POR_VERIFICAR" ? "t-acc" : "";

export const actVencida = (a: Act, hoy: string) =>
  ["PROGRAMADA", "EN_CURSO"].includes(a.estado) && !!a.fecha_fin && a.fecha_fin < hoy;
export const accVencida = (a: Acc, ahora: Date) =>
  ["ASIGNADA", "EN_IMPLEMENTACION"].includes(a.estado) && new Date(a.vence_en) < ahora;

export type PerfilMet = Metodologia;
export const JERARQUIA: Record<string, string> = {
  ELIMINACION: "1. Eliminación", SUSTITUCION: "2. Sustitución", INGENIERIA: "3. Ingeniería",
  ADMINISTRATIVO: "4. Administrativo", EPP: "5. EPP",
};
