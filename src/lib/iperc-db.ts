// Operaciones de escritura del módulo IPERC (versiones, filas, controles y acción inmediata).
import { supabase } from "./supabase";
import { Clasif, Metodologia, requiereAccionInmediata, venceAccionInmediata } from "./iperc/engine";

export type Ver = { id: string; version: number; estado: string; aprobado_en: string | null };
const uid = () => crypto.randomUUID();
const fallo = (e: { message: string } | null, ctx: string) => { if (e) throw new Error(`${ctx}: ${e.message}`); };

/** Devuelve el borrador vigente o lo crea copiando la última versión aprobada (editar una aprobada crea un borrador nuevo). */
export async function obtenerOCrearBorrador(empresaId: string): Promise<Ver> {
  const { data: vers, error } = await supabase.from("iperc_version").select("id,version,estado,aprobado_en").order("version");
  fallo(error, "versiones");
  const lista = (vers ?? []) as Ver[];
  const bor = lista.find((v) => v.estado === "BORRADOR");
  if (bor) return bor;
  const base = [...lista].reverse().find((v) => v.estado === "APROBADO");
  const nuevo: Ver = { id: uid(), version: (lista[lista.length - 1]?.version ?? 0) + 1, estado: "BORRADOR", aprobado_en: null };
  const r = await supabase.from("iperc_version").insert({ id: nuevo.id, empresa_id: empresaId, anio: 2026, version: nuevo.version, estado: "BORRADOR" });
  fallo(r.error, "crear borrador");
  if (!base) return nuevo;
  const { data: filas, error: e2 } = await supabase.from("iperc_fila").select("*").eq("iperc_id", base.id);
  fallo(e2, "leer filas");
  const { data: ctl, error: e3 } = await supabase.from("control").select("*").in("fila_id", (filas ?? []).map((f) => f.id));
  fallo(e3, "leer controles");
  const mapa = new Map<string, string>();
  const nuevasFilas = (filas ?? []).map((f) => { const id = uid(); mapa.set(f.id, id); return { ...f, id, iperc_id: nuevo.id }; });
  if (nuevasFilas.length) fallo((await supabase.from("iperc_fila").insert(nuevasFilas)).error, "copiar filas");
  const nuevosCtl = (ctl ?? []).map((c) => ({ ...c, id: uid(), fila_id: mapa.get(c.fila_id) }));
  if (nuevosCtl.length) fallo((await supabase.from("control").insert(nuevosCtl)).error, "copiar controles");
  return nuevo;
}

/** Siguiente código de fila en el borrador: IPERC-C09, IPERC-W08… (letra = inicial del código de empresa). */
export async function siguienteCodigo(empresaCodigo: string, ipercId: string): Promise<string> {
  const { data } = await supabase.from("iperc_fila").select("codigo").eq("iperc_id", ipercId);
  const max = (data ?? []).map((r) => Number(String(r.codigo).replace(/\D/g, ""))).reduce((a, b) => Math.max(a, b), 0);
  return `IPERC-${empresaCodigo[0].toUpperCase()}${String(max + 1).padStart(2, "0")}`;
}

/** ¿La fila ya tiene una acción inmediata abierta o cerrada? */
export async function tieneAccionInmediata(filaId: string): Promise<boolean> {
  const { data: ctl } = await supabase.from("control").select("id").eq("fila_id", filaId);
  const ids = (ctl ?? []).map((c) => c.id);
  if (!ids.length) return false;
  const { data } = await supabase.from("accion").select("id").eq("inmediata", true).in("control_id", ids).limit(1);
  return (data ?? []).length > 0;
}

export const debeCrearAccionInmediata = (met: Metodologia, clasif: Clasif) => requiereAccionInmediata(met, clasif);

/** RF-36: crea el control y la acción inmediata; el plazo corre desde el registro de la evaluación. */
export async function crearAccionInmediata(p: {
  empresaId: string; filaId: string; codigo: string; clasif: Clasif; registradoEn: Date; descripcion: string; responsableId: string;
}) {
  const controlId = uid();
  fallo((await supabase.from("control").insert({
    id: controlId, empresa_id: p.empresaId, fila_id: p.filaId, codigo: p.codigo, jerarquia: "ADMINISTRATIVO", descripcion: p.descripcion, existente: false,
  })).error, "control de acción inmediata");
  fallo((await supabase.from("accion").insert({
    id: uid(), empresa_id: p.empresaId, control_id: controlId, descripcion: p.descripcion, inmediata: true,
    responsable_id: p.responsableId, vence_en: venceAccionInmediata(p.registradoEn, p.clasif).toISOString(), estado: "ASIGNADA",
  })).error, "acción inmediata");
}
