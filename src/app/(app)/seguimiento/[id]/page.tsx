"use client";
import Link from "next/link";
import { useParams } from "next/navigation";
import { useState } from "react";
import { supabase } from "@/lib/supabase";
import { useAuth } from "@/lib/auth";
import { useCarga, ok } from "@/lib/hooks";
import { useReloj } from "@/lib/reloj";
import { Cargando, Tag } from "@/lib/ui";
import { Acc, SEL_ACC, accVencida, fechaDM } from "@/lib/consultas";
import { puedeGestionar } from "@/lib/roles";
import TrazaPanel from "@/components/TrazaPanel";

type H = { id: string; origen: string; descripcion: string; ubicacion: string | null; criticidad: string | null; fecha: string; fila_id: string | null };
type Fila = { codigo: string; nivel_inicial: number; clasif_inicial: string; tarea: { nombre: string } | null; peligro: { codigo: string; peligro: string } | null; iperc: { version: number; estado: string } | null };
type U = { id: string; nombre: string };
const ORI: Record<string, string> = { INSPECCION: "Inspección", OBSERVACION: "Observación", AUDITORIA: "Auditoría" };

/** W8 · Hallazgo, acciones y «Agregar a la IPERC» (S04). */
export default function DetalleHallazgo() {
  const { id } = useParams<{ id: string }>();
  const { perfil } = useAuth();
  const { ahora } = useReloj();
  const gest = puedeGestionar(perfil);
  const [v, setV] = useState(0);
  const [form, setForm] = useState(false);
  const [d, setD] = useState({ desc: "", resp: "", plazo: "" });
  const [msg, setMsg] = useState<string | null>(null);
  const { datos, cargando, error } = useCarga(async () => {
    const h = (ok(await supabase.from("hallazgo").select("id,origen,descripcion,ubicacion,criticidad,fecha,fila_id").eq("id", id).limit(1)) as H[])[0];
    if (!h) throw new Error("Hallazgo no encontrado");
    const acc = ok(await supabase.from("accion").select(SEL_ACC).eq("hallazgo_id", id)) as unknown as Acc[];
    const usr = ok(await supabase.from("usuario").select("id,nombre").order("nombre")) as U[];
    const fila = h.fila_id ? (ok(await supabase.from("iperc_fila").select("codigo,nivel_inicial,clasif_inicial,tarea(nombre),peligro:peligro_catalogo(codigo,peligro),iperc:iperc_version(version,estado)").eq("id", h.fila_id).limit(1)) as unknown as Fila[])[0] ?? null : null;
    return { h, acc, usr, fila };
  }, [id, perfil, v]);
  if (cargando && !datos) return <Cargando />;
  if (error || !datos) return <Cargando error={error} />;
  const { h, acc, usr, fila } = datos;
  const cerrado = acc.length > 0 && acc.every((a) => a.estado === "VERIFICADA");

  const agregar = async () => {
    const { error: e } = await supabase.from("accion").insert({
      id: crypto.randomUUID(), empresa_id: perfil!.empresa_id, hallazgo_id: id, descripcion: d.desc, responsable_id: d.resp,
      vence_en: new Date(d.plazo + "T23:59:00-05:00").toISOString(), estado: "ASIGNADA", inmediata: false,
    });
    setMsg(e ? `No se pudo crear la acción: ${e.message}` : "✓ Acción creada");
    if (!e) { setForm(false); setD({ desc: "", resp: "", plazo: "" }); }
    setV(v + 1);
  };

  return (
    <div className="row">
      <div className="col" style={{ flex: 2 }}>
        <p><Link href="/seguimiento" style={{ textDecoration: "underline" }}>← Hallazgos</Link></p>
        <div className="blk"><small>Hallazgo · {ORI[h.origen] ?? h.origen} · {fechaDM(h.fecha)}{h.ubicacion ? ` · ${h.ubicacion}` : ""}{h.criticidad ? ` · Criticidad ${h.criticidad.toLowerCase()}` : ""}</small> &nbsp;<Tag cls="t-amb">{cerrado ? "Cerrado" : acc.length ? "Con acción" : "Abierto"}</Tag>
          <h4 style={{ fontSize: 14, marginTop: 4 }}>{h.descripcion}</h4>
          <div className="ph">Fotos adjuntas</div></div>

        <div className="blk"><h4>Acciones correctivas {gest && <button className="btn" onClick={() => setForm(!form)}>+ Agregar acción</button>}</h4>
          {form && (
            <div className="warn">
              <div className="field"><span className="k">Acción</span><input className="in" value={d.desc} onChange={(e) => setD({ ...d, desc: e.target.value })} /></div>
              <div className="field"><span className="k">Responsable</span><select className="in" value={d.resp} onChange={(e) => setD({ ...d, resp: e.target.value })}><option value="">Elegir…</option>{usr.map((u) => <option key={u.id} value={u.id}>{u.nombre}</option>)}</select></div>
              <div className="field"><span className="k">Plazo</span><input className="in" type="date" value={d.plazo} onChange={(e) => setD({ ...d, plazo: e.target.value })} /></div>
              <button className="btn pri" disabled={!d.desc || !d.resp || !d.plazo} onClick={agregar}>Crear acción</button>
            </div>)}
          {msg && <small>{msg}</small>}
          <div className="scroll"><table className="mini"><thead><tr><th>Acción</th><th>Responsable</th><th>Plazo</th><th>Estado</th><th>Verificación</th></tr></thead><tbody>
            {acc.map((a) => (
              <tr key={a.id}><td><Link href={`/registro/accion/${a.id}`} style={{ textDecoration: "underline" }}>{a.descripcion}</Link></td><td>{a.responsable?.nombre}</td><td>{fechaDM(a.vence_en)}</td>
                <td><Tag estado={accVencida(a, ahora) ? "VENCIDA" : a.estado} /></td>
                <td><small>{a.estado === "VERIFICADA" ? "Verificada" : a.estado === "POR_VERIFICAR" ? "Pendiente: la verifica otra persona" : `La hará otra persona, no ${a.responsable?.nombre.split(" ")[0]}`}</small></td></tr>))}
            {acc.length === 0 && <tr><td colSpan={5}><small>Sin acciones.</small></td></tr>}
          </tbody></table></div>
          <small>El hallazgo se cierra cuando todas sus acciones están verificadas.</small></div>

        <div className="blk" style={{ borderColor: "var(--amber)" }}><h4>¿Revela un peligro que no está en la IPERC?</h4>
          {fila ? (
            <div className="okb">✓ Relacionado con la fila <b>{fila.codigo}</b> de la <b>IPERC 2026 v{fila.iperc?.version} {fila.iperc?.estado === "BORRADOR" ? "(borrador)" : "(aprobada)"}</b>: <b>{fila.tarea?.nombre}</b> + <b>{fila.peligro?.codigo} · {fila.peligro?.peligro}</b>. {fila.iperc?.estado === "BORRADOR" ? "La v1 aprobada no cambia. " : ""}
              <Link href={`/iperc/${fila.codigo}`} className="btn">Ir a la fila</Link></div>
          ) : (<><button className="btn pri" disabled>Agregar a la IPERC</button> <small>Crear la fila precargada en un borrador nuevo queda para la siguiente fase.</small></>)}
        </div>
      </div>
      <div className="col"><TrazaPanel tipo="hallazgo" id={id} /></div>
    </div>
  );
}
