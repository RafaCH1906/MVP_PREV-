-- Prevé · políticas RLS v0.1 (ejecutar DESPUÉS de schema.sql; el orden respecto a seed.sql da igual)
-- Reglas:
--   · Cada persona solo ve los datos de SU empresa. Sin sesión no se ve nada.
--   · Catálogos (peligros, actividades base, ítems del diagnóstico) y config: lectura para cualquier usuario con sesión.
--   · Escritura de gestión (IPERC, diagnóstico, hallazgos, actividades, acciones, documentos): roles SST y ADMIN.
--   · Responsable de actividad: actualiza solo SUS actividades y acciones, y sube evidencias.
--   · Lector: solo lectura. Nadie borra filas desde la app.
-- Funciona con la sesión de Supabase Auth (auth.uid()). La service_role y el SQL Editor se saltan el RLS.

create or replace function mi_empresa() returns uuid
  language sql stable security definer set search_path = public as
$$ select empresa_id from usuario where auth_id = auth.uid() $$;

create or replace function mi_usuario() returns uuid
  language sql stable security definer set search_path = public as
$$ select id from usuario where auth_id = auth.uid() $$;

create or replace function tengo_rol(r rol_usuario) returns boolean
  language sql stable security definer set search_path = public as
$$ select coalesce(r = any(roles), false) from usuario where auth_id = auth.uid() $$;

create or replace function puedo_gestionar() returns boolean
  language sql stable security definer set search_path = public as
$$ select coalesce(tengo_rol('SST') or tengo_rol('ADMIN'), false) $$;

-- Activar RLS en todo (por si el editor no lo hizo)
do $$
declare t text;
begin
  for t in select unnest(array['config','empresa','usuario','sede','area','puesto','tarea','tarea_puesto','peligro_catalogo',
    'control_catalogo','actividad_base_plantilla','diagnostico_item','diagnostico_respuesta','iperc_version','iperc_fila',
    'control','hito_documento','hallazgo','actividad','accion','evidencia'])
  loop
    execute format('alter table %I enable row level security', t);
  end loop;
end $$;

-- Lectura: datos de mi empresa
do $$
declare t text;
begin
  for t in select unnest(array['usuario','sede','area','puesto','tarea','diagnostico_respuesta','iperc_version','iperc_fila',
    'control','hito_documento','hallazgo','actividad','accion','evidencia'])
  loop
    execute format('drop policy if exists lectura_empresa on %I', t);
    execute format('create policy lectura_empresa on %I for select to authenticated using (empresa_id = mi_empresa())', t);
  end loop;
end $$;

drop policy if exists lectura_empresa on empresa;
create policy lectura_empresa on empresa for select to authenticated using (id = mi_empresa());

drop policy if exists lectura_empresa on tarea_puesto;
create policy lectura_empresa on tarea_puesto for select to authenticated
  using (exists (select 1 from tarea t where t.id = tarea_id and t.empresa_id = mi_empresa()));

-- Lectura: catálogos y config (cualquier usuario con sesión)
do $$
declare t text;
begin
  for t in select unnest(array['config','peligro_catalogo','control_catalogo','actividad_base_plantilla','diagnostico_item'])
  loop
    execute format('drop policy if exists lectura_global on %I', t);
    execute format('create policy lectura_global on %I for select to authenticated using (true)', t);
  end loop;
end $$;

-- Escritura de gestión (SST y ADMIN), solo en su empresa. Sin DELETE.
do $$
declare t text;
begin
  for t in select unnest(array['diagnostico_respuesta','iperc_version','iperc_fila','control','hito_documento','hallazgo','actividad','accion'])
  loop
    execute format('drop policy if exists gestion_insert on %I', t);
    execute format('drop policy if exists gestion_update on %I', t);
    execute format('create policy gestion_insert on %I for insert to authenticated with check (empresa_id = mi_empresa() and puedo_gestionar())', t);
    execute format('create policy gestion_update on %I for update to authenticated using (empresa_id = mi_empresa() and puedo_gestionar()) with check (empresa_id = mi_empresa() and puedo_gestionar())', t);
  end loop;
end $$;

-- Responsable de actividad: actualiza lo suyo
drop policy if exists responsable_update on actividad;
create policy responsable_update on actividad for update to authenticated
  using (empresa_id = mi_empresa() and responsable_id = mi_usuario())
  with check (empresa_id = mi_empresa() and responsable_id = mi_usuario());

drop policy if exists responsable_update on accion;
create policy responsable_update on accion for update to authenticated
  using (empresa_id = mi_empresa() and responsable_id = mi_usuario())
  with check (empresa_id = mi_empresa() and responsable_id = mi_usuario());

-- Evidencias: SST, ADMIN y responsables de actividad las suben (a nombre propio)
drop policy if exists evidencia_insert on evidencia;
create policy evidencia_insert on evidencia for insert to authenticated
  with check (empresa_id = mi_empresa() and registrado_por = mi_usuario() and (puedo_gestionar() or tengo_rol('ACTIVIDAD')));

-- Las vistas deben respetar el RLS de quien consulta (si no, mostrarían datos de todas las empresas)
alter view v_reloj set (security_invoker = true);
alter view v_actividad set (security_invoker = true);
alter view v_accion set (security_invoker = true);
alter view v_cumplimiento_bloque set (security_invoker = true);
alter view v_cumplimiento_total set (security_invoker = true);
alter view v_brecha set (security_invoker = true);
