"use client";
import { useState, FormEvent, useEffect } from "react";
import { useRouter } from "next/navigation";
import { useAuth } from "@/lib/auth";

export default function Login() {
  const { entrar, perfil } = useAuth();
  const router = useRouter();
  const [usuario, setUsuario] = useState("");
  const [clave, setClave] = useState("");
  const [error, setError] = useState<string | null>(null);
  const [ocupado, setOcupado] = useState(false);
  useEffect(() => { if (perfil) router.replace("/"); }, [perfil, router]);

  const enviar = async (e: FormEvent) => {
    e.preventDefault();
    setOcupado(true);
    setError(await entrar(usuario, clave));
    setOcupado(false);
  };
  return (
    <div style={{ display: "flex", minHeight: "100vh", alignItems: "center", justifyContent: "center", padding: 16 }}>
      <form onSubmit={enviar} className="card" style={{ width: "100%", maxWidth: 360 }}>
        <span className="logo">PREVÉ</span>
        <p className="muted" style={{ marginBottom: 12 }}>Gestión continua de SST</p>
        <div className="field"><span className="k">Usuario</span>
          <input className="in" value={usuario} onChange={(e) => setUsuario(e.target.value)} autoCapitalize="none" autoComplete="username" required /></div>
        <div className="field"><span className="k">Contraseña</span>
          <input className="in" type="password" value={clave} onChange={(e) => setClave(e.target.value)} autoComplete="current-password" required /></div>
        {error && <p className="bad" style={{ fontSize: 13 }}>{error}</p>}
        <button className="btn pri" style={{ width: "100%", padding: 8, marginTop: 8 }} disabled={ocupado}>{ocupado ? "Ingresando…" : "Ingresar"}</button>
      </form>
    </div>
  );
}
