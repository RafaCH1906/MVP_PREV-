"use client";
import Link from "next/link";
import { supabase } from "@/lib/supabase";
import { useCarga, ok } from "@/lib/hooks";
import { fechaDM } from "@/lib/consultas";
import { Cargando } from "@/lib/ui";

type Nodo = { k: string; txt: string; href?: string; pendiente?: boolean };

/** T05: cadena hallazgo → acción/actividad → evidencia → fila IPERC. Parte de un registro (acción, actividad o hallazgo). */
export default function TrazaPanel({ tipo, id }: { tipo: "accion" | "actividad" | "hallazgo"; id: string }) {
  const { datos, cargando, error } = useCarga(async () => {
    const nodos: Nodo[] = [];
    let filaId: string | null = null;
    let hallId: string | null = null;
    let accId: string | null = null, actId: string | null = null;
    if (tipo === "hallazgo") hallId = id;
    if (tipo === "accion") {
      const a = ok(await supabase.from("accion").select("id,descripcion,estado,hallazgo_id,control(codigo,fila_id)").eq("id", id).limit(1)) as unknown as { id: string; descripcion: string; estado: string; hallazgo_id: string | null; control: { fila_id: string } | null }[];
      if (a[0]) { accId = a[0].id; hallId = a[0].hallazgo_id; filaId = a[0].control?.fila_id ?? null; }
    }
    if (tipo === "actividad") {
      const a = ok(await supabase.from("actividad").select("id,hallazgo_id,control(fila_id)").eq("id", id).limit(1)) as unknown as { id: string; hallazgo_id: string | null; control: { fila_id: string } | null }[];
      if (a[0]) { actId = a[0].id; hallId = a[0].hallazgo_id; filaId = a[0].control?.fila_id ?? null; }
    }
    if (hallId) {
      const h = ok(await supabase.from("hallazgo").select("id,descripcion,fecha,fila_id").eq("id", hallId).limit(1)) as { id: string; descripcion: string; fecha: string; fila_id: string | null }[];
      if (h[0]) { nodos.push({ k: "h", txt: `Hallazgo ${fechaDM(h[0].fecha)} · ${h[0].descripcion.slice(0, 60)}`, href: `/seguimiento/${h[0].id}` }); filaId = filaId ?? h[0].fila_id; }
      const accs = ok(await supabase.from("accion").select("id,descripcion,estado").eq("hallazgo_id", hallId)) as { id: string; descripcion: string; estado: string }[];
      accs.forEach((a) => nodos.push({ k: a.id, txt: `Acción · ${a.descripcion.slice(0, 50)} · ${a.estado.toLowerCase().replace(/_/g, " ")}`, href: `/registro/accion/${a.id}` }));
      if (!accId && accs[0]) accId = accs[0].id;
    } else if (accId || actId) {
      nodos.push({ k: "r", txt: accId ? "Acción correctiva / inmediata" : "Actividad del programa" });
    }
    const ev = (accId || actId)
      ? ok(await supabase.from("evidencia").select("id,tipo").or(accId ? `accion_id.eq.${accId}` : `actividad_id.eq.${actId}`)) as { id: string; tipo: string }[]
      : [];
    nodos.push({ k: "e", txt: ev.length ? `Evidencia (${ev.length})` : "Evidencia (pendiente)", pendiente: ev.length === 0 });
    if (filaId) {
      const f = ok(await supabase.from("iperc_fila").select("codigo,clasif_inicial,nivel_inicial,iperc:iperc_version(version,estado)").eq("id", filaId).limit(1)) as unknown as { codigo: string; clasif_inicial: string; nivel_inicial: number; iperc: { version: number; estado: string } | null }[];
      if (f[0]) nodos.push({ k: "f", txt: `Fila ${f[0].codigo} · v${f[0].iperc?.version} ${f[0].iperc?.estado === "BORRADOR" ? "borrador" : "aprobada"} · ${f[0].clasif_inicial} (${f[0].nivel_inicial})`, href: `/iperc/${f[0].codigo}` });
    }
    return nodos;
  }, [tipo, id]);
  if (cargando) return <Cargando />;
  if (error || !datos) return <Cargando error={error} />;
  return (
    <div className="blk">
      <h4>Trazabilidad (T05)</h4>
      {datos.map((n, i) => (
        <div key={n.k}>
          {i > 0 && <div style={{ textAlign: "center" }}>↓</div>}
          {n.href ? <Link href={n.href} className="pcard">{n.txt}</Link> : <div className={`pcard ${n.pendiente ? "ph" : ""}`} style={n.pendiente ? { minHeight: 0 } : undefined}>{n.txt}</div>}
        </div>
      ))}
    </div>
  );
}
