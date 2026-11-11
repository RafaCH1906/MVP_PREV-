"use client";
import MatrizMineria from "./MatrizMineria";
import { Clasif as ClasifTag } from "@/lib/ui";
import {
  esSignificativo, evaluarMineria, evaluarMtpe, indiceAMtpe, severidadFinalMineria,
  Clasif, Indice, Metodologia, ProbMineria, SeveridadMineria, SeveridadMtpe,
} from "@/lib/iperc/engine";

export type Factores = Record<string, number | string | boolean>;

const SEV_MIN = [1, 2, 3, 4, 5];
const PROB: Record<string, string> = { A: "A · Común", B: "B · Ha sucedido", C: "C · Podría suceder", D: "D · Poco probable", E: "E · Prácticamente imposible" };
const A_TXT: Record<number, string> = { 1: "1 a 3 expuestos", 2: "4 a 12 expuestos", 3: "más de 12" };
const B_TXT: Record<number, string> = { 1: "existen y son satisfactorios", 2: "existen parcialmente", 3: "no existen" };
const C_TXT: Record<number, string> = { 1: "entrenado y capacitado", 2: "parcialmente entrenado", 3: "sin entrenamiento" };
const D_TXT: Record<number, string> = { 1: "al menos una vez al año", 2: "al menos una vez al mes", 3: "al menos una vez al día" };
const S_TXT: Record<number, string> = { 1: "ligeramente dañino", 2: "incapacidad temporal", 3: "incapacidad permanente" };

export const factoresPorDefecto = (met: Metodologia, nExp?: number | null, sevMtpe?: number | null): Factores =>
  met === "MTPE"
    ? { A: nExp ? indiceAMtpe(nExp) : 1, B: 2, C: 2, D: 2, S: sevMtpe ?? 2 }
    : { lesion: 3, propiedad: 3, proceso: 3, severidad: 3, prob: "C", modificada: false };

export type Calculo = { ok: boolean; nivel: number; clasif: Clasif; formula: string; sevFinal: number; signif: boolean };

/** Calcula nivel y clasificación con el motor IPERC (funciones puras). */
export function calcular(met: Metodologia, m: Factores): Calculo {
  try {
    if (met === "MTPE") {
      const r = evaluarMtpe({ A: Number(m.A) as Indice, B: Number(m.B) as Indice, C: Number(m.C) as Indice, D: Number(m.D) as Indice, S: Number(m.S) as SeveridadMtpe });
      return { ok: true, nivel: r.nivel, clasif: r.clasificacion, formula: `P = ${m.A}+${m.B}+${m.C}+${m.D} = ${r.P} · NR = ${r.P} × ${m.S} = ${r.nivel}`, sevFinal: Number(m.S), signif: esSignificativo(met, r.clasificacion) };
    }
    const prop = severidadFinalMineria({ lesion: Number(m.lesion) as SeveridadMineria, propiedad: Number(m.propiedad) as SeveridadMineria, proceso: Number(m.proceso) as SeveridadMineria });
    const sev = m.modificada ? Number(m.severidad) : prop;
    const r = evaluarMineria(sev as SeveridadMineria, m.prob as ProbMineria);
    return { ok: true, nivel: r.nivel, clasif: r.clasificacion, formula: `Nivel ${r.nivel}`, sevFinal: sev, signif: esSignificativo(met, r.clasificacion) };
  } catch {
    return { ok: false, nivel: 0, clasif: (met === "MTPE" ? "Trivial" : "Bajo") as Clasif, formula: "", sevFinal: 0, signif: false };
  }
}

/** Los factores se guardan con la severidad final ya resuelta. */
export const paraGuardar = (met: Metodologia, m: Factores): Factores => (met === "MINERIA" ? { ...m, severidad: calcular(met, m).sevFinal } : { ...m });

function Sel({ k, v, set, op, fmt, dis }: { k: string; v: string | number; set: (x: string) => void; op: (string | number)[]; fmt?: (x: string | number) => string; dis?: boolean }) {
  return (
    <div className="field"><span className="k">{k}</span>
      <select className="in" value={v} disabled={dis} onChange={(e) => set(e.target.value)}>{op.map((o) => <option key={o} value={o}>{fmt ? fmt(o) : o}</option>)}</select></div>
  );
}

/** Bloque de evaluación (inicial o residual) según la metodología de la empresa (RF-35). */
export default function EvalForm({ met, m, onChange, dis, nExpuestos, marcaMatriz, matrizOtra }: {
  met: Metodologia; m: Factores; onChange: (m: Factores) => void; dis?: boolean; nExpuestos?: number | null;
  marcaMatriz?: "sel" | "res"; matrizOtra?: { sev: number; prob: string };
}) {
  const set = (k: string) => (x: string) => onChange({ ...m, [k]: k === "prob" ? x : Number(x) });
  const c = calcular(met, m);
  const umbral = met === "MTPE" ? "Moderado" : "Medio";
  if (met === "MTPE") {
    return (<>
      <div className="field"><span className="k">N.º expuestos</span><span className="in">{nExpuestos ?? "—"} (desde los puestos)</span></div>
      <Sel k="A · Personas expuestas" v={m.A as number} set={set("A")} op={[1, 2, 3]} dis={dis} fmt={(x) => `${x} · ${A_TXT[Number(x)]}${nExpuestos && indiceAMtpe(nExpuestos) === Number(x) ? " (propuesto)" : ""}`} />
      <Sel k="B · Procedimientos" v={m.B as number} set={set("B")} op={[1, 2, 3]} dis={dis} fmt={(x) => `${x} · ${B_TXT[Number(x)]}`} />
      <Sel k="C · Capacitación" v={m.C as number} set={set("C")} op={[1, 2, 3]} dis={dis} fmt={(x) => `${x} · ${C_TXT[Number(x)]}`} />
      <Sel k="D · Exposición" v={m.D as number} set={set("D")} op={[1, 2, 3]} dis={dis} fmt={(x) => `${x} · ${D_TXT[Number(x)]}`} />
      <Sel k="S · Severidad" v={m.S as number} set={set("S")} op={[1, 2, 3]} dis={dis} fmt={(x) => `${x} · ${S_TXT[Number(x)]}`} />
      {c.ok && <div className="warn"><b>{c.formula} → <ClasifTag c={c.clasif} /></b> · {c.signif ? "Significativo" : "No significativo"} (umbral: {umbral}) · plazo según la clasificación</div>}
    </>);
  }
  return (<>
    <Sel k="Severidad · lesión personal" v={m.lesion as number} set={set("lesion")} op={SEV_MIN} dis={dis} />
    <Sel k="Severidad · daño a la propiedad" v={m.propiedad as number} set={set("propiedad")} op={SEV_MIN} dis={dis} />
    <Sel k="Severidad · daño al proceso" v={m.proceso as number} set={set("proceso")} op={SEV_MIN} dis={dis} />
    <div className="field"><span className="k">Severidad final</span>
      {m.modificada
        ? <select className="in" disabled={dis} value={c.sevFinal} onChange={(e) => onChange({ ...m, severidad: Number(e.target.value) })}>{SEV_MIN.map((s) => <option key={s}>{s}</option>)}</select>
        : <span className="in"><b>{c.sevFinal}</b> <small>(propuesta: la más grave)</small></span>}
      {!dis && <button type="button" className="btn" onClick={() => onChange({ ...m, modificada: !m.modificada, severidad: c.sevFinal })}>{m.modificada ? "Volver a la propuesta" : "Modificar"}</button>}</div>
    <Sel k="Probabilidad" v={(m.prob as string) ?? "C"} set={set("prob")} op={["A", "B", "C", "D", "E"]} dis={dis} fmt={(x) => PROB[String(x)]} />
    <div className="row" style={{ alignItems: "center" }}>
      <MatrizMineria sev={marcaMatriz === "res" ? matrizOtra?.sev : c.sevFinal} prob={marcaMatriz === "res" ? matrizOtra?.prob : String(m.prob)}
        sevR={marcaMatriz === "res" ? c.sevFinal : matrizOtra?.sev} probR={marcaMatriz === "res" ? String(m.prob) : matrizOtra?.prob} />
      <div className="col">{c.ok && <div className="warn"><b>Nivel {c.nivel} → <ClasifTag c={c.clasif} /></b> · {c.signif ? "Significativo" : "No significativo"} (umbral: {umbral})</div>}
        <small>Celda con borde sólido: inicial · punteado: residual.</small></div></div>
  </>);
}
