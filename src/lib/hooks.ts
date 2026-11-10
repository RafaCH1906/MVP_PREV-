"use client";
import { useEffect, useState } from "react";

/** Carga asíncrona simple: {datos, cargando, error}. */
export function useCarga<T>(fn: () => PromiseLike<T>, deps: unknown[]) {
  const [datos, setDatos] = useState<T | null>(null);
  const [cargando, setCargando] = useState(true);
  const [error, setError] = useState<string | null>(null);
  useEffect(() => {
    let vivo = true;
    setCargando(true);
    Promise.resolve(fn())
      .then((d) => vivo && (setDatos(d), setError(null)))
      .catch((e) => vivo && setError(String(e?.message ?? e)))
      .finally(() => vivo && setCargando(false));
    return () => {
      vivo = false;
    };
    // eslint-disable-next-line react-hooks/exhaustive-deps
  }, deps);
  return { datos, cargando, error };
}

/** Desenvuelve {data,error} de supabase o lanza. */
export function ok<T>(r: { data: T | null; error: { message: string } | null }): T {
  if (r.error) throw new Error(r.error.message);
  return (r.data ?? ([] as unknown)) as T;
}
