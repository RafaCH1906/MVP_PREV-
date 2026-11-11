"use client";
import { createContext, useContext, useEffect, useState, ReactNode } from "react";
import { supabase } from "./supabase";
import { useAuth } from "./auth";

type R = { ahora: Date; hoy: string; listo: boolean };
const RelojCtx = createContext<R>({ ahora: new Date(), hoy: "", listo: false });
export const useReloj = () => useContext(RelojCtx);

/** Reloj de la demo: parte de config.reloj_demo y avanza en vivo. */
export function RelojProvider({ children }: { children: ReactNode }) {
  const [base, setBase] = useState<{ t0: number; real0: number; hoy: string } | null>(null);
  const [, tick] = useState(0);
  const { perfil } = useAuth();

  // Se vuelve a leer al iniciar sesión (antes del login la vista no es legible).
  useEffect(() => {
    if (!perfil) return;
    supabase.from("v_reloj").select("*").maybeSingle().then(({ data }) => {
      const d = data as { ahora?: string; hoy?: string; reloj_demo?: string; fecha_referencia?: string } | null;
      const iso = d?.ahora ?? d?.reloj_demo;
      const t0 = iso ? new Date(iso).getTime() : Date.now();
      const hoy = (d?.hoy ?? d?.fecha_referencia ?? new Date(t0).toISOString()).slice(0, 10);
      setBase({ t0, real0: Date.now(), hoy });
    });
  }, [perfil]);

  useEffect(() => {
    const id = setInterval(() => tick((n) => n + 1), 1000);
    return () => clearInterval(id);
  }, []);

  const ahora = base ? new Date(base.t0 + (Date.now() - base.real0)) : new Date();
  return (
    <RelojCtx.Provider value={{ ahora, hoy: base?.hoy ?? "", listo: !!base }}>{children}</RelojCtx.Provider>
  );
}
