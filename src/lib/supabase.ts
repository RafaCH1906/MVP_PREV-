import { createClient } from "@supabase/supabase-js";

export const DOMINIO_INTERNO = "preve.local";
export const emailInterno = (usuario: string) =>
  `${usuario.trim().toLowerCase()}@${DOMINIO_INTERNO}`;

export const supabase = createClient(
  process.env.NEXT_PUBLIC_SUPABASE_URL ?? "http://localhost:54321",
  process.env.NEXT_PUBLIC_SUPABASE_ANON_KEY ?? "anon"
);
