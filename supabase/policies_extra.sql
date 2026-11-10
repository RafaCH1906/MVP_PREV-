-- Permite que cualquier usuario de la empresa reporte un hallazgo desde el celular (W7).
-- Ejecutar una vez en el SQL Editor de Supabase, después de policies.sql.
create policy hallazgo_insert_empresa on hallazgo for insert to authenticated
  with check (empresa_id = mi_empresa());
