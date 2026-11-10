"use client";
import { createContext, useContext, useEffect, useState, ReactNode } from "react";
import { supabase, emailInterno } from "./supabase";

export type Perfil = {
  id: string;
  nombre: string;
  usuario_login: string;
  roles: string[];
  empresa_id: string;
  empresa: { nombre: string; metodologia?: string } | null;
};

type Ctx = {
  perfil: Perfil | null;
  cargando: boolean;
  entrar: (usuario: string, clave: string) => Promise<string | null>;
  salir: () => Promise<void>;
};
const AuthCtx = createContext<Ctx>(null as unknown as Ctx);
export const useAuth = () => useContext(AuthCtx);

async function cargarPerfil(authId: string): Promise<{ perfil: Perfil | null; error: string | null }> {
  const u = await supabase
    .from("usuario")
    .select("id,nombre,usuario_login,roles,empresa_id")
    .eq("auth_id", authId)
    .maybeSingle();
  if (u.error) return { perfil: null, error: `usuario: ${u.error.message}` };
  if (!u.data) return { perfil: null, error: "usuario: sin filas visibles (revisar políticas RLS)" };
  const e = await supabase
    .from("empresa")
    .select("nombre:razon_social,metodologia")
    .eq("id", u.data.empresa_id)
    .maybeSingle();
  if (e.error) return { perfil: null, error: `empresa: ${e.error.message}` };
  return { perfil: { ...(u.data as object), empresa: e.data } as unknown as Perfil, error: null };
}

export function AuthProvider({ children }: { children: ReactNode }) {
  const [perfil, setPerfil] = useState<Perfil | null>(null);
  const [cargando, setCargando] = useState(true);

  useEffect(() => {
    supabase.auth.getSession().then(async ({ data }) => {
      if (data.session) setPerfil((await cargarPerfil(data.session.user.id)).perfil);
      setCargando(false);
    });
  }, []);

  const entrar = async (usuario: string, clave: string) => {
    const { data, error } = await supabase.auth.signInWithPassword({
      email: emailInterno(usuario),
      password: clave,
    });
    if (error || !data.user) return "Usuario o contraseña incorrectos";
    const r = await cargarPerfil(data.user.id);
    if (!r.perfil) return `No se pudo cargar tu perfil → ${r.error}`;
    setPerfil(r.perfil);
    return null;
  };
  const salir = async () => {
    await supabase.auth.signOut();
    setPerfil(null);
  };
  return <AuthCtx.Provider value={{ perfil, cargando, entrar, salir }}>{children}</AuthCtx.Provider>;
}
