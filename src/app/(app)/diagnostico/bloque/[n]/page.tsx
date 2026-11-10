"use client";
import Link from "next/link";
import { useParams } from "next/navigation";
import { useState } from "react";
import { supabase } from "@/lib/supabase";
import { useAuth } from "@/lib/auth";
import { useCarga, ok } from "@/lib/hooks";
import { puedeGestionar } from "@/lib/roles";
import { Cargando } from "@/lib/ui";

type Item = { n: number; bloque_num: number; bloque: string; subseccion: string | null; indicador: string; ayuda: string | null; accion_sugerida: string | null; base_normativa: string | null };
type Rsp = { item_n: number; estado: string; comentario: string | null };
const OPC: [string, string][] = [["C", "Cumple"], ["P", "Parcial"], ["NC", "No cumple"], ["NA", "No aplica"]];

/** W2 · Cuestionario de diagnóstico, un bloque (D02). */
export default function Cuestionario() {
  const { n } = useParams<{ n: string }>();
  const { perfil } = useAuth();
  const edita = puedeGestionar(perfil);
  const [idx, setIdx] = useState(0);
  const [v, setV] = useState(0);
  const [guardado, setGuardado] = useState<string | null>(null);
  const { datos, cargando, error } = useCarga(async () => {
    const items = ok(await supabase.from("diagnostico_item").select("n,bloque_num,bloque,subseccion,indicador,ayuda,accion_sugerida,base_normativa").order("n")) as Item[];
    const rs = ok(await supabase.from("diagnostico_respuesta").select("item_n,estado,comentario")) as Rsp[];
    return { items, rs };
  }, [perfil, v]);
  if (cargando && !datos) return <Cargando />;
  if (error || !datos) return <Cargando error={error} />;
  const { items, rs } = datos;
  const rmap = new Map(rs.map((r) => [r.item_n, r]));
  const bloques = Array.from(new Map(items.map((i) => [i.bloque_num, i.bloque])).entries());
  const delBloque = items.filter((i) => String(i.bloque_num) === n);
  const it = delBloque[Math.min(idx, delBloque.length - 1)];
  if (!it) return <Cargando error="Bloque no encontrado" />;
  const r = rmap.get(it.n);

  const guardar = async (estado: string, comentario?: string | null) => {
    const { error: e } = await supabase.from("diagnostico_respuesta").upsert(
      { empresa_id: perfil!.empresa_id, item_n: it.n, estado, comentario: comentario ?? r?.comentario ?? null }, { onConflict: "empresa_id,item_n" });
    setGuardado(e ? `No se pudo guardar: ${e.message}` : `✓ Guardado · ${new Date().toLocaleTimeString("es-PE", { hour: "2-digit", minute: "2-digit" })}`);
    setV(v + 1);
  };

  return (
    <div className="row">
      <div style={{ width: 260, maxWidth: "100%" }}>
        <div className="blk"><h4>Bloques · {rs.length} de {items.length}</h4>
          {bloques.map(([num, nombre]) => {
            const tot = items.filter((i) => i.bloque_num === num).length;
            const hechos = items.filter((i) => i.bloque_num === num && rmap.has(i.n)).length;
            const actual = String(num) === n;
            return (
              <Link key={num} href={`/diagnostico/bloque/${num}`} onClick={() => setIdx(0)} className="barh" style={{ textDecoration: "none" }}>
                <span className="l">{actual ? <b>{nombre} ●</b> : nombre}{hechos === tot ? " ✓" : ""}</span><span className="p">{hechos}/{tot}</span>
              </Link>
            );
          })}
          <small>Puedes salir y retomar donde te quedaste.</small>
        </div>
      </div>
      <div className="col">
        <div className="blk">
          <small>{it.bloque}{it.subseccion ? ` › ${it.subseccion}` : ""} · Ítem {it.n} de {items.length}</small>
          <h4 style={{ fontSize: 14, marginTop: 6 }}>{it.indicador}</h4>
          {it.ayuda && <div className="warn"><b>¿Qué significa?</b> {it.ayuda}{it.base_normativa && <><br /><small>Base normativa: {it.base_normativa}</small></>}</div>}
          <div className="opts" style={{ margin: "10px 0" }}>
            {OPC.map(([k, t]) => <button key={k} className={r?.estado === k ? "on" : ""} disabled={!edita} onClick={() => guardar(k)}>{t}</button>)}
          </div>
          <div className="field"><span className="k">Comentario</span>
            <input key={it.n} className="in" defaultValue={r?.comentario ?? ""} disabled={!edita || !r} placeholder={r ? "" : "Primero elige una respuesta"}
              onBlur={(e) => r && e.target.value !== (r.comentario ?? "") && guardar(r.estado, e.target.value)} /></div>
          <div className="field"><span className="k">Evidencia (opcional)</span><button className="btn" disabled>Adjuntar</button></div>
          {(r?.estado === "P" || r?.estado === "NC") && it.accion_sugerida && (
            <div className="okb">Si queda en Parcial o No cumple, se creará la brecha con la acción sugerida: «{it.accion_sugerida}».</div>
          )}
          <div style={{ display: "flex", justifyContent: "space-between", marginTop: 8, alignItems: "center", flexWrap: "wrap" }}>
            <button className="btn" disabled={idx <= 0} onClick={() => setIdx(idx - 1)}>← Ítem {delBloque[idx - 1]?.n ?? ""}</button>
            <small>{guardado ?? (edita ? "Se guarda al elegir una respuesta" : "Solo lectura")}</small>
            <button className="btn pri" disabled={idx >= delBloque.length - 1} onClick={() => setIdx(idx + 1)}>Ítem {delBloque[idx + 1]?.n ?? ""} →</button>
          </div>
        </div>
      </div>
    </div>
  );
}
