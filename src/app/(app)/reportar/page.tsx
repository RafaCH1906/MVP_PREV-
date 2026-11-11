"use client";
import { useRef, useState } from "react";
import { supabase } from "@/lib/supabase";
import { useAuth } from "@/lib/auth";
import { reducir } from "@/lib/imagen";

export default function Reportar() {
  const { perfil } = useAuth();
  const [d, setD] = useState({ desc: "", ubic: "", crit: "Media" });
  const [foto, setFoto] = useState<string | null>(null);
  const [msg, setMsg] = useState<string | null>(null);
  const [ocupado, setOcupado] = useState(false);
  const ref = useRef<HTMLInputElement>(null);
  const enviar = async () => {
    setOcupado(true); setMsg(null);
    const id = crypto.randomUUID();
    const { error } = await supabase.from("hallazgo").insert({
      id, empresa_id: perfil!.empresa_id, origen: "OBSERVACION", descripcion: d.desc, ubicacion: d.ubic || null,
      criticidad: d.crit, fecha: new Date().toLocaleDateString("sv-SE", { timeZone: "America/Lima" }), estado: "ABIERTO", registrado_por: perfil!.id,
    });
    if (!error && foto) {
      const e2 = await supabase.from("evidencia").insert({ id: crypto.randomUUID(), empresa_id: perfil!.empresa_id, hallazgo_id: id, tipo: "IMAGEN", url: foto, registrado_por: perfil!.id });
      if (e2.error) { setMsg(`Hallazgo registrado, pero la foto no se guardó: ${e2.error.message}`); setOcupado(false); return; }
    }
    setMsg(error ? `No se pudo registrar: ${error.message}` : "✓ Hallazgo reportado");
    if (!error) { setD({ desc: "", ubic: "", crit: "Media" }); setFoto(null); }
    setOcupado(false);
  };
  return (
    <div>
      <div className="ptop"><b>Reportar un hallazgo</b></div>
      <div className="field"><span className="k">Descripción</span><textarea className="in" rows={4} value={d.desc} onChange={(e) => setD({ ...d, desc: e.target.value })} /></div>
      <div className="field"><span className="k">Ubicación</span><input className="in" value={d.ubic} onChange={(e) => setD({ ...d, ubic: e.target.value })} /></div>
      <div className="field"><span className="k">Criticidad</span><select className="in" value={d.crit} onChange={(e) => setD({ ...d, crit: e.target.value })}><option>Baja</option><option>Media</option><option>Alta</option></select></div>
      <input ref={ref} type="file" accept="image/*" capture="environment" hidden onChange={async (e) => { const f = e.target.files?.[0]; if (f) setFoto(await reducir(f)); e.target.value = ""; }} />
      <button className="btn" onClick={() => ref.current?.click()}>📷 {foto ? "Cambiar foto" : "Tomar foto"}</button>
      {foto && <img src={foto} alt="foto del hallazgo" style={{ maxWidth: "100%", borderRadius: 6, margin: "6px 0" }} />}
      <button className="btn pri" style={{ width: "100%", padding: 8, marginTop: 6 }} disabled={!d.desc || ocupado} onClick={enviar}>{ocupado ? "Enviando…" : "Enviar hallazgo"}</button>
      {msg && <p style={{ fontSize: 13 }}>{msg}</p>}
    </div>
  );
}
