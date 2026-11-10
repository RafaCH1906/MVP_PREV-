// Motor IPERC de Prevé: funciones puras (sin base de datos ni red).
// Fuente: Capítulo III v0.6, apartado 3.2.3.

export type Metodologia = "MTPE" | "MINERIA";

export type ClasifMtpe = "Trivial" | "Tolerable" | "Moderado" | "Importante" | "Intolerable";
export type ClasifMineria = "Alto" | "Medio" | "Bajo";
export type Clasif = ClasifMtpe | ClasifMineria;

export interface Resultado {
  nivel: number;
  clasificacion: Clasif;
  /** Mayor número = más grave, comparable solo dentro de la misma metodología. */
  gravedad: number;
  /** Plazo de la medida en horas (null si no aplica). */
  plazoHoras: number | null;
}

/* ------------------------------ MTPE (RM 050-2013-TR) ------------------------------ */

export type Indice = 1 | 2 | 3;
export type SeveridadMtpe = 1 | 2 | 3;

export interface EntradaMtpe {
  A: Indice; // personas expuestas
  B: Indice; // procedimientos existentes
  C: Indice; // capacitación
  D: Indice; // exposición al riesgo
  S: SeveridadMtpe;
}

/** Índice A propuesto desde el número de expuestos: 1–3 → 1, 4–12 → 2, más de 12 → 3. */
export function indiceAMtpe(expuestos: number): Indice {
  if (!Number.isFinite(expuestos) || expuestos < 1) throw new RangeError("expuestos debe ser ≥ 1");
  if (expuestos <= 3) return 1;
  if (expuestos <= 12) return 2;
  return 3;
}

const GRAVEDAD_MTPE: Record<ClasifMtpe, number> = {
  Trivial: 0, Tolerable: 1, Moderado: 2, Importante: 3, Intolerable: 4,
};

export function clasificarMtpe(nr: number): ClasifMtpe {
  if (nr < 4 || nr > 36) throw new RangeError("NR fuera de rango (4–36)");
  if (nr === 4) return "Trivial";
  if (nr <= 8) return "Tolerable";
  if (nr <= 16) return "Moderado";
  if (nr <= 24) return "Importante";
  return "Intolerable";
}

// Plazos sugeridos (configurables): horas aproximadas para poder compararlos.
const PLAZO_MTPE: Record<ClasifMtpe, number | null> = {
  Trivial: null,
  Tolerable: 365 * 24, // revisión anual
  Moderado: 365 * 24, // dentro del año
  Importante: 30 * 24, // 30 días o antes de iniciar
  Intolerable: 0, // inmediato
};

export function evaluarMtpe(e: EntradaMtpe): Resultado & { P: number } {
  for (const k of ["A", "B", "C", "D", "S"] as const) {
    if (![1, 2, 3].includes(e[k])) throw new RangeError(`${k} debe ser 1, 2 o 3`);
  }
  const P = e.A + e.B + e.C + e.D;
  const nivel = P * e.S;
  const clasificacion = clasificarMtpe(nivel);
  return { P, nivel, clasificacion, gravedad: GRAVEDAD_MTPE[clasificacion], plazoHoras: PLAZO_MTPE[clasificacion] };
}

/* ------------------------- Minería (DS 024-2016-EM, anexos 7 y 8) ------------------------- */

export type SeveridadMineria = 1 | 2 | 3 | 4 | 5;
export type ProbMineria = "A" | "B" | "C" | "D" | "E";

// Matriz básica del Anexo 7: filas = severidad 1..5, columnas = probabilidad A..E.
export const MATRIZ_MINERIA: Record<SeveridadMineria, [number, number, number, number, number]> = {
  1: [1, 2, 4, 7, 11],
  2: [3, 5, 8, 12, 16],
  3: [6, 9, 13, 17, 20],
  4: [10, 14, 18, 21, 23],
  5: [15, 19, 22, 24, 25],
};

const COLS: ProbMineria[] = ["A", "B", "C", "D", "E"];
const GRAVEDAD_MIN: Record<ClasifMineria, number> = { Bajo: 0, Medio: 1, Alto: 2 };

export function clasificarMineria(nivel: number): ClasifMineria {
  if (nivel < 1 || nivel > 25) throw new RangeError("Nivel fuera de rango (1–25)");
  if (nivel <= 8) return "Alto";
  if (nivel <= 15) return "Medio";
  return "Bajo";
}

// Alto: 0–24 h, Medio: 0–72 h, Bajo: 1 mes (30 días).
const PLAZO_MIN: Record<ClasifMineria, number> = { Alto: 24, Medio: 72, Bajo: 30 * 24 };

/** Severidad final propuesta: la más grave (número menor) entre las dimensiones dadas. */
export function severidadFinalMineria(dims: {
  lesion?: SeveridadMineria; propiedad?: SeveridadMineria; proceso?: SeveridadMineria;
}): SeveridadMineria {
  const vals = [dims.lesion, dims.propiedad, dims.proceso].filter((v): v is SeveridadMineria => v !== undefined);
  if (vals.length === 0) throw new Error("Al menos una dimensión de severidad es obligatoria");
  return Math.min(...vals) as SeveridadMineria;
}

export function evaluarMineria(severidad: SeveridadMineria, prob: ProbMineria): Resultado {
  const fila = MATRIZ_MINERIA[severidad];
  if (!fila) throw new RangeError("Severidad debe ser 1–5");
  const idx = COLS.indexOf(prob);
  if (idx < 0) throw new RangeError("Probabilidad debe ser A–E");
  const nivel = fila[idx];
  const clasificacion = clasificarMineria(nivel);
  return { nivel, clasificacion, gravedad: GRAVEDAD_MIN[clasificacion], plazoHoras: PLAZO_MIN[clasificacion] };
}

/* --------------------------------- Reglas comunes --------------------------------- */

const UMBRAL_DEFECTO: Record<Metodologia, Clasif> = { MTPE: "Moderado", MINERIA: "Medio" };

function gravedadDe(m: Metodologia, c: Clasif): number {
  return m === "MTPE" ? GRAVEDAD_MTPE[c as ClasifMtpe] : GRAVEDAD_MIN[c as ClasifMineria];
}

/** Riesgo significativo: clasificación igual o más grave que el umbral configurable. */
export function esSignificativo(m: Metodologia, c: Clasif, umbral: Clasif = UMBRAL_DEFECTO[m]): boolean {
  return gravedadDe(m, c) >= gravedadDe(m, umbral);
}

/**
 * RF-17: alerta cuando la clasificación residual es igual o más grave que la inicial.
 * Compara por orden de gravedad, no por el número (MTPE 20→18 sigue Importante; minería 9→12 sigue Medio).
 */
export function alertaResidual(m: Metodologia, inicial: Clasif, residual: Clasif): boolean {
  return gravedadDe(m, residual) >= gravedadDe(m, inicial);
}

/* ------------------------------ Acción inmediata (RF-36) ------------------------------ */

/** Solo minería y solo riesgos Alto y Medio generan acción inmediata. */
export function requiereAccionInmediata(m: Metodologia, c: Clasif): boolean {
  return m === "MINERIA" && (c === "Alto" || c === "Medio");
}

/** El plazo corre desde que se registra la evaluación, aunque la IPERC siga en borrador. */
export function venceAccionInmediata(registradoEn: Date, c: Clasif): Date {
  if (c !== "Alto" && c !== "Medio") throw new Error("Solo Alto y Medio");
  return new Date(registradoEn.getTime() + PLAZO_MIN[c] * 3_600_000);
}

export function minutosRestantes(vence: Date, ahora: Date): number {
  return Math.floor((vence.getTime() - ahora.getTime()) / 60_000);
}

/** "5 h 10 min", o "vencida hace 2 h 5 min". */
export function formatoRestante(minutos: number): string {
  const abs = Math.abs(minutos);
  const h = Math.floor(abs / 60);
  const m = abs % 60;
  const t = `${h} h ${m} min`;
  return minutos >= 0 ? `quedan ${t}` : `vencida hace ${t}`;
}
