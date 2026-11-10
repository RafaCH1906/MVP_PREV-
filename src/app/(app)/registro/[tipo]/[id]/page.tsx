"use client";
import Link from "next/link";
import { useParams } from "next/navigation";
import { useRef, useState } from "react";
import { supabase } from "@/lib/supabase";
import { useAuth } from "@/lib/auth";
import { useCarga, ok } from "@/lib/hooks";
import { useReloj } from "@/lib/reloj";
import { Cargando, Tag } from "@/lib/ui";
import { fechaDM, hora, origenTag, SEL_ACC, SEL_ACT, Acc, Act } from "@/lib/consultas";
import { formatoRestante, minutosRestantes } from "@/lib/iperc/engine";
import { puedeGestionar, soloActividad } from "@/lib/roles";
import TrazaPanel from "@/components/TrazaPanel";

type Ev = { id: string; tipo: string; url: string; nota: string | null; creado_en: string };

/** Reduce la foto a ~800 px para guardarla como data URL (demo sin Storage). */
function reducir(file: File): Promise<string> {
  return new Promise((res, rej) => {
    const r = new FileReader();
    r.onerror = () => rej(new Error("No se pudo leer la imagen"));
    r.onload = () => {
      const img = new Image();
      img.onload = () => {
        const k = Math.min(1, 800 / Math.max(img.width, img.height));
        const c = document.createElement("canvas");
        c.width = img.width * k; c.height = img.height * k;
        c.getContext("2d")!.drawImage(img, 0, 0, c.width, c.height);
        res(c.toDataURL("image/jpeg", 0.7));
      };
      img.onerror = () => rej(new Error("Imagen no válida"));
      img.src = String(r.result);
    };
    r.readAsDataURL(file);
  });
}

/** W7 (derecha) · S05/S02: acción inmediata o actividad, con evidencia, envío y verificación. */
export default function Registro() {
  const { tipo, id } = useParams<{ tipo: string; id: string }>();
  const esAcc = tipo === "accion";
  const { perfil } = useAuth();
  const { ahora } = useReloj();
  const [v, setV] = useState(0);
  const [msg, setMsg] = useState<string | null>(null);
  const [nota, setNota] = useState("");
  const [enlace, setEnlace] = useState("");
  const foto = useRef<HTMLInputElement>(null);
  const { datos, cargando, error } = useCarga(async () => {
    const col = esAcc ? "accion_id" : "actividad_id";
    const reg = ok(await supabase.from(esAcc ? "accion" : "actividad").select(esAcc ? SEL_ACC : SEL_ACT).eq("id", id).limit(1)) as unknown as (Acc | Act)[];
    if (!reg[0]) throw new Error("Registro no encontrado");
    const ev = ok(await supabase.from("evidencia").select("id,tipo,url,nota,creado_en").eq(col, id).order("creado_en")) as Ev[];
    const fid = reg[0].control?.fila_id;
    const fila = fid ? (ok(await supabase.from("iperc_fila").select("codigo,nivel_inicial,clasif_inicial").eq("id", fid).limit(1)) as { codigo: string; nivel_inicial: number; clasif_inicial: string }[])[0] : null;
    return { reg: reg[0], ev, fila: fila ?? null };
  }, [tipo, id, perfil, v]);
  if (cargando && !datos) return <Cargando />;
  if (error || !datos) return <Cargando error={error} />;
  const { reg, ev, fila } = datos;
  const acc = esAcc ? (reg as Acc) : null;
  const act = !esAcc ? (reg as Act) : null;
  const mia = reg.responsable_id === perfil?.id;
  const gest = puedeGestionar(perfil);
  const estado = reg.estado;
  const cerrado = ["VERIFICADA", "RECHAZADA", "EJECUTADA"].includes(estado) || estado === "POR_VERIFICAR";
  const puedeEditar = (mia || gest) && !["VERIFICADA", "POR_VERIFICAR", "EJECUTADA"].includes(estado);
  const tag = origenTag(reg);
  const min = acc ? minutosRestantes(new Date(acc.vence_en), ahora) : 0;

  const actualizar = async (campos: Record<string, unknown>, texto: string) => {
    const { error: e } = await supabase.from(esAcc ? "accion" : "actividad").update(campos).eq("id", id);
    setMsg(e ? `No se pudo guardar: ${e.message}` : texto);
    setV(v + 1);
  };
  const agregarEv = async (tipoEv: string, url: string) => {
    const { error: e } = await supabase.from("evidencia").insert({
      id: crypto.randomUUID(), empresa_id: perfil!.empresa_id, [esAcc ? "accion_id" : "actividad_id"]: id,
      tipo: tipoEv, url, nota: nota || null, registrado_por: perfil!.id,
    });
    setMsg(e ? `No se pudo guardar la evidencia: ${e.message}` : "✓ Evidencia registrada");
    if (!e) { setNota(""); setEnlace(""); }
    setV(v + 1);
  };
  const subirFoto = async (f?: File | null) => {
    if (!f) return;
    try { await agregarEv("IMAGEN", await reducir(f)); } catch (e) { setMsg(String((e as Error).message)); }
  };
  const verificar = async () => {
    if (acc && acc.responsable_id === perfil!.id) { setMsg("Quien verifica no puede ser el responsable de la acción (RF-28)."); return; }
    await actualizar(esAcc ? { estado: "VERIFICADA", verificada_por: perfil!.id } : { estado: "VERIFICADA" }, "✓ Verificada. El tablero ya refleja el cambio.");
  };
  const enviar = () => actualizar({ estado: esAcc ? "POR_VERIFICAR" : "EJECUTADA" }, esAcc ? "✓ Enviada a verificación" : "✓ Marcada como ejecutada");
  const porVerificar = estado === "POR_VERIFICAR" || estado === "EJECUTADA";
  const celular = soloActividad(perfil);

  return (
    <div className={celular ? "" : "row"}>
      <div className="col" style={{ flex: 1.4 }}>
        <div className="ptop"><Link href={celular ? "/" : "/seguimiento"}>← {esAcc ? (acc?.inmediata ? "Acción inmediata" : "Acción correctiva") : "Actividad"}</Link>
          {acc?.inmediata && <span className="tag t-red">{fila?.clasif_inicial === "Medio" ? "72 h" : "24 h"}</span>}</div>
        <b>{reg.descripcion}</b>
        {acc?.inmediata && estado !== "VERIFICADA" && <p className="bad">{min >= 0 ? `Quedan ${formatoRestante(min).replace("quedan ", "")}` : formatoRestante(min)}</p>}
        <div className="field"><span className="k" style={{ width: 90 }}>Origen</span>
          <span className="in">{fila ? <Link href={`/iperc/${fila.codigo}`} style={{ textDecoration: "underline" }}>{fila.codigo} · {fila.clasif_inicial} ({fila.nivel_inicial}) ↗</Link> : tag.txt}</span></div>
        <div className="field"><span className="k" style={{ width: 90 }}>Plazo</span>
          <span className="in">{acc ? `${fechaDM(acc.vence_en)} ${hora(acc.vence_en)}` : fechaDM(act?.fecha_fin)}</span></div>
        <div className="field"><span className="k" style={{ width: 90 }}>Responsable</span><span className="in">{reg.responsable?.nombre ?? "—"}</span></div>
        <div className="field"><span className="k" style={{ width: 90 }}>Estado</span>
          {puedeEditar && esAcc
            ? <select className="in" value={estado} onChange={(e) => actualizar({ estado: e.target.value }, "✓ Estado actualizado")}><option value="ASIGNADA">Asignada</option><option value="EN_IMPLEMENTACION">En implementación</option></select>
            : puedeEditar && !esAcc
              ? <select className="in" value={estado} onChange={(e) => actualizar({ estado: e.target.value }, "✓ Estado actualizado")}><option value="PROGRAMADA">Programada</option><option value="EN_CURSO">En curso</option></select>
              : <span className="in"><Tag estado={estado} /></span>}</div>

        <div className="blk" style={{ marginTop: 8 }}><h4>Evidencias</h4>
          {puedeEditar && (<>
            <input ref={foto} type="file" accept="image/*" capture="environment" hidden onChange={(e) => { subirFoto(e.target.files?.[0]); e.target.value = ""; }} />
            <button className="btn" onClick={() => foto.current?.click()}>📷 Tomar foto</button>
            <div className="field"><span className="k" style={{ width: 90 }}>Enlace</span>
              <input className="in" placeholder="https://…" value={enlace} onChange={(e) => setEnlace(e.target.value)} />
              <button className="btn" disabled={!/^https?:\/\//.test(enlace)} onClick={() => agregarEv("ENLACE", enlace)}>Agregar</button></div>
          </>)}
          {ev.length === 0 && <small>Aún no hay evidencias.</small>}
          {ev.map((e) => (
            <div key={e.id} className="pcard" style={{ marginTop: 6 }}>
              {e.tipo === "IMAGEN" ? <>🖼 Foto · {fechaDM(e.creado_en)} {hora(e.creado_en)}<br /><img src={e.url} alt="evidencia" style={{ maxWidth: "100%", borderRadius: 6, marginTop: 4 }} /></>
                : <a href={e.url} target="_blank" rel="noreferrer" style={{ textDecoration: "underline" }}>🔗 {e.url.slice(0, 50)}</a>}
              {e.nota && <><br /><small>{e.nota}</small></>}
            </div>))}
        </div>
        {puedeEditar && <div className="field"><span className="k" style={{ width: 90 }}>Nota</span><input className="in" value={nota} onChange={(e) => setNota(e.target.value)} placeholder="Ej.: cuadros instalados; acceso señalizado" /></div>}

        {puedeEditar && <button className="btn pri" style={{ display: "block", width: "100%", textAlign: "center", marginTop: 8, padding: 8 }} disabled={ev.length === 0} onClick={enviar}>{esAcc ? "Enviar a verificación" : "Marcar como ejecutada"}</button>}
        {puedeEditar && <small>Se activa con al menos una evidencia.{esAcc && " La verificará otra persona."}</small>}
        {porVerificar && gest && !(acc && acc.responsable_id === perfil?.id) && <button className="btn pri" style={{ display: "block", width: "100%", marginTop: 8, padding: 8 }} onClick={verificar}>Verificar {esAcc ? "acción" : "actividad"}</button>}
        {porVerificar && !gest && <p className="muted">Pendiente de verificación por el responsable de SST.</p>}
        {estado === "VERIFICADA" && <div className="okb">✓ Verificada{acc?.verificada_por ? "" : ""}.</div>}
        {msg && <p style={{ fontSize: 13 }}>{msg}</p>}
        {cerrado && !porVerificar && estado !== "VERIFICADA" && null}
      </div>
      {!celular && <div className="col"><TrazaPanel tipo={esAcc ? "accion" : "actividad"} id={id} /></div>}
    </div>
  );
}
