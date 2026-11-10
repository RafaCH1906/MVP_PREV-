// Prueba rápida: inicia sesión con usuario + contraseña y lee datos de la base.
//   PowerShell:
//   $env:SUPABASE_URL="https://TU-PROYECTO.supabase.co"
//   $env:SUPABASE_ANON_KEY="tu-clave-anon"
//   $env:DEMO_PASSWORD="la-clave-de-la-demo"
//   node scripts/probar-conexion.mjs jorge.quispe
import { createClient } from "@supabase/supabase-js";

const usuario = process.argv[2] ?? "jorge.quispe";
const { SUPABASE_URL, SUPABASE_ANON_KEY, DEMO_PASSWORD } = process.env;
if (!SUPABASE_URL || !SUPABASE_ANON_KEY || !DEMO_PASSWORD) {
  console.error("Faltan SUPABASE_URL, SUPABASE_ANON_KEY o DEMO_PASSWORD");
  process.exit(1);
}
const sb = createClient(SUPABASE_URL, SUPABASE_ANON_KEY);

const email = `${usuario.trim().toLowerCase()}@preve.local`;
const { error: errLogin } = await sb.auth.signInWithPassword({ email, password: DEMO_PASSWORD });
if (errLogin) { console.error("✗ Login:", errLogin.message); process.exit(1); }
console.log("✓ Login correcto como", usuario);

const { data: yo, error: e1 } = await sb.from("usuario").select("nombre, roles, empresa(razon_social, metodologia)").eq("usuario_login", usuario).single();
if (e1) { console.error("✗ Leer usuario:", e1.message); process.exit(1); }
console.log("✓ Perfil:", JSON.stringify(yo));

const { data: acc, error: e2 } = await sb.from("accion").select("descripcion, inmediata, vence_en, estado").eq("inmediata", true);
if (e2) { console.error("✗ Leer acciones:", e2.message); process.exit(1); }
console.log("✓ Acciones inmediatas:", JSON.stringify(acc));
