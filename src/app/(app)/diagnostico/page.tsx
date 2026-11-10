"use client";
import Link from "next/link";
import { useState } from "react";
import { supabase } from "@/lib/supabase";
import { useAuth } from "@/lib/auth";
import { useCarga, ok } from "@/lib/hooks";
import { Cargando } from "@/lib/ui";

type Bq = { bloque_num: number; bloque: string; pct: number };
type Br = { item_n: number; estado: string; bloque_num: number; bloque: string; indicador: string; accion_sugerida: string | null };
const coma = (n: number | null) => (n == null ? "—" : n.toFixed(1).replace(".", ","));

/** W3 · Resultados del diagnóstico y brechas (D03). */
export default function Resultados() {
  const { perfil } = useAuth();
  const [est, setEst] = useState<"NC" | "P">("NC");
  const [bq, setBq] = useState("");
  const { datos, cargando, error } = useCarga(async () => {
    const b = ok(await supabase.from("v_cumplimiento_bloque").select("bloque_num,bloque,pct").order("bloque_num")) as Bq[];
    const t = await supabase.from("v_cumplimiento_total").select("pct").maybeSingle();
    const br = ok(await supabase.from("v_brecha").select("item_n,estado,bloque_num,bloque,indicador,accion_sugerida").order("item_n")) as Br[];
    return { b, total: (t.data as { pct: number } | null)?.pct ?? null, br };
  }, [perfil]);
  if (cargando) return <Cargando />;
  if (error || !datos) return <Cargando error={error} />;
  const { b, total, br } = datos;
  const nc = br.filter((x) => x.estado === "NC"), pa = br.filter((x) => x.estado === "P");
  const lista = (est === "NC" ? nc : pa).filter((x) => !bq || String(x.bloque_num) === bq);
  return (
    <div>
      <div className="noprint" style={{ marginBottom: 8 }}>
        <button className="btn" onClick={() => window.print()}>Exportar PDF</button>
        <Link href="/plan" className="btn pri">Usar las brechas en el programa anual →</Link>
      </div>
      <div className="row">
        <div className="col">
          <div className="blk"><h4>Cumplimiento 2026 · <span style={{ fontSize: 20 }}>{coma(total)} %</span></h4>
            <small>% = Σ(peso × puntaje) / Σ(peso de los ítems aplicables) · C = 1 · P = 0,5 · NC = 0 · NA excluido</small>
            {b.map((x) => (
              <Link key={x.bloque_num} href={`/diagnostico/bloque/${x.bloque_num}`} className="barh" style={{ textDecoration: "none" }}>
                <span className="l">{x.bloque}</span><span className="t"><span className="f" style={{ width: `${x.pct}%` }} /></span><span className="p">{coma(x.pct)} %</span>
              </Link>
            ))}
            <small>Toca un bloque para ver o retomar su cuestionario.</small>
          </div>
        </div>
        <div className="col" style={{ flex: 1.4 }}>
          <div className="blk"><h4>Brechas · {br.length} &nbsp;
            <button className={`btn ${est === "NC" ? "on" : ""}`} onClick={() => setEst("NC")}>No cumple ({nc.length})</button>
            <button className={`btn ${est === "P" ? "on" : ""}`} onClick={() => setEst("P")}>Parcial ({pa.length})</button>
            <select className="btn" value={bq} onChange={(e) => setBq(e.target.value)}><option value="">Bloque ▾</option>{b.map((x) => <option key={x.bloque_num} value={x.bloque_num}>{x.bloque}</option>)}</select></h4>
            <div className="scroll"><table className="mini"><thead><tr><th>Ítem</th><th>Brecha</th><th>Acción sugerida</th></tr></thead><tbody>
              {lista.slice(0, 25).map((x) => <tr key={x.item_n}><td>{x.item_n}</td><td>{x.indicador}</td><td>{x.accion_sugerida}</td></tr>)}
              {lista.length > 25 && <tr><td colSpan={3}><small>… {lista.length - 25} más · Las de No cumple van primero y se distribuyen en el primer semestre (3.2.4)</small></td></tr>}
            </tbody></table></div>
          </div>
        </div>
      </div>
    </div>
  );
}
