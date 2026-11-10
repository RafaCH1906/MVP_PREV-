"use client";
import { useState } from "react";
import { supabase } from "@/lib/supabase";
import { useAuth } from "@/lib/auth";

export default function Reportar() {
  const { perfil } = useAuth();
  const [d, setD] = useState({ desc: "", ubic: "", crit: "Media" });
  const [msg, setMsg] = useState<string | null>(null);
  const enviar = async () => {
    const { error } = await supabase.from("hallazgo").insert({
      id: crypto.randomUUID(), empresa_id: perfil!.empresa_id, origen: "OBSERVACION", descripcion: d.desc, ubicacion: d.ubic || null,
      criticidad: d.crit, fecha: new Date().toLocaleDateString("sv-SE", { timeZone: "America/Lima" }), estado: "ABIERTO", registrado_por: perfil!.id,
    });
    setMsg(error ? `No se pudo registrar: ${error.message}` : "✓ Hallazgo reportado");
    if (!error) setD({ desc: "", ubic: "", crit: "Media" });
  };
  return (
    <div>
      <div className="ptop"><b>Reportar un hallazgo</b></div>
      <div className="field"><span className="k">Descripción</span><textarea className="in" rows={4} value={d.desc} onChange={(e) => setD({ ...d, desc: e.target.value })} /></div>
      <div className="field"><span className="k">Ubicación</span><input className="in" value={d.ubic} onChange={(e) => setD({ ...d, ubic: e.target.value })} /></div>
      <div className="field"><span className="k">Criticidad</span><select className="in" value={d.crit} onChange={(e) => setD({ ...d, crit: e.target.value })}><option>Baja</option><option>Media</option><option>Alta</option></select></div>
      <button className="btn pri" style={{ width: "100%", padding: 8 }} disabled={!d.desc} onClick={enviar}>Enviar hallazgo</button>
      {msg && <p style={{ fontSize: 13 }}>{msg}</p>}
    </div>
  );
}
