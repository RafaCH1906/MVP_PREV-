"use client";
import Link from "next/link";
import { supabase } from "@/lib/supabase";
import { useAuth } from "@/lib/auth";
import { useCarga, ok } from "@/lib/hooks";
import { Cargando, Tag } from "@/lib/ui";
import { fechaDM } from "@/lib/consultas";

type H = { id: string; origen: string; descripcion: string; fecha: string; estado: string; criticidad: string | null };
const ORI: Record<string, string> = { INSPECCION: "Inspección", OBSERVACION: "Observación", AUDITORIA: "Auditoría" };

/** S03 · Lista de hallazgos. */
export default function Seguimiento() {
  const { perfil } = useAuth();
  const { datos, cargando, error } = useCarga(async () => ({
    h: ok(await supabase.from("hallazgo").select("id,origen,descripcion,fecha,estado,criticidad").order("fecha", { ascending: false })) as H[],
    a: ok(await supabase.from("accion").select("id,hallazgo_id,estado")) as { id: string; hallazgo_id: string | null; estado: string }[],
  }), [perfil]);
  if (cargando) return <Cargando />;
  if (error || !datos) return <Cargando error={error} />;
  return (
    <div>
      <h1>Seguimiento · hallazgos</h1>
      {datos.h.map((h) => {
        const n = datos.a.filter((a) => a.hallazgo_id === h.id);
        return (
          <Link key={h.id} href={`/seguimiento/${h.id}`} className="blk" style={{ display: "block", textDecoration: "none", color: "inherit" }}>
            <small>{ORI[h.origen] ?? h.origen} · {fechaDM(h.fecha)}{h.criticidad ? ` · Criticidad ${h.criticidad.toLowerCase()}` : ""}</small> &nbsp;<Tag cls="t-amb">{n.length ? `${n.length} acción(es)` : "Sin acción"}</Tag>
            <h4 style={{ fontSize: 14, marginTop: 4 }}>{h.descripcion}</h4>
          </Link>
        );
      })}
      {datos.h.length === 0 && <p className="muted">Sin hallazgos registrados.</p>}
    </div>
  );
}
