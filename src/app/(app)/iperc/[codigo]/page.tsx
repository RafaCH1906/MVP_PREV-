"use client";
import Link from "next/link";
import { useParams } from "next/navigation";
import { useEffect, useState } from "react";
import { supabase } from "@/lib/supabase";
import { useAuth } from "@/lib/auth";
import { useCarga, ok } from "@/lib/hooks";
import { puedeGestionar } from "@/lib/roles";
import { Cargando, Clasif } from "@/lib/ui";
import { JERARQUIA } from "@/lib/consultas";
import MatrizMineria from "@/components/MatrizMineria";
import {
  alertaResidual, esSignificativo, evaluarMineria, evaluarMtpe, indiceAMtpe, requiereAccionInmediata, severidadFinalMineria,
  Clasif as C, Indice, Metodologia, ProbMineria, SeveridadMineria, SeveridadMtpe,
} from "@/lib/iperc/engine";

type Det = {
  id: string; codigo: string; n_expuestos: number | null; eval_inicial: Record<string, number | string | boolean>; eval_residual: Record<string, number | string | boolean> | null;
  nivel_inicial: number; clasif_inicial: C; nivel_residual: number | null; clasif_residual: C | null;
  iperc: { version: number; estado: string } | null;
  tarea: { codigo: string; nombre: string } | null; peligro: { codigo: string; peligro: string; riesgo: string; consecuencia: string; sev_mtpe: number | null } | null;
};
type Ctl = { id: string; jerarquia: string; descripcion: string; existente: boolean };

const SEV_MIN = [1, 2, 3, 4, 5];
const PROB: Record<string, string> = { A: "A · Común", B: "B · Ha sucedido", C: "C · Podría suceder", D: "D · Poco probable", E: "E · Prácticamente imposible" };
const B_TXT: Record<number, string> = { 1: "existen y son satisfactorios", 2: "existen parcialmente", 3: "no existen" };
const C_TXT: Record<number, string> = { 1: "entrenado y capacitado", 2: "parcialmente entrenado", 3: "sin entrenamiento" };
const D_TXT: Record<number, string> = { 1: "al menos una vez al año", 2: "al menos una vez al mes", 3: "al menos una vez al día" };
const S_TXT: Record<number, string> = { 1: "ligeramente dañino", 2: "incapacidad temporal", 3: "incapacidad permanente" };
const A_TXT: Record<number, string> = { 1: "1 a 3 expuestos", 2: "4 a 12 expuestos", 3: "más de 12" };

function Sel({ k, v, set, op, fmt, dis }: { k: string; v: string | number; set: (x: string) => void; op: (string | number)[]; fmt?: (x: string | number) => string; dis?: boolean }) {
  return (
    <div className="field"><span className="k">{k}</span>
      <select className="in" value={v} disabled={dis} onChange={(e) => set(e.target.value)}>{op.map((o) => <option key={o} value={o}>{fmt ? fmt(o) : o}</option>)}</select></div>
  );
}

/** W4 · Evaluar una fila IPERC (I03). El bloque central cambia según la metodología. */
export default function EvaluarFila() {
  const { codigo } = useParams<{ codigo: string }>();
  const { perfil } = useAuth();
  const met = (perfil?.empresa?.metodologia ?? "MINERIA") as Metodologia;
  const [v, setV] = useState(0);
  const { datos, cargando, error } = useCarga(async () => {
    const f = ok(await supabase.from("iperc_fila")
      .select("id,codigo,n_expuestos,eval_inicial,eval_residual,nivel_inicial,clasif_inicial,nivel_residual,clasif_residual,iperc:iperc_version(version,estado),tarea(codigo,nombre),peligro:peligro_catalogo(codigo,peligro,riesgo,consecuencia,sev_mtpe)")
      .eq("codigo", codigo).limit(1)) as unknown as Det[];
    if (!f[0]) throw new Error("Fila no encontrada");
    const c = ok(await supabase.from("control").select("id,jerarquia,descripcion,existente").eq("fila_id", f[0].id)) as Ctl[];
    return { f: f[0], c };
  }, [codigo, perfil, v]);

  // estado editable (se inicia con lo guardado)
  const [m, setM] = useState<Record<string, number | string | boolean>>({});
  const [dec, setDec] = useState<Record<string, "ok" | "no">>({});
  const [msg, setMsg] = useState<string | null>(null);
  useEffect(() => { if (datos) setM({ ...datos.f.eval_inicial }); }, [datos]);

  if (cargando && !datos) return <Cargando />;
  if (error || !datos) return <Cargando error={error} />;
  const { f, c } = datos;
  const borrador = f.iperc?.estado === "BORRADOR";
  const edita = puedeGestionar(perfil) && borrador;

  // --- cálculo en vivo con el motor ---
  let nivel = f.nivel_inicial, clasif: C = f.clasif_inicial, formula = "";
  let sevFinal = Number(m.severidad ?? 3);
  try {
    if (met === "MTPE") {
      const r = evaluarMtpe({ A: Number(m.A) as Indice, B: Number(m.B) as Indice, C: Number(m.C) as Indice, D: Number(m.D) as Indice, S: Number(m.S) as SeveridadMtpe });
      nivel = r.nivel; clasif = r.clasificacion;
      formula = `P = ${m.A}+${m.B}+${m.C}+${m.D} = ${r.P} · NR = ${r.P} × ${m.S} = ${r.nivel}`;
    } else {
      const prop = severidadFinalMineria({ lesion: Number(m.lesion) as SeveridadMineria, propiedad: Number(m.propiedad) as SeveridadMineria, proceso: Number(m.proceso) as SeveridadMineria });
      sevFinal = m.modificada ? Number(m.severidad) : prop;
      const r = evaluarMineria(sevFinal as SeveridadMineria, m.prob as ProbMineria);
      nivel = r.nivel; clasif = r.clasificacion;
    }
  } catch { /* valores incompletos: se mantiene lo guardado */ }
  const signif = esSignificativo(met, clasif);
  const inm = requiereAccionInmediata(met, clasif);

  // residual
  const rf = f.eval_residual;
  let resTxt: { nivel: number; clasif: C; formula: string } | null = null;
  try {
    if (rf) {
      if (met === "MTPE") { const r = evaluarMtpe({ A: Number(rf.A) as Indice, B: Number(rf.B) as Indice, C: Number(rf.C) as Indice, D: Number(rf.D) as Indice, S: Number(rf.S) as SeveridadMtpe }); resTxt = { nivel: r.nivel, clasif: r.clasificacion, formula: `NR residual = ${r.P} × ${rf.S} = ${r.nivel}` }; }
      else { const r = evaluarMineria(Number(rf.severidad) as SeveridadMineria, rf.prob as ProbMineria); resTxt = { nivel: r.nivel, clasif: r.clasificacion, formula: `Nivel ${r.nivel}` }; }
    }
  } catch { resTxt = null; }
  const alerta = resTxt ? alertaResidual(met, clasif, resTxt.clasif) : false;

  const set = (k: string) => (x: string) => setM({ ...m, [k]: k === "prob" ? x : Number(x) });
  const guardar = async () => {
    const eval_inicial = met === "MINERIA" ? { ...m, severidad: sevFinal } : { ...m };
    const { error: e } = await supabase.from("iperc_fila").update({ eval_inicial, nivel_inicial: nivel, clasif_inicial: clasif, significativo: signif }).eq("id", f.id);
    setMsg(e ? `No se pudo guardar: ${e.message}` : "✓ Evaluación guardada");
    setV(v + 1);
  };

  const grupos = Object.keys(JERARQUIA).map((k) => [k, c.filter((x) => x.jerarquia === k && !x.existente)] as const).filter(([, l]) => l.length);
  const existentes = c.filter((x) => x.existente);

  return (
    <div>
      <p><Link href="/iperc" style={{ textDecoration: "underline" }}>← Matriz IPERC</Link> <small>· IPERC 2026 v{f.iperc?.version} {borrador ? "(borrador)" : "(aprobada, solo lectura)"} · fila {f.codigo.replace("IPERC-", "")}</small></p>
      <div className="row">
        <div className="col" style={{ flex: 1.3 }}>
          <div className="blk"><small>Tarea</small><br /><b>{f.tarea?.codigo} · {f.tarea?.nombre}</b><br />
            <small>Peligro</small> <b>{f.peligro?.codigo} · {f.peligro?.peligro}</b><br />
            <small>Riesgo:</small> {f.peligro?.riesgo} · <small>Consecuencia:</small> {f.peligro?.consecuencia}</div>
          {existentes.length > 0 && <div className="blk"><h4>Controles existentes</h4>{existentes.map((x) => <div key={x.id} style={{ fontSize: 13 }}>{JERARQUIA[x.jerarquia]} · {x.descripcion}</div>)}</div>}

          <div className="blk"><h4>Evaluación inicial</h4>
            {met === "MTPE" ? (<>
              <div className="field"><span className="k">N.º expuestos</span><span className="in">{f.n_expuestos ?? "—"} (desde los puestos)</span></div>
              <Sel k="A · Personas expuestas" v={m.A as number ?? 1} set={set("A")} op={[1, 2, 3]} dis={!edita} fmt={(x) => `${x} · ${A_TXT[Number(x)]}${f.n_expuestos && indiceAMtpe(f.n_expuestos) === Number(x) ? " (propuesto)" : ""}`} />
              <Sel k="B · Procedimientos" v={m.B as number ?? 1} set={set("B")} op={[1, 2, 3]} dis={!edita} fmt={(x) => `${x} · ${B_TXT[Number(x)]}`} />
              <Sel k="C · Capacitación" v={m.C as number ?? 1} set={set("C")} op={[1, 2, 3]} dis={!edita} fmt={(x) => `${x} · ${C_TXT[Number(x)]}`} />
              <Sel k="D · Exposición" v={m.D as number ?? 1} set={set("D")} op={[1, 2, 3]} dis={!edita} fmt={(x) => `${x} · ${D_TXT[Number(x)]}`} />
              <Sel k="S · Severidad" v={m.S as number ?? 1} set={set("S")} op={[1, 2, 3]} dis={!edita} fmt={(x) => `${x} · ${S_TXT[Number(x)]}`} />
              <div className="warn"><b>{formula} → <Clasif c={clasif} /></b> · {signif ? "Significativo" : "No significativo"} (umbral: Moderado)</div>
            </>) : (<>
              <Sel k="Severidad · lesión personal" v={m.lesion as number ?? 3} set={set("lesion")} op={SEV_MIN} dis={!edita} />
              <Sel k="Severidad · daño a la propiedad" v={m.propiedad as number ?? 3} set={set("propiedad")} op={SEV_MIN} dis={!edita} />
              <Sel k="Severidad · daño al proceso" v={m.proceso as number ?? 3} set={set("proceso")} op={SEV_MIN} dis={!edita} />
              <div className="field"><span className="k">Severidad final</span>
                {m.modificada ? <select className="in" disabled={!edita} value={sevFinal} onChange={(e) => setM({ ...m, severidad: Number(e.target.value) })}>{SEV_MIN.map((s) => <option key={s}>{s}</option>)}</select>
                  : <span className="in"><b>{sevFinal}</b> <small>(propuesta: la más grave)</small></span>}
                {edita && <button className="btn" onClick={() => setM({ ...m, modificada: !m.modificada, severidad: sevFinal })}>{m.modificada ? "Volver a la propuesta" : "Modificar"}</button>}</div>
              <Sel k="Probabilidad" v={(m.prob as string) ?? "C"} set={set("prob")} op={["A", "B", "C", "D", "E"]} dis={!edita} fmt={(x) => PROB[String(x)]} />
              <div className="row" style={{ alignItems: "center" }}>
                <MatrizMineria sev={sevFinal} prob={String(m.prob)} sevR={rf ? Number(rf.severidad) : undefined} probR={rf ? String(rf.prob) : undefined} />
                <div className="col"><div className="warn"><b>Nivel {nivel} → <Clasif c={clasif} /></b> · {signif ? "Significativo" : "No significativo"} (umbral: Medio)</div>
                  <small>Celda con borde sólido: inicial · borde punteado: residual esperado.</small></div></div>
              {inm && <div className="alert" style={{ marginTop: 8 }}><b>{borrador || edita ? "Al guardar se creará una acción inmediata" : "Esta fila generó una acción inmediata"}</b> con plazo de <b>{clasif === "Alto" ? "24 h" : "72 h"} desde el registro</b>, aunque la IPERC esté en borrador. Se avisará al responsable de SST (campana y tablero).</div>}
            </>)}
            {edita && <div><button className="btn pri" onClick={guardar}>Guardar evaluación</button> {msg && <small>{msg}</small>}</div>}
            {!edita && <small>{borrador ? "Tu rol solo permite consultar." : "Una versión aprobada es de solo lectura: editar crea un borrador nuevo."}</small>}
          </div>
        </div>

        <div className="col">
          <div className="blk"><h4>Controles sugeridos (catálogo, por jerarquía)</h4>
            {grupos.length === 0 && <small>Sin controles propuestos.</small>}
            {grupos.map(([k, l]) => l.map((x) => (
              <div key={x.id} style={{ margin: "4px 0", opacity: dec[x.id] === "no" ? 0.4 : 1, fontSize: 13 }}>
                {JERARQUIA[k]} · {x.descripcion}{dec[x.id] === "ok" && " ✓"}
                {edita && <><button className="btn" onClick={() => setDec({ ...dec, [x.id]: "ok" })}>Aceptar</button>
                  <button className="btn" onClick={() => setDec({ ...dec, [x.id]: "no" })}>Descartar</button></>}
              </div>)))}
          </div>
          <div className="blk"><h4>Evaluación residual (esperada)</h4>
            {!rf || !resTxt ? <small>Sin evaluación residual.</small> : (<>
              <small>{met === "MTPE" ? `A ${rf.A} · B ${rf.B} · C ${rf.C} · D ${rf.D} · S ${rf.S}` : `Severidad ${rf.severidad} · Probabilidad ${rf.prob}`}</small>
              {alerta
                ? <div className="warn"><b>⚠ {resTxt.formula} → {resTxt.clasif}</b> · no baja de clasificación ({clasif} → {resTxt.clasif}). Revisar los controles (RF-17).</div>
                : <div className="okb">{resTxt.formula} → <b>{resTxt.clasif}</b> · baja de clasificación ✓ ({clasif} → {resTxt.clasif})</div>}
            </>)}
          </div>
        </div>
      </div>
    </div>
  );
}
