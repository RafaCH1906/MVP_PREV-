-- Migración 001 (ejecutar una vez en cada proyecto, después de schema, seed, policies y policies_extra).
-- 1) Evidencia también para hallazgos (foto al reportar).  2) Alcance anual de tareas (RF-04).
-- 3) Escritura de la estructura de la empresa (RF-01 a RF-03) y administración de usuarios (RF-32).

alter table evidencia add column if not exists hallazgo_id uuid references hallazgo(id);
do $$
declare c text;
begin
  for c in select conname from pg_constraint where conrelid = 'evidencia'::regclass and contype = 'c'
  loop execute format('alter table evidencia drop constraint %I', c); end loop;
  alter table evidencia add constraint evidencia_un_origen
    check (num_nonnulls(actividad_id, accion_id, hallazgo_id) = 1);
  alter table evidencia add constraint evidencia_tipo_ok check (tipo in ('IMAGEN', 'PDF', 'ENLACE'));
end $$;

alter table tarea add column if not exists en_alcance boolean not null default true;

-- Estructura: SST y ADMIN crean y editan en su empresa (sin DELETE).
do $$
declare t text;
begin
  for t in select unnest(array['sede', 'area', 'puesto', 'tarea'])
  loop
    execute format('drop policy if exists gestion_insert on %I', t);
    execute format('drop policy if exists gestion_update on %I', t);
    execute format('create policy gestion_insert on %I for insert to authenticated with check (empresa_id = mi_empresa() and puedo_gestionar())', t);
    execute format('create policy gestion_update on %I for update to authenticated using (empresa_id = mi_empresa() and puedo_gestionar()) with check (empresa_id = mi_empresa() and puedo_gestionar())', t);
  end loop;
end $$;

drop policy if exists gestion_update on empresa;
create policy gestion_update on empresa for update to authenticated
  using (id = mi_empresa() and puedo_gestionar()) with check (id = mi_empresa() and puedo_gestionar());

drop policy if exists gestion_insert on tarea_puesto;
create policy gestion_insert on tarea_puesto for insert to authenticated
  with check (puedo_gestionar() and exists (select 1 from tarea t where t.id = tarea_id and t.empresa_id = mi_empresa()));

-- Usuarios: solo el ADMIN cambia roles y activa o desactiva (no se puede quitar el rol a sí mismo).
drop policy if exists admin_update on usuario;
create policy admin_update on usuario for update to authenticated
  using (empresa_id = mi_empresa() and tengo_rol('ADMIN')) with check (empresa_id = mi_empresa() and tengo_rol('ADMIN'));
