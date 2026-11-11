"use client";
import Link from "next/link";
import { supabase } from "@/lib/supabase";
import { useAuth } from "@/lib/auth";
import { useCarga, ok } from "@/lib/hooks";
import { useReloj } from "@/lib/reloj";
import { Cargando, Tag } from "@/lib/ui";
import { Acc, Act, SEL_ACC, SEL_ACT, actVencida, fechaDM } from "@/lib/consultas";
import AlertaInmediata from "./AlertaInmediata";
import Campana from "./Campana";

/** W7 (izquierda) · S01 Mis pendientes, en el celular. */
export default function Pendientes() {
  const { perfil } = useAuth();
  const { hoy } = useReloj();
  const { datos, cargando, error } = useCarga(async () => {
    const acts = ok(await supabase.from("actividad").select(SEL_ACT).eq("responsable_id", perfil!.id).in("estado", ["PROGRAMADA", "EN_CURSO"]).order("fecha_fin")) as unknown as Act[];
    const accs = ok(await supabase.from("accion").select(SEL_ACC).eq("responsable_id", perfil!.id).in("estado", ["ASIGNADA", "EN_IMPLEMENTACION"]).order("vence_en")) as unknown as Acc[];
    const fids = accs.map((a) => a.control?.fila_id).filter(Boolean) as string[];
    const filas = fids.length ? ok(await supabase.from("iperc_fila").select("id,iperc_id,codigo,nivel_inicial,clasif_inicial").in("id", fids)) as { id: string; iperc_id: string; codigo: string; nivel_inicial: number; clasif_inicial: string }[] : [];
    return { acts, accs, filas };
  }, [perfil]);
  if (cargando) return <Cargando />;
  if (error || !datos) return <Cargando error={error} />;
  const { acts, accs, filas } = datos;
  const inm = accs.filter((a) => a.inmediata);
  const otras = accs.filter((a) => !a.inmediata);
  return (
    <div>
      <div className="ptop"><b>Mis pendientes</b><Campana /></div>
      {inm.map((a) => (
        <AlertaInmediata key={a.id} celular a={{ id: a.id, descripcion: a.descripcion, vence_en: a.vence_en, estado: a.estado, responsable: a.responsable, fila: filas.find((f) => f.id === a.control?.fila_id) ?? null }} />
      ))}
      {otras.map((a) => (
        <Link key={a.id} href={`/registro/accion/${a.id}`} className="pcard">
          <Tag estado={a.estado} /> · {fechaDM(a.vence_en)}<br /><b>{a.descripcion}</b><br /><small>Acción · {a.control?.codigo ?? "hallazgo"}</small>
        </Link>
      ))}
      {acts.map((a) => (
        <Link key={a.id} href={`/registro/actividad/${a.id}`} className="pcard">
          <Tag estado={actVencida(a, hoy) ? "VENCIDA" : a.estado} /> · {fechaDM(a.fecha_fin)}<br /><b>{a.descripcion}</b><br /><small>Programa anual · {a.plantilla_codigo ? `Base ${a.plantilla_codigo}` : a.control?.codigo ?? ""}</small>
        </Link>
      ))}
      {acts.length + accs.length === 0 && <p className="muted">No tienes pendientes.</p>}
      <Link href="/reportar" className="pcard"><span className="tag">Hallazgo</span><br /><b>+ Reportar un hallazgo</b><br /><small>Foto, ubicación y descripción</small></Link>
    </div>
  );
}
