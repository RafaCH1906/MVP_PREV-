-- Prevé · esquema v0.2 para el MVP de co-creación (UTEC Ventures)
-- Basado en el Capítulo III v0.6 (3.2.2) y en el contenido semilla v0.1 del equipo MBA.
-- TODOS los datos cargados son un ESCENARIO DE DEMOSTRACIÓN (es_demo = true): provienen de entrevistas
-- y de supuestos, no deben tomarse como datos reales de ninguna empresa.
-- Sin RLS todavía: agregar políticas por empresa_id antes de usar datos reales (RNF-06).

create type metodologia as enum ('MTPE', 'MINERIA');
create type rol_usuario as enum ('ADMIN', 'SST', 'ACTIVIDAD', 'LECTOR');
create type estado_doc as enum ('BORRADOR', 'EN_REVISION', 'APROBADO', 'REEMPLAZADO');
create type origen_act as enum ('BRECHA', 'CONTROL', 'BASE', 'HALLAZGO');
create type estado_act as enum ('PROGRAMADA', 'EN_CURSO', 'EJECUTADA', 'VERIFICADA');
create type estado_accion as enum ('ASIGNADA', 'EN_IMPLEMENTACION', 'POR_VERIFICAR', 'VERIFICADA', 'RECHAZADA');
create type tipo_control as enum ('ELIMINACION', 'SUSTITUCION', 'INGENIERIA', 'ADMINISTRATIVO', 'EPP');

-- Reloj de la demo: las vistas calculan "vencido" con estos valores para que la demo siempre muestre el estado del 07/11/2026.
-- Dejar reloj_demo vacío ('') para usar la hora real (ver demo_reiniciar_contador()).
create table config (clave text primary key, valor text not null);

create table empresa (
  id uuid primary key,
  codigo text unique not null,                -- CAR, WIR
  ruc char(11) not null check (ruc ~ '^[0-9]{11}$'),
  razon_social text not null,
  ciiu text,
  domicilio text,
  sector text not null,
  metodologia metodologia not null,
  umbral_significativo text,                  -- null = umbral por defecto de la metodología
  n_trabajadores int,
  organo_sst text,
  fiscalizador text,
  etiqueta_plan text,                         -- "Programa anual de SSO" / "Plan anual de SST"
  etiqueta_comite text,                       -- "Comité de SSO" / "Comité de SST"
  es_demo boolean not null default true,
  estado_dato char(1) check (estado_dato in ('V', 'S')),
  fuente text
);

create table usuario (
  id uuid primary key,
  empresa_id uuid not null references empresa(id),
  codigo text unique,                         -- U-C2
  auth_id uuid unique,                        -- = auth.users.id de Supabase; lo llena scripts/crear-usuarios.mjs
  nombre text not null,
  cargo text,
  usuario_login text not null unique,         -- lo que la persona escribe al ingresar (ej. jorge.quispe)
  roles rol_usuario[] not null default '{LECTOR}',
  sede text,
  activo boolean default true
);

create table sede (
  id uuid primary key,
  empresa_id uuid not null references empresa(id),
  codigo text unique not null,
  nombre text not null,
  ubicacion text,
  tipo text,
  estado_dato char(1)
);

create table area (
  id uuid primary key,
  empresa_id uuid not null references empresa(id),
  sede_id uuid not null references sede(id),
  nombre text not null
);

create table puesto (
  id uuid primary key,
  empresa_id uuid not null references empresa(id),
  area_id uuid not null references area(id),
  nombre text not null,
  n_trabajadores int not null default 1       -- alimenta el índice A de MTPE
);

create table tarea (
  id uuid primary key,
  empresa_id uuid not null references empresa(id),
  codigo text unique not null,                -- CAR-T01
  proceso text not null,
  actividad text,
  nombre text not null,
  rutinaria boolean default true,
  sedes text,
  fuente text,
  estado_dato char(1)
);

create table tarea_puesto (
  tarea_id uuid not null references tarea(id),
  puesto_id uuid not null references puesto(id),
  primary key (tarea_id, puesto_id)
);

create table peligro_catalogo (
  id uuid primary key,
  codigo text unique not null,                -- PEL-M01
  sector text not null,                       -- 'Minería' | 'General'
  tipo text not null,
  peligro text not null,
  riesgo text not null,
  consecuencia text not null,
  sev_mtpe int check (sev_mtpe between 1 and 3),      -- severidad sugerida
  sev_mineria int check (sev_mineria between 1 and 5)
);

create table control_catalogo (
  id uuid primary key,
  peligro_id uuid not null references peligro_catalogo(id),
  jerarquia tipo_control not null,
  descripcion text not null
);

create table actividad_base_plantilla (
  id uuid primary key,
  codigo text unique not null,                -- AB-G01, AB-M01
  sector text not null,
  actividad text not null,
  tipo text,
  frecuencia_minima text,
  base_normativa text,
  frecuencia_por_empresa jsonb,               -- {"CAR": "Mensual", "WIR": "No aplica"}
  meses text,
  objetivo text,
  fuente text,
  estado_dato char(1)
);

create table diagnostico_item (
  n int primary key,                          -- 1..120
  bloque_num int not null,
  bloque text not null,
  subseccion text,
  indicador text not null,
  ayuda text,
  accion_sugerida text,
  base_normativa text,
  peso int not null default 1
);

create table diagnostico_respuesta (
  empresa_id uuid not null references empresa(id),
  item_n int not null references diagnostico_item(n),
  estado text not null check (estado in ('C', 'P', 'NC', 'NA')),
  comentario text,
  primary key (empresa_id, item_n)
);

create table iperc_version (
  id uuid primary key,
  empresa_id uuid not null references empresa(id),
  anio int not null,
  version int not null,
  estado estado_doc not null default 'BORRADOR',
  aprobado_por uuid references usuario(id),
  aprobado_en date,
  unique (empresa_id, anio, version)
);

create table iperc_fila (
  id uuid primary key,
  empresa_id uuid not null references empresa(id),
  iperc_id uuid not null references iperc_version(id),
  codigo text not null,                       -- IPERC-C01
  tarea_id uuid not null references tarea(id),
  peligro_id uuid not null references peligro_catalogo(id),
  n_expuestos int,                            -- solo MTPE
  -- Factores propios de cada metodología en JSON
  --   MTPE:    {"A":3,"B":2,"C":2,"D":3,"S":2}
  --   MINERIA: {"lesion":2,"propiedad":4,"proceso":4,"severidad":2,"prob":"B","modificada":false}
  eval_inicial jsonb not null,
  nivel_inicial int not null,
  clasif_inicial text not null,
  significativo boolean not null,
  eval_residual jsonb,
  nivel_residual int,
  clasif_residual text,
  registrado_en timestamptz not null,         -- de aquí corre el plazo de la acción inmediata
  fuente text,
  unique (iperc_id, codigo)
);

create table control (
  id uuid primary key,
  empresa_id uuid not null references empresa(id),
  fila_id uuid not null references iperc_fila(id),
  codigo text,                                -- IPERC-C02 (el de la fila)
  jerarquia tipo_control not null,
  descripcion text not null,
  existente boolean not null default false    -- false = propuesto
);

-- Documentos de la gestión (diagnóstico, plan anual, IPERC) con su estado en el escenario
create table hito_documento (
  id uuid primary key,
  empresa_id uuid not null references empresa(id),
  tipo text not null,                         -- DIAGNOSTICO | IPERC | PLAN
  titulo text not null,
  estado text not null,
  fecha date,
  responsable_id uuid references usuario(id),
  ref_semilla text,
  estado_dato char(1),
  fuente text
);

create table hallazgo (
  id uuid primary key,
  empresa_id uuid not null references empresa(id),
  origen text not null check (origen in ('INSPECCION', 'OBSERVACION', 'AUDITORIA')),
  descripcion text not null,
  ubicacion text,
  criticidad text,
  fecha date not null,
  estado text not null default 'ABIERTO',
  fila_id uuid references iperc_fila(id),     -- RF-34 / trazabilidad con la IPERC
  registrado_por uuid references usuario(id),
  ref_semilla text,
  estado_dato char(1)
);

create table actividad (
  id uuid primary key,
  empresa_id uuid not null references empresa(id),
  objetivo text,
  origen origen_act not null,
  control_id uuid references control(id),
  hallazgo_id uuid references hallazgo(id),
  plantilla_codigo text,                      -- AB-G01 (si viene de una actividad base)
  brecha_item int references diagnostico_item(n),
  descripcion text not null,
  responsable_id uuid references usuario(id),
  fecha_fin date,
  estado estado_act not null default 'PROGRAMADA',
  ref_semilla text,
  estado_dato char(1)
);

-- Exactamente un origen: hallazgo o control (RF-27 / RF-36)
create table accion (
  id uuid primary key,
  empresa_id uuid not null references empresa(id),
  hallazgo_id uuid references hallazgo(id),
  control_id uuid references control(id),
  descripcion text not null,
  inmediata boolean not null default false,
  responsable_id uuid not null references usuario(id),
  vence_en timestamptz not null,
  estado estado_accion not null default 'ASIGNADA',
  verificada_por uuid references usuario(id),
  ref_semilla text,
  estado_dato char(1),
  check ((hallazgo_id is null) <> (control_id is null)),
  check (verificada_por is null or verificada_por <> responsable_id)   -- RF-28
);

create table evidencia (
  id uuid primary key,
  empresa_id uuid not null references empresa(id),
  actividad_id uuid references actividad(id),
  accion_id uuid references accion(id),
  tipo text not null check (tipo in ('IMAGEN', 'PDF', 'ENLACE')),
  url text not null,
  nota text,
  registrado_por uuid references usuario(id),
  creado_en timestamptz default now(),
  ref_semilla text,
  check ((actividad_id is null) <> (accion_id is null))
);

create index on iperc_fila (empresa_id, iperc_id);
create index on accion (empresa_id, estado, vence_en);
create index on actividad (empresa_id, estado, fecha_fin);

/* ----------------------------------- Vistas ----------------------------------- */

create view v_reloj as
  select coalesce(nullif((select valor from config where clave = 'reloj_demo'), '')::timestamptz, now()) as ahora,
         coalesce(nullif((select valor from config where clave = 'fecha_referencia'), '')::date, current_date) as hoy;

create view v_actividad as
  select a.*, (a.estado in ('PROGRAMADA', 'EN_CURSO') and a.fecha_fin < r.hoy) as vencida
  from actividad a cross join v_reloj r;

create view v_accion as
  select a.*,
         (a.estado in ('ASIGNADA', 'EN_IMPLEMENTACION') and a.vence_en < r.ahora) as vencida,
         floor(extract(epoch from (a.vence_en - r.ahora)) / 60)::int as minutos_restantes
  from accion a cross join v_reloj r;

-- RF-08: % = Σ(peso × puntaje) / Σ(peso de ítems aplicables); C = 1, P = 0,5, NC = 0, NA excluido
create view v_cumplimiento_bloque as
  select r.empresa_id, i.bloque_num, i.bloque,
         round(100.0 * sum(i.peso * case r.estado when 'C' then 1 when 'P' then 0.5 else 0 end) / nullif(sum(i.peso), 0), 1) as pct
  from diagnostico_respuesta r join diagnostico_item i on i.n = r.item_n
  where r.estado <> 'NA' group by r.empresa_id, i.bloque_num, i.bloque;

create view v_cumplimiento_total as
  select r.empresa_id,
         round(100.0 * sum(i.peso * case r.estado when 'C' then 1 when 'P' then 0.5 else 0 end) / nullif(sum(i.peso), 0), 1) as pct
  from diagnostico_respuesta r join diagnostico_item i on i.n = r.item_n
  where r.estado <> 'NA' group by r.empresa_id;

-- RF-09: brechas = ítems en Parcial o No cumple, con su acción sugerida
create view v_brecha as
  select r.empresa_id, r.item_n, r.estado, i.bloque_num, i.bloque, i.indicador, i.accion_sugerida
  from diagnostico_respuesta r join diagnostico_item i on i.n = r.item_n
  where r.estado in ('P', 'NC');
