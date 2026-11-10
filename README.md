# Prevé · MVP (co-creación UTEC Ventures)

Base técnica del prototipo. Guion de demo A (Minera Caracol, minería) y también MTPE (Wirbi).

> **Todos los datos son un escenario de demostración.** Vienen del contenido semilla v0.1 del equipo MBA
> (entrevistas y supuestos); no son datos reales de ninguna empresa. La marca `estado_dato` (V = respaldado
> por entrevista o norma según el equipo, S = supuesto) se conserva solo para saber qué falta validar con la persona experta en SST.
> Mantener este repositorio **privado**.

## Contenido
- `src/lib/iperc/engine.ts`: motor IPERC con funciones puras (MTPE y minería, riesgo significativo, alerta residual RF-17, acción inmediata RF-36 con contador).
- `src/lib/iperc/engine.test.ts` y `semilla.test.ts`: 53 pruebas, incluidas las 17 filas IPERC de la semilla contrastadas con un cálculo independiente.
- `supabase/schema.sql`: tablas y vistas (cumplimiento del diagnóstico, brechas, actividades y acciones vencidas). Sin RLS todavía.
- `supabase/policies.sql`: RLS: cada persona ve solo su empresa; SST y administrador escriben; el responsable de actividad solo actualiza lo suyo y sube evidencias; el lector solo lee. Probado con usuarios simulados.
- `supabase/seed.sql`: **generado** desde `semilla/` (no editar a mano).
- `semilla/`: copia del contenido semilla v0.1 (`semilla_datos.py`, `semilla_diagnostico.py`, `diagnostico_lineabase_items.json`).
- `tools/generar_seed_sql.py`: regenera `seed.sql` y `src/lib/iperc/semilla-casos.json`. Si el equipo corrige un dato: cambiar el `.py` y ejecutar `npm run seed:generar`.

## Datos cargados
2 empresas, 5 sedes, 52 puestos, 30 tareas, 64 peligros con 162 controles sugeridos, 28 actividades base, diagnóstico de 120 ítems con respuestas de ambas empresas,
17 filas IPERC (41 controles), 14 actividades, 6 acciones (1 inmediata), 3 hallazgos y 1 evidencia.
Referencias: Caracol 52,5 % de cumplimiento y 92 brechas; Wirbi 71,1 %.

## Reloj de la demo
La tabla `config` fija `fecha_referencia = 2026-11-07` y `reloj_demo = 2026-11-07 13:20`. Las vistas `v_actividad` y `v_accion` calculan
"vencido" y los minutos restantes con ese reloj, así la demo siempre muestra el estado del 07/11 (la acción inmediata queda a 5 h 10 min).
Para ensayar con la hora real: `select demo_reiniciar_contador();`.

## Usuarios (ingreso con usuario + contraseña)
**La app no usa correos**: el formulario solo pide *Usuario* y *Contraseña*, y la base no guarda ningún correo.
Por dentro, Supabase Auth exige un identificador con forma de correo, así que el frontend le agrega `@preve.local` al usuario (`emailInterno` en `scripts/crear-usuarios.mjs`); la persona nunca lo ve ni lo escribe.
Todas las cuentas usan la misma contraseña de demo.

| Usuario | Persona (ficticia) | Empresa | Rol |
|---|---|---|---|
| `jorge.quispe` | Jorge Quispe | Caracol | Responsable de SST |
| `luis.huaman` | Luis Huamán | Caracol | Responsable de actividad |
| `rosa.medina` | Rosa Medina | Caracol | Administrador |
| `carmen.rojas` | Carmen Rojas | Caracol | Responsable de actividad |
| `victor.mendoza` | Víctor Mendoza | Caracol | Lector |
| `martin.vega` | Martín Vega | Wirbi | Responsable de SST |
| `daniela.torres` | Daniela Torres | Wirbi | Administrador |
| `lucia.campos`, `pedro.ramirez` | Lucía Campos, Pedro Ramírez | Wirbi | Responsable de actividad |
| `andres.castillo` | Andrés Castillo | Wirbi | Lector |

Guion A: Jorge en la computadora y Luis en el celular (dos sesiones distintas de la misma app).

## Conectar a Supabase (PowerShell)
1. Crear el proyecto en supabase.com. En **Authentication → Providers → Email** desactivar "Confirm email".
2. En **SQL Editor** ejecutar, en este orden, `supabase/schema.sql` (elegir **Run and enable RLS** cuando lo pregunte), `supabase/seed.sql` y `supabase/policies.sql`.
3. En **Project Settings → API** copiar la URL, la clave `anon` y la `service_role` (esta última es secreta).
4. Crear las cuentas:
```powershell
npm install
$env:SUPABASE_URL="https://TU-PROYECTO.supabase.co"
$env:SUPABASE_SERVICE_ROLE_KEY="tu-clave-service-role"
$env:DEMO_PASSWORD="la-clave-de-la-demo"
node scripts/crear-usuarios.mjs
```
5. Probar el ingreso:
```powershell
$env:SUPABASE_ANON_KEY="tu-clave-anon"
node scripts/probar-conexion.mjs jorge.quispe
node scripts/probar-conexion.mjs luis.huaman
```

## Pendiente
- Frontend (Next.js + Tailwind), responsive. Pantallas del guion A: T03 Inicio, T05 trazabilidad, I03 evaluar fila (minería), I05 matriz, P02 programa anual, S04 hallazgo, S01/S05 celular, R01 tablero.
- Subida de evidencias (Supabase Storage).
- El wireframe W1 dice "9 riesgos significativos" en Caracol; la semilla da 8 (C01 a C07 y C09). Alinear con el equipo.

## Correr la app (Fase 1)

```powershell
npm install
copy .env.example .env.local      # pega NEXT_PUBLIC_SUPABASE_URL y NEXT_PUBLIC_SUPABASE_ANON_KEY
npm run dev                       # http://localhost:3000
```
Ingresa con usuario + contraseña (ej. `jorge.quispe`). Pantallas: Inicio (alerta con contador), IPERC (matriz 5×5 y simulador), Trazabilidad. Luis (`luis.huaman`) ve solo "Mis actividades".
Para probar en el celular: misma red WiFi → `http://IP-de-tu-PC:3000`, o despliega en Vercel con las dos variables.

## Pantallas (siguen los wireframes v0.1)
W1 Inicio (`/`) · W2 cuestionario (`/diagnostico/bloque/N`) · W3 resultados (`/diagnostico`) · W4 evaluar fila (`/iperc/IPERC-C09`) · W5 matriz (`/iperc`) · W6 plan (`/plan`) · W7 celular (`/` con `luis.huaman`, `/registro/accion/ID`) · W8 hallazgo (`/seguimiento/ID`).
Ejecutar también `supabase/policies_extra.sql` (permite reportar hallazgos desde el celular).
Las fotos de evidencia se guardan reducidas dentro de la tabla `evidencia` (sin Storage) para simplificar la demo.
