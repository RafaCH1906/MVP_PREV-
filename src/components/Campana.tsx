"use client";
import Link from "next/link";
import { useState } from "react";
import { supabase } from "@/lib/supabase";
import { useAuth } from "@/lib/auth";
import { useReloj } from "@/lib/reloj";
import { useCarga, ok } from "@/lib/hooks";
import { puedeGestionar } from "@/lib/roles";
import { Acc, Act, SEL_ACC, SEL_ACT, accVencida, actVencida } from "@/lib/consultas";
import { formatoRestante, minutosRestantes } from "@/lib/iperc/engine";

/** T04: avisos dentro de la plataforma (acción inmediata, vencimientos). */
export default function Campana() {
  const { perfil } = useAuth();
  const { ahora, hoy } = useReloj();
  const [abierto, setAbierto] = useState(false);
  const { datos } = useCarga(async () => {
    const acc = ok(await supabase.from("accion").select(SEL_ACC)) as unknown as Acc[];
    const act = ok(await supabase.from("actividad").select(SEL_ACT)) as unknown as Act[];
    return { acc, act };
  }, [perfil]);
  if (!datos || !perfil) return <span className="bell">🔔</span>;
  const gest = puedeGestionar(perfil);
  const mias = <T extends { responsable_id: string | null }>(l: T[]) => (gest ? l : l.filter((x) => x.responsable_id === perfil.id));
  const abiertas = mias(datos.acc).filter((a) => ["ASIGNADA", "EN_IMPLEMENTACION"].includes(a.estado));
  const avisos = [
    ...abiertas.filter((a) => a.inmediata).map((a) => ({
      k: a.id, rojo: true, href: `/registro/accion/${a.id}`,
      t: `Acción inmediata: ${a.descripcion} · ${formatoRestante(minutosRestantes(new Date(a.vence_en), ahora))}`,
    })),
    ...abiertas.filter((a) => !a.inmediata && accVencida(a, ahora)).map((a) => ({
      k: a.id, rojo: true, href: `/registro/accion/${a.id}`, t: `Acción vencida: ${a.descripcion}`,
    })),
    ...mias(datos.act).filter((a) => actVencida(a, hoy)).map((a) => ({
      k: a.id, rojo: false, href: `/registro/actividad/${a.id}`, t: `Actividad vencida: ${a.descripcion}`,
    })),
  ];
  return (
    <span style={{ position: "relative" }}>
      <span className="bell" onClick={() => setAbierto(!abierto)}>🔔{avisos.length > 0 && <b>{avisos.length}</b>}</span>
      {abierto && (
        <div className="card" style={{ position: "absolute", right: 0, top: 36, width: 320, zIndex: 30, fontSize: 12.5 }}>
          <h4 style={{ margin: "0 0 6px" }}>Avisos</h4>
          {avisos.length === 0 && <small>Sin avisos.</small>}
          {avisos.slice(0, 8).map((a) => (
            <Link key={a.k} href={a.href} onClick={() => setAbierto(false)} style={{ display: "block", padding: "4px 0", borderTop: "1px solid var(--line)", color: a.rojo ? "var(--red)" : "inherit" }}>
              {a.t}
            </Link>
          ))}
        </div>
      )}
    </span>
  );
}
