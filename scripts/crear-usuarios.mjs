// Crea en Supabase Auth una cuenta (usuario + contraseña) por cada fila de la tabla `usuario`
// y guarda su id en usuario.auth_id. Ejecutar UNA vez, después de schema.sql y seed.sql.
//
// Supabase Auth exige un correo por dentro, así que la persona escribe solo su usuario (ej. "jorge.quispe")
// y la app le agrega el dominio interno. Usar siempre la misma función (emailInterno) en el login del frontend.
//
//   SUPABASE_URL=https://xxxx.supabase.co \
//   SUPABASE_SERVICE_ROLE_KEY=... \
//   DEMO_PASSWORD='una-clave-para-la-demo' \
//   node scripts/crear-usuarios.mjs
//
// La service role key NUNCA va en el frontend ni en el repositorio: solo en tu terminal.

import { createClient } from "@supabase/supabase-js";

export const DOMINIO_INTERNO = "preve.local";
export const emailInterno = (usuario) => `${usuario.trim().toLowerCase()}@${DOMINIO_INTERNO}`;

const { SUPABASE_URL, SUPABASE_SERVICE_ROLE_KEY, DEMO_PASSWORD } = process.env;
if (!SUPABASE_URL || !SUPABASE_SERVICE_ROLE_KEY || !DEMO_PASSWORD) {
  console.error("Faltan SUPABASE_URL, SUPABASE_SERVICE_ROLE_KEY o DEMO_PASSWORD");
  process.exit(1);
}

const sb = createClient(SUPABASE_URL, SUPABASE_SERVICE_ROLE_KEY, {
  auth: { autoRefreshToken: false, persistSession: false },
});

const { data: usuarios, error: errLista } = await sb.from("usuario").select("id, usuario_login, auth_id");
if (errLista) throw errLista;

// Cuentas que ya existen en Auth (por si se vuelve a ejecutar)
const { data: existentes, error: errAuth } = await sb.auth.admin.listUsers({ perPage: 1000 });
if (errAuth) throw errAuth;
const porEmail = new Map(existentes.users.map((u) => [u.email?.toLowerCase(), u.id]));

for (const u of usuarios) {
  const email = emailInterno(u.usuario_login);
  let authId = porEmail.get(email);
  if (!authId) {
    const { data, error } = await sb.auth.admin.createUser({
      email,
      password: DEMO_PASSWORD,
      email_confirm: true, // sin correo de confirmación: es una demo
    });
    if (error) { console.error("✗", u.usuario_login, error.message); continue; }
    authId = data.user.id;
    console.log("＋ cuenta creada:", u.usuario_login);
  } else {
    console.log("= ya existía:", u.usuario_login);
  }
  const { error } = await sb.from("usuario").update({ auth_id: authId }).eq("id", u.id);
  if (error) console.error("✗ no se pudo vincular", u.usuario_login, error.message);
}
console.log("Listo. Ingreso: usuario de la tabla usuario (ej. jorge.quispe) + DEMO_PASSWORD.");
