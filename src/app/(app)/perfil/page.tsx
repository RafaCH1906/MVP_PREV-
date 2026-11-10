"use client";
import { useAuth } from "@/lib/auth";
import { ROL_NOMBRE } from "@/lib/consultas";

export default function Perfil() {
  const { perfil, salir } = useAuth();
  if (!perfil) return null;
  return (
    <div>
      <div className="ptop"><b>Perfil</b></div>
      <div className="pcard"><b>{perfil.nombre}</b><br /><small>Usuario: {perfil.usuario_login}</small><br /><small>{perfil.roles.map((r) => ROL_NOMBRE[r] ?? r).join(" / ")}</small><br /><small>{perfil.empresa?.nombre}</small></div>
      <button className="btn" style={{ width: "100%", padding: 8 }} onClick={salir}>Cerrar sesión</button>
    </div>
  );
}
