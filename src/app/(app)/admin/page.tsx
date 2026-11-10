"use client";
import { supabase } from "@/lib/supabase";
import { useAuth } from "@/lib/auth";
import { useCarga, ok } from "@/lib/hooks";
import { Cargando } from "@/lib/ui";
import { ROL_NOMBRE } from "@/lib/consultas";

type U = { id: string; nombre: string; cargo: string | null; usuario_login: string; roles: string[]; activo: boolean | null };

/** A01 · Usuarios y roles (consulta). */
export default function Admin() {
  const { perfil } = useAuth();
  const { datos, cargando, error } = useCarga(async () => ok(await supabase.from("usuario").select("id,nombre,cargo,usuario_login,roles,activo").order("nombre")) as U[], [perfil]);
  if (cargando) return <Cargando />;
  if (error || !datos) return <Cargando error={error} />;
  return (
    <div className="blk"><h4>Usuarios y roles</h4>
      <div className="scroll"><table className="mini"><thead><tr><th>Nombre</th><th>Usuario</th><th>Cargo</th><th>Rol</th><th>Activo</th></tr></thead><tbody>
        {datos.map((u) => <tr key={u.id}><td>{u.nombre}</td><td>{u.usuario_login}</td><td>{u.cargo}</td><td>{u.roles.map((r) => ROL_NOMBRE[r] ?? r).join(" / ")}</td><td>{u.activo === false ? "No" : "Sí"}</td></tr>)}
      </tbody></table></div></div>
  );
}
