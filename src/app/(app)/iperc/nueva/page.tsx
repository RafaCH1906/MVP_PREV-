"use client";
import Link from "next/link";
import { useRouter } from "next/navigation";
import { useEffect, useState } from "react";
import { supabase } from "@/lib/supabase";
import { useAuth } from "@/lib/auth";
import { useCarga, ok } from "@/lib/hooks";
import { useReloj } from "@/lib/reloj";
import { puedeGestionar } from "@/lib/roles";
import { Cargando, Clasif as Tag } from "@/lib/ui";
import { JERARQUIA } from "@/lib/consultas";
import { Metodologia, alertaResidual, requiereAccionInmediata } from "@/lib/iperc/engine";
import { crearAccionInmediata, obtenerOCrearBorrador, siguienteCodigo } from "@/lib/iperc-db";
import EvalForm, { Factores, calcular, factoresPorDefecto, paraGuardar } from "@/components/EvalForm";
import AccionInmediataForm, { AccInm, Usr } from "@/components/AccionInmediataForm";

type Tarea = { id: string; codigo: string; proceso: string; nombre: string };
type Pel = { id: string; codigo: string; sector: string; tipo: string; peligro: string; riesgo: string; consecuencia: string; sev_mtpe: number | null };
type Cat = { id: string; jerarquia: string; descripcion: string };
type Ex = { jer: string; desc: string };

/** I02 + I03 · Nueva fila IPERC: tarea → peligro del catálogo → evaluación → controles. Se guarda en el borrador. */
export default function NuevaFila() {
  const { perfil } = useAuth();
  const { ahora } = useReloj();
  const router = useRouter();
  const met = (perfil?.empresa?.metodologia ?? "MINERIA") as Metodologia;
  const [tareaId, setTareaId] = useState("");
  const [pelId, setPelId] = useState("");
  const [q, setQ] = useState("");
  const [m, setM] = useState<Factores>(factoresPorDefecto(met));
  const [conRes, setConRes] = useState(true);
  const [mr, setMr] = useState<Factores>(factoresPorDefecto(met));
  const [exist, setExist] = useState<Ex[]>([]);
  const [nuevoEx, setNuevoEx] = useState<Ex>({ jer: "ADMINISTRATIVO", desc: "" });
  const [sug, setSug] = useState<Cat[]>([]);
  const [acepta, setAcepta] = useState<Set<string>>(new Set());
  const [ai, setAi] = useState<AccInm>({ descripcion: "Restringir el acceso y evaluar la labor antes de reanudar el trabajo", responsableId: "" });
  const [msg, setMsg] = useState<string | null>(null);
  const [guardando, setGuardando] = useState(false);
  const [hallId, setHallId] = useState<string | null>(null);
  const [nExp, setNExp] = useState<number | null>(null);

  useEffect(() => { setHallId(new URLSearchParams(window.location.search).get("hallazgo")); }, []);

  const { datos, cargando, error } = useCarga(async () => ({
    tareas: ok(await supabase.from("tarea").select("id,codigo,proceso,nombre").order("codigo")) as Tarea[],
    pel: ok(await supabase.from("peligro_catalogo").select("id,codigo,sector,tipo,peligro,riesgo,consecuencia,sev_mtpe").order("codigo")) as Pel[],
    usr: ok(await supabase.from("usuario").select("id,nombre,roles").order("nombre")) as Usr[],
    hall: hallId ? ((ok(await supabase.from("hallazgo").select("id,descripcion,fecha").eq("id", hallId).limit(1)) as { id: string; descripcion: string; fecha: string }[])[0] ?? null) : null,
  }), [perfil, hallId]);

  const pelSel = datos?.pel.find((p) => p.id === pelId);

  // expuestos desde los puestos de la tarea (alimenta el índice A de MTPE)
  useEffect(() => {
    if (!tareaId) { setNExp(null); return; }
    (async () => {
      const tp = ok(await supabase.from("tarea_puesto").select("puesto_id").eq("tarea_id", tareaId)) as { puesto_id: string }[];
      if (!tp.length) { setNExp(null); return; }
      const pu = ok(await supabase.from("puesto").select("n_trabajadores").in("id", tp.map((x) => x.puesto_id))) as { n_trabajadores: number }[];
      setNExp(pu.reduce((a, b) => a + b.n_trabajadores, 0) || null);
    })().catch(() => setNExp(null));
  }, [tareaId]);

  // controles sugeridos del catálogo y valores por defecto al elegir peligro/tarea
  useEffect(() => {
    if (!pelId) { setSug([]); return; }
    supabase.from("control_catalogo").select("id,jerarquia,descripcion").eq("peligro_id", pelId).then(({ data }) => setSug((data ?? []) as Cat[]));
    setAcepta(new Set());
  }, [pelId]);
  useEffect(() => {
    const f = factoresPorDefecto(met, nExp, pelSel?.sev_mtpe);
    setM(f); setMr(f);
  }, [met, nExp, pelSel?.sev_mtpe]);

  if (!puedeGestionar(perfil)) return <p className="muted">Tu rol no permite registrar filas de la IPERC.</p>;
  if (cargando && !datos) return <Cargando />;
  if (error || !datos) return <Cargando error={error} />;

  const lista = datos.pel.filter((p) => (met === "MINERIA" || p.sector === "General") && (!q || `${p.codigo} ${p.peligro} ${p.riesgo} ${p.tipo}`.toLowerCase().includes(q.toLowerCase())));
  const ci = calcular(met, m), cr = calcular(met, mr);
  const inm = ci.ok && requiereAccionInmediata(met, ci.clasif);
  const alerta = conRes && ci.ok && cr.ok && alertaResidual(met, ci.clasif, cr.clasif);
  const puede = !!tareaId && !!pelId && ci.ok && (!inm || (ai.descripcion && ai.responsableId)) && !guardando;

  const guardar = async () => {
    setGuardando(true); setMsg(null);
    try {
      const empresaId = perfil!.empresa_id;
      const bor = await obtenerOCrearBorrador(empresaId);
      const { data: emp } = await supabase.from("empresa").select("codigo").limit(1);
      const codigo = await siguienteCodigo(emp?.[0]?.codigo ?? "X", bor.id);
      const filaId = crypto.randomUUID();
      const reg = ahora;
      const r = await supabase.from("iperc_fila").insert({
        id: filaId, empresa_id: empresaId, iperc_id: bor.id, codigo, tarea_id: tareaId, peligro_id: pelId, n_expuestos: met === "MTPE" ? nExp : null,
        eval_inicial: paraGuardar(met, m), nivel_inicial: ci.nivel, clasif_inicial: ci.clasif, significativo: ci.signif,
        eval_residual: conRes ? paraGuardar(met, mr) : null, nivel_residual: conRes ? cr.nivel : null, clasif_residual: conRes ? cr.clasif : null,
        registrado_en: reg.toISOString(), fuente: "Registrado en Prevé",
      });
      if (r.error) throw new Error(r.error.message);
      const ctl = [
        ...exist.map((x) => ({ jerarquia: x.jer, descripcion: x.desc, existente: true })),
        ...sug.filter((s) => acepta.has(s.id)).map((s) => ({ jerarquia: s.jerarquia, descripcion: s.descripcion, existente: false })),
      ].map((c) => ({ id: crypto.randomUUID(), empresa_id: empresaId, fila_id: filaId, codigo, ...c }));
      if (ctl.length) { const c = await supabase.from("control").insert(ctl); if (c.error) throw new Error(c.error.message); }
      if (inm) await crearAccionInmediata({ empresaId, filaId, codigo, clasif: ci.clasif, registradoEn: reg, descripcion: ai.descripcion, responsableId: ai.responsableId });
      if (hallId) await supabase.from("hallazgo").update({ fila_id: filaId }).eq("id", hallId);
      router.push(`/iperc/${codigo}`);
    } catch (e) { setMsg(`No se pudo guardar: ${(e as Error).message}`); setGuardando(false); }
  };

  return (
    <div>
      <p><Link href="/iperc" style={{ textDecoration: "underline" }}>← Matriz IPERC</Link> <small>· Nueva fila: se guarda en el borrador de la IPERC (la versión aprobada no cambia)</small></p>
      {datos.hall && <div className="warn"><b>Desde el hallazgo del {datos.hall.fecha}:</b> {datos.hall.descripcion}<br /><small>Elige la tarea y el peligro que corresponden; al guardar, el hallazgo quedará enlazado a la nueva fila (RF-34).</small></div>}
      <div className="row">
        <div className="col" style={{ flex: 1.3 }}>
          <div className="blk"><h4>1 · Tarea</h4>
            <select className="in" style={{ width: "100%", padding: 5 }} value={tareaId} onChange={(e) => setTareaId(e.target.value)}>
              <option value="">Elegir tarea del alcance…</option>{datos.tareas.map((t) => <option key={t.id} value={t.id}>{t.codigo} · {t.proceso} › {t.nombre}</option>)}</select></div>
          <div className="blk"><h4>2 · Peligro (catálogo)</h4>
            <input className="in" style={{ width: "100%", padding: 5, border: "1.5px solid var(--wf)", borderRadius: 6 }} placeholder="Buscar por peligro, riesgo o tipo…" value={q} onChange={(e) => setQ(e.target.value)} />
            <div style={{ maxHeight: 200, overflowY: "auto", marginTop: 6 }}>
              {lista.map((p) => (
                <label key={p.id} style={{ display: "block", fontSize: 13, padding: "3px 0", cursor: "pointer", fontWeight: pelId === p.id ? 700 : 400 }}>
                  <input type="radio" name="pel" checked={pelId === p.id} onChange={() => setPelId(p.id)} /> {p.codigo} · {p.peligro} <small>→ {p.riesgo}</small></label>))}
              {lista.length === 0 && <small>Sin resultados.</small>}
            </div></div>
          {pelSel && <div className="blk"><small>Riesgo:</small> {pelSel.riesgo} · <small>Consecuencia:</small> {pelSel.consecuencia}</div>}
          <div className="blk"><h4>3 · Controles existentes</h4>
            {exist.map((x, i) => <div key={i} style={{ fontSize: 13 }}>{JERARQUIA[x.jer]} · {x.desc} <button className="btn" onClick={() => setExist(exist.filter((_, j) => j !== i))}>Quitar</button></div>)}
            <div className="field">
              <select className="in" style={{ flex: "0 0 150px" }} value={nuevoEx.jer} onChange={(e) => setNuevoEx({ ...nuevoEx, jer: e.target.value })}>{Object.entries(JERARQUIA).map(([k, v]) => <option key={k} value={k}>{v}</option>)}</select>
              <input className="in" placeholder="Describe el control que ya existe" value={nuevoEx.desc} onChange={(e) => setNuevoEx({ ...nuevoEx, desc: e.target.value })} />
              <button className="btn" disabled={!nuevoEx.desc} onClick={() => { setExist([...exist, nuevoEx]); setNuevoEx({ ...nuevoEx, desc: "" }); }}>Agregar</button></div></div>
          <div className="blk"><h4>4 · Evaluación inicial</h4>
            <EvalForm met={met} m={m} onChange={setM} nExpuestos={nExp} marcaMatriz="sel" matrizOtra={conRes && cr.ok ? { sev: cr.sevFinal, prob: String(mr.prob) } : undefined} />
            {inm && <AccionInmediataForm clasif={ci.clasif} usuarios={datos.usr} value={ai} onChange={setAi} />}</div>
        </div>
        <div className="col">
          <div className="blk"><h4>Controles sugeridos (catálogo, por jerarquía)</h4>
            {!pelId && <small>Elige un peligro para ver los controles sugeridos.</small>}
            {Object.keys(JERARQUIA).map((k) => sug.filter((s) => s.jerarquia === k).map((s) => (
              <label key={s.id} style={{ display: "block", fontSize: 13, margin: "4px 0" }}>
                <input type="checkbox" checked={acepta.has(s.id)} onChange={(e) => { const n = new Set(acepta); e.target.checked ? n.add(s.id) : n.delete(s.id); setAcepta(n); }} /> {JERARQUIA[k]} · {s.descripcion}</label>)))}
            <small>Marca los que aceptas. Los descartados no se guardan.</small></div>
          <div className="blk"><h4>5 · Evaluación residual (esperada) <label style={{ fontWeight: 400, fontSize: 12 }}><input type="checkbox" checked={conRes} onChange={(e) => setConRes(e.target.checked)} /> incluir</label></h4>
            {conRes && <EvalForm met={met} m={mr} onChange={setMr} nExpuestos={nExp} marcaMatriz="res" matrizOtra={ci.ok ? { sev: ci.sevFinal, prob: String(m.prob) } : undefined} />}
            {conRes && ci.ok && cr.ok && (alerta
              ? <div className="warn"><b>⚠ El riesgo residual ({cr.clasif}) no baja de la clasificación inicial ({ci.clasif}).</b> Revisa los controles (RF-17).</div>
              : <div className="okb">Baja de clasificación ✓ ({ci.clasif} → {cr.clasif})</div>)}</div>
          <button className="btn pri" style={{ width: "100%", padding: 9 }} disabled={!puede} onClick={guardar}>{guardando ? "Guardando…" : "Guardar fila en el borrador"}</button>
          {ci.ok && <p style={{ fontSize: 12 }}>Resultado: <Tag c={ci.clasif} n={ci.nivel} /> {ci.signif ? "· significativo" : ""}</p>}
          {msg && <p className="bad" style={{ fontSize: 13 }}>{msg}</p>}
        </div>
      </div>
    </div>
  );
}
