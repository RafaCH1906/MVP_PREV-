"use client";
import { useState } from "react";
import { supabase } from "@/lib/supabase";
import { useAuth } from "@/lib/auth";
import { useCarga, ok } from "@/lib/hooks";
import { Cargando } from "@/lib/ui";
import { ROL_NOMBRE } from "@/lib/consultas";

type U = { id: string; nombre: string; cargo: string | null; usuario_login: string; roles: string[]; activo: boolean | null };
const ROLES = ["ADMIN", "SST", "ACTIVIDAD", "LECTOR"];

/** A01 · Usuarios y roles (RF-32): el administrador cambia roles y activa/desactiva. */
export default function Admin() {
  const { perfil } = useAuth();
  const esAdmin = !!perfil?.roles.includes("ADMIN");
  const [v, setV] = useState(0);
  const [msg, setMsg] = useState<string | null>(null);
  const { datos, cargando, error } = useCarga(async () => ok(await supabase.from("usuario").select("id,nombre,cargo,usuario_login,roles,activo").order("nombre")) as U[], [perfil, v]);
  if (cargando) return <Cargando />;
  if (error || !datos) return <Cargando error={error} />;
  const cambiar = async (u: U, cambio: Partial<U>) => {
    if (u.id === perfil?.id) { setMsg("No puedes cambiar tu propio rol ni desactivarte."); return; }
    const { error: er } = await supabase.from("usuario").update(cambio).eq("id", u.id);
    setMsg(er ? `No se pudo guardar: ${er.message}` : "✓ Usuario actualizado"); if (!er) setV((x) => x + 1);
  };
  const toggleRol = (u: U, r: string) => {
    const nuevos = u.roles.includes(r) ? u.roles.filter((x) => x !== r) : [...u.roles, r];
    if (!nuevos.length) { setMsg("Cada usuario debe tener al menos un rol."); return; }
    cambiar(u, { roles: nuevos });
  };
  return (
    <div className="blk"><h4>Usuarios y roles</h4>
      {msg && <p className="warn" style={{ fontSize: 13 }}>{msg}</p>}
      <div className="scroll"><table className="mini"><thead><tr><th>Nombre</th><th>Usuario</th><th>Cargo</th><th>Rol</th><th>Activo</th></tr></thead><tbody>
        {datos.map((u) => <tr key={u.id}><td>{u.nombre}</td><td>{u.usuario_login}</td><td>{u.cargo}</td>
          <td>{esAdmin ? ROLES.map((r) => <label key={r} style={{ marginRight: 8, fontSize: 12 }}><input type="checkbox" checked={u.roles.includes(r)} onChange={() => toggleRol(u, r)} /> {ROL_NOMBRE[r] ?? r}</label>) : u.roles.map((r) => ROL_NOMBRE[r] ?? r).join(" / ")}</td>
          <td>{esAdmin ? <input type="checkbox" checked={u.activo !== false} onChange={() => cambiar(u, { activo: u.activo === false })} /> : u.activo === false ? "No" : "Sí"}</td></tr>)}
      </tbody></table></div>
      {esAdmin && <p style={{ fontSize: 12 }}>Para invitar a una persona nueva se crea su usuario con <code>scripts/crear-usuarios.mjs</code> (requiere la llave de servicio, que nunca va en el navegador).</p>}
    </div>
  );
}
