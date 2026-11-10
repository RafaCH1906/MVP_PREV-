-- GENERADO por tools/generar_seed_sql.py a partir de semilla/ (contenido semilla v0.1 del equipo MBA). No editar a mano.
-- ESCENARIO DE DEMOSTRACIÓN: datos de entrevistas y supuestos, no reales. La marca estado_dato (V/S) es la que declaró el equipo.

insert into config (clave, valor) values
  ('fecha_referencia', '2026-11-07'),
  ('reloj_demo', '2026-11-07T13:20:00-05:00');

insert into empresa (id, codigo, ruc, razon_social, ciiu, domicilio, sector, metodologia, n_trabajadores, organo_sst, fiscalizador, etiqueta_plan, etiqueta_comite, es_demo, estado_dato, fuente) values
  ('cd37147b-c5c0-5863-a5ef-a377924adfb3', 'CAR', '20452673267', 'MINERA CARACOL S.A.C.', '0729 – Extracción de otros minerales metalíferos no ferrosos', 'Av. San Luis N.° 2113, Dpto. 402, Urb. San Borja, San Borja, Lima', 'Minería', 'MINERIA', 168, 'Comité de SSO', 'Gobierno Regional (pequeña minería) – por confirmar', 'Programa anual de SSO', 'Comité de SSO', true, 'V', 'datosperu.org (consulta 07/11/2026): RUC, CIIU, domicilio, trabajadores 2026-08. INT002: comité, fiscalizador.'),
  ('8e5ec102-d967-54bc-b370-1a067286ec4a', 'WIR', '20488111672', 'WIRBI S.A.C.', '6202 – Consultoría de informática y gestión de instalaciones informáticas', 'Av. Jorge Basadre Grohmann N.° 702, Urb. Orrantia, San Isidro, Lima', 'Servicios (tecnología)', 'MTPE', 40, 'Comité de SST', 'SUNAFIL', 'Plan anual de SST', 'Comité de SST', true, 'V', 'datosperu.org (consulta 07/11/2026): RUC, CIIU, domicilio. N.° de trabajadores = 40, supuesto acordado con el equipo. INT001: comité, SUNAFIL.');

insert into usuario (id, empresa_id, codigo, nombre, cargo, usuario_login, roles, sede) values
  ('d204909c-c2e9-55b3-b918-89600c06d088', 'cd37147b-c5c0-5863-a5ef-a377924adfb3', 'U-C1', 'Rosa Medina Ugarte', 'Jefa de administración y RR. HH.', 'rosa.medina', '{ADMIN}', 'Oficina administrativa'),
  ('8902c33a-40a4-5f7c-b4fc-44da76c680ad', 'cd37147b-c5c0-5863-a5ef-a377924adfb3', 'U-C2', 'Jorge Quispe Valdivia', 'Jefe de seguridad y salud ocupacional; secretario del Comité de SSO', 'jorge.quispe', '{SST}', 'Caracolito I'),
  ('a511194f-5628-505b-9aa2-1666af83ddbe', 'cd37147b-c5c0-5863-a5ef-a377924adfb3', 'U-C3', 'Luis Huamán Cárdenas', 'Jefe de guardia mina', 'luis.huaman', '{ACTIVIDAD}', 'Caracolito II'),
  ('ea84727a-4ba2-58a8-99f1-49646d6f3406', 'cd37147b-c5c0-5863-a5ef-a377924adfb3', 'U-C4', 'Carmen Rojas Villanueva', 'Jefa de planta de beneficio', 'carmen.rojas', '{ACTIVIDAD}', 'Planta de beneficio'),
  ('d05a53da-0119-5904-a55b-cc0092eed08a', 'cd37147b-c5c0-5863-a5ef-a377924adfb3', 'U-C5', 'Víctor Mendoza Arias', 'Gerente de operaciones', 'victor.mendoza', '{LECTOR}', 'Oficina administrativa'),
  ('44241aa2-eb43-5216-aca9-f9a818da767e', '8e5ec102-d967-54bc-b370-1a067286ec4a', 'U-W1', 'Daniela Torres Ríos', 'Jefa de administración y finanzas', 'daniela.torres', '{ADMIN}', 'Oficina principal'),
  ('99af0518-7a54-5f07-94e5-b8fb305278c0', '8e5ec102-d967-54bc-b370-1a067286ec4a', 'U-W2', 'Martín Vega Soto', 'Oficial de cumplimiento; miembro del Comité de SST', 'martin.vega', '{SST}', 'Oficina principal'),
  ('374efafc-0bb0-5e54-8763-bad3277ad758', '8e5ec102-d967-54bc-b370-1a067286ec4a', 'U-W3', 'Lucía Campos Herrera', 'Analista de Talento Humano', 'lucia.campos', '{ACTIVIDAD}', 'Oficina principal'),
  ('82e24213-dafa-5849-92d5-2416638a570d', '8e5ec102-d967-54bc-b370-1a067286ec4a', 'U-W4', 'Pedro Ramírez León', 'Asistente de servicios generales', 'pedro.ramirez', '{ACTIVIDAD}', 'Oficina principal'),
  ('3bb5c299-05c4-56d4-939d-c99cd7eb7360', '8e5ec102-d967-54bc-b370-1a067286ec4a', 'U-W5', 'Andrés Castillo Núñez', 'Gerente general', 'andres.castillo', '{LECTOR}', 'Oficina principal');

insert into sede (id, empresa_id, codigo, nombre, ubicacion, tipo, estado_dato) values
  ('c67efe7f-1d1a-5b7b-ba0b-81f932215f41', 'cd37147b-c5c0-5863-a5ef-a377924adfb3', 'CAR-S1', 'Oficina administrativa', 'San Borja, Lima', 'Administrativa', 'V'),
  ('28fb05a4-5a76-5898-8ca2-bd45eb852d00', 'cd37147b-c5c0-5863-a5ef-a377924adfb3', 'CAR-S2', 'Unidad de explotación Caracolito I', 'Ámbar, Huaura, Lima', 'Productiva (mina subterránea)', 'V'),
  ('ef9e50ac-6eb5-5ca7-b5ba-9ab41cc80e74', 'cd37147b-c5c0-5863-a5ef-a377924adfb3', 'CAR-S3', 'Unidad de explotación Caracolito II', 'Supe, Barranca, Lima', 'Productiva (mina subterránea)', 'V'),
  ('eb171412-15ee-5c05-b261-a3f0f4cbd130', 'cd37147b-c5c0-5863-a5ef-a377924adfb3', 'CAR-S4', 'Planta de beneficio Minera Caracol', 'Supe, Barranca, Lima', 'Productiva (planta)', 'V'),
  ('526a734f-5d36-5387-ba37-a15de1be1069', '8e5ec102-d967-54bc-b370-1a067286ec4a', 'WIR-S1', 'Oficina principal', 'San Isidro, Lima', 'Administrativa', 'V');

insert into area (id, empresa_id, sede_id, nombre) values
  ('d973de3e-ac51-580f-9479-cdc45b3aa0e6', 'cd37147b-c5c0-5863-a5ef-a377924adfb3', 'c67efe7f-1d1a-5b7b-ba0b-81f932215f41', 'Gerencia'),
  ('abd73183-e130-5810-aec4-f5b2e715a41b', 'cd37147b-c5c0-5863-a5ef-a377924adfb3', 'c67efe7f-1d1a-5b7b-ba0b-81f932215f41', 'Administración y RR. HH.'),
  ('82a984c6-4a02-58aa-a188-a3d017e0699e', 'cd37147b-c5c0-5863-a5ef-a377924adfb3', 'c67efe7f-1d1a-5b7b-ba0b-81f932215f41', 'Logística'),
  ('5077fb6d-8f9e-579d-91df-ceecdecc62e4', 'cd37147b-c5c0-5863-a5ef-a377924adfb3', '28fb05a4-5a76-5898-8ca2-bd45eb852d00', 'Mina'),
  ('8da32fee-409c-5516-8c84-e54c8d05c3d6', 'cd37147b-c5c0-5863-a5ef-a377924adfb3', '28fb05a4-5a76-5898-8ca2-bd45eb852d00', 'Mantenimiento'),
  ('9a60c937-1c7a-5d2c-a400-0e3eaa884346', 'cd37147b-c5c0-5863-a5ef-a377924adfb3', '28fb05a4-5a76-5898-8ca2-bd45eb852d00', 'Seguridad y Salud Ocupacional'),
  ('72ef604a-efe5-599c-b668-d5ca8eccf7bd', 'cd37147b-c5c0-5863-a5ef-a377924adfb3', '28fb05a4-5a76-5898-8ca2-bd45eb852d00', 'Geología'),
  ('786678de-3270-53bb-abd3-a24c2745784d', 'cd37147b-c5c0-5863-a5ef-a377924adfb3', '28fb05a4-5a76-5898-8ca2-bd45eb852d00', 'Servicios generales'),
  ('a7ebf1b8-9570-5926-a43e-2b45d71e4c6a', 'cd37147b-c5c0-5863-a5ef-a377924adfb3', 'ef9e50ac-6eb5-5ca7-b5ba-9ab41cc80e74', 'Mina'),
  ('0ffd8360-f91a-523a-a281-dbb23658b0fe', 'cd37147b-c5c0-5863-a5ef-a377924adfb3', 'ef9e50ac-6eb5-5ca7-b5ba-9ab41cc80e74', 'Mantenimiento'),
  ('cea0b799-decc-5365-b559-089bea5556fd', 'cd37147b-c5c0-5863-a5ef-a377924adfb3', 'ef9e50ac-6eb5-5ca7-b5ba-9ab41cc80e74', 'Seguridad y Salud Ocupacional'),
  ('a5f0f7e3-6e79-568f-a72c-a1f964a94743', 'cd37147b-c5c0-5863-a5ef-a377924adfb3', 'eb171412-15ee-5c05-b261-a3f0f4cbd130', 'Planta'),
  ('11f58897-5070-5d30-8ef6-80f1ce92eedf', 'cd37147b-c5c0-5863-a5ef-a377924adfb3', 'eb171412-15ee-5c05-b261-a3f0f4cbd130', 'Mantenimiento'),
  ('1498a488-1c6b-5d72-ae74-111d6e0ce472', 'cd37147b-c5c0-5863-a5ef-a377924adfb3', 'eb171412-15ee-5c05-b261-a3f0f4cbd130', 'Transporte'),
  ('d046c847-013e-5d4a-ad33-a7161ba3570e', 'cd37147b-c5c0-5863-a5ef-a377924adfb3', 'eb171412-15ee-5c05-b261-a3f0f4cbd130', 'Almacén'),
  ('151fc568-f3ef-5827-a75e-775cbe38f300', 'cd37147b-c5c0-5863-a5ef-a377924adfb3', 'eb171412-15ee-5c05-b261-a3f0f4cbd130', 'Seguridad y Salud Ocupacional'),
  ('5d4a7bf5-336e-5a16-9bbc-6df555fd7504', '8e5ec102-d967-54bc-b370-1a067286ec4a', '526a734f-5d36-5387-ba37-a15de1be1069', 'Gerencia'),
  ('8db3c6e7-2bfe-5f73-9d7d-d604a5080750', '8e5ec102-d967-54bc-b370-1a067286ec4a', '526a734f-5d36-5387-ba37-a15de1be1069', 'Tecnología'),
  ('ee579aad-49ae-5b80-88f5-6dd7dc29ab46', '8e5ec102-d967-54bc-b370-1a067286ec4a', '526a734f-5d36-5387-ba37-a15de1be1069', 'Administración y finanzas'),
  ('d1074fbb-6bee-5bd1-8bcc-cad7eac4614d', '8e5ec102-d967-54bc-b370-1a067286ec4a', '526a734f-5d36-5387-ba37-a15de1be1069', 'Talento Humano'),
  ('08359009-057c-535a-a291-c50b85874283', '8e5ec102-d967-54bc-b370-1a067286ec4a', '526a734f-5d36-5387-ba37-a15de1be1069', 'Cumplimiento'),
  ('d0197200-3d29-5730-acef-70fe2cf9117e', '8e5ec102-d967-54bc-b370-1a067286ec4a', '526a734f-5d36-5387-ba37-a15de1be1069', 'Comercial'),
  ('9d0b050c-2175-5475-be6f-8007193af7e2', '8e5ec102-d967-54bc-b370-1a067286ec4a', '526a734f-5d36-5387-ba37-a15de1be1069', 'Servicios generales');

insert into puesto (id, empresa_id, area_id, nombre, n_trabajadores) values
  ('09f7461d-8727-56b1-bf4d-d7cfb8151238', 'cd37147b-c5c0-5863-a5ef-a377924adfb3', 'd973de3e-ac51-580f-9479-cdc45b3aa0e6', 'Gerente general', 1),
  ('9f0940ec-5564-563c-befa-56b5bae42366', 'cd37147b-c5c0-5863-a5ef-a377924adfb3', 'd973de3e-ac51-580f-9479-cdc45b3aa0e6', 'Gerente de operaciones', 1),
  ('63cca336-fae9-5ec5-b4ed-692a003706d5', 'cd37147b-c5c0-5863-a5ef-a377924adfb3', 'abd73183-e130-5810-aec4-f5b2e715a41b', 'Jefa de administración y RR. HH.', 1),
  ('241d719e-0ba7-5b6c-9b4d-585c8a3724f4', 'cd37147b-c5c0-5863-a5ef-a377924adfb3', 'abd73183-e130-5810-aec4-f5b2e715a41b', 'Asistente administrativo-contable', 5),
  ('d65ad369-e800-57fc-b83e-b56cb77136e8', 'cd37147b-c5c0-5863-a5ef-a377924adfb3', 'abd73183-e130-5810-aec4-f5b2e715a41b', 'Asistente de RR. HH.', 2),
  ('df361e06-19d8-5f83-8647-85251a986e07', 'cd37147b-c5c0-5863-a5ef-a377924adfb3', '82a984c6-4a02-58aa-a188-a3d017e0699e', 'Comprador', 2),
  ('aa6a00c2-b72a-5556-bd61-4cfc4eaf9bb7', 'cd37147b-c5c0-5863-a5ef-a377924adfb3', '5077fb6d-8f9e-579d-91df-ceecdecc62e4', 'Jefe de guardia', 3),
  ('5ce11237-33ef-596a-8a15-9862231d084d', 'cd37147b-c5c0-5863-a5ef-a377924adfb3', '5077fb6d-8f9e-579d-91df-ceecdecc62e4', 'Perforista', 16),
  ('b3c64463-a91e-584f-8184-23e4bcaa1e72', 'cd37147b-c5c0-5863-a5ef-a377924adfb3', '5077fb6d-8f9e-579d-91df-ceecdecc62e4', 'Ayudante de perforista', 16),
  ('37623654-c6c3-52f9-b0d7-d6e1f11661c5', 'cd37147b-c5c0-5863-a5ef-a377924adfb3', '5077fb6d-8f9e-579d-91df-ceecdecc62e4', 'Cargador-disparador', 6),
  ('f552e204-b4c3-5ff4-b665-7a16cd7993d9', 'cd37147b-c5c0-5863-a5ef-a377924adfb3', '5077fb6d-8f9e-579d-91df-ceecdecc62e4', 'Sostenedor (enmaderador)', 12),
  ('fc526b20-ae5f-5c5d-9d54-ce6933d4afea', 'cd37147b-c5c0-5863-a5ef-a377924adfb3', '5077fb6d-8f9e-579d-91df-ceecdecc62e4', 'Operador de winche/scoop', 8),
  ('99d0fc13-1986-5665-923d-9050beac5bd0', 'cd37147b-c5c0-5863-a5ef-a377924adfb3', '5077fb6d-8f9e-579d-91df-ceecdecc62e4', 'Bodeguero de polvorín', 2),
  ('516fa51b-7666-52a3-b3ed-19b4bec81cf8', 'cd37147b-c5c0-5863-a5ef-a377924adfb3', '8da32fee-409c-5516-8c84-e54c8d05c3d6', 'Mecánico', 4),
  ('6e4f41c5-70b5-5dc5-b574-cd02466f86ef', 'cd37147b-c5c0-5863-a5ef-a377924adfb3', '8da32fee-409c-5516-8c84-e54c8d05c3d6', 'Electricista', 2),
  ('5dbd5a45-fe74-5c03-bf05-5f59c87ad3ae', 'cd37147b-c5c0-5863-a5ef-a377924adfb3', '9a60c937-1c7a-5d2c-a400-0e3eaa884346', 'Jefe de seguridad y salud ocupacional', 1),
  ('f03a6d44-7bbd-5ebc-b762-1047fe767ef3', 'cd37147b-c5c0-5863-a5ef-a377924adfb3', '9a60c937-1c7a-5d2c-a400-0e3eaa884346', 'Supervisor de seguridad', 2),
  ('b33f57e6-a850-53bb-8125-54bf414a95ac', 'cd37147b-c5c0-5863-a5ef-a377924adfb3', '9a60c937-1c7a-5d2c-a400-0e3eaa884346', 'Enfermero(a)', 1),
  ('b6acdca7-2e47-5c43-a972-e20241dbd0d7', 'cd37147b-c5c0-5863-a5ef-a377924adfb3', '72ef604a-efe5-599c-b668-d5ca8eccf7bd', 'Geólogo', 1),
  ('e1b214c6-ebac-52b0-a000-bf30fe766b79', 'cd37147b-c5c0-5863-a5ef-a377924adfb3', '72ef604a-efe5-599c-b668-d5ca8eccf7bd', 'Topógrafo', 1),
  ('a8a3fdcc-d103-516a-9193-958cfdf167c7', 'cd37147b-c5c0-5863-a5ef-a377924adfb3', '786678de-3270-53bb-abd3-a24c2745784d', 'Vigilante', 1),
  ('5c359197-5ce5-56b9-bc9e-d4646f09d3d8', 'cd37147b-c5c0-5863-a5ef-a377924adfb3', 'a7ebf1b8-9570-5926-a43e-2b45d71e4c6a', 'Jefe de guardia', 2),
  ('9c5c7586-dfbc-53a9-b191-6976e215747f', 'cd37147b-c5c0-5863-a5ef-a377924adfb3', 'a7ebf1b8-9570-5926-a43e-2b45d71e4c6a', 'Perforista', 8),
  ('673cc928-1adb-5930-959c-7345378b9d79', 'cd37147b-c5c0-5863-a5ef-a377924adfb3', 'a7ebf1b8-9570-5926-a43e-2b45d71e4c6a', 'Ayudante de perforista', 8),
  ('ce514f91-c698-597d-b053-295ee53dd6d6', 'cd37147b-c5c0-5863-a5ef-a377924adfb3', 'a7ebf1b8-9570-5926-a43e-2b45d71e4c6a', 'Cargador-disparador', 4),
  ('c7b13069-3035-5e8f-b682-b794cb08376f', 'cd37147b-c5c0-5863-a5ef-a377924adfb3', 'a7ebf1b8-9570-5926-a43e-2b45d71e4c6a', 'Sostenedor (enmaderador)', 6),
  ('1875fc61-6f8d-51c5-ad81-1f779cc24a13', 'cd37147b-c5c0-5863-a5ef-a377924adfb3', 'a7ebf1b8-9570-5926-a43e-2b45d71e4c6a', 'Operador de winche/scoop', 7),
  ('71253eca-b653-5911-91a4-ff8a3d8ee740', 'cd37147b-c5c0-5863-a5ef-a377924adfb3', 'a7ebf1b8-9570-5926-a43e-2b45d71e4c6a', 'Bodeguero de polvorín', 1),
  ('88a65cbc-947e-5e91-8881-893f38a8d514', 'cd37147b-c5c0-5863-a5ef-a377924adfb3', '0ffd8360-f91a-523a-a281-dbb23658b0fe', 'Mecánico', 2),
  ('7e8cf408-2f3d-5c75-9b99-d3cfd6379170', 'cd37147b-c5c0-5863-a5ef-a377924adfb3', 'cea0b799-decc-5365-b559-089bea5556fd', 'Supervisor de seguridad', 1),
  ('156231f2-0bc9-5f7e-a45a-af38218ba949', 'cd37147b-c5c0-5863-a5ef-a377924adfb3', 'a5f0f7e3-6e79-568f-a72c-a1f964a94743', 'Jefa de planta', 1),
  ('1bd0d6c3-17b1-5042-8837-348ac4ef2d1b', 'cd37147b-c5c0-5863-a5ef-a377924adfb3', 'a5f0f7e3-6e79-568f-a72c-a1f964a94743', 'Operador de chancado', 6),
  ('a5c1ce08-e778-57bc-8638-22686ecd3ae0', 'cd37147b-c5c0-5863-a5ef-a377924adfb3', 'a5f0f7e3-6e79-568f-a72c-a1f964a94743', 'Operador de molienda', 6),
  ('30373ce5-565a-52dc-903f-9407d77817ce', 'cd37147b-c5c0-5863-a5ef-a377924adfb3', 'a5f0f7e3-6e79-568f-a72c-a1f964a94743', 'Operador de procesos', 6),
  ('252c13aa-c910-5baa-b279-321ae8805939', 'cd37147b-c5c0-5863-a5ef-a377924adfb3', 'a5f0f7e3-6e79-568f-a72c-a1f964a94743', 'Laboratorista', 3),
  ('6b43245d-ea91-5ed2-987a-7de7762365ee', 'cd37147b-c5c0-5863-a5ef-a377924adfb3', '11f58897-5070-5d30-8ef6-80f1ce92eedf', 'Mecánico de planta', 4),
  ('20cd59a5-d49f-5d7b-8ca2-e65fe90990e9', 'cd37147b-c5c0-5863-a5ef-a377924adfb3', '11f58897-5070-5d30-8ef6-80f1ce92eedf', 'Electricista', 2),
  ('f446b842-d22f-58b1-bc9b-f0eb6919b107', 'cd37147b-c5c0-5863-a5ef-a377924adfb3', '1498a488-1c6b-5d72-ae74-111d6e0ce472', 'Conductor de volquete', 10),
  ('a2d3afc0-d093-5145-8937-7ff7f0f23e38', 'cd37147b-c5c0-5863-a5ef-a377924adfb3', 'd046c847-013e-5d4a-ad33-a7161ba3570e', 'Almacenero', 2),
  ('1d4494d9-ecef-569b-9579-69bc398aef11', 'cd37147b-c5c0-5863-a5ef-a377924adfb3', '151fc568-f3ef-5827-a75e-775cbe38f300', 'Enfermero(a)', 1),
  ('71afd7ce-3897-5d13-9d40-ac3b8b95ec23', '8e5ec102-d967-54bc-b370-1a067286ec4a', '5d4a7bf5-336e-5a16-9bbc-6df555fd7504', 'Gerente general', 1),
  ('30d65361-b34c-56e5-8e66-598164ac1468', '8e5ec102-d967-54bc-b370-1a067286ec4a', '8db3c6e7-2bfe-5f73-9d7d-d604a5080750', 'Jefe de proyectos', 4),
  ('6dc3413e-ecee-581c-8b17-15ad0d1089be', '8e5ec102-d967-54bc-b370-1a067286ec4a', '8db3c6e7-2bfe-5f73-9d7d-d604a5080750', 'Desarrollador de software', 18),
  ('266f4d44-eb6f-5446-94b9-19afbd025b3c', '8e5ec102-d967-54bc-b370-1a067286ec4a', '8db3c6e7-2bfe-5f73-9d7d-d604a5080750', 'Analista QA', 4),
  ('7ad99382-e277-5cc4-bd1c-45322a99f312', '8e5ec102-d967-54bc-b370-1a067286ec4a', '8db3c6e7-2bfe-5f73-9d7d-d604a5080750', 'Especialista de infraestructura y soporte', 3),
  ('11095150-0959-5723-9a2b-dae09c9a8964', '8e5ec102-d967-54bc-b370-1a067286ec4a', 'ee579aad-49ae-5b80-88f5-6dd7dc29ab46', 'Jefa de administración y finanzas', 1),
  ('85ff722c-f8eb-56cb-876c-16a28e704fbe', '8e5ec102-d967-54bc-b370-1a067286ec4a', 'ee579aad-49ae-5b80-88f5-6dd7dc29ab46', 'Analista contable-administrativo', 2),
  ('ee0f3f23-c2fb-591b-b89b-3c3b82f4f237', '8e5ec102-d967-54bc-b370-1a067286ec4a', 'd1074fbb-6bee-5bd1-8bcc-cad7eac4614d', 'Analista de Talento Humano', 2),
  ('e861b23e-dd34-5332-aaf6-0a537ba19b44', '8e5ec102-d967-54bc-b370-1a067286ec4a', '08359009-057c-535a-a291-c50b85874283', 'Oficial de cumplimiento', 1),
  ('a6462991-3588-541d-b623-dc541b02852e', '8e5ec102-d967-54bc-b370-1a067286ec4a', 'd0197200-3d29-5730-acef-70fe2cf9117e', 'Ejecutivo comercial', 2),
  ('3e391480-3a16-53bc-834a-8328b35612d3', '8e5ec102-d967-54bc-b370-1a067286ec4a', '9d0b050c-2175-5475-be6f-8007193af7e2', 'Asistente de servicios generales', 1),
  ('0ad4e8a6-6c2e-5b6e-971e-41c70c85a1da', '8e5ec102-d967-54bc-b370-1a067286ec4a', '9d0b050c-2175-5475-be6f-8007193af7e2', 'Personal de limpieza', 1);

insert into tarea (id, empresa_id, codigo, proceso, actividad, nombre, rutinaria, sedes, fuente, estado_dato) values
  ('ab8dd1fe-d28a-5540-b472-71b77849ff60', 'cd37147b-c5c0-5863-a5ef-a377924adfb3', 'CAR-T01', 'Explotación subterránea', 'Perforación', 'Desatado de rocas e inspección de la labor al inicio de la guardia', true, 'Caracolito I; Caracolito II', 'INT002 (minería subterránea) + supuesto', 'S'),
  ('8d9a8a18-c0f1-535f-a16f-bb32d710988d', 'cd37147b-c5c0-5863-a5ef-a377924adfb3', 'CAR-T02', 'Explotación subterránea', 'Perforación', 'Perforación de taladros con perforadora neumática', true, 'Caracolito I; Caracolito II', 'Supuesto', 'S'),
  ('f01b6f52-30af-5ef0-8bad-810c179ed982', 'cd37147b-c5c0-5863-a5ef-a377924adfb3', 'CAR-T03', 'Explotación subterránea', 'Voladura', 'Transporte de explosivos del polvorín a la labor', true, 'Caracolito I; Caracolito II', 'INT002 (explosivos)', 'S'),
  ('5001e0b7-22ac-598d-a5da-bef3e4adcda0', 'cd37147b-c5c0-5863-a5ef-a377924adfb3', 'CAR-T04', 'Explotación subterránea', 'Voladura', 'Carguío de taladros y encendido', true, 'Caracolito I; Caracolito II', 'INT002 (carné para manipular explosivos)', 'S'),
  ('f4186636-8de4-5b42-b253-adcce6699614', 'cd37147b-c5c0-5863-a5ef-a377924adfb3', 'CAR-T05', 'Explotación subterránea', 'Voladura', 'Ventilación y verificación de gases después de la voladura', true, 'Caracolito I; Caracolito II', 'Supuesto', 'S'),
  ('a2111acd-3e3f-50e6-b03a-ecc1d35b4166', 'cd37147b-c5c0-5863-a5ef-a377924adfb3', 'CAR-T06', 'Explotación subterránea', 'Sostenimiento', 'Instalación de cuadros de madera y puntales', true, 'Caracolito I; Caracolito II', 'Supuesto', 'S'),
  ('8e0aa118-963d-52c4-b5af-b69fd149c0fd', 'cd37147b-c5c0-5863-a5ef-a377924adfb3', 'CAR-T07', 'Explotación subterránea', 'Limpieza y extracción de mineral', 'Limpieza de mineral con winche o scoop', true, 'Caracolito I; Caracolito II', 'Supuesto', 'S'),
  ('8c3d9633-25aa-5c8e-8152-4d2e73449905', 'cd37147b-c5c0-5863-a5ef-a377924adfb3', 'CAR-T08', 'Explotación subterránea', 'Apertura de nueva labor', 'Habilitación y sostenimiento de una nueva labor', false, 'Caracolito II', 'Supuesto (escenario RF-36)', 'S'),
  ('7b9348bc-9e28-5549-a85e-63cc45619229', 'cd37147b-c5c0-5863-a5ef-a377924adfb3', 'CAR-T09', 'Transporte de mineral', 'Transporte mina–planta', 'Carguío de volquete en cancha de mineral', true, 'Caracolito I; Caracolito II', 'Supuesto', 'S'),
  ('f99722f5-7e31-5542-a64c-27919d1cd668', 'cd37147b-c5c0-5863-a5ef-a377924adfb3', 'CAR-T10', 'Transporte de mineral', 'Transporte mina–planta', 'Conducción por vía de acceso con curvas', true, 'Caracolito II; Planta de beneficio', 'INT002 (curvas sin señalización, EV010)', 'V'),
  ('bc982b24-e087-5451-95a0-fc3861e098f3', 'cd37147b-c5c0-5863-a5ef-a377924adfb3', 'CAR-T11', 'Beneficio de mineral', 'Chancado', 'Alimentación de tolva y operación de chancadora', true, 'Planta de beneficio', 'Supuesto', 'S'),
  ('be30fac5-6394-5cc5-87b8-feaaa1dd4467', 'cd37147b-c5c0-5863-a5ef-a377924adfb3', 'CAR-T12', 'Beneficio de mineral', 'Molienda y procesamiento', 'Operación de molino', true, 'Planta de beneficio', 'Supuesto', 'S'),
  ('130bab44-9ac2-51b6-9315-00fc71dfdee5', 'cd37147b-c5c0-5863-a5ef-a377924adfb3', 'CAR-T13', 'Beneficio de mineral', 'Molienda y procesamiento', 'Preparación y dosificación de reactivos', true, 'Planta de beneficio', 'Supuesto', 'S'),
  ('8258338c-29ac-50cf-9b1a-790946373041', 'cd37147b-c5c0-5863-a5ef-a377924adfb3', 'CAR-T14', 'Beneficio de mineral', 'Laboratorio', 'Preparación y análisis de muestras', true, 'Planta de beneficio', 'Supuesto', 'S'),
  ('7e8f969d-ae03-5a02-9e9c-4c1bf47d1971', 'cd37147b-c5c0-5863-a5ef-a377924adfb3', 'CAR-T15', 'Mantenimiento', 'Mantenimiento mecánico', 'Mantenimiento de equipos con bloqueo y etiquetado', true, 'Caracolito I; Caracolito II; Planta de beneficio', 'Supuesto', 'S'),
  ('b43dba8b-6f99-5886-aaa9-98c47b4f3c88', 'cd37147b-c5c0-5863-a5ef-a377924adfb3', 'CAR-T16', 'Mantenimiento', 'Reparaciones con soldadura', 'Soldadura y corte en reparaciones', false, 'Planta de beneficio', 'Supuesto', 'S'),
  ('a4dc998e-e92d-5243-bf64-5ea559828971', 'cd37147b-c5c0-5863-a5ef-a377924adfb3', 'CAR-T17', 'Mantenimiento', 'Mantenimiento eléctrico', 'Revisión de tableros e instalaciones eléctricas', true, 'Caracolito I; Planta de beneficio', 'Supuesto', 'S'),
  ('fa467dd3-0c0e-5023-b8cf-130f441615b8', 'cd37147b-c5c0-5863-a5ef-a377924adfb3', 'CAR-T18', 'Almacenamiento de explosivos', 'Gestión de polvorín', 'Recepción, almacenamiento e inventario de explosivos', true, 'Caracolito I; Caracolito II', 'Supuesto', 'S'),
  ('1631ec63-75e3-5ddf-8ff5-2dc23945b2ba', 'cd37147b-c5c0-5863-a5ef-a377924adfb3', 'CAR-T19', 'Gestión administrativa', 'Trabajo de oficina', 'Trabajo en computadora', true, 'Oficina administrativa', 'Supuesto', 'S'),
  ('2df6560e-fda7-52c9-896f-d315e96cbccb', '8e5ec102-d967-54bc-b370-1a067286ec4a', 'WIR-T01', 'Desarrollo y soporte de software', 'Trabajo en computadora', 'Desarrollo, pruebas y soporte frente a computadora', true, 'Oficina principal', 'INT001 (trabajo administrativo)', 'V'),
  ('b25d611f-5a2f-526f-8195-408b47784e82', '8e5ec102-d967-54bc-b370-1a067286ec4a', 'WIR-T02', 'Gestión administrativa', 'Trabajo en computadora', 'Trabajo administrativo en computadora', true, 'Oficina principal', 'INT001', 'V'),
  ('b0a1a6cf-f19a-5c1b-b1ab-ad73a4575597', '8e5ec102-d967-54bc-b370-1a067286ec4a', 'WIR-T03', 'Desarrollo y soporte de software', 'Soporte de infraestructura', 'Instalación y revisión de equipos y cableado', true, 'Oficina principal', 'Supuesto', 'S'),
  ('fce9f8f4-4881-521b-bbc9-d0a417070cc5', '8e5ec102-d967-54bc-b370-1a067286ec4a', 'WIR-T04', 'Uso de cocina', 'Preparación y consumo de alimentos', 'Calentar alimentos y bebidas (microondas, cafetera)', true, 'Oficina principal', 'INT001 (kitchen, microondas, cafetera)', 'V'),
  ('f688e568-05ab-506c-a0bf-b8b3e1695f12', '8e5ec102-d967-54bc-b370-1a067286ec4a', 'WIR-T05', 'Uso de cocina', 'Preparación y consumo de alimentos', 'Cortar y servir alimentos', true, 'Oficina principal', 'INT001 (incidente con cuchillo)', 'V'),
  ('a228ba90-9544-5a33-84f2-05bf6e5dd1f8', '8e5ec102-d967-54bc-b370-1a067286ec4a', 'WIR-T06', 'Limpieza y servicios generales', 'Limpieza', 'Limpieza de oficinas, cocina y servicios higiénicos con productos químicos', true, 'Oficina principal', 'INT001 (riesgos de limpieza)', 'V'),
  ('a324ba75-605d-538c-a436-4da3134f9759', '8e5ec102-d967-54bc-b370-1a067286ec4a', 'WIR-T07', 'Limpieza y servicios generales', 'Limpieza', 'Traslado de residuos y bidones de agua', true, 'Oficina principal', 'Supuesto', 'S'),
  ('7a0069d4-4725-5ff3-bd12-47151b43792b', '8e5ec102-d967-54bc-b370-1a067286ec4a', 'WIR-T08', 'Atención a clientes', 'Visitas a clientes', 'Desplazamiento en la ciudad hacia el cliente', true, 'Oficina principal', 'INT001 (seguridad fuera de la oficina)', 'S'),
  ('d9491fba-03f7-5477-84a1-4ead90d61c7a', '8e5ec102-d967-54bc-b370-1a067286ec4a', 'WIR-T09', 'Atención a clientes', 'Visitas a clientes', 'Trabajo en instalaciones del cliente', true, 'Oficina principal', 'INT001 (seguridad dentro del cliente)', 'S'),
  ('6cf818b2-403e-593f-a7bb-f65c1f3552fa', '8e5ec102-d967-54bc-b370-1a067286ec4a', 'WIR-T10', 'Gestión de emergencias', 'Mantenimiento de equipos de seguridad', 'Coordinación de recarga de extintores y revisión de alarmas y rociadores (ejecuta proveedor)', false, 'Oficina principal', 'INT001 (mantenimientos que vencen, EV006)', 'V'),
  ('182105df-356b-51f7-8773-e81ed8505c77', '8e5ec102-d967-54bc-b370-1a067286ec4a', 'WIR-T11', 'Gestión de emergencias', 'Evacuación', 'Evacuación ante sismo o simulacro', false, 'Oficina principal', 'INT001 (simulacros, brigadistas)', 'V');

insert into tarea_puesto select 'ab8dd1fe-d28a-5540-b472-71b77849ff60'::uuid, p.id from puesto p where p.empresa_id = 'cd37147b-c5c0-5863-a5ef-a377924adfb3'::uuid and p.nombre in ('Perforista', 'Ayudante de perforista', 'Jefe de guardia');
insert into tarea_puesto select '8d9a8a18-c0f1-535f-a16f-bb32d710988d'::uuid, p.id from puesto p where p.empresa_id = 'cd37147b-c5c0-5863-a5ef-a377924adfb3'::uuid and p.nombre in ('Perforista', 'Ayudante de perforista');
insert into tarea_puesto select 'f01b6f52-30af-5ef0-8bad-810c179ed982'::uuid, p.id from puesto p where p.empresa_id = 'cd37147b-c5c0-5863-a5ef-a377924adfb3'::uuid and p.nombre in ('Cargador-disparador', 'Bodeguero de polvorín');
insert into tarea_puesto select '5001e0b7-22ac-598d-a5da-bef3e4adcda0'::uuid, p.id from puesto p where p.empresa_id = 'cd37147b-c5c0-5863-a5ef-a377924adfb3'::uuid and p.nombre in ('Cargador-disparador', 'Jefe de guardia');
insert into tarea_puesto select 'f4186636-8de4-5b42-b253-adcce6699614'::uuid, p.id from puesto p where p.empresa_id = 'cd37147b-c5c0-5863-a5ef-a377924adfb3'::uuid and p.nombre in ('Jefe de guardia', 'Supervisor de seguridad');
insert into tarea_puesto select 'a2111acd-3e3f-50e6-b03a-ecc1d35b4166'::uuid, p.id from puesto p where p.empresa_id = 'cd37147b-c5c0-5863-a5ef-a377924adfb3'::uuid and p.nombre in ('Sostenedor (enmaderador)');
insert into tarea_puesto select '8e0aa118-963d-52c4-b5af-b69fd149c0fd'::uuid, p.id from puesto p where p.empresa_id = 'cd37147b-c5c0-5863-a5ef-a377924adfb3'::uuid and p.nombre in ('Operador de winche/scoop');
insert into tarea_puesto select '8c3d9633-25aa-5c8e-8152-4d2e73449905'::uuid, p.id from puesto p where p.empresa_id = 'cd37147b-c5c0-5863-a5ef-a377924adfb3'::uuid and p.nombre in ('Jefe de guardia', 'Sostenedor (enmaderador)', 'Perforista');
insert into tarea_puesto select '7b9348bc-9e28-5549-a85e-63cc45619229'::uuid, p.id from puesto p where p.empresa_id = 'cd37147b-c5c0-5863-a5ef-a377924adfb3'::uuid and p.nombre in ('Conductor de volquete');
insert into tarea_puesto select 'f99722f5-7e31-5542-a64c-27919d1cd668'::uuid, p.id from puesto p where p.empresa_id = 'cd37147b-c5c0-5863-a5ef-a377924adfb3'::uuid and p.nombre in ('Conductor de volquete');
insert into tarea_puesto select 'bc982b24-e087-5451-95a0-fc3861e098f3'::uuid, p.id from puesto p where p.empresa_id = 'cd37147b-c5c0-5863-a5ef-a377924adfb3'::uuid and p.nombre in ('Operador de chancado');
insert into tarea_puesto select 'be30fac5-6394-5cc5-87b8-feaaa1dd4467'::uuid, p.id from puesto p where p.empresa_id = 'cd37147b-c5c0-5863-a5ef-a377924adfb3'::uuid and p.nombre in ('Operador de molienda');
insert into tarea_puesto select '130bab44-9ac2-51b6-9315-00fc71dfdee5'::uuid, p.id from puesto p where p.empresa_id = 'cd37147b-c5c0-5863-a5ef-a377924adfb3'::uuid and p.nombre in ('Operador de procesos');
insert into tarea_puesto select '8258338c-29ac-50cf-9b1a-790946373041'::uuid, p.id from puesto p where p.empresa_id = 'cd37147b-c5c0-5863-a5ef-a377924adfb3'::uuid and p.nombre in ('Laboratorista');
insert into tarea_puesto select '7e8f969d-ae03-5a02-9e9c-4c1bf47d1971'::uuid, p.id from puesto p where p.empresa_id = 'cd37147b-c5c0-5863-a5ef-a377924adfb3'::uuid and p.nombre in ('Mecánico', 'Mecánico de planta');
insert into tarea_puesto select 'b43dba8b-6f99-5886-aaa9-98c47b4f3c88'::uuid, p.id from puesto p where p.empresa_id = 'cd37147b-c5c0-5863-a5ef-a377924adfb3'::uuid and p.nombre in ('Mecánico de planta');
insert into tarea_puesto select 'a4dc998e-e92d-5243-bf64-5ea559828971'::uuid, p.id from puesto p where p.empresa_id = 'cd37147b-c5c0-5863-a5ef-a377924adfb3'::uuid and p.nombre in ('Electricista');
insert into tarea_puesto select 'fa467dd3-0c0e-5023-b8cf-130f441615b8'::uuid, p.id from puesto p where p.empresa_id = 'cd37147b-c5c0-5863-a5ef-a377924adfb3'::uuid and p.nombre in ('Bodeguero de polvorín');
insert into tarea_puesto select '1631ec63-75e3-5ddf-8ff5-2dc23945b2ba'::uuid, p.id from puesto p where p.empresa_id = 'cd37147b-c5c0-5863-a5ef-a377924adfb3'::uuid and p.nombre in ('Jefa de administración y RR. HH.', 'Asistente administrativo-contable', 'Asistente de RR. HH.', 'Comprador');
insert into tarea_puesto select '2df6560e-fda7-52c9-896f-d315e96cbccb'::uuid, p.id from puesto p where p.empresa_id = '8e5ec102-d967-54bc-b370-1a067286ec4a'::uuid and p.nombre in ('Jefe de proyectos', 'Desarrollador de software', 'Analista QA', 'Especialista de infraestructura y soporte');
insert into tarea_puesto select 'b25d611f-5a2f-526f-8195-408b47784e82'::uuid, p.id from puesto p where p.empresa_id = '8e5ec102-d967-54bc-b370-1a067286ec4a'::uuid and p.nombre in ('Gerente general', 'Jefa de administración y finanzas', 'Analista contable-administrativo', 'Analista de Talento Humano', 'Oficial de cumplimiento', 'Ejecutivo comercial');
insert into tarea_puesto select 'b0a1a6cf-f19a-5c1b-b1ab-ad73a4575597'::uuid, p.id from puesto p where p.empresa_id = '8e5ec102-d967-54bc-b370-1a067286ec4a'::uuid and p.nombre in ('Especialista de infraestructura y soporte');
insert into tarea_puesto select 'fce9f8f4-4881-521b-bbc9-d0a417070cc5'::uuid, p.id from puesto p where p.empresa_id = '8e5ec102-d967-54bc-b370-1a067286ec4a'::uuid;
insert into tarea_puesto select 'f688e568-05ab-506c-a0bf-b8b3e1695f12'::uuid, p.id from puesto p where p.empresa_id = '8e5ec102-d967-54bc-b370-1a067286ec4a'::uuid;
insert into tarea_puesto select 'a228ba90-9544-5a33-84f2-05bf6e5dd1f8'::uuid, p.id from puesto p where p.empresa_id = '8e5ec102-d967-54bc-b370-1a067286ec4a'::uuid and p.nombre in ('Personal de limpieza');
insert into tarea_puesto select 'a324ba75-605d-538c-a436-4da3134f9759'::uuid, p.id from puesto p where p.empresa_id = '8e5ec102-d967-54bc-b370-1a067286ec4a'::uuid and p.nombre in ('Personal de limpieza', 'Asistente de servicios generales');
insert into tarea_puesto select '7a0069d4-4725-5ff3-bd12-47151b43792b'::uuid, p.id from puesto p where p.empresa_id = '8e5ec102-d967-54bc-b370-1a067286ec4a'::uuid and p.nombre in ('Ejecutivo comercial', 'Jefe de proyectos');
insert into tarea_puesto select 'd9491fba-03f7-5477-84a1-4ead90d61c7a'::uuid, p.id from puesto p where p.empresa_id = '8e5ec102-d967-54bc-b370-1a067286ec4a'::uuid and p.nombre in ('Jefe de proyectos', 'Especialista de infraestructura y soporte');
insert into tarea_puesto select '6cf818b2-403e-593f-a7bb-f65c1f3552fa'::uuid, p.id from puesto p where p.empresa_id = '8e5ec102-d967-54bc-b370-1a067286ec4a'::uuid and p.nombre in ('Asistente de servicios generales');
insert into tarea_puesto select '182105df-356b-51f7-8773-e81ed8505c77'::uuid, p.id from puesto p where p.empresa_id = '8e5ec102-d967-54bc-b370-1a067286ec4a'::uuid;

insert into peligro_catalogo (id, codigo, sector, tipo, peligro, riesgo, consecuencia, sev_mtpe, sev_mineria) values
  ('5a0be95c-b5a8-5e8f-aa58-9787348701df', 'PEL-M01', 'Minería', 'Mecánico / locativo', 'Rocas sueltas en techo y hastiales', 'Caída de rocas', 'Aplastamiento, politraumatismo, muerte', 3, 2),
  ('6358c075-7fe5-5b60-9bfc-5ed464412d54', 'PEL-M02', 'Minería', 'Explosivos', 'Explosivos (dinamita, emulsiones, ANFO)', 'Detonación prematura o no controlada', 'Muerte, amputaciones, quemaduras', 3, 1),
  ('9c5da228-9b88-5289-85c1-320e862b93e7', 'PEL-M03', 'Minería', 'Explosivos', 'Tiros cortados (fallados)', 'Detonación al perforar o limpiar', 'Muerte, lesiones graves', 3, 1),
  ('b3e21a27-6e10-5974-9679-38c61d24c931', 'PEL-M04', 'Minería', 'Químico', 'Gases de voladura (CO, NO2)', 'Inhalación de gases tóxicos', 'Intoxicación, asfixia, muerte', 3, 2),
  ('e4b0774e-47b1-5ab2-bbf3-afa87c0c0256', 'PEL-M05', 'Minería', 'Químico', 'Atmósfera deficiente en oxígeno', 'Asfixia', 'Pérdida de conciencia, muerte', 3, 2),
  ('e0e7d6c7-a645-570f-89fc-1cb46e80bcfb', 'PEL-M06', 'Minería', 'Físico', 'Polvo con sílice', 'Inhalación de polvo', 'Silicosis, neumoconiosis', 3, 3),
  ('14e5a795-6072-51b9-827c-3d05791eda4d', 'PEL-M07', 'Minería', 'Físico', 'Ruido de perforadoras', 'Exposición a ruido', 'Hipoacusia', 2, 3),
  ('15b181bb-be71-5f49-9583-f93c9a40876e', 'PEL-M08', 'Minería', 'Físico', 'Vibración de perforadora manual', 'Exposición a vibración mano-brazo', 'Trastornos vasculares y musculoesqueléticos', 2, 4),
  ('b5d9c82e-a47e-5926-a83f-a3b8aba599c9', 'PEL-M09', 'Minería', 'Mecánico', 'Barreno y partes móviles de perforadora', 'Atrapamiento, golpes', 'Fracturas, amputaciones', 2, 3),
  ('63d52789-24a2-52d9-88e7-455a15f1cefb', 'PEL-M10', 'Minería', 'Locativo', 'Piso irregular, desniveles y agua en labores', 'Caída al mismo nivel', 'Contusiones, esguinces', 1, 4),
  ('847158b5-1804-5a14-aa42-3c1dec087883', 'PEL-M11', 'Minería', 'Locativo', 'Chimeneas, piques y echaderos abiertos', 'Caída a distinto nivel', 'Politraumatismo, muerte', 3, 2),
  ('5b1b6cc6-5042-53f0-a4c7-a5824bcbcbd4', 'PEL-M12', 'Minería', 'Mecánico', 'Winche o scoop en operación', 'Atropello, atrapamiento', 'Fracturas, muerte', 3, 2),
  ('ec3d4873-6cd8-5d8c-8b7e-e0086509b2d3', 'PEL-M13', 'Minería', 'Mecánico', 'Carros mineros y locomotora', 'Atropello, descarrilamiento', 'Fracturas, muerte', 3, 2),
  ('93e13e57-a77b-50c4-be0d-5a62f1c7c38a', 'PEL-M14', 'Minería', 'Transporte', 'Vías con curvas sin señalización', 'Choque o volcadura del vehículo', 'Politraumatismo, muerte, daño a equipos', 3, 2),
  ('50411b59-baca-51ea-aaae-2213e04e5531', 'PEL-M15', 'Minería', 'Psicosocial / transporte', 'Fatiga del conductor en turnos largos', 'Pérdida de control del vehículo', 'Politraumatismo, muerte', 3, 2),
  ('1d343bb9-240b-556c-84ab-30e8cafab141', 'PEL-M16', 'Minería', 'Transporte', 'Tránsito de personal en vías de volquetes', 'Atropello', 'Politraumatismo, muerte', 3, 2),
  ('0b5a7eb1-ed30-5e66-ad30-235f469c9739', 'PEL-M17', 'Minería', 'Eléctrico', 'Tableros y cables sin protección en mina', 'Contacto eléctrico directo o indirecto', 'Quemaduras, electrocución, muerte', 3, 2),
  ('60431bf6-8b91-5d5d-85b7-ce57efd39eed', 'PEL-M18', 'Minería', 'Mecánico', 'Partes móviles de chancadora y fajas', 'Atrapamiento', 'Amputación, muerte', 3, 2),
  ('c8ca7f84-7340-553e-b53c-ec47335b1dc7', 'PEL-M19', 'Minería', 'Mecánico', 'Proyección de fragmentos en chancado', 'Golpe por proyección', 'Lesión ocular, contusiones', 2, 4),
  ('20629d0d-e96e-5883-a075-7ae121cf9d06', 'PEL-M20', 'Minería', 'Químico', 'Reactivos de procesamiento (p. ej., cianuro, cal, ácidos)', 'Contacto, inhalación o ingestión', 'Intoxicación, quemaduras químicas', 3, 2),
  ('a99ccd5d-5299-58c8-a179-b371a5b6b8f6', 'PEL-M21', 'Minería', 'Físico', 'Polvo en chancado y molienda', 'Inhalación de polvo', 'Neumoconiosis', 2, 3),
  ('626d0591-8b99-55bc-a0a3-5be3e81d54a1', 'PEL-M22', 'Minería', 'Físico', 'Ruido de molinos', 'Exposición a ruido', 'Hipoacusia', 2, 3),
  ('f3cabf52-d4f2-59af-b12b-79b0cf03e54c', 'PEL-M23', 'Minería', 'Locativo', 'Trabajo sobre tolvas y plataformas elevadas', 'Caída a distinto nivel', 'Politraumatismo, muerte', 3, 2),
  ('02a8b7a0-324c-5871-93dd-dbea04c83275', 'PEL-M24', 'Minería', 'Mecánico', 'Izaje de cargas en mantenimiento', 'Caída de objetos suspendidos', 'Aplastamiento, muerte', 3, 2),
  ('f85da438-fb33-5275-9ee5-026d43092143', 'PEL-M25', 'Minería', 'Mecánico', 'Herramientas manuales en mal estado', 'Golpes y cortes', 'Contusiones, heridas', 1, 4),
  ('f5d7e27a-b71e-5445-8c39-3dc891754846', 'PEL-M26', 'Minería', 'Físico', 'Soldadura y corte (radiación, chispas)', 'Quemaduras, lesión ocular, incendio', 'Quemaduras, conjuntivitis actínica', 2, 3),
  ('ae405ef2-2e84-520e-bf81-b5e8a65fb993', 'PEL-M27', 'Minería', 'Químico', 'Humos metálicos de soldadura', 'Inhalación', 'Fiebre de humos metálicos, enfermedad respiratoria', 2, 3),
  ('31a4d934-641c-5d77-9f2d-9e05549b1854', 'PEL-M28', 'Minería', 'Físico', 'Temperaturas extremas y altitud', 'Exposición a frío o calor', 'Hipotermia, golpe de calor, mal de altura', 2, 3),
  ('244d201e-99e0-508a-be12-046993603bc6', 'PEL-M29', 'Minería', 'Ergonómico', 'Carga manual de madera, sacos y materiales', 'Sobreesfuerzo', 'Lumbalgia, hernias', 2, 4),
  ('c81bb9b3-251c-5a94-8601-4f4c0dd23bf1', 'PEL-M30', 'Minería', 'Ergonómico', 'Posturas forzadas en labores estrechas', 'Trastornos musculoesqueléticos', 'Lesiones de espalda y rodillas', 2, 4),
  ('0e4f2ef8-2b07-5ba4-b691-2cc5042b43ec', 'PEL-M31', 'Minería', 'Psicosocial', 'Turnos rotativos y trabajo nocturno', 'Fatiga y estrés', 'Trastornos del sueño, mayor probabilidad de accidentes', 2, 4),
  ('e8cfa402-bd48-5c09-92c0-36f7e6491e4b', 'PEL-M32', 'Minería', 'Biológico', 'Agua contaminada y roedores en interior mina', 'Contacto con agentes biológicos', 'Infecciones', 1, 4),
  ('f4a05a6d-374a-50b2-8572-e9f8ba304291', 'PEL-M33', 'Minería', 'Incendio', 'Combustibles y madera en interior mina', 'Incendio subterráneo', 'Asfixia por humos, muerte', 3, 1),
  ('2f8eb8f8-2e31-5aa4-a7b3-ea125e44bb7d', 'PEL-M34', 'Minería', 'Locativo', 'Bolsonadas de agua y labores antiguas inundadas', 'Inundación de la labor', 'Ahogamiento, atrapamiento', 3, 1),
  ('064aff0b-7430-528e-9db5-e417687f008f', 'PEL-M35', 'Minería', 'Físico', 'Iluminación deficiente en labores', 'Golpes y caídas', 'Contusiones', 1, 4),
  ('21c8c556-effa-51f5-b2df-9063690f5f8f', 'PEL-M36', 'Minería', 'Explosivos', 'Almacenamiento inadecuado en polvorín', 'Explosión, incendio', 'Muerte, destrucción de instalaciones', 3, 1),
  ('cec9659e-ee72-599a-be3b-5b1ae91c6d49', 'PEL-G01', 'General', 'Ergonómico', 'Trabajo prolongado frente a computadora (PVD)', 'Postura sedente prolongada', 'Trastornos musculoesqueléticos (cuello, espalda, muñeca)', 2, 4),
  ('800df624-b41e-55f0-bceb-79e31fc95141', 'PEL-G02', 'General', 'Ergonómico', 'Uso intensivo de pantalla', 'Fatiga visual', 'Cefalea, sequedad ocular', 1, 5),
  ('ab9c83c9-815c-56c8-8ec2-37e14a1804a8', 'PEL-G03', 'General', 'Psicosocial', 'Carga de trabajo y plazos de entrega', 'Estrés laboral', 'Ansiedad, agotamiento', 2, 4),
  ('01e4fa4f-b7f5-583f-afd0-cd8d53ccf862', 'PEL-G04', 'General', 'Eléctrico', 'Instalaciones y equipos eléctricos (enchufes, extensiones)', 'Contacto eléctrico, cortocircuito', 'Quemaduras, electrocución, incendio', 2, 3),
  ('aadd3ba5-d9f1-54f6-af94-292e46d08fb4', 'PEL-G05', 'General', 'Incendio', 'Material combustible y sobrecarga eléctrica', 'Incendio', 'Quemaduras, intoxicación por humo', 3, 2),
  ('35e202a1-547a-5186-8947-38da0dca2a1f', 'PEL-G06', 'General', 'Natural', 'Sismo', 'Atrapamiento, golpes por caída de objetos', 'Lesiones graves, muerte', 3, 2),
  ('a0ef9bff-15a4-5768-bb25-ce7fdc2a8a7e', 'PEL-G07', 'General', 'Locativo', 'Pisos mojados o resbaladizos', 'Caída al mismo nivel', 'Contusiones, fracturas', 2, 4),
  ('9d4faa6c-5d9e-58aa-8284-0858d1a8dc7e', 'PEL-G08', 'General', 'Locativo', 'Cables y objetos en zonas de tránsito', 'Tropiezo', 'Contusiones', 1, 4),
  ('6c99bdb3-d22c-5914-ba48-29b590950178', 'PEL-G09', 'General', 'Locativo', 'Escaleras', 'Caída a distinto nivel', 'Fracturas', 2, 4),
  ('3706c5da-38f0-561c-b8f9-f40897f1fbf0', 'PEL-G10', 'General', 'Mecánico', 'Cuchillos y utensilios cortantes (cocina)', 'Cortes', 'Heridas cortantes', 1, 4),
  ('fbe37a2e-7035-574a-a757-f78912056e44', 'PEL-G11', 'General', 'Térmico', 'Superficies y líquidos calientes (microondas, cafetera, hervidor)', 'Contacto con superficies o líquidos calientes', 'Quemaduras', 1, 4),
  ('76da7a3f-1edd-56b7-ad80-6e727ac6bef9', 'PEL-G12', 'General', 'Eléctrico', 'Electrodomésticos de cocina', 'Contacto eléctrico', 'Quemaduras, electrocución', 2, 3),
  ('39f8c642-a731-56ba-8eda-b0f7ad595ab5', 'PEL-G13', 'General', 'Químico', 'Productos de limpieza (lejía, desinfectantes)', 'Contacto con piel u ojos, inhalación', 'Dermatitis, irritación', 1, 4),
  ('69aec62b-97f5-56b9-8a2a-0cb690d54cfc', 'PEL-G14', 'General', 'Biológico', 'Residuos y servicios higiénicos', 'Contacto con agentes biológicos', 'Infecciones', 1, 4),
  ('2b076c59-dc48-518e-bc87-af75e5fd4a1e', 'PEL-G15', 'General', 'Ergonómico', 'Traslado de bolsas de residuos y bidones de agua', 'Sobreesfuerzo', 'Lumbalgia', 2, 4),
  ('004f4cb2-bbd7-5782-86f5-aee4314515a3', 'PEL-G16', 'General', 'Mecánico', 'Objetos en estanterías altas', 'Caída de objetos', 'Golpes', 1, 4),
  ('d290946f-7d9f-513b-b50d-8266be9168d5', 'PEL-G17', 'General', 'Transporte', 'Desplazamiento en la ciudad (visitas a clientes)', 'Accidente de tránsito, atropello', 'Lesiones graves, muerte', 3, 2),
  ('a60748c5-6a6b-5c1a-899a-886d95f8409d', 'PEL-G18', 'General', 'Social', 'Delincuencia en la vía pública', 'Asalto', 'Lesiones, estrés', 2, 3),
  ('a40ac2cc-e6a3-5ec0-ae83-0659e6041fc2', 'PEL-G19', 'General', 'Locativo', 'Instalaciones del cliente con peligros no conocidos', 'Exposición a peligros no identificados', 'Variable según el lugar', 2, 3),
  ('705321df-26b5-5e63-aaf0-8f753ea02006', 'PEL-G20', 'General', 'Biológico', 'Enfermedades respiratorias transmisibles', 'Contagio', 'Infección respiratoria', 2, 4),
  ('d5759424-4f9d-578e-bd99-8623e4bb3049', 'PEL-G21', 'General', 'Psicosocial', 'Hostigamiento o conflictos interpersonales', 'Estrés, ansiedad', 'Afectación de la salud mental', 2, 4),
  ('06632a7b-bd09-590a-96c7-7fb377af32e8', 'PEL-G22', 'General', 'Físico', 'Iluminación inadecuada', 'Fatiga visual', 'Cefalea', 1, 5),
  ('718f8d68-3a40-5d1c-9b53-c494d1e4547f', 'PEL-G23', 'General', 'Físico', 'Ruido en oficina abierta', 'Disconfort acústico', 'Fatiga, falta de concentración', 1, 5),
  ('eed3bb04-c85a-506f-9de6-e9fe4c2103e1', 'PEL-G24', 'General', 'Físico', 'Temperatura y ventilación inadecuadas', 'Disconfort térmico', 'Malestar', 1, 5),
  ('38143379-ed9a-57ba-9653-d5d7821f7951', 'PEL-G25', 'General', 'Emergencia', 'Equipos de emergencia sin mantenimiento (extintores, alarmas, rociadores)', 'Respuesta fallida ante emergencia', 'Agravamiento de lesiones y daños', 3, 2),
  ('bfa242d7-1774-549d-a62f-538dc014694f', 'PEL-G26', 'General', 'Emergencia', 'Botiquín incompleto o con insumos vencidos', 'Atención inadecuada de primeros auxilios', 'Agravamiento de lesiones', 1, 4),
  ('2ee605db-2f5d-5344-9296-780e35020924', 'PEL-G27', 'General', 'Locativo', 'Puertas de vidrio y mamparas', 'Golpe, cortes', 'Contusiones, heridas', 1, 4),
  ('38682dc9-2b9c-5d78-9fe7-9d65449a9600', 'PEL-G28', 'General', 'Químico', 'Tóner y polvo de impresoras', 'Inhalación', 'Irritación respiratoria', 1, 5);

insert into control_catalogo (id, peligro_id, jerarquia, descripcion) values
  ('07d90955-3979-55c3-acab-7562b11a6cbd', '5a0be95c-b5a8-5e8f-aa58-9787348701df', 'INGENIERIA', 'Sostenimiento sistemático (pernos, malla, cuadros)'),
  ('9f33b847-1cc8-55d2-84fc-55bbe735b62f', '5a0be95c-b5a8-5e8f-aa58-9787348701df', 'ADMINISTRATIVO', 'Desatado obligatorio, PETS, inspección de la labor al inicio de la guardia'),
  ('7b9e10a6-0bd0-5a7e-9db9-af62432b58ce', '5a0be95c-b5a8-5e8f-aa58-9787348701df', 'EPP', 'Casco, botas con puntera de acero'),
  ('0a3baf3f-d121-59cc-84c1-f09e0acf7079', '6358c075-7fe5-5b60-9bfc-5ed464412d54', 'SUSTITUCION', 'Explosivos de mayor seguridad y sistemas de iniciación no eléctricos'),
  ('090e17ce-c77e-51d6-87cf-879a28e2955f', '6358c075-7fe5-5b60-9bfc-5ed464412d54', 'INGENIERIA', 'Polvorín según norma, cajas de transporte de explosivos'),
  ('b55154a8-c8a5-5f6a-85f9-7512e60ca5cc', '6358c075-7fe5-5b60-9bfc-5ed464412d54', 'ADMINISTRATIVO', 'Personal autorizado con carné vigente, PETS de voladura, vigías y señalización'),
  ('fb3476f8-d28b-557e-9148-07511b07984f', '6358c075-7fe5-5b60-9bfc-5ed464412d54', 'EPP', 'EPP completo, lámpara'),
  ('69f4e67c-d3a1-5020-9872-f7dccf267067', '9c5da228-9b88-5289-85c1-320e862b93e7', 'ADMINISTRATIVO', 'Inspección post-voladura, procedimiento de tiros cortados, prohibición de perforar en restos'),
  ('e426cf1a-8ba8-57c4-9b0a-1d9f2be12232', '9c5da228-9b88-5289-85c1-320e862b93e7', 'EPP', 'EPP completo'),
  ('6d117854-7c73-5688-8220-d60901a641d5', 'b3e21a27-6e10-5974-9679-38c61d24c931', 'INGENIERIA', 'Ventilación mecánica (ventiladores y mangas)'),
  ('5f42c9a5-1852-5fe3-9b1f-66444e84e2c8', 'b3e21a27-6e10-5974-9679-38c61d24c931', 'ADMINISTRATIVO', 'Tiempo de espera post-voladura, medición con detector de gases antes del ingreso'),
  ('f6236ec3-ffb3-5910-9ca8-882d2d474733', 'b3e21a27-6e10-5974-9679-38c61d24c931', 'EPP', 'Autorrescatador'),
  ('b5e4d8b2-1337-58b7-a5e9-29de63d7f12f', 'e4b0774e-47b1-5ab2-bbf3-afa87c0c0256', 'INGENIERIA', 'Ventilación forzada'),
  ('2c113719-d903-50c7-a9e9-2a6778df13ef', 'e4b0774e-47b1-5ab2-bbf3-afa87c0c0256', 'ADMINISTRATIVO', 'Medición de oxígeno antes del ingreso, permiso para espacios confinados'),
  ('5eea80df-66fe-55e5-9b23-063efa61a6ab', 'e4b0774e-47b1-5ab2-bbf3-afa87c0c0256', 'EPP', 'Autorrescatador'),
  ('401c1851-ec39-5529-a972-40bf0c725a5d', 'e0e7d6c7-a645-570f-89fc-1cb46e80bcfb', 'INGENIERIA', 'Perforación húmeda, riego de frentes, ventilación'),
  ('db79c687-bff5-50fc-b308-d7e441c9ceae', 'e0e7d6c7-a645-570f-89fc-1cb46e80bcfb', 'ADMINISTRATIVO', 'Monitoreo de polvo, rotación de personal'),
  ('aa2d9992-f232-59d4-81c0-603e174d49ee', 'e0e7d6c7-a645-570f-89fc-1cb46e80bcfb', 'EPP', 'Respirador con filtro para polvo'),
  ('b2eb7888-1200-5c1b-abc6-1cc80adf5c10', '14e5a795-6072-51b9-827c-3d05791eda4d', 'SUSTITUCION', 'Equipos de menor emisión'),
  ('710b7fe0-c0ee-536c-a69a-8d06dd926554', '14e5a795-6072-51b9-827c-3d05791eda4d', 'INGENIERIA', 'Silenciadores'),
  ('00ac1b71-18a3-58b2-93b7-52a0eb75a89a', '14e5a795-6072-51b9-827c-3d05791eda4d', 'ADMINISTRATIVO', 'Monitoreo de ruido, audiometrías, rotación'),
  ('364031c5-06a1-53c4-8862-6d98cba91c03', '14e5a795-6072-51b9-827c-3d05791eda4d', 'EPP', 'Protección auditiva doble'),
  ('7f353c7e-5021-50ee-93cd-21997a465220', '15b181bb-be71-5f49-9583-f93c9a40876e', 'SUSTITUCION', 'Equipos con antivibración'),
  ('92c42799-06e8-55e3-aec0-cd1dfd5823d6', '15b181bb-be71-5f49-9583-f93c9a40876e', 'INGENIERIA', 'Empuñaduras amortiguadas'),
  ('19c1825e-581a-5830-9e37-fd1a59845809', '15b181bb-be71-5f49-9583-f93c9a40876e', 'ADMINISTRATIVO', 'Pausas y rotación'),
  ('b1bdb0e6-f13a-5ff5-90f8-f9f04817347d', '15b181bb-be71-5f49-9583-f93c9a40876e', 'EPP', 'Guantes antivibración'),
  ('e126986d-580e-55ad-a79b-b9dc8373a9bd', 'b5d9c82e-a47e-5926-a83f-a3b8aba599c9', 'INGENIERIA', 'Protecciones en equipos'),
  ('7f6c9787-5ed9-575d-9c39-cb3b611fa64c', 'b5d9c82e-a47e-5926-a83f-a3b8aba599c9', 'ADMINISTRATIVO', 'PETS de perforación, capacitación'),
  ('c7ca52e3-8b73-53b9-a448-b08fcee0670c', 'b5d9c82e-a47e-5926-a83f-a3b8aba599c9', 'EPP', 'Guantes, ropa ajustada'),
  ('23ad82b8-f90b-581e-94ca-7d8f80a11ef6', '63d52789-24a2-52d9-88e7-455a15f1cefb', 'INGENIERIA', 'Cunetas y nivelación de piso'),
  ('1367f0de-0932-50c3-ab22-88f6f74d3034', '63d52789-24a2-52d9-88e7-455a15f1cefb', 'ADMINISTRATIVO', 'Orden y limpieza, iluminación'),
  ('cb84ebc2-cd80-54cf-8e02-dccc5fd37959', '63d52789-24a2-52d9-88e7-455a15f1cefb', 'EPP', 'Botas de jebe con puntera'),
  ('6fa88a45-e09d-5f52-b26c-a947ff92ba57', '847158b5-1804-5a14-aa42-3c1dec087883', 'INGENIERIA', 'Barandas, parrillas y tapas en aberturas'),
  ('c60d2cb9-18cd-5062-a2f4-55990d673bbc', '847158b5-1804-5a14-aa42-3c1dec087883', 'ADMINISTRATIVO', 'Señalización, permiso de trabajo en altura'),
  ('1bebf5f9-debf-52a9-a22e-700bbbf1d850', '847158b5-1804-5a14-aa42-3c1dec087883', 'EPP', 'Arnés y línea de vida'),
  ('fa8ca52e-738e-564c-acf3-01c5393883bd', '5b1b6cc6-5042-53f0-a4c7-a5824bcbcbd4', 'INGENIERIA', 'Guardas en tambores, alarmas de retroceso'),
  ('06717ba0-0a67-5d1b-bef9-80e2b2c5457d', '5b1b6cc6-5042-53f0-a4c7-a5824bcbcbd4', 'ADMINISTRATIVO', 'Operador autorizado, zona de exclusión'),
  ('de3e012e-33ef-5a82-ad3d-3e2a72670155', '5b1b6cc6-5042-53f0-a4c7-a5824bcbcbd4', 'EPP', 'Chaleco reflectivo'),
  ('abfd254d-2891-5819-b3ed-136fbf45c7cb', 'ec3d4873-6cd8-5d8c-8b7e-e0086509b2d3', 'INGENIERIA', 'Refugios en galerías, mantenimiento de rieles'),
  ('4f2c73b4-e8ff-529c-9723-ab66af1c2abc', 'ec3d4873-6cd8-5d8c-8b7e-e0086509b2d3', 'ADMINISTRATIVO', 'Señalización, velocidad controlada'),
  ('6077e39c-64f7-5302-b0c1-6bbdc154e164', 'ec3d4873-6cd8-5d8c-8b7e-e0086509b2d3', 'EPP', 'Chaleco reflectivo'),
  ('0a1cc20b-f0aa-5f69-8a98-fabb240e6889', '93e13e57-a77b-50c4-be0d-5a62f1c7c38a', 'INGENIERIA', 'Bermas de seguridad, guardavías, ensanche de curvas'),
  ('467bd2ae-f28d-5384-8edc-f93ec7c3987b', '93e13e57-a77b-50c4-be0d-5a62f1c7c38a', 'ADMINISTRATIVO', 'Señalización vertical, espejos convexos, límite de velocidad, conductores autorizados'),
  ('94fd6b75-7744-594a-9fb2-3d13ead2fa27', '93e13e57-a77b-50c4-be0d-5a62f1c7c38a', 'EPP', 'Cinturón de seguridad'),
  ('688f031d-d1aa-5a92-9ae8-3c0de5e9f144', '50411b59-baca-51ea-aaae-2213e04e5531', 'ADMINISTRATIVO', 'Control de horas de manejo, pausas, evaluación de fatiga'),
  ('c7457a76-f4cd-522c-83be-d1a749440fca', '1d343bb9-240b-556c-84ab-30e8cafab141', 'ELIMINACION', 'Separar vías peatonales de vehículos'),
  ('aa595cae-7d0e-58d6-a94a-9c9c6037959e', '1d343bb9-240b-556c-84ab-30e8cafab141', 'INGENIERIA', 'Pasos peatonales delimitados'),
  ('454d935d-331a-5641-bd61-921470de929f', '1d343bb9-240b-556c-84ab-30e8cafab141', 'ADMINISTRATIVO', 'Señalización, prioridad de paso, vigías'),
  ('c6a9adf8-3ff1-5a28-94f6-26261f309080', '1d343bb9-240b-556c-84ab-30e8cafab141', 'EPP', 'Chaleco reflectivo'),
  ('6aa80911-a5d6-582b-8837-da15f42c7d04', '0b5a7eb1-ed30-5e66-ad30-235f469c9739', 'INGENIERIA', 'Interruptores diferenciales, puesta a tierra, cables protegidos'),
  ('3825371c-743f-565f-9e28-d7ba72e9d18b', '0b5a7eb1-ed30-5e66-ad30-235f469c9739', 'ADMINISTRATIVO', 'Bloqueo y etiquetado, personal autorizado'),
  ('c09bfc27-294b-5f85-893a-eeb23febc1c2', '0b5a7eb1-ed30-5e66-ad30-235f469c9739', 'EPP', 'Guantes y calzado dieléctricos'),
  ('644bff8f-7dda-5ee8-a604-3e2062bcd62b', '60431bf6-8b91-5d5d-85b7-ce57efd39eed', 'INGENIERIA', 'Guardas fijas, paradas de emergencia, interbloqueos'),
  ('0d52c2c1-5d55-5806-a78f-c278338ec819', '60431bf6-8b91-5d5d-85b7-ce57efd39eed', 'ADMINISTRATIVO', 'Bloqueo y etiquetado en mantenimiento'),
  ('a3e6b5a4-80d8-5967-aeb8-b3e43885f68a', '60431bf6-8b91-5d5d-85b7-ce57efd39eed', 'EPP', 'Ropa ajustada'),
  ('5bd0e638-154d-5254-8b6b-7724aa0e4436', 'c8ca7f84-7340-553e-b53c-ec47335b1dc7', 'INGENIERIA', 'Cortinas y guardas'),
  ('dc07625f-d283-5c53-9e7e-0b4fa76ca7e9', 'c8ca7f84-7340-553e-b53c-ec47335b1dc7', 'ADMINISTRATIVO', 'Zona restringida'),
  ('904e8f18-7023-5d91-9cfa-eadecad0fa27', 'c8ca7f84-7340-553e-b53c-ec47335b1dc7', 'EPP', 'Lentes de seguridad, careta'),
  ('349640a7-0feb-5a21-9266-7e9d203d6727', '20629d0d-e96e-5883-a075-7ae121cf9d06', 'SUSTITUCION', 'Reactivos menos tóxicos cuando sea viable'),
  ('6e9e1e9a-f967-52e3-8404-ade6459d1d17', '20629d0d-e96e-5883-a075-7ae121cf9d06', 'INGENIERIA', 'Sistemas cerrados, extracción localizada'),
  ('897a7cf2-e94c-5c67-ac98-d5669b2e5138', '20629d0d-e96e-5883-a075-7ae121cf9d06', 'ADMINISTRATIVO', 'Hojas de datos de seguridad, rotulado SGA, ducha y lavaojos'),
  ('06452cde-199b-59f2-ba0d-be60156d6c18', '20629d0d-e96e-5883-a075-7ae121cf9d06', 'EPP', 'Respirador, guantes de nitrilo, lentes, mandil'),
  ('65526a9d-a14b-5144-a4b7-7b3a8bd48956', 'a99ccd5d-5299-58c8-a179-b371a5b6b8f6', 'INGENIERIA', 'Captación de polvo, riego'),
  ('de25a6ec-0b49-5386-95e2-05c6e4733a7e', 'a99ccd5d-5299-58c8-a179-b371a5b6b8f6', 'ADMINISTRATIVO', 'Monitoreo de polvo'),
  ('42ec329c-e52a-5970-8c37-612bedfcbafb', 'a99ccd5d-5299-58c8-a179-b371a5b6b8f6', 'EPP', 'Respirador'),
  ('939d45ef-3482-5e7e-9b6e-453e125ded40', '626d0591-8b99-55bc-a0a3-5be3e81d54a1', 'INGENIERIA', 'Cabinas aisladas'),
  ('289d58a3-1568-5cab-a7fb-0f80d2d8f19b', '626d0591-8b99-55bc-a0a3-5be3e81d54a1', 'ADMINISTRATIVO', 'Monitoreo de ruido, audiometrías'),
  ('03a45250-5f06-566c-aba6-e632887a929e', '626d0591-8b99-55bc-a0a3-5be3e81d54a1', 'EPP', 'Protección auditiva'),
  ('df4bc0a1-2f0a-5a24-87c9-1fa6c8413d12', 'f3cabf52-d4f2-59af-b12b-79b0cf03e54c', 'INGENIERIA', 'Barandas y plataformas con rodapié'),
  ('5cba3257-91c1-5f8a-87ae-41bdcacc47b5', 'f3cabf52-d4f2-59af-b12b-79b0cf03e54c', 'ADMINISTRATIVO', 'Permiso de trabajo en altura'),
  ('c9003858-9a29-5b5d-96b2-542525d964f1', 'f3cabf52-d4f2-59af-b12b-79b0cf03e54c', 'EPP', 'Arnés y línea de vida'),
  ('ac90cba5-4a52-5a8d-a084-e43bfde143f5', '02a8b7a0-324c-5871-93dd-dbea04c83275', 'INGENIERIA', 'Equipos de izaje certificados'),
  ('a511dfcc-fa2f-58ad-a504-793e5d3d9ff6', '02a8b7a0-324c-5871-93dd-dbea04c83275', 'ADMINISTRATIVO', 'Rigger autorizado, zona de exclusión'),
  ('78f6da5d-c58e-5113-9a47-d1a3c364a95b', '02a8b7a0-324c-5871-93dd-dbea04c83275', 'EPP', 'Casco'),
  ('156cceb6-ad6f-5776-bf88-a961d5cdf891', 'f85da438-fb33-5275-9ee5-026d43092143', 'SUSTITUCION', 'Reemplazo de herramientas dañadas'),
  ('3d60c999-6d81-537f-931a-fe0f12624708', 'f85da438-fb33-5275-9ee5-026d43092143', 'ADMINISTRATIVO', 'Inspección de herramientas manuales (código de colores)'),
  ('9e6e16df-c214-599f-873b-15c17322ffa6', 'f85da438-fb33-5275-9ee5-026d43092143', 'EPP', 'Guantes'),
  ('e28a27db-5688-5a7f-94b7-98b15439a6fb', 'f5d7e27a-b71e-5445-8c39-3dc891754846', 'INGENIERIA', 'Biombos, extracción de humos'),
  ('66da2ef0-a694-51b6-bb2b-3f83a1a96bf9', 'f5d7e27a-b71e-5445-8c39-3dc891754846', 'ADMINISTRATIVO', 'Permiso de trabajo en caliente, extintor a la mano'),
  ('43a70538-2fb5-57d7-a6b5-bfc63a50dc5b', 'f5d7e27a-b71e-5445-8c39-3dc891754846', 'EPP', 'Careta, guantes y mandil de cuero'),
  ('eb5ca266-f256-5386-9bb8-21f5099dc543', 'ae405ef2-2e84-520e-bf81-b5e8a65fb993', 'INGENIERIA', 'Extracción localizada'),
  ('4d543386-2a96-5a3d-8e0e-c216566e3fab', 'ae405ef2-2e84-520e-bf81-b5e8a65fb993', 'ADMINISTRATIVO', 'Trabajo en zona ventilada'),
  ('8d3a1ca3-df57-5857-b25f-fa4fe709af2a', 'ae405ef2-2e84-520e-bf81-b5e8a65fb993', 'EPP', 'Respirador para humos'),
  ('5567fdad-f58f-5f33-b446-d298778e94f5', '31a4d934-641c-5d77-9f2d-9e05549b1854', 'ADMINISTRATIVO', 'Aclimatación, hidratación, evaluación médica'),
  ('66b5d6ad-7201-53d0-996d-96e15be20b0b', '31a4d934-641c-5d77-9f2d-9e05549b1854', 'EPP', 'Ropa térmica'),
  ('24ddd479-bf8d-5c63-bd8b-52df98952f4b', '244d201e-99e0-508a-be12-046993603bc6', 'INGENIERIA', 'Ayudas mecánicas'),
  ('3ec2cf18-62c3-524c-b0bc-c8d509ba13ff', '244d201e-99e0-508a-be12-046993603bc6', 'ADMINISTRATIVO', 'Técnicas de levantamiento, límite de peso'),
  ('d8f4e67a-8ddb-5cd2-8f6a-fb6421f01e7b', '244d201e-99e0-508a-be12-046993603bc6', 'EPP', 'Faja (solo si la indica el médico)'),
  ('d0b356ba-5c1e-5e1c-a5bf-c89076e694e2', 'c81bb9b3-251c-5a94-8601-4f4c0dd23bf1', 'INGENIERIA', 'Dimensiones adecuadas de labores'),
  ('9ab9e0e0-3b02-5e4b-94f4-26577c7530c2', 'c81bb9b3-251c-5a94-8601-4f4c0dd23bf1', 'ADMINISTRATIVO', 'Pausas y rotación'),
  ('de711f39-ed41-5df0-bb33-b24187fba800', 'c81bb9b3-251c-5a94-8601-4f4c0dd23bf1', 'EPP', 'Rodilleras'),
  ('3bc5ca54-6b9b-54cc-a53f-ee27a86f68e4', '0e4f2ef8-2b07-5ba4-b691-2cc5042b43ec', 'ADMINISTRATIVO', 'Diseño de turnos, descansos, vigilancia de la fatiga'),
  ('5ee0e5ca-8c7f-5205-ae00-7fdfdd2361ff', 'e8cfa402-bd48-5c09-92c0-36f7e6491e4b', 'INGENIERIA', 'Drenaje'),
  ('3f4ab3ff-c7c5-5206-b7dd-8a4bd330ddb6', 'e8cfa402-bd48-5c09-92c0-36f7e6491e4b', 'ADMINISTRATIVO', 'Control de plagas, agua segura'),
  ('92d9b3f5-4943-5a2f-92a2-8a71f0edf6c0', 'e8cfa402-bd48-5c09-92c0-36f7e6491e4b', 'EPP', 'Guantes, botas'),
  ('e49c6ba6-4bfd-56de-bd36-43c6028c6044', 'f4a05a6d-374a-50b2-8572-e9f8ba304291', 'INGENIERIA', 'Extintores, rutas de escape, cámara de refugio'),
  ('080df909-8c9e-5144-b40f-efb8b7d7bb42', 'f4a05a6d-374a-50b2-8572-e9f8ba304291', 'ADMINISTRATIVO', 'Plan de emergencia, simulacros, control de combustibles'),
  ('0f0fa406-d193-5855-8f37-f1f57ce71416', 'f4a05a6d-374a-50b2-8572-e9f8ba304291', 'EPP', 'Autorrescatador'),
  ('fede98e1-2f4b-5967-aef1-49b03326fe40', '2f8eb8f8-2e31-5aa4-a7b3-ea125e44bb7d', 'INGENIERIA', 'Sondajes de drenaje'),
  ('c7d1f8d7-b0c6-5bd3-b001-1d491dace0ce', '2f8eb8f8-2e31-5aa4-a7b3-ea125e44bb7d', 'ADMINISTRATIVO', 'Planos actualizados, perforación con taladros de avance'),
  ('88a03fd9-7367-59b5-a502-30a47e411102', '064aff0b-7430-528e-9db5-e417687f008f', 'INGENIERIA', 'Iluminación fija en zonas de tránsito'),
  ('b029174f-d8a8-5def-8a5b-435d88312e48', '064aff0b-7430-528e-9db5-e417687f008f', 'ADMINISTRATIVO', 'Revisión de lámparas'),
  ('9fcfb920-6844-53ff-a57d-cd4c9da17be0', '064aff0b-7430-528e-9db5-e417687f008f', 'EPP', 'Lámpara minera'),
  ('372ddcce-62ca-5b5c-bbcf-dd62467186c6', '21c8c556-effa-51f5-b2df-9063690f5f8f', 'INGENIERIA', 'Polvorín con ventilación, pararrayos y separación de explosivos y accesorios'),
  ('da2b41de-7da9-5c87-b6a9-c825aaa063b3', '21c8c556-effa-51f5-b2df-9063690f5f8f', 'ADMINISTRATIVO', 'Inventario, acceso restringido, señalización'),
  ('e451b0c8-5620-52dd-9420-b3219884fa3c', 'cec9659e-ee72-599a-be3b-5b1ae91c6d49', 'INGENIERIA', 'Sillas regulables, soportes de monitor y reposapiés'),
  ('ee5b6d58-a7f0-5586-a61d-89fdd338736e', 'cec9659e-ee72-599a-be3b-5b1ae91c6d49', 'ADMINISTRATIVO', 'Pausas activas, evaluación ergonómica del puesto (RM N.° 375-2008-TR)'),
  ('2b6c42c2-1397-5575-bd6c-6edf2fc777c5', '800df624-b41e-55f0-bceb-79e31fc95141', 'INGENIERIA', 'Pantallas con ajuste de brillo, filtro'),
  ('0831ef68-c53a-558e-91b7-a3df9e5bb7d4', '800df624-b41e-55f0-bceb-79e31fc95141', 'ADMINISTRATIVO', 'Regla 20-20-20, pausas'),
  ('b591e3fb-53e5-5531-bc38-d7817087e6bb', 'ab9c83c9-815c-56c8-8ec2-37e14a1804a8', 'ADMINISTRATIVO', 'Planificación de cargas, canal de apoyo'),
  ('1b33c66d-ad3c-5416-ae74-cbeabf5057e4', '01e4fa4f-b7f5-583f-afd0-cd8d53ccf862', 'INGENIERIA', 'Interruptores termomagnéticos y diferenciales, puesta a tierra'),
  ('0118344e-217a-5e87-bdb9-5d2a138c1e7c', '01e4fa4f-b7f5-583f-afd0-cd8d53ccf862', 'ADMINISTRATIVO', 'Prohibir extensiones en cascada, inspección periódica'),
  ('aae9ba18-1830-52b7-b16d-fd28c2685f29', 'aadd3ba5-d9f1-54f6-af94-292e46d08fb4', 'INGENIERIA', 'Detectores, rociadores, extintores'),
  ('dab4356b-678b-5df0-8044-bf8b483bb77a', 'aadd3ba5-d9f1-54f6-af94-292e46d08fb4', 'ADMINISTRATIVO', 'Plan de emergencias, brigada, mantenimiento de equipos'),
  ('80e1a93a-425f-538f-8d51-3f6962e5edf1', '35e202a1-547a-5186-8947-38da0dca2a1f', 'INGENIERIA', 'Anclaje de muebles y estantes'),
  ('3fb47683-c5ef-55e1-bff2-2fa11113e896', '35e202a1-547a-5186-8947-38da0dca2a1f', 'ADMINISTRATIVO', 'Plan de evacuación, señalización de rutas y zonas seguras, simulacros'),
  ('a99786ed-dadd-5c95-a92a-1490e87999ed', 'a0ef9bff-15a4-5768-bb25-ce7fdc2a8a7e', 'INGENIERIA', 'Pisos antideslizantes'),
  ('3bf62657-1c48-55cc-9d40-d6993e771652', 'a0ef9bff-15a4-5768-bb25-ce7fdc2a8a7e', 'ADMINISTRATIVO', 'Señal de piso mojado, limpieza fuera de horas punta'),
  ('4bf72c0f-448d-50f2-ab74-0b6c21196724', 'a0ef9bff-15a4-5768-bb25-ce7fdc2a8a7e', 'EPP', 'Calzado antideslizante (limpieza)'),
  ('3bdfb0db-45d1-5032-86dd-2621d2e51b33', '9d4faa6c-5d9e-58aa-8284-0858d1a8dc7e', 'INGENIERIA', 'Canaletas para cables'),
  ('af41fbf2-c34d-5523-a097-ef5190af6c70', '9d4faa6c-5d9e-58aa-8284-0858d1a8dc7e', 'ADMINISTRATIVO', 'Orden y limpieza'),
  ('e251b674-30e5-5ba6-bb4f-a39a46b04395', '6c99bdb3-d22c-5914-ba48-29b590950178', 'INGENIERIA', 'Pasamanos, cinta antideslizante'),
  ('acd8d06b-324f-5f24-9b72-68003d6ab790', '6c99bdb3-d22c-5914-ba48-29b590950178', 'ADMINISTRATIVO', 'No correr ni usar el celular en escaleras'),
  ('820d4e69-7b99-5364-87f9-20248d6c227f', '3706c5da-38f0-561c-b8f9-f40897f1fbf0', 'SUSTITUCION', 'Cuchillos especializados por tipo de alimento'),
  ('3f1ad06f-0afc-5eef-a520-2dd46918cdad', '3706c5da-38f0-561c-b8f9-f40897f1fbf0', 'INGENIERIA', 'Soporte para cuchillos'),
  ('d585f7f8-950d-5d0e-8237-15d7a74dd735', '3706c5da-38f0-561c-b8f9-f40897f1fbf0', 'ADMINISTRATIVO', 'Señalización del uso de cada cuchillo'),
  ('a2d1977b-7063-581f-8585-103cfe64b5c4', 'fbe37a2e-7035-574a-a757-f78912056e44', 'INGENIERIA', 'Ubicación estable de los equipos'),
  ('191a8f8d-ecda-505a-86e5-e534bb90c0ec', 'fbe37a2e-7035-574a-a757-f78912056e44', 'ADMINISTRATIVO', 'Stickers de advertencia, instrucciones de uso'),
  ('813bc0c9-44c8-5580-ae94-7402dd82a704', '76da7a3f-1edd-56b7-ad80-6e727ac6bef9', 'INGENIERIA', 'Tomacorrientes con puesta a tierra'),
  ('ece0892b-9410-559c-b729-6c5109c8257f', '76da7a3f-1edd-56b7-ad80-6e727ac6bef9', 'ADMINISTRATIVO', 'Revisión de cables y enchufes'),
  ('ec3a7a38-03fd-5f0a-8ab2-93bb1a25d998', '39f8c642-a731-56ba-8eda-b0f7ad595ab5', 'SUSTITUCION', 'Productos menos agresivos'),
  ('47cae041-de44-5b32-bf79-9377b6eac830', '39f8c642-a731-56ba-8eda-b0f7ad595ab5', 'INGENIERIA', 'Ventilación'),
  ('90477bd0-6e5a-57ee-8f91-52ea13342e98', '39f8c642-a731-56ba-8eda-b0f7ad595ab5', 'ADMINISTRATIVO', 'Hojas de datos de seguridad, rotulado, no mezclar productos'),
  ('0395b539-becd-5dc0-a31d-27953dec4aa3', '39f8c642-a731-56ba-8eda-b0f7ad595ab5', 'EPP', 'Guantes de nitrilo, lentes'),
  ('2eac978b-6494-5045-8196-3ccc0cf4ab24', '69aec62b-97f5-56b9-8a2a-0cb690d54cfc', 'ADMINISTRATIVO', 'Procedimiento de limpieza y manejo de residuos'),
  ('f699abb7-ab22-55e2-85bf-2c37e189b357', '69aec62b-97f5-56b9-8a2a-0cb690d54cfc', 'EPP', 'Guantes, mascarilla'),
  ('c6b5f5f3-09be-578b-beae-efbbaf74df1c', '2b076c59-dc48-518e-bc87-af75e5fd4a1e', 'SUSTITUCION', 'Dispensadores con bomba'),
  ('1a37e9f3-8cd9-5328-b858-902f8ef52125', '2b076c59-dc48-518e-bc87-af75e5fd4a1e', 'INGENIERIA', 'Carretilla'),
  ('d088685e-ba9d-5592-86c8-56f6dc63bfec', '2b076c59-dc48-518e-bc87-af75e5fd4a1e', 'ADMINISTRATIVO', 'Técnicas de levantamiento'),
  ('2c6f73bd-be9e-53b6-a864-be7983db46c7', '004f4cb2-bbd7-5782-86f5-aee4314515a3', 'INGENIERIA', 'Anclaje de estanterías'),
  ('b15b6db1-01b9-536a-90ac-49394bdd032e', '004f4cb2-bbd7-5782-86f5-aee4314515a3', 'ADMINISTRATIVO', 'Objetos pesados en niveles bajos'),
  ('ea44f442-4d6d-57c5-8fd2-541a6df94aed', 'd290946f-7d9f-513b-b50d-8266be9168d5', 'ELIMINACION', 'Reuniones virtuales cuando sea posible'),
  ('79b0fd04-64cd-5fd8-a1ec-f2073bd4d2c0', 'd290946f-7d9f-513b-b50d-8266be9168d5', 'ADMINISTRATIVO', 'Planificación de rutas, transporte seguro, capacitación en seguridad vial'),
  ('28e9b9e8-b728-5204-a7c3-7b834047aba6', 'a60748c5-6a6b-5c1a-899a-886d95f8409d', 'ADMINISTRATIVO', 'Rutas y horarios seguros, protocolo ante asaltos'),
  ('bd1cec75-fa30-56d0-8fd7-8f03ec2da6b6', 'a40ac2cc-e6a3-5ec0-ae83-0659e6041fc2', 'ADMINISTRATIVO', 'Inducción de seguridad del cliente, coordinación previa'),
  ('1dfe9e5e-5923-55d3-b068-8a64d368cf90', 'a40ac2cc-e6a3-5ec0-ae83-0659e6041fc2', 'EPP', 'EPP exigido por el cliente'),
  ('3dec7ef4-9f0e-5f32-985b-f128eb63127d', '705321df-26b5-5e63-aaf0-8f753ea02006', 'INGENIERIA', 'Ventilación'),
  ('351f6b98-2abb-5857-99e6-51bb5edd02d5', '705321df-26b5-5e63-aaf0-8f753ea02006', 'ADMINISTRATIVO', 'Higiene de manos, trabajo remoto con síntomas'),
  ('fed31cf0-0d36-5a9b-901a-19732d786d28', 'd5759424-4f9d-578e-bd99-8623e4bb3049', 'ADMINISTRATIVO', 'Política y canal de denuncias'),
  ('f6cc4a82-2046-5b29-baca-205776970f6c', '06632a7b-bd09-590a-96c7-7fb377af32e8', 'INGENIERIA', 'Iluminación según la tarea'),
  ('ec0e5976-56c2-5c0e-ac91-1f02954bc902', '06632a7b-bd09-590a-96c7-7fb377af32e8', 'ADMINISTRATIVO', 'Medición de iluminación'),
  ('67ca3e7d-2071-52c1-bdb0-3690d36013a2', '718f8d68-3a40-5d1c-9b53-c494d1e4547f', 'INGENIERIA', 'Paneles acústicos, salas de reunión'),
  ('ca32cd78-27ea-50ff-ab47-235b34ef7586', '718f8d68-3a40-5d1c-9b53-c494d1e4547f', 'ADMINISTRATIVO', 'Normas de convivencia'),
  ('093d4fa5-ed53-5d6a-9fba-3b801061d9b8', 'eed3bb04-c85a-506f-9de6-e9fe4c2103e1', 'INGENIERIA', 'Climatización'),
  ('931d800f-7873-5535-88b3-10d26466d0ea', 'eed3bb04-c85a-506f-9de6-e9fe4c2103e1', 'ADMINISTRATIVO', 'Mantenimiento del aire acondicionado'),
  ('bcb9ebd4-c205-5d55-9c0b-4ef4f67cb8ad', '38143379-ed9a-57ba-9653-d5d7821f7951', 'ADMINISTRATIVO', 'Programa de mantenimiento, inspección mensual, registro de equipos de emergencia'),
  ('a7929141-7621-5590-a174-74e8be9f66a0', 'bfa242d7-1774-549d-a62f-538dc014694f', 'ADMINISTRATIVO', 'Revisión mensual del botiquín con lista de verificación'),
  ('6b7eb449-7e1f-5e6f-980d-543f378c60c3', '2ee605db-2f5d-5344-9296-780e35020924', 'SUSTITUCION', 'Vidrio templado o laminado'),
  ('feb77a97-de22-56c6-b87f-c88761f39fcb', '2ee605db-2f5d-5344-9296-780e35020924', 'ADMINISTRATIVO', 'Señalización en vidrios'),
  ('06f0f838-1642-5fc9-8585-b6849dec9073', '38682dc9-2b9c-5d78-9fe7-9d65449a9600', 'INGENIERIA', 'Ubicación ventilada de impresoras'),
  ('1e9ad466-71d7-5884-8fb7-7092f8ea4353', '38682dc9-2b9c-5d78-9fe7-9d65449a9600', 'ADMINISTRATIVO', 'Procedimiento de cambio de tóner'),
  ('86f74f7f-0ebd-5e51-a24d-f6b8e6fb60e9', '38682dc9-2b9c-5d78-9fe7-9d65449a9600', 'EPP', 'Guantes');

insert into actividad_base_plantilla (id, codigo, sector, actividad, tipo, frecuencia_minima, base_normativa, frecuencia_por_empresa, meses, objetivo, fuente, estado_dato) values
  ('44af2d20-db9b-5816-adec-c4533dec5ab6', 'AB-G01', 'General', 'Capacitación en SST', 'Capacitación', 'Mínimo 4 al año', 'Ley N.° 29783, art. 35', '{"CAR": "No aplica", "WIR": "4 al año (trimestral)"}'::jsonb, 'Mar, Jun, Sep, Dic', 'Controlar los riesgos significativos', 'Norma + INT001', 'V'),
  ('5e5c3dd1-a579-5b1d-9744-c173f5e1d58a', 'AB-G02', 'General', 'Inducción en SST a nuevos ingresos', 'Capacitación', 'Al ingreso de cada trabajador', 'Ley N.° 29783, art. 49', '{"CAR": "No aplica", "WIR": "Por ingreso"}'::jsonb, 'Según ingresos', 'Cerrar brechas del sistema de gestión', 'Norma + INT001 (inducciones pendientes)', 'V'),
  ('34e616b0-5296-5a0f-8b2e-61dde5ce92c9', 'AB-G03', 'General', 'Reunión ordinaria del comité de SST', 'Comité', 'Mensual', 'DS N.° 005-2012-TR, art. 69 (verificar)', '{"CAR": "No aplica", "WIR": "Quincenal (práctica de la empresa)"}'::jsonb, 'Todos los meses', 'Cerrar brechas del sistema de gestión', 'INT001 (comité quincenal) + norma', 'S'),
  ('16ed216c-64dd-589c-b19d-2b2da4deb960', 'AB-G04', 'General', 'Simulacro de evacuación (sismo)', 'Simulacro', 'Según plan de emergencias (verificar)', 'Ley N.° 29783; normativa de INDECI (verificar)', '{"CAR": "No aplica", "WIR": "2 al año"}'::jsonb, 'May, Nov', 'Controlar los riesgos significativos', 'INT001 (2 simulacros al año)', 'S'),
  ('d03cd52d-b47d-5055-a6bf-ac1feda91896', 'AB-G05', 'General', 'Inspección de seguridad de instalaciones', 'Inspección', 'Periódica (según programa)', 'RM N.° 050-2013-TR (registro de inspecciones)', '{"CAR": "No aplica", "WIR": "Semestral"}'::jsonb, 'Abr, Oct', 'Controlar los riesgos significativos', 'INT001 (inspecciones cada 6 meses)', 'S'),
  ('a5c3a320-a63d-58d2-907c-f78489f56cf2', 'AB-G06', 'General', 'Inspección de extintores y botiquín', 'Inspección', 'Mensual (buena práctica)', 'RM N.° 050-2013-TR (registro de equipos de emergencia)', '{"CAR": "No aplica", "WIR": "Mensual"}'::jsonb, 'Todos los meses', 'Controlar los riesgos significativos', 'INT001 (botiquín con insumos vencidos, EV006)', 'S'),
  ('4642b0e5-a49d-5e00-a810-1ac78656a13c', 'AB-G07', 'General', 'Recarga y mantenimiento de extintores', 'Mantenimiento', 'Anual (verificar NTP vigente)', 'NTP 350.043 (verificar)', '{"CAR": "No aplica", "WIR": "Anual"}'::jsonb, 'Oct', 'Controlar los riesgos significativos', 'INT001 (EV006)', 'S'),
  ('ec715d33-8aea-537e-b174-3fda2c6b258c', 'AB-G08', 'General', 'Mantenimiento de alarmas, detectores y rociadores', 'Mantenimiento', 'Según fabricante y normativa de edificaciones (verificar)', 'Reglamento Nacional de Edificaciones (verificar)', '{"CAR": "No aplica", "WIR": "Semestral"}'::jsonb, 'Mar, Sep', 'Controlar los riesgos significativos', 'INT001 (EV006)', 'S'),
  ('1ad9969b-1545-5666-90e5-f337f696c88b', 'AB-G09', 'General', 'Exámenes médicos ocupacionales (ingreso, periódico, retiro)', 'Salud ocupacional', 'Periódico al menos cada 2 años (verificar)', 'Ley N.° 29783, art. 49; DS N.° 005-2012-TR, art. 101', '{"CAR": "No aplica", "WIR": "Ingreso / periódico / retiro"}'::jsonb, 'Según calendario', 'Cerrar brechas del sistema de gestión', 'INT001 (Talento Humano)', 'S'),
  ('802175ba-07e2-50b4-8ff8-021998db9550', 'AB-G10', 'General', 'Actualización de la IPERC', 'Gestión', 'Anual y ante cambios o daños', 'DS N.° 005-2012-TR, art. 77', '{"CAR": "No aplica", "WIR": "Anual"}'::jsonb, 'Ene', 'Controlar los riesgos significativos', 'Norma + INT001 (revisión anual)', 'V'),
  ('5a7c3d64-2c54-54c5-b993-a95ce1c292df', 'AB-G11', 'General', 'Elaboración y aprobación del plan anual de SST', 'Gestión', 'Anual', 'DS N.° 005-2012-TR, art. 32', '{"CAR": "No aplica", "WIR": "Anual"}'::jsonb, 'Dic', 'Cerrar brechas del sistema de gestión', 'Norma', 'V'),
  ('764c4889-0b41-579b-943b-34045d5f8517', 'AB-G12', 'General', 'Revisión por la dirección', 'Gestión', 'Anual (verificar)', 'Ley N.° 29783, art. 41 (verificar)', '{"CAR": "No aplica", "WIR": "Anual"}'::jsonb, 'Dic', 'Cerrar brechas del sistema de gestión', 'Norma', 'S'),
  ('11c8769f-33b6-566c-9e26-3df37a1d1b34', 'AB-G13', 'General', 'Auditoría del sistema de gestión de SST', 'Auditoría', 'Periódica (verificar plazo vigente)', 'Ley N.° 29783, art. 43; DS N.° 005-2012-TR, art. 109', '{"CAR": "No aplica", "WIR": "Anual (interna)"}'::jsonb, 'Nov', 'Cerrar brechas del sistema de gestión', 'Norma', 'S'),
  ('53a35361-06d2-5cd9-93d7-a5a172b89177', 'AB-G14', 'General', 'Monitoreo de agentes ocupacionales (ergonómico, iluminación)', 'Monitoreo', 'Según IPERC', 'RM N.° 050-2013-TR (registro de monitoreo); RM N.° 375-2008-TR', '{"CAR": "No aplica", "WIR": "Anual"}'::jsonb, 'Jul', 'Controlar los riesgos significativos', 'Supuesto', 'S'),
  ('b2ce66b8-01af-596c-8b7d-7d76ecd7e862', 'AB-M01', 'Minería', 'Reunión ordinaria del comité de SSO (primeros 10 días del mes)', 'Comité', 'Mensual', 'DS N.° 024-2016-EM (verificar artículo)', '{"CAR": "Mensual", "WIR": "No aplica"}'::jsonb, 'Todos los meses', 'Cerrar brechas del sistema de gestión', 'INT002 (reunión en los 10 primeros días)', 'S'),
  ('0765d23e-47c3-5ecc-a38f-32ecb3620868', 'AB-M02', 'Minería', 'Elaboración y presentación del programa anual de SSO', 'Gestión', 'Anual, antes del cierre del año', 'DS N.° 024-2016-EM (verificar artículo)', '{"CAR": "Anual", "WIR": "No aplica"}'::jsonb, 'Dic', 'Cerrar brechas del sistema de gestión', 'INT002 (antes del 31 de diciembre)', 'S'),
  ('6fb01b06-f08e-54c8-b96d-dedea76553ea', 'AB-M03', 'Minería', 'Actualización de la IPERC de línea base y del mapa de riesgos', 'Gestión', 'Anual y ante cambios, incidentes peligrosos o cambios legales', 'DS N.° 024-2016-EM, art. 97 (mod. DS N.° 023-2017-EM)', '{"CAR": "Anual", "WIR": "No aplica"}'::jsonb, 'Ene', 'Controlar los riesgos significativos', 'Norma (verificada)', 'V'),
  ('8ab32107-30c7-5594-8603-60d08c657619', 'AB-M04', 'Minería', 'Inducción y orientación básica al ingreso', 'Capacitación', 'Al ingreso', 'DS N.° 024-2016-EM, anexos 4 y 5 (verificar)', '{"CAR": "Por ingreso", "WIR": "No aplica"}'::jsonb, 'Según ingresos', 'Cerrar brechas del sistema de gestión', 'INT002 (anexos 4 y 5)', 'S'),
  ('c036eac8-a5e2-56ce-893f-2da8b478c2a8', 'AB-M05', 'Minería', 'Capacitación anual en temas de seguridad', 'Capacitación', 'Anual, temas definidos por norma', 'DS N.° 024-2016-EM, anexo 6 (verificar)', '{"CAR": "Mensual (programa anual)", "WIR": "No aplica"}'::jsonb, 'Todos los meses', 'Controlar los riesgos significativos', 'INT002 (anexo 6)', 'S'),
  ('c1e4e0f9-f739-525e-9bb5-c991e1bf1a56', 'AB-M06', 'Minería', 'Inspección de botiquines', 'Inspección', 'Según programa de inspecciones', 'DS N.° 024-2016-EM (verificar)', '{"CAR": "Mensual", "WIR": "No aplica"}'::jsonb, 'Todos los meses', 'Controlar los riesgos significativos', 'INT002 (programa de inspecciones)', 'S'),
  ('eed66e7c-054e-5067-813a-31f72c652eb5', 'AB-M07', 'Minería', 'Inspección de extintores', 'Inspección', 'Según programa de inspecciones', 'DS N.° 024-2016-EM (verificar)', '{"CAR": "Mensual", "WIR": "No aplica"}'::jsonb, 'Todos los meses', 'Controlar los riesgos significativos', 'INT002', 'S'),
  ('f1d99769-86f9-5926-be6d-a83ba3013e80', 'AB-M08', 'Minería', 'Inspección de cámara de refugio (salvataje)', 'Inspección', 'Según programa de inspecciones', 'DS N.° 024-2016-EM (verificar)', '{"CAR": "Trimestral", "WIR": "No aplica"}'::jsonb, 'Mar, Jun, Sep, Dic', 'Controlar los riesgos significativos', 'INT002', 'S'),
  ('739e6326-29da-5c92-8955-e2b36b961663', 'AB-M09', 'Minería', 'Inspección de herramientas manuales', 'Inspección', 'Según programa de inspecciones', 'DS N.° 024-2016-EM (verificar)', '{"CAR": "Trimestral", "WIR": "No aplica"}'::jsonb, 'Feb, May, Ago, Nov', 'Controlar los riesgos significativos', 'INT002', 'S'),
  ('03c19769-9289-5381-9843-e5fb99715873', 'AB-M10', 'Minería', 'Inspección de la alta gerencia', 'Inspección', 'Según programa de inspecciones', 'DS N.° 024-2016-EM (verificar)', '{"CAR": "Trimestral", "WIR": "No aplica"}'::jsonb, 'Mar, Jun, Sep, Dic', 'Cerrar brechas del sistema de gestión', 'INT002', 'S'),
  ('5953c1ee-0964-5847-9db4-4efcb955afc2', 'AB-M11', 'Minería', 'Simulacro de emergencia en interior mina', 'Simulacro', 'Según plan de emergencias (verificar)', 'DS N.° 024-2016-EM (verificar)', '{"CAR": "Trimestral", "WIR": "No aplica"}'::jsonb, 'Mar, Jun, Sep, Dic', 'Controlar los riesgos significativos', 'INT002 (programa de simulacros)', 'S'),
  ('0e46e000-d419-5666-a8bb-8b6cb837c92d', 'AB-M12', 'Minería', 'Auditoría del sistema de gestión de SSO', 'Auditoría', 'Anual (verificar)', 'DS N.° 024-2016-EM (verificar)', '{"CAR": "Anual", "WIR": "No aplica"}'::jsonb, 'Nov', 'Cerrar brechas del sistema de gestión', 'INT002 (programa de auditorías)', 'S'),
  ('603f89cb-cd73-55c1-bebd-16955d4d43ed', 'AB-M13', 'Minería', 'Monitoreo de agentes (gases, polvo, ruido)', 'Monitoreo', 'Según IPERC (verificar)', 'DS N.° 024-2016-EM (verificar)', '{"CAR": "Trimestral", "WIR": "No aplica"}'::jsonb, 'Mar, Jun, Sep, Dic', 'Controlar los riesgos significativos', 'Supuesto', 'S'),
  ('56af0f6f-e744-5594-a3f4-e1735cd0ae83', 'AB-M14', 'Minería', 'Exámenes médicos ocupacionales', 'Salud ocupacional', 'Ingreso, anual y retiro (verificar)', 'DS N.° 024-2016-EM (verificar)', '{"CAR": "Ingreso / anual / retiro", "WIR": "No aplica"}'::jsonb, 'Según calendario', 'Cerrar brechas del sistema de gestión', 'INT002 (médico ocupacional remoto)', 'S');

insert into diagnostico_item (n, bloque_num, bloque, subseccion, indicador, ayuda, accion_sugerida, base_normativa, peso) values
  (1, 1, 'Compromiso e Involucramiento', 'Principios', 'El empleador proporciona los recursos necesarios para que se implemente un Sistema de Gestión de Seguridad y Salud en el Trabajo', 'La gerencia asigna personas, tiempo y dinero para que la SST funcione. Evidencia: presupuesto de SST aprobado, responsable designado.', 'Definir y aprobar un presupuesto anual de SST y designar formalmente al responsable.', 'Ley N.° 29783, Título Preliminar (principios); art. 48', 1),
  (2, 1, 'Compromiso e Involucramiento', 'Principios', 'Se ha cumplido lo planificado en los diferentes programas de seguridad y salud en el trabajo', 'Lo que se programó en el año (capacitaciones, inspecciones, simulacros) se ejecutó. Evidencia: programa anual con avance.', 'Revisar el avance del programa anual y reprogramar las actividades atrasadas con responsable y fecha.', 'Ley N.° 29783, Título Preliminar (principios); art. 48', 1),
  (3, 1, 'Compromiso e Involucramiento', 'Principios', 'Se implementan acciones preventivas de seguridad y salud en el trabajo para asegurar la mejora continua', 'Se toman acciones para prevenir antes de que ocurra un accidente, no solo después. Evidencia: acciones preventivas registradas.', 'Registrar acciones preventivas derivadas de inspecciones y de la IPERC y darles seguimiento.', 'Ley N.° 29783, Título Preliminar (principios); art. 48', 1),
  (4, 1, 'Compromiso e Involucramiento', 'Principios', 'Se reconoce el desempeño del trabajador para mejorar la autoestima y se fomenta el trabajo en equipo', 'Se reconoce a quienes trabajan de forma segura y se promueve el trabajo en equipo. Evidencia: reconocimientos, comunicados.', 'Implementar un mecanismo simple de reconocimiento por desempeño seguro (p. ej., trimestral).', 'Ley N.° 29783, Título Preliminar (principios); art. 48', 1),
  (5, 1, 'Compromiso e Involucramiento', 'Principios', 'Se realizan actividades para fomentar una cultura de prevención de riesgos del trabajo en toda la empresa, entidad pública o privada', 'Se realizan actividades que promueven la prevención en toda la empresa. Evidencia: campañas, charlas, comunicados.', 'Programar actividades de cultura preventiva (campañas, charlas) en el plan anual.', 'Ley N.° 29783, Título Preliminar (principios); art. 48', 1),
  (6, 1, 'Compromiso e Involucramiento', 'Principios', 'Se promueve un buen clima laboral para reforzar la empatía entre el empleador y trabajador y viceversa', 'Existe un buen clima laboral entre empleador y trabajadores. Evidencia: encuestas de clima, reuniones.', 'Incluir preguntas de SST en la medición de clima laboral y atender los resultados.', 'Ley N.° 29783, Título Preliminar (principios); art. 48', 1),
  (7, 1, 'Compromiso e Involucramiento', 'Principios', 'Existen medios que permiten el aporte de los trabajadores al empleador en materia de seguridad y salud en el trabajo', 'Los trabajadores tienen canales para dar ideas o reportar temas de SST. Evidencia: buzón, formato de sugerencias, comité.', 'Habilitar un canal de sugerencias y reportes de SST y responder cada aporte.', 'Ley N.° 29783, Título Preliminar (principios); art. 48', 1),
  (8, 1, 'Compromiso e Involucramiento', 'Principios', 'Existen mecanismos de reconocimiento del personal proactivo interesado en el mejoramiento continuo de la seguridad y salud en el trabajo', 'Se reconoce al personal que propone mejoras en SST. Evidencia: registro de reconocimientos.', 'Incorporar el reconocimiento de propuestas de mejora al mecanismo de reconocimiento.', 'Ley N.° 29783, Título Preliminar (principios); art. 48', 1),
  (9, 1, 'Compromiso e Involucramiento', 'Principios', 'Se tiene evaluado los principales riesgos que ocasionan mayores pérdidas', 'Se identificaron los riesgos que más daño o pérdidas pueden causar. Evidencia: IPERC con riesgos significativos priorizados.', 'Priorizar en la IPERC los riesgos significativos y asignarles controles.', 'Ley N.° 29783, Título Preliminar (principios); art. 48', 1),
  (10, 1, 'Compromiso e Involucramiento', 'Principios', 'Se fomenta la participación de los representantes de trabajadores y de las organizaciones sindicales en las decisiones sobre la seguridad y salud en el trabajo', 'Los representantes de los trabajadores participan en decisiones de SST. Evidencia: actas del comité o del supervisor.', 'Asegurar la participación de los representantes de los trabajadores en las decisiones de SST y dejarla en acta.', 'Ley N.° 29783, Título Preliminar (principios); art. 48', 1),
  (11, 2, 'Política de Seguridad y Salud Ocupacional', 'Política', 'Existe una política documentada en materia de seguridad y salud en el trabajo, especifica y apropiada para la empresa, entidad pública o privada', 'Existe una política de SST escrita y adecuada a la empresa. Evidencia: documento de política.', 'Elaborar la política de SST a partir de una plantilla y adaptarla a la empresa.', 'Ley N.° 29783, arts. 22 y 23', 1),
  (12, 2, 'Política de Seguridad y Salud Ocupacional', 'Política', 'La política de seguridad y salud en el trabajo está firmada por la máxima autoridad de la empresa, entidad pública o privada', 'La política está firmada por la máxima autoridad (gerente general). Evidencia: política firmada y fechada.', 'Obtener la firma de la gerencia general en la política de SST.', 'Ley N.° 29783, arts. 22 y 23', 1),
  (13, 2, 'Política de Seguridad y Salud Ocupacional', 'Política', 'Los trabajadores conocen y están comprometidos con lo establecido en la política de seguridad y salud en el trabajo', 'Los trabajadores conocen la política y se comprometen con ella. Evidencia: constancias de difusión, política publicada.', 'Difundir la política a todo el personal y registrar la constancia de difusión.', 'Ley N.° 29783, arts. 22 y 23', 1),
  (14, 2, 'Política de Seguridad y Salud Ocupacional', 'Política', 'Su contenido comprende:
- El compromiso de protección de todos los miembros de la organización.
- Cumplimiento de la normatividad.
- Garantía de protección, participación, consulta y participación en los elementos del Sistema de Gestión de Seguridad y Salud en el Trabajo por parte de los trabajadores y sus representantes.
- La mejora continua en materia de seguridad y salud en el trabajo
- Integración del Sistema de Gestión de Seguridad y Salud en el Trabajo con otros sistemas de ser el caso', 'La política incluye los compromisos mínimos: proteger a todos, cumplir la norma, consulta y participación, mejora continua e integración con otros sistemas.', 'Revisar el texto de la política y completar los compromisos mínimos que falten.', 'Ley N.° 29783, arts. 22 y 23', 1),
  (15, 2, 'Política de Seguridad y Salud Ocupacional', 'Dirección', 'Se toman decisiones en base al análisis de inspecciones, auditorias, informes de investigación de accidentes, informe de estadísticas, avances de programas de seguridad y salud en el trabajo y opiniones de trabajadores, dando el seguimiento de las mismas.', 'La gerencia decide con base en datos: inspecciones, auditorías, investigaciones, estadísticas, avance del programa y opinión de los trabajadores.', 'Presentar a la gerencia un reporte periódico de SST y registrar las decisiones tomadas.', 'Ley N.° 29783, arts. 26 y 48', 1),
  (16, 2, 'Política de Seguridad y Salud Ocupacional', 'Dirección', 'El empleador delega funciones y autoridad al personal encargado de implementar el Sistema de Gestión de Seguridad y Salud en el Trabajo', 'El empleador delega funciones y autoridad a quienes implementan el sistema. Evidencia: designaciones, funciones por escrito.', 'Formalizar por escrito las funciones y la autoridad del responsable de SST.', 'Ley N.° 29783, arts. 26 y 48', 1),
  (17, 2, 'Política de Seguridad y Salud Ocupacional', 'Liderazgo', 'El empleador asume el liderazgo en la gestión de la Seguridad y Salud en el Trabajo', 'La gerencia lidera la SST y participa activamente. Evidencia: participación en comité, revisiones, comunicados.', 'Programar la participación de la gerencia en actividades clave de SST (revisión, inspecciones de gerencia).', 'Ley N.° 29783, arts. 26 y 48', 1),
  (18, 2, 'Política de Seguridad y Salud Ocupacional', 'Liderazgo', 'El empleador dispone los recursos necesarios para mejorar la gestión de la seguridad y salud en el trabajo', 'La gerencia asigna los recursos necesarios para mejorar la SST. Evidencia: aprobaciones de compras y contrataciones de SST.', 'Vincular cada actividad del plan con sus recursos y obtener su aprobación.', 'Ley N.° 29783, arts. 26 y 48', 1),
  (19, 2, 'Política de Seguridad y Salud Ocupacional', 'Organización', 'Existen responsabilidades específicas en seguridad y salud en el trabajo de los niveles de mando de la empresa, entidad pública o privada', 'Cada nivel de mando (gerentes, jefes, supervisores) tiene responsabilidades de SST definidas. Evidencia: MOF o RISST.', 'Definir responsabilidades de SST por nivel de mando y comunicarlas.', 'Ley N.° 29783, arts. 26 y 29', 1),
  (20, 2, 'Política de Seguridad y Salud Ocupacional', 'Organización', 'Se ha destinado presupuesto para implementar o mejorar el sistema de gestión de seguridad y salud en el trabajo', 'Existe presupuesto asignado para implementar o mejorar el sistema de gestión de SST. Evidencia: presupuesto aprobado.', 'Estimar el costo del plan anual y aprobar el presupuesto de SST.', 'Ley N.° 29783, arts. 26 y 29', 1),
  (21, 2, 'Política de Seguridad y Salud Ocupacional', 'Organización', 'El Comité o Supervisor de Seguridad y Salud en el Trabajo participa en la definición de estímulos y sanciones', 'El comité o supervisor de SST participa en definir estímulos y sanciones. Evidencia: actas, RISST.', 'Incluir en la agenda del comité la definición de estímulos y sanciones y registrarla en el RISST.', 'Ley N.° 29783, arts. 26 y 29', 1),
  (22, 2, 'Política de Seguridad y Salud Ocupacional', 'Competencia', 'El empleador ha definido los requisitos de competencia necesarios para cada puesto de trabajo y adopta disposiciones de capacitación en materia de seguridad y salud en el trabajo para que éste asuma sus deberes con responsabilidad', 'Se definieron las competencias necesarias por puesto y la capacitación de SST correspondiente. Evidencia: perfiles de puesto, matriz de capacitación.', 'Definir competencias de SST por puesto y armar la matriz de capacitación.', 'Ley N.° 29783, arts. 27 y 51', 1),
  (23, 3, 'Planeamiento y Aplicación', 'Diagnóstico', 'Se ha realizado una evaluación inicial o estudio de línea base como diagnóstico participativo del estado de la salud y seguridad en el trabajo', 'Se hizo una evaluación inicial (línea base) con participación de los trabajadores. Evidencia: informe de línea base.', 'Completar el diagnóstico de línea base en Prevé y validarlo con el comité o supervisor.', 'DS N.° 005-2012-TR, art. 37', 1),
  (24, 3, 'Planeamiento y Aplicación', 'Diagnóstico', 'Los resultados han sido comparados con lo establecido en la Ley de SST y su Reglamento y otros dispositivos legales pertinentes, y servirán de base para planificar, aplicar el sistema y como referencia para medir su mejora continua', 'Los resultados se compararon con la ley y sirven para planificar y medir la mejora. Evidencia: brechas identificadas y plan derivado.', 'Usar la lista de brechas del diagnóstico como insumo del plan anual.', 'DS N.° 005-2012-TR, art. 37', 1),
  (25, 3, 'Planeamiento y Aplicación', 'Diagnóstico', 'La planificación permite:
- Cumplir con normas nacionales
- Mejorar el desempeño
- Mantener procesos productivos seguros o de servicios seguros', 'La planificación permite cumplir la norma, mejorar el desempeño y mantener procesos seguros. Evidencia: plan anual alineado al diagnóstico.', 'Alinear el plan anual a las brechas y a los riesgos significativos.', 'DS N.° 005-2012-TR, art. 37', 1),
  (26, 3, 'Planeamiento y Aplicación', 'Planeamiento para la identificación de peligros, evaluación y control de riesgos', 'El empleador ha establecido procedimientos para identificar peligros y evaluar riesgos', 'Existe un procedimiento para identificar peligros y evaluar riesgos (IPERC). Evidencia: procedimiento IPERC aprobado.', 'Documentar el procedimiento IPERC y la metodología de evaluación que usa la empresa.', 'Ley N.° 29783, arts. 21 y 57; DS N.° 005-2012-TR, art. 77', 1),
  (27, 3, 'Planeamiento y Aplicación', 'Planeamiento para la identificación de peligros, evaluación y control de riesgos', 'Comprende estos procedimientos:
- Todas las actividades
- Todo el personal
- Todas las instalaciones', 'La IPERC cubre todas las actividades, todo el personal y todas las instalaciones. Evidencia: matriz IPERC completa.', 'Revisar que todos los procesos, puestos e instalaciones tengan su IPERC.', 'Ley N.° 29783, arts. 21 y 57; DS N.° 005-2012-TR, art. 77', 1),
  (28, 3, 'Planeamiento y Aplicación', 'Planeamiento para la identificación de peligros, evaluación y control de riesgos', 'El empleador aplica medidas para:
- Gestionar, eliminar y controlar riesgos
- Diseñar ambiente y puesto de trabajo, seleccionar equipos y métodos de trabajo que garanticen la seguridad y salud del trabajador
- Eliminar las situaciones y agentes peligrosos o sustituirlos
- Modernizar los planes y programas de prevención de riesgos laborales
- Mantener políticas de protección
- Capacitar anticipadamente al trabajador', 'Se aplican medidas para eliminar o controlar riesgos, diseñar puestos seguros, sustituir agentes peligrosos y capacitar. Evidencia: controles implementados.', 'Implementar los controles propuestos en la IPERC siguiendo la jerarquía de controles.', 'Ley N.° 29783, arts. 21 y 57; DS N.° 005-2012-TR, art. 77', 1),
  (29, 3, 'Planeamiento y Aplicación', 'Planeamiento para la identificación de peligros, evaluación y control de riesgos', 'El empleador actualiza la evaluación de riesgo una (01) vez al año como mínimo o cuando condiciones o se hayan producido daños', 'La IPERC se actualiza al menos una vez al año o cuando cambian las condiciones o hay daños. Evidencia: fecha de última versión.', 'Programar la actualización anual de la IPERC y ante cambios o incidentes.', 'Ley N.° 29783, arts. 21 y 57; DS N.° 005-2012-TR, art. 77', 1),
  (30, 3, 'Planeamiento y Aplicación', 'Planeamiento para la identificación de peligros, evaluación y control de riesgos', 'La evaluación de riesgo considera:
- Controles periódicos de las condiciones de trabajo y de la salud de los trabajadores.
- Medidas de prevención', 'La evaluación considera controles periódicos de condiciones de trabajo, salud de los trabajadores y medidas de prevención.', 'Incluir en la IPERC los monitoreos y controles periódicos asociados a cada riesgo.', 'Ley N.° 29783, arts. 21 y 57; DS N.° 005-2012-TR, art. 77', 1),
  (31, 3, 'Planeamiento y Aplicación', 'Planeamiento para la identificación de peligros, evaluación y control de riesgos', 'Los representantes de los trabajadores han participado en la identificación de peligros y evaluación de riesgos, han sugerido las medidas de control y verificado su aplicación', 'Los representantes de los trabajadores participaron en la IPERC, sugirieron controles y verificaron su aplicación. Evidencia: actas, firmas.', 'Revisar la IPERC con los representantes de los trabajadores y registrar su participación.', 'Ley N.° 29783, arts. 21 y 57; DS N.° 005-2012-TR, art. 77', 1),
  (32, 3, 'Planeamiento y Aplicación', 'Objetivos', 'Los objetivos se centran en el logro de resultados realistas y posibles de aplicar, que comprende:
- Reducción de los riesgos del trabajo
- Reducción de los accidentes de trabajo y enfermedades ocupacionales
- La mejora continua de los procesos, la gestión del cambio, la preparación y respuesta a situaciones de emergencia.
- Definición de metas, indicadores, responsabilidades.
- Selección de criterios de medición para confirmar su logro.', 'Los objetivos de SST son realistas e incluyen reducción de riesgos y accidentes, mejora continua, metas, indicadores y responsables.', 'Definir objetivos de SST con meta, indicador y responsable.', 'Ley N.° 29783, art. 38; DS N.° 005-2012-TR, art. 32', 1),
  (33, 3, 'Planeamiento y Aplicación', 'Objetivos', 'La empresa, entidad pública o privada cuenta con objetivos cuantificables de seguridad y salud en el trabajo que abarca a todos los niveles de la organización y están documentados', 'Hay objetivos de SST medibles, documentados y para todos los niveles de la organización.', 'Documentar objetivos cuantificables y comunicarlos a todos los niveles.', 'Ley N.° 29783, art. 38; DS N.° 005-2012-TR, art. 32', 1),
  (34, 3, 'Planeamiento y Aplicación', 'Programa de Seguridad, Salud en el Trabajo', 'Existe un programa anual de seguridad y salud en el trabajo', 'Existe un programa anual de SST. Evidencia: programa del año en curso aprobado.', 'Generar el programa anual de SST en Prevé y aprobarlo.', 'DS N.° 005-2012-TR, art. 32', 1),
  (35, 3, 'Planeamiento y Aplicación', 'Programa de Seguridad, Salud en el Trabajo', 'Las actividades programadas están relacionadas con el logro de los objetivos', 'Las actividades del programa están relacionadas con los objetivos.', 'Agrupar las actividades del plan bajo sus objetivos.', 'DS N.° 005-2012-TR, art. 32', 1),
  (36, 3, 'Planeamiento y Aplicación', 'Programa de Seguridad, Salud en el Trabajo', 'Se definen responsables de las actividades en el programa de seguridad y salud en el trabajo', 'Cada actividad del programa tiene un responsable definido.', 'Asignar responsable a cada actividad del plan.', 'DS N.° 005-2012-TR, art. 32', 1),
  (37, 3, 'Planeamiento y Aplicación', 'Programa de Seguridad, Salud en el Trabajo', 'Se definen tiempos y plazos para el cumplimiento y se realiza seguimiento periódico', 'Cada actividad tiene fecha o plazo y se hace seguimiento periódico.', 'Asignar fechas a todas las actividades y revisar su avance cada mes.', 'DS N.° 005-2012-TR, art. 32', 1),
  (38, 3, 'Planeamiento y Aplicación', 'Programa de Seguridad, Salud en el Trabajo', 'Se señala dotación de recursos humanos y económicos', 'El programa indica los recursos humanos y económicos necesarios.', 'Registrar recursos y costo estimado por actividad.', 'DS N.° 005-2012-TR, art. 32', 1),
  (39, 3, 'Planeamiento y Aplicación', 'Programa de Seguridad, Salud en el Trabajo', 'Se establecen actividades preventivas antes los riesgos que inciden en la función de procreación del trabajador', 'Hay actividades preventivas frente a riesgos que afectan la función reproductiva de los trabajadores.', 'Identificar en la IPERC los agentes que afectan la función reproductiva y programar medidas preventivas.', 'DS N.° 005-2012-TR, art. 32', 1),
  (40, 4, 'Implementación y operación', 'Estructura y responsabilidades', 'El Comité de Seguridad y Salud en el Trabajo está constituido de forma paritaria(para el caso de los empleadores con 20 o más trabajadores)', 'Con 20 o más trabajadores debe existir un comité de SST paritario (mitad empleador, mitad trabajadores). Evidencia: acta de instalación.', 'Conformar o renovar el comité de SST paritario siguiendo el proceso de elección.', 'Ley N.° 29783, arts. 29 y 49', 1),
  (41, 4, 'Implementación y operación', 'Estructura y responsabilidades', 'El empleador es el responsable de:
- Garantizar la seguridad y salud de los trabajadores
- Actúa para mejorar el nivel de seguridad y salud en el trabajo
- Actúa en toma de medidas de prevención de riesgo ante modificaciones de las condiciones de trabajo.
- Realiza los exámenes médicos ocupacionales al trabajador antes durante y al término de la relación laboral', 'El empleador garantiza la SST, mejora continuamente, actúa ante cambios y realiza exámenes médicos antes, durante y al término del vínculo.', 'Verificar el cumplimiento de las responsabilidades del empleador, incluidos los exámenes médicos ocupacionales.', 'Ley N.° 29783, arts. 29 y 49', 1),
  (42, 4, 'Implementación y operación', 'Estructura y responsabilidades', 'El empleador considera las competencias del trabajador en materia de seguridad y salud en el trabajo, al asignarle sus labores', 'Al asignar labores se consideran las competencias de SST del trabajador.', 'Verificar competencias y capacitación antes de asignar tareas con riesgo.', 'Ley N.° 29783, arts. 29 y 49', 1),
  (43, 4, 'Implementación y operación', 'Estructura y responsabilidades', 'El empleador controla que sólo personal capacitado y protegido acceda a zonas de alto riesgo', 'Solo personal capacitado y protegido accede a zonas de alto riesgo. Evidencia: autorizaciones, control de acceso.', 'Controlar el acceso a zonas de alto riesgo con lista de personal autorizado y capacitado.', 'Ley N.° 29783, arts. 29 y 49', 1),
  (44, 4, 'Implementación y operación', 'Estructura y responsabilidades', 'El empleador prevé que la exposición a agentes físicos, químicos, biológicos, disergonómicos y psicosociales no generen daño al trabajador o trabajadora', 'La exposición a agentes físicos, químicos, biológicos, ergonómicos y psicosociales no debe causar daño.', 'Evaluar los agentes ocupacionales y programar su monitoreo.', 'Ley N.° 29783, arts. 29 y 49', 1),
  (45, 4, 'Implementación y operación', 'Estructura y responsabilidades', 'El empleador asume los costos de las acciones de seguridad y salud ejecutadas en el centro de trabajo.', 'El empleador asume el costo de las acciones de SST.', 'Confirmar que los costos de SST no se trasladan al trabajador.', 'Ley N.° 29783, arts. 29 y 49', 1),
  (46, 4, 'Implementación y operación', 'Capacitación', 'El empleador toma medidas para transmitir al trabajador información sobre los riesgos en el centro de trabajo y las medidas de protección que corresponda', 'El trabajador recibe información sobre los riesgos de su trabajo y las medidas de protección. Evidencia: inducción, recomendaciones por puesto.', 'Entregar a cada trabajador la información de riesgos de su puesto y registrar la entrega.', 'Ley N.° 29783, arts. 27, 35 y 49; DS N.° 005-2012-TR, art. 27', 1),
  (47, 4, 'Implementación y operación', 'Capacitación', 'El empleador imparte capacitación dentro de la jornada de trabajo', 'La capacitación se da dentro de la jornada de trabajo.', 'Programar las capacitaciones dentro del horario laboral.', 'Ley N.° 29783, arts. 27, 35 y 49; DS N.° 005-2012-TR, art. 27', 1),
  (48, 4, 'Implementación y operación', 'Capacitación', 'El costo de las capacitaciones es íntegramente asumido por el empleador', 'El costo de la capacitación lo asume íntegramente el empleador.', 'Asegurar que las capacitaciones sean costeadas por la empresa.', 'Ley N.° 29783, arts. 27, 35 y 49; DS N.° 005-2012-TR, art. 27', 1),
  (49, 4, 'Implementación y operación', 'Capacitación', 'Los representantes de los trabajadores han revisado el programa de capacitación', 'Los representantes de los trabajadores revisaron el programa de capacitación. Evidencia: acta de revisión.', 'Presentar el programa de capacitación al comité o supervisor para su revisión.', 'Ley N.° 29783, arts. 27, 35 y 49; DS N.° 005-2012-TR, art. 27', 1),
  (50, 4, 'Implementación y operación', 'Capacitación', 'La capacitación se imparte por personal competente y con experiencia en la materia', 'La capacitación la dicta personal competente y con experiencia.', 'Verificar las credenciales de los capacitadores internos y externos.', 'Ley N.° 29783, arts. 27, 35 y 49; DS N.° 005-2012-TR, art. 27', 1),
  (51, 4, 'Implementación y operación', 'Capacitación', 'Se ha capacitado a los integrantes del Comité de Seguridad y Salud en el Trabajo o Supervisor de Seguridad y Salud en el Trabajo', 'Los miembros del comité o el supervisor de SST fueron capacitados.', 'Programar la capacitación de los miembros del comité o del supervisor de SST.', 'Ley N.° 29783, arts. 27, 35 y 49; DS N.° 005-2012-TR, art. 27', 1),
  (52, 4, 'Implementación y operación', 'Capacitación', 'Las capacitaciones están documentadas', 'Las capacitaciones están documentadas. Evidencia: registros de asistencia con firma, fecha y tema.', 'Registrar cada capacitación con lista de asistencia y adjuntarla como evidencia.', 'Ley N.° 29783, arts. 27, 35 y 49; DS N.° 005-2012-TR, art. 27', 1),
  (53, 4, 'Implementación y operación', 'Capacitación', 'Se han realizado capacitaciones de seguridad y salud en el trabajo:
- Al momento de la contratación, cualquiera sea la modalidad o duración.
- Durante el desempeño de la labor
- Específica en el puesto de trabajo o en la función que cada trabajador desempeña, cualquiera que sea la naturaleza del vínculo, modalidad o duración de su contrato.
- Cuando se produce cambios en las funciones que desempeña el trabajador.
- Cuando se produce cambios en las tecnologías o en los equipos de trabajo.
- En las medidas que permitan la adaptación a la evolución de los riesgos y la prevención de nuevos riesgos.
- Para la actualización periódica de los conocimientos.
- Utilización y mantenimiento preventivo de las maquinarias y equipos.
- Uso apropiado de los materiales peligrosos', 'Hubo capacitaciones al ingreso, durante el trabajo, específicas del puesto, ante cambios de funciones, tecnología o equipos, y para actualizar conocimientos.', 'Programar inducción al ingreso y capacitaciones específicas por puesto y ante cambios.', 'Ley N.° 29783, arts. 27, 35 y 49; DS N.° 005-2012-TR, art. 27', 1),
  (54, 4, 'Implementación y operación', 'Medidas de prevención', 'Las medidas de prevención y protección se aplican en el orden de prioridad:
- Eliminación de los peligros y riesgos
- Tratamiento, control o aislamiento de los peligros y riesgos, adoptando medidas técnicas o administrativas.
- Minimizar los peligros y riesgos, adoptando sistemas de trabajo seguro que incluyan disposiciones administrativas de control.
- Programar la sustitución progresiva, y en la brevedad posible, de los procedimientos, técnicas, medios, sustancias y productos peligrosos por aquellos que produzcan un menor riesgo o ninguno para el trabajador.
- En último caso, facilitar equipos de protección personal adecuados, asegurándose que los trabajadores los utilicen y conserven en forma correcta.', 'Las medidas se aplican en orden: eliminar, controlar en la fuente, minimizar, sustituir y, en último caso, EPP.', 'Revisar los controles de la IPERC y priorizar los de mayor jerarquía antes que el EPP.', 'Ley N.° 29783, art. 21', 1),
  (55, 4, 'Implementación y operación', 'Preparación y respuesta ante emergencias', 'La empresa, entidad pública o privada ha elaborado planes y procedimientos para enfrentar y responder ante situaciones de emergencias.', 'Existen planes y procedimientos para responder ante emergencias. Evidencia: plan de respuesta ante emergencias.', 'Elaborar o actualizar el plan de respuesta ante emergencias.', 'Ley N.° 29783, art. 50; DS N.° 005-2012-TR, art. 83', 1),
  (56, 4, 'Implementación y operación', 'Preparación y respuesta ante emergencias', 'Se tiene organizada la brigada para actuar en caso de: incendios, primeros auxilios, evacuación', 'La brigada está organizada para incendios, primeros auxilios y evacuación. Evidencia: acta de designación, capacitación de brigadistas.', 'Designar brigadistas, formalizarlos en acta y capacitarlos.', 'Ley N.° 29783, art. 50; DS N.° 005-2012-TR, art. 83', 1),
  (57, 4, 'Implementación y operación', 'Preparación y respuesta ante emergencias', 'La empresa, entidad pública o privada revisa los planes y procedimientos ante situaciones de emergencia en forma periódica', 'Los planes de emergencia se revisan periódicamente.', 'Programar la revisión anual del plan de emergencias y después de cada simulacro.', 'Ley N.° 29783, art. 50; DS N.° 005-2012-TR, art. 83', 1),
  (58, 4, 'Implementación y operación', 'Preparación y respuesta ante emergencias', 'El empleador ha dado las instrucciones a los trabajadores para que en caso de un peligro grave e inminente puedan interrumpir sus labores y/o evacuar la zona de riesgo', 'Los trabajadores saben que pueden detener su labor y evacuar ante un peligro grave e inminente.', 'Comunicar el derecho a detener la labor ante peligro inminente e incluirlo en la inducción.', 'Ley N.° 29783, art. 50; DS N.° 005-2012-TR, art. 83', 1),
  (59, 4, 'Implementación y operación', 'Contratistas, Subcontratistas, empresa, entidad pública o privada, de servicios y cooperativas', 'El empleador que asume el contrato principal en cuyas instalaciones desarrollan actividades, trabajadores de contratistas, subcontratistas, empresas especiales de servicios y cooperativas de trabajadores, garantiza:
- La coordinación de la gestión en prevención de riesgos laborales
- La seguridad y salud de los trabajadores
- La verificación de la contratación de los seguros de acuerdo a ley por cada empleador
- La vigilancia del cumplimiento de la normatividad en materia de seguridad y salud en el trabajo por parte de la empresa, entidad pública o privada que destacan su personal', 'Si trabajan contratistas o terceros en sus instalaciones, la empresa coordina la prevención, verifica seguros y vigila el cumplimiento.', 'Establecer requisitos de SST para contratistas y verificar sus seguros (p. ej., SCTR).', 'Ley N.° 29783, art. 68', 1),
  (60, 4, 'Implementación y operación', 'Contratistas, Subcontratistas, empresa, entidad pública o privada, de servicios y cooperativas', 'Todos los trabajadores tienen el mismo nivel de protección en materia de seguridad y salud en el trabajo sea que tengan vínculo laboral con el empleador o con contratistas, subcontratistas, empresas especiales de servicios o cooperativas de trabajadores', 'Todos los trabajadores, propios o de terceros, tienen el mismo nivel de protección.', 'Incluir al personal de terceros en inducciones, EPP y controles de la IPERC.', 'Ley N.° 29783, art. 68', 1),
  (61, 4, 'Implementación y operación', 'Consulta y Comunicación', 'Los trabajadores han participado en:
- La consulta, información y capacitación en seguridad y salud en el trabajo.
- La elección de sus representantes ante el Comité de Seguridad y Salud en el Trabajo.
- La conformación del Comité de Seguridad y Salud en el Trabajo.
- El reconocimiento de sus representantes por parte del empleador', 'Los trabajadores participaron en la consulta, la capacitación, la elección y la conformación del comité.', 'Documentar la participación de los trabajadores en la elección y conformación del comité.', 'Ley N.° 29783, arts. 19 y 31', 1),
  (62, 4, 'Implementación y operación', 'Consulta y Comunicación', 'Los trabajadores han sido consultados ante los cambios realizados en las operaciones, procesos y organización del trabajo que repercuta en su seguridad y salud.', 'Se consulta a los trabajadores antes de cambios en operaciones o procesos que afecten su seguridad.', 'Incluir una consulta a los trabajadores en el procedimiento de gestión del cambio.', 'Ley N.° 29783, arts. 19 y 31', 1),
  (63, 4, 'Implementación y operación', 'Consulta y Comunicación', 'Existen procedimientos para asegurar que las informaciones pertinentes lleguen a los trabajadores correspondientes de la organización', 'Existen mecanismos para que la información de SST llegue a quien corresponde.', 'Definir canales de comunicación de SST (paneles, correo, charlas).', 'Ley N.° 29783, arts. 19 y 31', 1),
  (64, 5, 'Evaluación normativa', 'Requisitos Legales y de otro tipo', 'La empresa, entidad pública o privada tiene un procedimiento para identificar, acceder y monitorear el cumplimiento de la normatividad aplicable al sistema de gestión de seguridad y salud en el trabajo y se mantiene actualizada', 'Existe un procedimiento para identificar y seguir las normas de SST aplicables y mantenerlo actualizado.', 'Elaborar una lista de normas aplicables y revisarla periódicamente.', 'Ley N.° 29783, arts. 34, 64, 66 y 79', 1),
  (65, 5, 'Evaluación normativa', 'Requisitos Legales y de otro tipo', 'La empresa, entidad pública privada con 20 o más trabajadores ha elaborado su Reglamento Interno de Seguridad y Salud en el Trabajo (Salvo que una norma sectorial no establezca un número inferior)', 'Con 20 o más trabajadores se debe contar con el Reglamento Interno de SST (RISST).', 'Elaborar y aprobar el RISST con el comité y entregarlo a los trabajadores.', 'Ley N.° 29783, arts. 34, 64, 66 y 79', 1),
  (66, 5, 'Evaluación normativa', 'Requisitos Legales y de otro tipo', 'Los equipos a presión que posee la empresa entidad pública o privada tienen su libro de servicio autorizado por el MTPE', 'Los equipos a presión (calderas, compresoras, tanques) tienen su libro de servicio autorizado.', 'Inventariar los equipos a presión y gestionar su libro de servicio.', 'Ley N.° 29783, arts. 34, 64, 66 y 79', 1),
  (67, 5, 'Evaluación normativa', 'Requisitos Legales y de otro tipo', 'El empleador adopta las medidas necesarias y oportunas, cuando detecta que la utilización de ropas y/o equipos de trabajo o de protección personal representen riesgos específicos para la seguridad y salud de los trabajadores', 'Si la ropa o el EPP generan un riesgo específico, el empleador toma medidas.', 'Evaluar la idoneidad del EPP por tarea y reemplazar el que no sea adecuado.', 'Ley N.° 29783, arts. 34, 64, 66 y 79', 1),
  (68, 5, 'Evaluación normativa', 'Requisitos Legales y de otro tipo', 'El empleador toma medidas que eviten las labores peligrosas a trabajadoras en periodo de embarazo o lactancia conforme Ley', 'Se evitan labores peligrosas para trabajadoras gestantes o en lactancia.', 'Definir un procedimiento para reubicar a trabajadoras gestantes o en lactancia expuestas a riesgos.', 'Ley N.° 29783, arts. 34, 64, 66 y 79', 1),
  (69, 5, 'Evaluación normativa', 'Requisitos Legales y de otro tipo', 'El empleador no emplea a niños, ni adolescentes en actividades peligrosas', 'No se emplea a niños ni adolescentes en actividades peligrosas.', 'Verificar la edad del personal en actividades peligrosas.', 'Ley N.° 29783, arts. 34, 64, 66 y 79', 1),
  (70, 5, 'Evaluación normativa', 'Requisitos Legales y de otro tipo', 'El empleador evalúa el puesto de trabajo que va a desempeñar un adolescente trabajador previamente a su incorporación laboral a fin de determinar la naturaleza, el grado y la duración de la exposición al riesgo, con el objeto de adoptar medidas preventivas necesarias', 'Antes de incorporar a un adolescente se evalúa su puesto y se adoptan medidas preventivas.', 'Evaluar el puesto antes de incorporar a un adolescente.', 'Ley N.° 29783, arts. 34, 64, 66 y 79', 1),
  (71, 5, 'Evaluación normativa', 'Requisitos Legales y de otro tipo', 'La empresa, entidad pública o privada dispondrá lo necesario para que:
- Las máquinas, equipos, sustancias, productos o útiles de trabajo no constituyan una fuente de peligro.
- Se proporcione información y capacitación sobre la instalación, adecuada utilización y mantenimiento preventivo de las maquinarias y equipos.
- Se proporcione información y capacitación para el uso apropiado de los materiales peligrosos.
- Las instrucciones, manuales, avisos de peligro u otras medidas de precaución colocadas en los equipos y maquinarias estén traducidos al castellano.
- Las informaciones relativas a las máquinas, equipos, productos, sustancias o útiles de trabajo son comprensibles para los trabajadores', 'Máquinas, equipos y sustancias no son fuente de peligro; hay capacitación, manuales y avisos en castellano y comprensibles.', 'Verificar manuales y señalización en castellano y capacitar en el uso de equipos y sustancias.', 'Ley N.° 29783, arts. 34, 64, 66 y 79', 1),
  (72, 5, 'Evaluación normativa', 'Requisitos Legales y de otro tipo', 'Los trabajadores cumplen con:
- Las normas, reglamentos e instrucciones de los programas de seguridad y salud en el trabajo que se apliquen en el lugar de trabajo y con las instrucciones que les impartan sus superiores jerárquicos directos.
- Usar adecuadamente los instrumentos y materiales de trabajo, así como los equipos de protección personal y colectiva.. No operar o manipular equipos, maquinarias, herramientas u otros elementos necesarios para los cuales no hayan sido autorizados y, en caso de ser necesario, capacitados.
- Cooperar y participar en el proceso de investigación de los accidentes de trabajo, incidentes peligrosos, otros incidentes y las enfermedades ocupacionales cuando la autoridad competente lo requiera.
- Velar por el cuidado integral individual y colectivo, de su salud física y mental.
- Someterse a exámenes médicos obligatorios.
- Participar en los organismos paritarios de seguridad y salud en el trabajo.
- Comunicar al empleador situaciones que ponga o pueda poner en riesgo su seguridad y salud y/o en las instalaciones físicas.
- Reportar a los representantes de seguridad de forma inmediata, la ocurrencia de cualquier accidente de trabajo, incidente peligroso o incidente.
- Concurrir a la capacitación y entrenamiento sobre seguridad y salud en el trabajo', 'Los trabajadores cumplen normas, usan bien el EPP, no operan equipos sin autorización, reportan incidentes y asisten a capacitaciones.', 'Reforzar las obligaciones de los trabajadores en la inducción y verificarlas en las inspecciones.', 'Ley N.° 29783, arts. 34, 64, 66 y 79', 1),
  (73, 6, 'Verificación', 'Supervisión, monitoreo y seguimiento de desempeño', 'La vigilancia y control de seguridad y salud en el trabajo permite evaluar con regularidad los resultados logrados en materia de seguridad y salud en el trabajo', 'La vigilancia de SST permite evaluar los resultados con regularidad.', 'Revisar mensualmente los indicadores del tablero de SST.', 'Ley N.° 29783, arts. 40 y 41', 1),
  (74, 6, 'Verificación', 'Supervisión, monitoreo y seguimiento de desempeño', 'La supervisión permite:
- Identificar las fallas o deficiencias en el sistema de gestión de la seguridad y salud en el trabajo.
- Adoptar las medidas preventivas y correctivas', 'La supervisión identifica fallas del sistema y lleva a medidas preventivas y correctivas.', 'Registrar las fallas detectadas como hallazgos con acciones correctivas.', 'Ley N.° 29783, arts. 40 y 41', 1),
  (75, 6, 'Verificación', 'Supervisión, monitoreo y seguimiento de desempeño', 'El monitoreo permite la medición cuantitativa y cualitativa apropiadas.', 'El monitoreo mide con datos cuantitativos y cualitativos.', 'Definir indicadores cuantitativos (p. ej., % del plan ejecutado, acciones cerradas a tiempo).', 'Ley N.° 29783, arts. 40 y 41', 1),
  (76, 6, 'Verificación', 'Supervisión, monitoreo y seguimiento de desempeño', 'Se monitorea el grado de cumplimiento de los objetivos de la seguridad y salud en el trabajo', 'Se mide el avance de los objetivos de SST.', 'Medir el avance de cada objetivo con su indicador.', 'Ley N.° 29783, arts. 40 y 41', 1),
  (77, 6, 'Verificación', 'Salud en el trabajo', 'El empleador realiza exámenes médicos antes, durante y al término de la relación laboral a los trabajadores (incluyendo los adolescentes)', 'Se realizan exámenes médicos ocupacionales al ingreso, periódicos y al retiro.', 'Programar los exámenes médicos ocupacionales con la clínica y registrar su realización (sin datos clínicos).', 'Ley N.° 29783, arts. 49 y 71; DS N.° 005-2012-TR, art. 101', 1),
  (78, 6, 'Verificación', 'Salud en el trabajo', 'Los trabajadores son informados:
- A título grupal, de las razones para los exámenes de salud ocupacional.
- A título personal, sobre los resultados de los informes médicos relativos a la evaluación de su salud.
- Los resultados de los exámenes médicos no son pasibles de uso para ejercer discriminación', 'Los trabajadores conocen por qué se hacen los exámenes y reciben sus resultados; estos no se usan para discriminar.', 'Informar el propósito de los exámenes y asegurar la entrega confidencial de resultados.', 'Ley N.° 29783, arts. 49 y 71; DS N.° 005-2012-TR, art. 101', 1),
  (79, 6, 'Verificación', 'Salud en el trabajo', 'Los resultados de los exámenes médicos son considerados para tomar acciones preventivas o correctivas al respecto', 'Los resultados de los exámenes (agregados) se usan para tomar acciones preventivas.', 'Analizar los resultados agregados de aptitud y programar acciones preventivas.', 'Ley N.° 29783, arts. 49 y 71; DS N.° 005-2012-TR, art. 101', 1),
  (80, 6, 'Verificación', 'Accidentes, incidentes peligrosos e incidentes, no conformidad, acción correctiva y preventiva', 'El empleador notifica al Ministerio de Trabajo y Promoción del Empleo los accidentes de trabajo mortales dentro de las 24 horas de ocurridos.', 'Los accidentes mortales se notifican al MTPE dentro de las 24 horas.', 'Definir el procedimiento de notificación de accidentes mortales en 24 horas.', 'Ley N.° 29783, art. 82; DS N.° 005-2012-TR, art. 110', 1),
  (81, 6, 'Verificación', 'Accidentes, incidentes peligrosos e incidentes, no conformidad, acción correctiva y preventiva', 'El empleador notifica al Ministerio de Trabajo y Promoción del Empleo, dentro de las 24 horas de producidos, los incidentes peligrosos que han puesto en riesgo la salud y la integridad física de los trabajadores y/o a la población', 'Los incidentes peligrosos se notifican al MTPE dentro de las 24 horas.', 'Definir el procedimiento de notificación de incidentes peligrosos en 24 horas.', 'Ley N.° 29783, art. 82; DS N.° 005-2012-TR, art. 110', 1),
  (82, 6, 'Verificación', 'Accidentes, incidentes peligrosos e incidentes, no conformidad, acción correctiva y preventiva', 'Se implementan las medidas correctivas propuestas en los registros de accidentes de trabajo, incidentes peligrosos y otros incidentes.', 'Se implementan las medidas correctivas de los registros de accidentes e incidentes.', 'Dar seguimiento a las medidas correctivas de cada accidente o incidente hasta su verificación.', 'Ley N.° 29783, art. 82; DS N.° 005-2012-TR, art. 110', 1),
  (83, 6, 'Verificación', 'Accidentes, incidentes peligrosos e incidentes, no conformidad, acción correctiva y preventiva', 'Se implementan las medidas correctivas producto de las no conformidades halladas en las auditorias de seguridad y salud en el trabajo', 'Se implementan las medidas correctivas de las no conformidades de auditoría.', 'Registrar las no conformidades como hallazgos y seguir sus acciones.', 'Ley N.° 29783, art. 82; DS N.° 005-2012-TR, art. 110', 1),
  (84, 6, 'Verificación', 'Accidentes, incidentes peligrosos e incidentes, no conformidad, acción correctiva y preventiva', 'Se implementan medidas preventivas de seguridad y salud en el trabajo', 'Se implementan medidas preventivas de SST.', 'Programar medidas preventivas derivadas de la IPERC e inspecciones.', 'Ley N.° 29783, art. 82; DS N.° 005-2012-TR, art. 110', 1),
  (85, 6, 'Verificación', 'Investigación de accidentes y enfermedades ocupacionales', 'El empleador ha realizado las investigaciones de accidentes de trabajo, enfermedades ocupacionales e incidentes peligrosos, y ha comunicado a la autoridad administrativa de trabajo, indicando las medidas correctivas y preventivas adoptadas', 'Se investigan accidentes, enfermedades e incidentes peligrosos y se comunica a la autoridad con las medidas adoptadas.', 'Definir el procedimiento de investigación y comunicación a la autoridad.', 'Ley N.° 29783, art. 42', 1),
  (86, 6, 'Verificación', 'Investigación de accidentes y enfermedades ocupacionales', 'Se investigan los accidentes de trabajo, enfermedades ocupacionales e incidentes peligrosos para:
- Determinar las causas e implementar las medidas correctivas.
- Comprobar la eficacia de las medidas de seguridad y salud vigentes al momento del hecho.
- Determinar la necesidad de modificar dichas medidas', 'Las investigaciones buscan causas, verifican la eficacia de las medidas vigentes y determinan cambios.', 'Usar un formato de investigación con análisis de causas y revisión de controles.', 'Ley N.° 29783, art. 42', 1),
  (87, 6, 'Verificación', 'Investigación de accidentes y enfermedades ocupacionales', 'Se toma medidas correctivas para reducir las consecuencias de accidentes', 'Se toman medidas para reducir las consecuencias de los accidentes.', 'Definir medidas de mitigación (primeros auxilios, respuesta) para los riesgos principales.', 'Ley N.° 29783, art. 42', 1),
  (88, 6, 'Verificación', 'Investigación de accidentes y enfermedades ocupacionales', 'Se ha documentado los cambios en los procedimientos como consecuencia de las acciones correctivas', 'Los cambios en procedimientos derivados de acciones correctivas están documentados.', 'Actualizar y versionar los procedimientos tras cada acción correctiva.', 'Ley N.° 29783, art. 42', 1),
  (89, 6, 'Verificación', 'Investigación de accidentes y enfermedades ocupacionales', 'El trabajador ha sido transferido en caso de accidente o enfermedad ocupacional a otro puesto que implique menos riesgo', 'Tras un accidente o enfermedad ocupacional, el trabajador es reubicado a un puesto de menor riesgo.', 'Definir el procedimiento de reubicación laboral.', 'Ley N.° 29783, art. 42', 1),
  (90, 6, 'Verificación', 'Control de Operaciones', 'La empresa, entidad pública o privada ha identificado las operaciones y actividades que están asociadas con riesgos donde las medidas de control necesitan ser aplicadas', 'Se identificaron las operaciones asociadas a riesgos que requieren controles.', 'Marcar en la IPERC las tareas críticas que requieren control operacional.', 'Ley N.° 29783, art. 50', 1),
  (91, 6, 'Verificación', 'Control de Operaciones', 'La empresa, entidad pública o privada ha establecido procedimientos para el diseño del lugar de trabajo, procesos operativos, instalaciones, maquinarias y organización del trabajo que incluye la adaptación a las capacidades humanas a modo de reducir los riesgos en sus fuentes.', 'Existen procedimientos para diseñar lugares de trabajo, procesos, instalaciones y equipos adaptados a las personas.', 'Incluir criterios ergonómicos y de seguridad en el diseño de puestos e instalaciones.', 'Ley N.° 29783, art. 50', 1),
  (92, 6, 'Verificación', 'Gestión del cambio', 'Se han evaluado las medidas de seguridad debido a cambios internos, método de trabajo, estructura organizativa y cambios externos normativos, conocimientos en el campo de la seguridad, cambios tecnológicos, adaptándose las medidas de prevención antes de introducirlos.', 'Antes de introducir cambios (internos, normativos o tecnológicos) se evalúan sus efectos en la SST.', 'Elaborar un procedimiento de gestión del cambio que exija revisar la IPERC antes de aplicar cambios.', 'Ley N.° 29783, art. 50', 1),
  (93, 6, 'Verificación', 'Auditorias', 'Se cuenta con un programa de auditorías', 'Existe un programa de auditorías del sistema de SST.', 'Incluir un programa de auditorías en el plan anual.', 'Ley N.° 29783, art. 43', 1),
  (94, 6, 'Verificación', 'Auditorias', 'El empleador realiza auditorías internas periódicas para comprobar la adecuada aplicación del sistema de gestión de seguridad y salud en el trabajo', 'Se realizan auditorías internas periódicas del sistema de SST.', 'Programar una auditoría interna anual.', 'Ley N.° 29783, art. 43', 1),
  (95, 6, 'Verificación', 'Auditorias', 'Las auditorías externas son realizadas por auditores independientes con la participación de los trabajadores o sus representantes', 'Las auditorías externas las hacen auditores independientes con participación de los trabajadores.', 'Contratar la auditoría externa con auditor independiente e invitar a los representantes de los trabajadores.', 'Ley N.° 29783, art. 43', 1),
  (96, 6, 'Verificación', 'Auditorias', 'Los resultados de las auditorías son comunicados a la alta dirección de la empresa, entidad pública o privada', 'Los resultados de las auditorías se comunican a la alta dirección.', 'Presentar los resultados de auditoría a la gerencia y registrar la presentación.', 'Ley N.° 29783, art. 43', 1),
  (97, 7, 'Control de información y documentos', 'Documentos', 'La empresa, entidad pública o privada establece y mantiene información en medios apropiados para describir los componentes del sistema de gestión y su relación entre ellos.', 'La información del sistema de SST está en medios apropiados y muestra cómo se relacionan sus partes.', 'Centralizar los documentos del sistema de SST en un repositorio único.', 'Ley N.° 29783, arts. 28 y 35', 1),
  (98, 7, 'Control de información y documentos', 'Documentos', 'Los procedimientos de la empresa, entidad pública o privada, en la gestión de la seguridad y salud en el trabajo, se revisan periódicamente', 'Los procedimientos de SST se revisan periódicamente.', 'Programar la revisión anual de procedimientos.', 'Ley N.° 29783, arts. 28 y 35', 1),
  (99, 7, 'Control de información y documentos', 'Documentos', 'El empleador establece y mantiene disposiciones y procedimientos para:
- Recibir, documentar y responder adecuadamente a las comunicaciones internas y externas relativas a la seguridad y salud en el trabajo.
- Garantizar la comunicación interna de la información relativa a la seguridad y salud en el trabajo entre los distintos niveles y cargos de la organización.
- Garantizar que las sugerencias de los trabajadores o de sus representantes sobre seguridad y salud en el trabajo se reciban y atiendan en forma oportuna y adecuada', 'Hay procedimientos para recibir y responder comunicaciones de SST, comunicar internamente y atender sugerencias de los trabajadores.', 'Definir cómo se reciben, registran y responden las comunicaciones y sugerencias de SST.', 'Ley N.° 29783, arts. 28 y 35', 1),
  (100, 7, 'Control de información y documentos', 'Documentos', 'El empleador entrega adjunto a los contratos de trabajo las recomendaciones de seguridad y salud considerando los riesgos del centro de laborales y los relacionados con el puesto o función del trabajador.', 'Junto con el contrato se entregan las recomendaciones de SST del puesto.', 'Entregar las recomendaciones de SST por puesto con el contrato y registrar la entrega.', 'Ley N.° 29783, arts. 28 y 35', 1),
  (101, 7, 'Control de información y documentos', 'Documentos', 'El empleador ha:
- Facilitado al trabajador una copia del reglamento interno de seguridad y salud en el trabajo.
- Capacitado al trabajador en referencia al contenido del reglamento interno de seguridad y salud en el trabajo.
- Asegurado para poner en práctica las medidas de seguridad y salud en el trabajo.
- Elaborado un mapa de riesgos del centro de trabajo y lo exhibe en un lugar visible.
- El empleador entrega al trabajador las recomendaciones de seguridad y salud en el trabajo considerando los riesgos del centro de labores y los relacionados con el puesto o función, el primer día de labores.', 'Se entregó el RISST, se capacitó sobre él, existe mapa de riesgos visible y se entregan recomendaciones de SST el primer día.', 'Entregar el RISST, capacitar sobre su contenido y publicar el mapa de riesgos.', 'Ley N.° 29783, arts. 28 y 35', 1),
  (102, 7, 'Control de información y documentos', 'Documentos', 'El empleador mantiene procedimientos para garantizar que:
- Se identifiquen, evalúen e incorporen en las especificaciones relativas a compras y arrendamiento financiero, disposiciones relativas al cumplimiento por parte de la organización de los requisitos de seguridad y salud.
- Se identifiquen las obligaciones y los requisitos tanto legales como de la propia organización en materia de seguridad y salud en el trabajo antes de la adquisición de bienes y servicios.
- Se adopten disposiciones para que se cumplan dichos requisitos antes de utilizar los bienes y servicios mencionados', 'En compras y contrataciones se incluyen requisitos de SST antes de adquirir bienes o servicios.', 'Incluir requisitos de SST en las especificaciones de compra.', 'Ley N.° 29783, arts. 28 y 35', 1),
  (103, 7, 'Control de información y documentos', 'Control de la documentación y de los datos', 'La empresa, entidad pública o privada establece procedimientos para el control de los documentos que se generen por esta lista de verificación', 'Existen procedimientos para controlar los documentos del sistema.', 'Definir el control de documentos (versión, aprobación, vigencia).', 'DS N.° 005-2012-TR, arts. 32 y 33', 1),
  (104, 7, 'Control de información y documentos', 'Control de la documentación y de los datos', 'Este control asegura que los documentos y datos:
- Puedan ser fácilmente localizados.
- Puedan ser analizados y verificados periódicamente.
- Están disponibles en los locales.
- Sean removidos cuando los datos sean obsoletos.
- Son adecuadamente archivados', 'Los documentos son fáciles de localizar, se revisan, están disponibles, se retiran si son obsoletos y se archivan bien.', 'Digitalizar y organizar los documentos y registros para localizarlos rápidamente.', 'DS N.° 005-2012-TR, arts. 32 y 33', 1),
  (105, 7, 'Control de información y documentos', 'Gestión de los registros', 'El empleador ha implementado registros y documentos del sistema de gestión actualizados y a disposición del trabajador referido a:
- Registro de accidentes de trabajo, enfermedades ocupacionales, incidentes peligrosos y otros incidentes, en el que deben constar la investigación y las medidas correctivas', 'Existe el registro de accidentes, enfermedades ocupacionales, incidentes peligrosos e incidentes, con investigación y medidas correctivas.', 'Implementar el registro de accidentes e incidentes según el formato del MTPE.', 'Ley N.° 29783, art. 28; DS N.° 005-2012-TR, art. 33; RM N.° 050-2013-TR (formatos)', 1),
  (106, 7, 'Control de información y documentos', 'Gestión de los registros', 'Registro de exámenes médicos ocupacionales', 'Existe el registro de exámenes médicos ocupacionales.', 'Implementar el registro de exámenes médicos ocupacionales (solo aptitud).', 'Ley N.° 29783, art. 28; DS N.° 005-2012-TR, art. 33; RM N.° 050-2013-TR (formatos)', 1),
  (107, 7, 'Control de información y documentos', 'Gestión de los registros', 'Registro de monitoreo de agentes físicos, químicos, biológicos, psicosociales y factores de riesgo disergonómicos', 'Existe el registro de monitoreo de agentes físicos, químicos, biológicos, psicosociales y ergonómicos.', 'Programar monitoreos de agentes y llevar su registro.', 'Ley N.° 29783, art. 28; DS N.° 005-2012-TR, art. 33; RM N.° 050-2013-TR (formatos)', 1),
  (108, 7, 'Control de información y documentos', 'Gestión de los registros', 'Registro de inspecciones internas de seguridad y salud en el trabajo', 'Existe el registro de inspecciones internas de SST.', 'Registrar cada inspección con su formato y hallazgos.', 'Ley N.° 29783, art. 28; DS N.° 005-2012-TR, art. 33; RM N.° 050-2013-TR (formatos)', 1),
  (109, 7, 'Control de información y documentos', 'Gestión de los registros', 'Registro de estadísticas de seguridad y salud', 'Existe el registro de estadísticas de SST.', 'Llevar estadísticas mensuales de SST.', 'Ley N.° 29783, art. 28; DS N.° 005-2012-TR, art. 33; RM N.° 050-2013-TR (formatos)', 1),
  (110, 7, 'Control de información y documentos', 'Gestión de los registros', 'Registro de equipos de seguridad o emergencia', 'Existe el registro de equipos de seguridad o emergencia (extintores, botiquines, alarmas).', 'Inventariar los equipos de emergencia y registrar sus mantenimientos.', 'Ley N.° 29783, art. 28; DS N.° 005-2012-TR, art. 33; RM N.° 050-2013-TR (formatos)', 1),
  (111, 7, 'Control de información y documentos', 'Gestión de los registros', 'Registro de inducción, capacitación, entrenamiento y simulacros de emergencia', 'Existe el registro de inducción, capacitación, entrenamiento y simulacros.', 'Registrar inducciones, capacitaciones y simulacros con evidencia de asistencia.', 'Ley N.° 29783, art. 28; DS N.° 005-2012-TR, art. 33; RM N.° 050-2013-TR (formatos)', 1),
  (112, 7, 'Control de información y documentos', 'Gestión de los registros', 'Registro de auditorías', 'Existe el registro de auditorías.', 'Registrar las auditorías realizadas y sus resultados.', 'Ley N.° 29783, art. 28; DS N.° 005-2012-TR, art. 33; RM N.° 050-2013-TR (formatos)', 1),
  (113, 7, 'Control de información y documentos', 'Gestión de los registros', 'La empresa, entidad pública o privada cuenta con registros de accidente de trabajo y enfermedad ocupacional e incidentes peligrosos y otros incidentes ocurridos a:
- Sus trabajadores
- Trabajadores de intermediación laboral y/o tercerización.
- Beneficiarios bajo modalidades formativas
- Personal que presta servicios de manera independiente, desarrollando sus actividades total o parcialmente en las instalaciones de la empresa, entidad pública o privada', 'Los registros de accidentes e incidentes incluyen a trabajadores propios, de intermediación, tercerización, modalidades formativas e independientes en las instalaciones.', 'Ampliar el registro de accidentes e incidentes al personal de terceros y modalidades formativas.', 'Ley N.° 29783, art. 28; DS N.° 005-2012-TR, art. 33; RM N.° 050-2013-TR (formatos)', 1),
  (114, 7, 'Control de información y documentos', 'Gestión de los registros', 'Los registros mencionados son:
- Legibles e identificables
- Permite su seguimiento
- Son archivados y adecuadamente protegidos', 'Los registros son legibles, permiten seguimiento y están archivados y protegidos.', 'Archivar los registros de forma digital y con respaldo.', 'Ley N.° 29783, art. 28; DS N.° 005-2012-TR, art. 33; RM N.° 050-2013-TR (formatos)', 1),
  (115, 8, 'Revisión por la dirección', 'Gestión de la mejora continua', 'La alta dirección:Revisa y analiza periódicamente el sistema de gestión para asegurar que sea apropiada y efectiva', 'La alta dirección revisa periódicamente si el sistema de SST es apropiado y efectivo.', 'Programar la revisión por la dirección al menos una vez al año.', 'Ley N.° 29783, arts. 39 y 41', 1),
  (116, 8, 'Revisión por la dirección', 'Gestión de la mejora continua', 'Las disposiciones adoptadas por la dirección para la mejora continua del sistema de gestión de seguridad y salud en el trabajo, deben tener en cuenta:
- Los objetivos de la seguridad y salud en el trabajo de la empresa, entidad pública o privada. Los resultados de la identificación de los peligros y evaluación de los riesgos.
- Los resultados de la supervisión y medición de la eficiencia
- La investigación de accidentes, enfermedades ocupacionales, incidentes peligrosos y otros incidentes relacionados con el trabajo.
- Los resultados y recomendaciones de las auditorias y evaluaciones realizadas por la dirección de la empresa, entidad pública o privada.
- Las recomendaciones del Comité o Supervisor de Seguridad y Salud en el Trabajo.
- Los cambios en las normas.
- La información pertinente nueva.
- Los resultados de los programas anuales de seguridad y salud en el trabajo', 'Las decisiones de mejora consideran objetivos, IPERC, mediciones, investigaciones, auditorías, recomendaciones del comité, cambios normativos y resultados del programa anual.', 'Preparar para la revisión por la dirección un resumen con todos esos insumos.', 'Ley N.° 29783, arts. 39 y 41', 1),
  (117, 8, 'Revisión por la dirección', 'Gestión de la mejora continua', 'La metodología de mejoramiento continuo considera:
- La identificación de las desviaciones de las prácticas y condiciones aceptadas como seguras.
- El establecimiento de estándares de seguridad
- La medición y evaluación periódica del desempeño con respecto a los estándares de la empresa.. La corrección y reconocimiento del desempeño', 'La mejora continua identifica desviaciones, establece estándares, mide el desempeño y corrige y reconoce.', 'Definir estándares de seguridad y medir el desempeño contra ellos.', 'Ley N.° 29783, arts. 39 y 41', 1),
  (118, 8, 'Revisión por la dirección', 'Gestión de la mejora continua', 'La investigación y auditorías permiten a la dirección de la empresa, entidad pública o privada lograr los fines previstos y determinar, de ser el caso, cambios en la política y objetivos del Sistema de Gestión de Seguridad y Salud en el Trabajo', 'Las investigaciones y auditorías permiten a la dirección ajustar la política y los objetivos.', 'Revisar política y objetivos con base en investigaciones y auditorías.', 'Ley N.° 29783, arts. 39 y 41', 1),
  (119, 8, 'Revisión por la dirección', 'Gestión de la mejora continua', 'La investigación de los accidentes, enfermedades ocupacionales, incidentes peligrosos y otros incidentes, permiten identificar:
- Las causas inmediatas (actas y condiciones subestándares).
- Las causas básicas (factores personales y factores del trabajo)
- Deficiencia del sistema de gestión de la Seguridad y Salud en el Trabajo, para la planificación de la acción correctiva pertinente.', 'Las investigaciones identifican causas inmediatas, causas básicas y deficiencias del sistema.', 'Usar un método de análisis de causas (inmediatas y básicas) en cada investigación.', 'Ley N.° 29783, arts. 39 y 41', 1),
  (120, 8, 'Revisión por la dirección', 'Gestión de la mejora continua', 'El empleador ha modificado las medidas de prevención de riesgos laborales cuando resulten inadecuadas e insuficientes para garantizar la seguridad y salud de los trabajadores incluyendo al personal de los regímenes de intermediación y tercerización, modalidad formativa e inclusivo a los que prestan servicios de manera independiente, siempre que éstos desarrollen sus actividades total parcialmente en las instalaciones de la empresa, entidad pública o privada durante el desarrollo de las operaciones.', 'Las medidas de prevención se modifican cuando resultan insuficientes, incluyendo al personal de terceros y modalidades formativas.', 'Revisar los controles cuando un hallazgo o incidente muestre que son insuficientes.', 'Ley N.° 29783, arts. 39 y 41', 1);

insert into diagnostico_respuesta (empresa_id, item_n, estado) values
  ('cd37147b-c5c0-5863-a5ef-a377924adfb3', 1, 'P'),
  ('cd37147b-c5c0-5863-a5ef-a377924adfb3', 2, 'P'),
  ('cd37147b-c5c0-5863-a5ef-a377924adfb3', 3, 'P'),
  ('cd37147b-c5c0-5863-a5ef-a377924adfb3', 4, 'NC'),
  ('cd37147b-c5c0-5863-a5ef-a377924adfb3', 5, 'P'),
  ('cd37147b-c5c0-5863-a5ef-a377924adfb3', 6, 'P'),
  ('cd37147b-c5c0-5863-a5ef-a377924adfb3', 7, 'C'),
  ('cd37147b-c5c0-5863-a5ef-a377924adfb3', 8, 'NC'),
  ('cd37147b-c5c0-5863-a5ef-a377924adfb3', 9, 'P'),
  ('cd37147b-c5c0-5863-a5ef-a377924adfb3', 10, 'C'),
  ('cd37147b-c5c0-5863-a5ef-a377924adfb3', 11, 'C'),
  ('cd37147b-c5c0-5863-a5ef-a377924adfb3', 12, 'C'),
  ('cd37147b-c5c0-5863-a5ef-a377924adfb3', 13, 'P'),
  ('cd37147b-c5c0-5863-a5ef-a377924adfb3', 14, 'C'),
  ('cd37147b-c5c0-5863-a5ef-a377924adfb3', 15, 'P'),
  ('cd37147b-c5c0-5863-a5ef-a377924adfb3', 16, 'C'),
  ('cd37147b-c5c0-5863-a5ef-a377924adfb3', 17, 'P'),
  ('cd37147b-c5c0-5863-a5ef-a377924adfb3', 18, 'NC'),
  ('cd37147b-c5c0-5863-a5ef-a377924adfb3', 19, 'P'),
  ('cd37147b-c5c0-5863-a5ef-a377924adfb3', 20, 'P'),
  ('cd37147b-c5c0-5863-a5ef-a377924adfb3', 21, 'NC'),
  ('cd37147b-c5c0-5863-a5ef-a377924adfb3', 22, 'P'),
  ('cd37147b-c5c0-5863-a5ef-a377924adfb3', 23, 'P'),
  ('cd37147b-c5c0-5863-a5ef-a377924adfb3', 24, 'P'),
  ('cd37147b-c5c0-5863-a5ef-a377924adfb3', 25, 'P'),
  ('cd37147b-c5c0-5863-a5ef-a377924adfb3', 26, 'C'),
  ('cd37147b-c5c0-5863-a5ef-a377924adfb3', 27, 'P'),
  ('cd37147b-c5c0-5863-a5ef-a377924adfb3', 28, 'P'),
  ('cd37147b-c5c0-5863-a5ef-a377924adfb3', 29, 'C'),
  ('cd37147b-c5c0-5863-a5ef-a377924adfb3', 30, 'P'),
  ('cd37147b-c5c0-5863-a5ef-a377924adfb3', 31, 'NC'),
  ('cd37147b-c5c0-5863-a5ef-a377924adfb3', 32, 'P'),
  ('cd37147b-c5c0-5863-a5ef-a377924adfb3', 33, 'NC'),
  ('cd37147b-c5c0-5863-a5ef-a377924adfb3', 34, 'C'),
  ('cd37147b-c5c0-5863-a5ef-a377924adfb3', 35, 'P'),
  ('cd37147b-c5c0-5863-a5ef-a377924adfb3', 36, 'C'),
  ('cd37147b-c5c0-5863-a5ef-a377924adfb3', 37, 'P'),
  ('cd37147b-c5c0-5863-a5ef-a377924adfb3', 38, 'NC'),
  ('cd37147b-c5c0-5863-a5ef-a377924adfb3', 39, 'NC'),
  ('cd37147b-c5c0-5863-a5ef-a377924adfb3', 40, 'C'),
  ('cd37147b-c5c0-5863-a5ef-a377924adfb3', 41, 'P'),
  ('cd37147b-c5c0-5863-a5ef-a377924adfb3', 42, 'P'),
  ('cd37147b-c5c0-5863-a5ef-a377924adfb3', 43, 'P'),
  ('cd37147b-c5c0-5863-a5ef-a377924adfb3', 44, 'P'),
  ('cd37147b-c5c0-5863-a5ef-a377924adfb3', 45, 'C'),
  ('cd37147b-c5c0-5863-a5ef-a377924adfb3', 46, 'P'),
  ('cd37147b-c5c0-5863-a5ef-a377924adfb3', 47, 'C'),
  ('cd37147b-c5c0-5863-a5ef-a377924adfb3', 48, 'C'),
  ('cd37147b-c5c0-5863-a5ef-a377924adfb3', 49, 'NC'),
  ('cd37147b-c5c0-5863-a5ef-a377924adfb3', 50, 'C'),
  ('cd37147b-c5c0-5863-a5ef-a377924adfb3', 51, 'P'),
  ('cd37147b-c5c0-5863-a5ef-a377924adfb3', 52, 'C'),
  ('cd37147b-c5c0-5863-a5ef-a377924adfb3', 53, 'P'),
  ('cd37147b-c5c0-5863-a5ef-a377924adfb3', 54, 'P'),
  ('cd37147b-c5c0-5863-a5ef-a377924adfb3', 55, 'C'),
  ('cd37147b-c5c0-5863-a5ef-a377924adfb3', 56, 'P'),
  ('cd37147b-c5c0-5863-a5ef-a377924adfb3', 57, 'P'),
  ('cd37147b-c5c0-5863-a5ef-a377924adfb3', 58, 'P'),
  ('cd37147b-c5c0-5863-a5ef-a377924adfb3', 59, 'P'),
  ('cd37147b-c5c0-5863-a5ef-a377924adfb3', 60, 'P'),
  ('cd37147b-c5c0-5863-a5ef-a377924adfb3', 61, 'C'),
  ('cd37147b-c5c0-5863-a5ef-a377924adfb3', 62, 'NC'),
  ('cd37147b-c5c0-5863-a5ef-a377924adfb3', 63, 'P'),
  ('cd37147b-c5c0-5863-a5ef-a377924adfb3', 64, 'P'),
  ('cd37147b-c5c0-5863-a5ef-a377924adfb3', 65, 'C'),
  ('cd37147b-c5c0-5863-a5ef-a377924adfb3', 66, 'P'),
  ('cd37147b-c5c0-5863-a5ef-a377924adfb3', 67, 'P'),
  ('cd37147b-c5c0-5863-a5ef-a377924adfb3', 68, 'P'),
  ('cd37147b-c5c0-5863-a5ef-a377924adfb3', 69, 'C'),
  ('cd37147b-c5c0-5863-a5ef-a377924adfb3', 70, 'NA'),
  ('cd37147b-c5c0-5863-a5ef-a377924adfb3', 71, 'P'),
  ('cd37147b-c5c0-5863-a5ef-a377924adfb3', 72, 'P'),
  ('cd37147b-c5c0-5863-a5ef-a377924adfb3', 73, 'P'),
  ('cd37147b-c5c0-5863-a5ef-a377924adfb3', 74, 'P'),
  ('cd37147b-c5c0-5863-a5ef-a377924adfb3', 75, 'NC'),
  ('cd37147b-c5c0-5863-a5ef-a377924adfb3', 76, 'P'),
  ('cd37147b-c5c0-5863-a5ef-a377924adfb3', 77, 'P'),
  ('cd37147b-c5c0-5863-a5ef-a377924adfb3', 78, 'P'),
  ('cd37147b-c5c0-5863-a5ef-a377924adfb3', 79, 'NC'),
  ('cd37147b-c5c0-5863-a5ef-a377924adfb3', 80, 'C'),
  ('cd37147b-c5c0-5863-a5ef-a377924adfb3', 81, 'C'),
  ('cd37147b-c5c0-5863-a5ef-a377924adfb3', 82, 'P'),
  ('cd37147b-c5c0-5863-a5ef-a377924adfb3', 83, 'P'),
  ('cd37147b-c5c0-5863-a5ef-a377924adfb3', 84, 'P'),
  ('cd37147b-c5c0-5863-a5ef-a377924adfb3', 85, 'P'),
  ('cd37147b-c5c0-5863-a5ef-a377924adfb3', 86, 'P'),
  ('cd37147b-c5c0-5863-a5ef-a377924adfb3', 87, 'P'),
  ('cd37147b-c5c0-5863-a5ef-a377924adfb3', 88, 'NC'),
  ('cd37147b-c5c0-5863-a5ef-a377924adfb3', 89, 'P'),
  ('cd37147b-c5c0-5863-a5ef-a377924adfb3', 90, 'C'),
  ('cd37147b-c5c0-5863-a5ef-a377924adfb3', 91, 'NC'),
  ('cd37147b-c5c0-5863-a5ef-a377924adfb3', 92, 'NC'),
  ('cd37147b-c5c0-5863-a5ef-a377924adfb3', 93, 'C'),
  ('cd37147b-c5c0-5863-a5ef-a377924adfb3', 94, 'P'),
  ('cd37147b-c5c0-5863-a5ef-a377924adfb3', 95, 'NC'),
  ('cd37147b-c5c0-5863-a5ef-a377924adfb3', 96, 'P'),
  ('cd37147b-c5c0-5863-a5ef-a377924adfb3', 97, 'P'),
  ('cd37147b-c5c0-5863-a5ef-a377924adfb3', 98, 'P'),
  ('cd37147b-c5c0-5863-a5ef-a377924adfb3', 99, 'P'),
  ('cd37147b-c5c0-5863-a5ef-a377924adfb3', 100, 'NC'),
  ('cd37147b-c5c0-5863-a5ef-a377924adfb3', 101, 'P'),
  ('cd37147b-c5c0-5863-a5ef-a377924adfb3', 102, 'NC'),
  ('cd37147b-c5c0-5863-a5ef-a377924adfb3', 103, 'NC'),
  ('cd37147b-c5c0-5863-a5ef-a377924adfb3', 104, 'P'),
  ('cd37147b-c5c0-5863-a5ef-a377924adfb3', 105, 'C'),
  ('cd37147b-c5c0-5863-a5ef-a377924adfb3', 106, 'P'),
  ('cd37147b-c5c0-5863-a5ef-a377924adfb3', 107, 'NC'),
  ('cd37147b-c5c0-5863-a5ef-a377924adfb3', 108, 'C'),
  ('cd37147b-c5c0-5863-a5ef-a377924adfb3', 109, 'P'),
  ('cd37147b-c5c0-5863-a5ef-a377924adfb3', 110, 'P'),
  ('cd37147b-c5c0-5863-a5ef-a377924adfb3', 111, 'C'),
  ('cd37147b-c5c0-5863-a5ef-a377924adfb3', 112, 'P'),
  ('cd37147b-c5c0-5863-a5ef-a377924adfb3', 113, 'P'),
  ('cd37147b-c5c0-5863-a5ef-a377924adfb3', 114, 'P'),
  ('cd37147b-c5c0-5863-a5ef-a377924adfb3', 115, 'P'),
  ('cd37147b-c5c0-5863-a5ef-a377924adfb3', 116, 'P'),
  ('cd37147b-c5c0-5863-a5ef-a377924adfb3', 117, 'NC'),
  ('cd37147b-c5c0-5863-a5ef-a377924adfb3', 118, 'P'),
  ('cd37147b-c5c0-5863-a5ef-a377924adfb3', 119, 'P'),
  ('cd37147b-c5c0-5863-a5ef-a377924adfb3', 120, 'P'),
  ('8e5ec102-d967-54bc-b370-1a067286ec4a', 1, 'C'),
  ('8e5ec102-d967-54bc-b370-1a067286ec4a', 2, 'P'),
  ('8e5ec102-d967-54bc-b370-1a067286ec4a', 3, 'C'),
  ('8e5ec102-d967-54bc-b370-1a067286ec4a', 4, 'P'),
  ('8e5ec102-d967-54bc-b370-1a067286ec4a', 5, 'P'),
  ('8e5ec102-d967-54bc-b370-1a067286ec4a', 6, 'C'),
  ('8e5ec102-d967-54bc-b370-1a067286ec4a', 7, 'C'),
  ('8e5ec102-d967-54bc-b370-1a067286ec4a', 8, 'NC'),
  ('8e5ec102-d967-54bc-b370-1a067286ec4a', 9, 'C'),
  ('8e5ec102-d967-54bc-b370-1a067286ec4a', 10, 'C'),
  ('8e5ec102-d967-54bc-b370-1a067286ec4a', 11, 'C'),
  ('8e5ec102-d967-54bc-b370-1a067286ec4a', 12, 'C'),
  ('8e5ec102-d967-54bc-b370-1a067286ec4a', 13, 'P'),
  ('8e5ec102-d967-54bc-b370-1a067286ec4a', 14, 'C'),
  ('8e5ec102-d967-54bc-b370-1a067286ec4a', 15, 'P'),
  ('8e5ec102-d967-54bc-b370-1a067286ec4a', 16, 'C'),
  ('8e5ec102-d967-54bc-b370-1a067286ec4a', 17, 'C'),
  ('8e5ec102-d967-54bc-b370-1a067286ec4a', 18, 'C'),
  ('8e5ec102-d967-54bc-b370-1a067286ec4a', 19, 'C'),
  ('8e5ec102-d967-54bc-b370-1a067286ec4a', 20, 'P'),
  ('8e5ec102-d967-54bc-b370-1a067286ec4a', 21, 'NC'),
  ('8e5ec102-d967-54bc-b370-1a067286ec4a', 22, 'P'),
  ('8e5ec102-d967-54bc-b370-1a067286ec4a', 23, 'C'),
  ('8e5ec102-d967-54bc-b370-1a067286ec4a', 24, 'C'),
  ('8e5ec102-d967-54bc-b370-1a067286ec4a', 25, 'C'),
  ('8e5ec102-d967-54bc-b370-1a067286ec4a', 26, 'C'),
  ('8e5ec102-d967-54bc-b370-1a067286ec4a', 27, 'P'),
  ('8e5ec102-d967-54bc-b370-1a067286ec4a', 28, 'C'),
  ('8e5ec102-d967-54bc-b370-1a067286ec4a', 29, 'C'),
  ('8e5ec102-d967-54bc-b370-1a067286ec4a', 30, 'P'),
  ('8e5ec102-d967-54bc-b370-1a067286ec4a', 31, 'C'),
  ('8e5ec102-d967-54bc-b370-1a067286ec4a', 32, 'P'),
  ('8e5ec102-d967-54bc-b370-1a067286ec4a', 33, 'P'),
  ('8e5ec102-d967-54bc-b370-1a067286ec4a', 34, 'C'),
  ('8e5ec102-d967-54bc-b370-1a067286ec4a', 35, 'C'),
  ('8e5ec102-d967-54bc-b370-1a067286ec4a', 36, 'C'),
  ('8e5ec102-d967-54bc-b370-1a067286ec4a', 37, 'P'),
  ('8e5ec102-d967-54bc-b370-1a067286ec4a', 38, 'P'),
  ('8e5ec102-d967-54bc-b370-1a067286ec4a', 39, 'NC'),
  ('8e5ec102-d967-54bc-b370-1a067286ec4a', 40, 'C'),
  ('8e5ec102-d967-54bc-b370-1a067286ec4a', 41, 'C'),
  ('8e5ec102-d967-54bc-b370-1a067286ec4a', 42, 'C'),
  ('8e5ec102-d967-54bc-b370-1a067286ec4a', 43, 'NA'),
  ('8e5ec102-d967-54bc-b370-1a067286ec4a', 44, 'P'),
  ('8e5ec102-d967-54bc-b370-1a067286ec4a', 45, 'C'),
  ('8e5ec102-d967-54bc-b370-1a067286ec4a', 46, 'C'),
  ('8e5ec102-d967-54bc-b370-1a067286ec4a', 47, 'C'),
  ('8e5ec102-d967-54bc-b370-1a067286ec4a', 48, 'C'),
  ('8e5ec102-d967-54bc-b370-1a067286ec4a', 49, 'P'),
  ('8e5ec102-d967-54bc-b370-1a067286ec4a', 50, 'C'),
  ('8e5ec102-d967-54bc-b370-1a067286ec4a', 51, 'P'),
  ('8e5ec102-d967-54bc-b370-1a067286ec4a', 52, 'C'),
  ('8e5ec102-d967-54bc-b370-1a067286ec4a', 53, 'P'),
  ('8e5ec102-d967-54bc-b370-1a067286ec4a', 54, 'P'),
  ('8e5ec102-d967-54bc-b370-1a067286ec4a', 55, 'C'),
  ('8e5ec102-d967-54bc-b370-1a067286ec4a', 56, 'C'),
  ('8e5ec102-d967-54bc-b370-1a067286ec4a', 57, 'C'),
  ('8e5ec102-d967-54bc-b370-1a067286ec4a', 58, 'C'),
  ('8e5ec102-d967-54bc-b370-1a067286ec4a', 59, 'P'),
  ('8e5ec102-d967-54bc-b370-1a067286ec4a', 60, 'P'),
  ('8e5ec102-d967-54bc-b370-1a067286ec4a', 61, 'C'),
  ('8e5ec102-d967-54bc-b370-1a067286ec4a', 62, 'P'),
  ('8e5ec102-d967-54bc-b370-1a067286ec4a', 63, 'C'),
  ('8e5ec102-d967-54bc-b370-1a067286ec4a', 64, 'P'),
  ('8e5ec102-d967-54bc-b370-1a067286ec4a', 65, 'C'),
  ('8e5ec102-d967-54bc-b370-1a067286ec4a', 66, 'NA'),
  ('8e5ec102-d967-54bc-b370-1a067286ec4a', 67, 'C'),
  ('8e5ec102-d967-54bc-b370-1a067286ec4a', 68, 'C'),
  ('8e5ec102-d967-54bc-b370-1a067286ec4a', 69, 'C'),
  ('8e5ec102-d967-54bc-b370-1a067286ec4a', 70, 'NA'),
  ('8e5ec102-d967-54bc-b370-1a067286ec4a', 71, 'C'),
  ('8e5ec102-d967-54bc-b370-1a067286ec4a', 72, 'P'),
  ('8e5ec102-d967-54bc-b370-1a067286ec4a', 73, 'P'),
  ('8e5ec102-d967-54bc-b370-1a067286ec4a', 74, 'P'),
  ('8e5ec102-d967-54bc-b370-1a067286ec4a', 75, 'NC'),
  ('8e5ec102-d967-54bc-b370-1a067286ec4a', 76, 'P'),
  ('8e5ec102-d967-54bc-b370-1a067286ec4a', 77, 'C'),
  ('8e5ec102-d967-54bc-b370-1a067286ec4a', 78, 'C'),
  ('8e5ec102-d967-54bc-b370-1a067286ec4a', 79, 'P'),
  ('8e5ec102-d967-54bc-b370-1a067286ec4a', 80, 'NA'),
  ('8e5ec102-d967-54bc-b370-1a067286ec4a', 81, 'NA'),
  ('8e5ec102-d967-54bc-b370-1a067286ec4a', 82, 'C'),
  ('8e5ec102-d967-54bc-b370-1a067286ec4a', 83, 'P'),
  ('8e5ec102-d967-54bc-b370-1a067286ec4a', 84, 'C'),
  ('8e5ec102-d967-54bc-b370-1a067286ec4a', 85, 'P'),
  ('8e5ec102-d967-54bc-b370-1a067286ec4a', 86, 'P'),
  ('8e5ec102-d967-54bc-b370-1a067286ec4a', 87, 'C'),
  ('8e5ec102-d967-54bc-b370-1a067286ec4a', 88, 'P'),
  ('8e5ec102-d967-54bc-b370-1a067286ec4a', 89, 'NA'),
  ('8e5ec102-d967-54bc-b370-1a067286ec4a', 90, 'C'),
  ('8e5ec102-d967-54bc-b370-1a067286ec4a', 91, 'P'),
  ('8e5ec102-d967-54bc-b370-1a067286ec4a', 92, 'P'),
  ('8e5ec102-d967-54bc-b370-1a067286ec4a', 93, 'P'),
  ('8e5ec102-d967-54bc-b370-1a067286ec4a', 94, 'P'),
  ('8e5ec102-d967-54bc-b370-1a067286ec4a', 95, 'NC'),
  ('8e5ec102-d967-54bc-b370-1a067286ec4a', 96, 'C'),
  ('8e5ec102-d967-54bc-b370-1a067286ec4a', 97, 'C'),
  ('8e5ec102-d967-54bc-b370-1a067286ec4a', 98, 'P'),
  ('8e5ec102-d967-54bc-b370-1a067286ec4a', 99, 'C'),
  ('8e5ec102-d967-54bc-b370-1a067286ec4a', 100, 'P'),
  ('8e5ec102-d967-54bc-b370-1a067286ec4a', 101, 'P'),
  ('8e5ec102-d967-54bc-b370-1a067286ec4a', 102, 'NC'),
  ('8e5ec102-d967-54bc-b370-1a067286ec4a', 103, 'P'),
  ('8e5ec102-d967-54bc-b370-1a067286ec4a', 104, 'C'),
  ('8e5ec102-d967-54bc-b370-1a067286ec4a', 105, 'C'),
  ('8e5ec102-d967-54bc-b370-1a067286ec4a', 106, 'C'),
  ('8e5ec102-d967-54bc-b370-1a067286ec4a', 107, 'NC'),
  ('8e5ec102-d967-54bc-b370-1a067286ec4a', 108, 'P'),
  ('8e5ec102-d967-54bc-b370-1a067286ec4a', 109, 'P'),
  ('8e5ec102-d967-54bc-b370-1a067286ec4a', 110, 'NC'),
  ('8e5ec102-d967-54bc-b370-1a067286ec4a', 111, 'P'),
  ('8e5ec102-d967-54bc-b370-1a067286ec4a', 112, 'NC'),
  ('8e5ec102-d967-54bc-b370-1a067286ec4a', 113, 'P'),
  ('8e5ec102-d967-54bc-b370-1a067286ec4a', 114, 'C'),
  ('8e5ec102-d967-54bc-b370-1a067286ec4a', 115, 'P'),
  ('8e5ec102-d967-54bc-b370-1a067286ec4a', 116, 'P'),
  ('8e5ec102-d967-54bc-b370-1a067286ec4a', 117, 'P'),
  ('8e5ec102-d967-54bc-b370-1a067286ec4a', 118, 'P'),
  ('8e5ec102-d967-54bc-b370-1a067286ec4a', 119, 'P'),
  ('8e5ec102-d967-54bc-b370-1a067286ec4a', 120, 'C');

insert into iperc_version (id, empresa_id, anio, version, estado, aprobado_por, aprobado_en) values
  ('8b6163ca-eb22-556c-8db5-75478666a07b', 'cd37147b-c5c0-5863-a5ef-a377924adfb3', 2026, 1, 'APROBADO', '8902c33a-40a4-5f7c-b4fc-44da76c680ad', '2026-03-10'),
  ('7427237d-fb18-5cb0-9185-447b5a5435b3', 'cd37147b-c5c0-5863-a5ef-a377924adfb3', 2026, 2, 'BORRADOR', NULL, NULL),
  ('689046c5-230a-532a-b4a0-cf750bd7f637', '8e5ec102-d967-54bc-b370-1a067286ec4a', 2026, 1, 'APROBADO', '99af0518-7a54-5f07-94e5-b8fb305278c0', '2026-02-20'),
  ('b41ab34e-ab5d-52d3-bc38-2505d058308b', '8e5ec102-d967-54bc-b370-1a067286ec4a', 2026, 2, 'BORRADOR', NULL, NULL);

insert into iperc_fila (id, empresa_id, iperc_id, codigo, tarea_id, peligro_id, n_expuestos, eval_inicial, nivel_inicial, clasif_inicial, significativo, eval_residual, nivel_residual, clasif_residual, registrado_en, fuente) values
  ('9956bddd-25aa-533a-bf8e-5e293ffd6ec9', 'cd37147b-c5c0-5863-a5ef-a377924adfb3', '8b6163ca-eb22-556c-8db5-75478666a07b', 'IPERC-C01', 'ab8dd1fe-d28a-5540-b472-71b77849ff60', '5a0be95c-b5a8-5e8f-aa58-9787348701df', NULL, '{"lesion": 2, "propiedad": 4, "proceso": 4, "severidad": 2, "prob": "B", "modificada": false}'::jsonb, 5, 'Alto', true, '{"lesion": 2, "propiedad": 4, "proceso": 4, "severidad": 2, "prob": "D", "modificada": false}'::jsonb, 12, 'Medio', '2026-03-02T00:00:00-05:00'::timestamptz, 'Supuesto'),
  ('20073d40-fd1d-58fb-9d34-76166669f521', 'cd37147b-c5c0-5863-a5ef-a377924adfb3', '8b6163ca-eb22-556c-8db5-75478666a07b', 'IPERC-C02', '5001e0b7-22ac-598d-a5da-bef3e4adcda0', '6358c075-7fe5-5b60-9bfc-5ed464412d54', NULL, '{"lesion": 1, "propiedad": 3, "proceso": 3, "severidad": 1, "prob": "C", "modificada": false}'::jsonb, 4, 'Alto', true, '{"lesion": 1, "propiedad": 3, "proceso": 3, "severidad": 1, "prob": "E", "modificada": false}'::jsonb, 11, 'Medio', '2026-03-02T00:00:00-05:00'::timestamptz, 'INT002 (EV010: trámite de carné postergado)'),
  ('621f4018-f95c-5e4d-8a01-00be702ea56f', 'cd37147b-c5c0-5863-a5ef-a377924adfb3', '8b6163ca-eb22-556c-8db5-75478666a07b', 'IPERC-C03', 'f4186636-8de4-5b42-b253-adcce6699614', 'b3e21a27-6e10-5974-9679-38c61d24c931', NULL, '{"lesion": 2, "propiedad": 5, "proceso": 4, "severidad": 2, "prob": "C", "modificada": false}'::jsonb, 8, 'Alto', true, '{"lesion": 2, "propiedad": 5, "proceso": 4, "severidad": 2, "prob": "E", "modificada": false}'::jsonb, 16, 'Bajo', '2026-03-02T00:00:00-05:00'::timestamptz, 'Supuesto'),
  ('8fd78c18-06df-5b0f-a871-156e9c45cc29', 'cd37147b-c5c0-5863-a5ef-a377924adfb3', '8b6163ca-eb22-556c-8db5-75478666a07b', 'IPERC-C04', 'f99722f5-7e31-5542-a64c-27919d1cd668', '93e13e57-a77b-50c4-be0d-5a62f1c7c38a', NULL, '{"lesion": 2, "propiedad": 3, "proceso": 4, "severidad": 2, "prob": "C", "modificada": false}'::jsonb, 8, 'Alto', true, '{"lesion": 2, "propiedad": 3, "proceso": 4, "severidad": 2, "prob": "D", "modificada": false}'::jsonb, 12, 'Medio', '2026-03-02T00:00:00-05:00'::timestamptz, 'INT002 (EV010: señalización de curvas)'),
  ('4f596630-2cd5-5aa9-a627-55ac40dc63a9', 'cd37147b-c5c0-5863-a5ef-a377924adfb3', '8b6163ca-eb22-556c-8db5-75478666a07b', 'IPERC-C05', '8d9a8a18-c0f1-535f-a16f-bb32d710988d', '14e5a795-6072-51b9-827c-3d05791eda4d', NULL, '{"lesion": 3, "propiedad": 5, "proceso": 5, "severidad": 3, "prob": "B", "modificada": false}'::jsonb, 9, 'Medio', true, '{"lesion": 3, "propiedad": 5, "proceso": 5, "severidad": 3, "prob": "C", "modificada": false}'::jsonb, 13, 'Medio', '2026-03-02T00:00:00-05:00'::timestamptz, 'Supuesto (caso de alerta residual: 9 → 13 sigue en Medio)'),
  ('2b231b9a-8d17-5b3a-b153-d4b79e231822', 'cd37147b-c5c0-5863-a5ef-a377924adfb3', '8b6163ca-eb22-556c-8db5-75478666a07b', 'IPERC-C06', '8d9a8a18-c0f1-535f-a16f-bb32d710988d', 'e0e7d6c7-a645-570f-89fc-1cb46e80bcfb', NULL, '{"lesion": 3, "propiedad": 5, "proceso": 5, "severidad": 3, "prob": "B", "modificada": false}'::jsonb, 9, 'Medio', true, '{"lesion": 3, "propiedad": 5, "proceso": 5, "severidad": 3, "prob": "D", "modificada": false}'::jsonb, 17, 'Bajo', '2026-03-02T00:00:00-05:00'::timestamptz, 'Supuesto'),
  ('90ef79b1-5b11-54b5-8f81-8ab0fd60a288', 'cd37147b-c5c0-5863-a5ef-a377924adfb3', '8b6163ca-eb22-556c-8db5-75478666a07b', 'IPERC-C07', 'bc982b24-e087-5451-95a0-fc3861e098f3', '60431bf6-8b91-5d5d-85b7-ce57efd39eed', NULL, '{"lesion": 3, "propiedad": 4, "proceso": 3, "severidad": 3, "prob": "C", "modificada": false}'::jsonb, 13, 'Medio', true, '{"lesion": 3, "propiedad": 4, "proceso": 3, "severidad": 3, "prob": "E", "modificada": false}'::jsonb, 20, 'Bajo', '2026-03-02T00:00:00-05:00'::timestamptz, 'Supuesto'),
  ('e10c2eec-cdd8-5009-9487-a8888519abb8', 'cd37147b-c5c0-5863-a5ef-a377924adfb3', '8b6163ca-eb22-556c-8db5-75478666a07b', 'IPERC-C08', '130bab44-9ac2-51b6-9315-00fc71dfdee5', '20629d0d-e96e-5883-a075-7ae121cf9d06', NULL, '{"lesion": 4, "propiedad": 5, "proceso": 5, "severidad": 4, "prob": "C", "modificada": false}'::jsonb, 18, 'Bajo', false, NULL, NULL, NULL, '2026-03-02T00:00:00-05:00'::timestamptz, 'Supuesto'),
  ('0bded31b-8481-510c-b865-98b05dff3e91', 'cd37147b-c5c0-5863-a5ef-a377924adfb3', '7427237d-fb18-5cb0-9185-447b5a5435b3', 'IPERC-C09', '8c3d9633-25aa-5c8e-8152-4d2e73449905', '5a0be95c-b5a8-5e8f-aa58-9787348701df', NULL, '{"lesion": 2, "propiedad": 4, "proceso": 3, "severidad": 2, "prob": "B", "modificada": false}'::jsonb, 5, 'Alto', true, '{"lesion": 2, "propiedad": 4, "proceso": 3, "severidad": 2, "prob": "D", "modificada": false}'::jsonb, 12, 'Medio', '2026-11-06 18:30:00-05:00'::timestamptz, 'Supuesto (escenario RF-36)'),
  ('a94b8843-6c6f-5bb6-baec-ce711b499efe', '8e5ec102-d967-54bc-b370-1a067286ec4a', '689046c5-230a-532a-b4a0-cf750bd7f637', 'IPERC-W01', '2df6560e-fda7-52c9-896f-d315e96cbccb', 'cec9659e-ee72-599a-be3b-5b1ae91c6d49', 29, '{"A": 3, "B": 2, "C": 2, "D": 3, "S": 2}'::jsonb, 20, 'Importante', true, '{"A": 3, "B": 1, "C": 1, "D": 3, "S": 2}'::jsonb, 16, 'Moderado', '2026-02-10T00:00:00-05:00'::timestamptz, 'INT001 (trabajo de oficina)'),
  ('c27b58ef-05c1-58cc-8848-962b5cec3d87', '8e5ec102-d967-54bc-b370-1a067286ec4a', '689046c5-230a-532a-b4a0-cf750bd7f637', 'IPERC-W02', 'b25d611f-5a2f-526f-8195-408b47784e82', '01e4fa4f-b7f5-583f-afd0-cd8d53ccf862', 11, '{"A": 2, "B": 1, "C": 2, "D": 3, "S": 2}'::jsonb, 16, 'Moderado', true, '{"A": 2, "B": 1, "C": 1, "D": 3, "S": 2}'::jsonb, 14, 'Moderado', '2026-02-10T00:00:00-05:00'::timestamptz, 'INT001 (conexiones, cortocircuito)'),
  ('894192d2-a9f7-5308-b00a-c78eaa9f5458', '8e5ec102-d967-54bc-b370-1a067286ec4a', '689046c5-230a-532a-b4a0-cf750bd7f637', 'IPERC-W03', 'fce9f8f4-4881-521b-bbc9-d0a417070cc5', 'fbe37a2e-7035-574a-a757-f78912056e44', 40, '{"A": 3, "B": 2, "C": 2, "D": 3, "S": 1}'::jsonb, 10, 'Moderado', true, '{"A": 3, "B": 2, "C": 1, "D": 3, "S": 1}'::jsonb, 9, 'Moderado', '2026-02-10T00:00:00-05:00'::timestamptz, 'INT001 (stickers pendientes)'),
  ('61759e0f-1e0b-5de8-bde7-944dd72e7d37', '8e5ec102-d967-54bc-b370-1a067286ec4a', '689046c5-230a-532a-b4a0-cf750bd7f637', 'IPERC-W04', 'a228ba90-9544-5a33-84f2-05bf6e5dd1f8', '39f8c642-a731-56ba-8eda-b0f7ad595ab5', 1, '{"A": 1, "B": 2, "C": 2, "D": 3, "S": 1}'::jsonb, 8, 'Tolerable', false, NULL, NULL, NULL, '2026-02-10T00:00:00-05:00'::timestamptz, 'INT001 (riesgos de limpieza)'),
  ('dae903db-2d43-548e-82f3-60cd9572c8a4', '8e5ec102-d967-54bc-b370-1a067286ec4a', '689046c5-230a-532a-b4a0-cf750bd7f637', 'IPERC-W05', 'a228ba90-9544-5a33-84f2-05bf6e5dd1f8', 'a0ef9bff-15a4-5768-bb25-ce7fdc2a8a7e', 40, '{"A": 3, "B": 2, "C": 2, "D": 3, "S": 2}'::jsonb, 20, 'Importante', true, '{"A": 3, "B": 1, "C": 1, "D": 3, "S": 2}'::jsonb, 16, 'Moderado', '2026-02-10T00:00:00-05:00'::timestamptz, 'INT001 (riesgos de limpieza)'),
  ('ffd80fac-8cc8-5fbe-96bc-d2e16c63c843', '8e5ec102-d967-54bc-b370-1a067286ec4a', '689046c5-230a-532a-b4a0-cf750bd7f637', 'IPERC-W06', '182105df-356b-51f7-8773-e81ed8505c77', '35e202a1-547a-5186-8947-38da0dca2a1f', 40, '{"A": 3, "B": 2, "C": 2, "D": 1, "S": 3}'::jsonb, 24, 'Importante', true, '{"A": 3, "B": 1, "C": 1, "D": 1, "S": 3}'::jsonb, 18, 'Importante', '2026-02-10T00:00:00-05:00'::timestamptz, 'INT001 (sismo, brigadistas)'),
  ('97c9b0e4-8e28-5860-a378-0020073f0146', '8e5ec102-d967-54bc-b370-1a067286ec4a', '689046c5-230a-532a-b4a0-cf750bd7f637', 'IPERC-W07', '7a0069d4-4725-5ff3-bd12-47151b43792b', 'd290946f-7d9f-513b-b50d-8266be9168d5', 6, '{"A": 2, "B": 2, "C": 2, "D": 2, "S": 3}'::jsonb, 24, 'Importante', true, '{"A": 2, "B": 1, "C": 1, "D": 1, "S": 3}'::jsonb, 15, 'Moderado', '2026-02-10T00:00:00-05:00'::timestamptz, 'INT001 (seguridad fuera de la oficina)'),
  ('71bd9b80-bc62-5289-97c7-29b4b8841f2d', '8e5ec102-d967-54bc-b370-1a067286ec4a', 'b41ab34e-ab5d-52d3-bc38-2505d058308b', 'IPERC-W08', 'f688e568-05ab-506c-a0bf-b8b3e1695f12', '3706c5da-38f0-561c-b8f9-f40897f1fbf0', 40, '{"A": 3, "B": 3, "C": 2, "D": 3, "S": 1}'::jsonb, 11, 'Moderado', true, '{"A": 3, "B": 1, "C": 1, "D": 3, "S": 1}'::jsonb, 8, 'Tolerable', '2026-10-29T00:00:00-05:00'::timestamptz, 'INT001 (incidente con cuchillo); creada con RF-34');

insert into control (id, empresa_id, fila_id, codigo, jerarquia, descripcion, existente) values
  ('c1b9d72d-07e3-59ed-897c-4ce3ec68f4ec', 'cd37147b-c5c0-5863-a5ef-a377924adfb3', '9956bddd-25aa-533a-bf8e-5e293ffd6ec9', 'IPERC-C01', 'ADMINISTRATIVO', 'Desatado con barretilla y PETS', true),
  ('3167a0a5-a455-509e-bf54-e2e10c66a02c', 'cd37147b-c5c0-5863-a5ef-a377924adfb3', '9956bddd-25aa-533a-bf8e-5e293ffd6ec9', 'IPERC-C01', 'INGENIERIA', 'Sostenimiento sistemático con pernos y malla', false),
  ('14112500-e59a-5ebc-9384-1ddea275b02f', 'cd37147b-c5c0-5863-a5ef-a377924adfb3', '9956bddd-25aa-533a-bf8e-5e293ffd6ec9', 'IPERC-C01', 'ADMINISTRATIVO', 'Capacitación en desatado y verificación del jefe de guardia', false),
  ('d6dc4537-b041-5632-a7af-5fde20bdfbe7', 'cd37147b-c5c0-5863-a5ef-a377924adfb3', '20073d40-fd1d-58fb-9d34-76166669f521', 'IPERC-C02', 'ADMINISTRATIVO', 'PETS de voladura', true),
  ('a136c03e-2ff2-513b-a342-a3988880fc4c', 'cd37147b-c5c0-5863-a5ef-a377924adfb3', '20073d40-fd1d-58fb-9d34-76166669f521', 'IPERC-C02', 'EPP', 'Equipo completo', true),
  ('aed59345-10d0-5230-97db-e371f7e41df3', 'cd37147b-c5c0-5863-a5ef-a377924adfb3', '20073d40-fd1d-58fb-9d34-76166669f521', 'IPERC-C02', 'ADMINISTRATIVO', 'Carné vigente para todo el personal que manipula explosivos', false),
  ('aecb02b6-500e-5c6a-be37-1d233d5aceae', 'cd37147b-c5c0-5863-a5ef-a377924adfb3', '20073d40-fd1d-58fb-9d34-76166669f521', 'IPERC-C02', 'ADMINISTRATIVO', 'Vigías y señales en accesos durante la voladura', false),
  ('b83b4bb3-7894-5f00-b5bd-d339549608dc', 'cd37147b-c5c0-5863-a5ef-a377924adfb3', '621f4018-f95c-5e4d-8a01-00be702ea56f', 'IPERC-C03', 'ADMINISTRATIVO', 'Tiempo de espera de 30 minutos', true),
  ('89a5265c-c9ad-5dee-9892-d530bd15138b', 'cd37147b-c5c0-5863-a5ef-a377924adfb3', '621f4018-f95c-5e4d-8a01-00be702ea56f', 'IPERC-C03', 'INGENIERIA', 'Ventilador auxiliar con manga', false),
  ('df6c5ddc-b5b5-5884-b5dc-9adfbcb95762', 'cd37147b-c5c0-5863-a5ef-a377924adfb3', '621f4018-f95c-5e4d-8a01-00be702ea56f', 'IPERC-C03', 'ADMINISTRATIVO', 'Medición con detector de gases antes del ingreso', false),
  ('e93a6c06-9a4e-5130-8ec3-397c5ef443b9', 'cd37147b-c5c0-5863-a5ef-a377924adfb3', '621f4018-f95c-5e4d-8a01-00be702ea56f', 'IPERC-C03', 'EPP', 'Autorrescatador', false),
  ('0cf2a78d-992a-5e31-8db8-af7da4699e99', 'cd37147b-c5c0-5863-a5ef-a377924adfb3', '8fd78c18-06df-5b0f-a871-156e9c45cc29', 'IPERC-C04', 'ADMINISTRATIVO', 'Límite de velocidad indicado verbalmente', true),
  ('461a4c66-3d4d-5ed0-ad0e-78cefe6dbe8f', 'cd37147b-c5c0-5863-a5ef-a377924adfb3', '8fd78c18-06df-5b0f-a871-156e9c45cc29', 'IPERC-C04', 'ADMINISTRATIVO', 'Señales verticales y espejos convexos en curvas', false),
  ('fd1461f7-43aa-5d45-8d42-176465a9400a', 'cd37147b-c5c0-5863-a5ef-a377924adfb3', '8fd78c18-06df-5b0f-a871-156e9c45cc29', 'IPERC-C04', 'INGENIERIA', 'Bermas de seguridad', false),
  ('125bc347-c8b9-57d6-8888-6cdb0c91c7a4', 'cd37147b-c5c0-5863-a5ef-a377924adfb3', '4f596630-2cd5-5aa9-a627-55ac40dc63a9', 'IPERC-C05', 'EPP', 'Tapones auditivos', true),
  ('9144c079-46cf-5f46-a655-1fb2f0d7e16b', 'cd37147b-c5c0-5863-a5ef-a377924adfb3', '4f596630-2cd5-5aa9-a627-55ac40dc63a9', 'IPERC-C05', 'ADMINISTRATIVO', 'Monitoreo de ruido y audiometrías', false),
  ('463aaf41-f751-5ec1-8dc6-bbf509d01ac2', 'cd37147b-c5c0-5863-a5ef-a377924adfb3', '4f596630-2cd5-5aa9-a627-55ac40dc63a9', 'IPERC-C05', 'EPP', 'Protección auditiva doble', false),
  ('215f95cd-813e-546b-acee-c19d68cf5467', 'cd37147b-c5c0-5863-a5ef-a377924adfb3', '2b231b9a-8d17-5b3a-b153-d4b79e231822', 'IPERC-C06', 'ADMINISTRATIVO', 'Riego ocasional del frente', true),
  ('0a45d63a-22d5-5322-a700-140923d89728', 'cd37147b-c5c0-5863-a5ef-a377924adfb3', '2b231b9a-8d17-5b3a-b153-d4b79e231822', 'IPERC-C06', 'INGENIERIA', 'Perforación húmeda', false),
  ('d4d1cc02-b935-5bea-bbaa-83c40e8873a4', 'cd37147b-c5c0-5863-a5ef-a377924adfb3', '2b231b9a-8d17-5b3a-b153-d4b79e231822', 'IPERC-C06', 'EPP', 'Respirador con filtro para polvo', false),
  ('5a2cdf79-f68d-5348-99a0-f8930b8297d7', 'cd37147b-c5c0-5863-a5ef-a377924adfb3', '90ef79b1-5b11-54b5-8f81-8ab0fd60a288', 'IPERC-C07', 'INGENIERIA', 'Guardas parciales', true),
  ('e785b211-265d-50dc-9aaf-c045ca28e94d', 'cd37147b-c5c0-5863-a5ef-a377924adfb3', '90ef79b1-5b11-54b5-8f81-8ab0fd60a288', 'IPERC-C07', 'INGENIERIA', 'Completar guardas y parada de emergencia', false),
  ('c49c66bc-646a-5efe-b469-088a138629fd', 'cd37147b-c5c0-5863-a5ef-a377924adfb3', '90ef79b1-5b11-54b5-8f81-8ab0fd60a288', 'IPERC-C07', 'ADMINISTRATIVO', 'Bloqueo y etiquetado', false),
  ('0239b5bc-4ee2-56d9-b853-f71a5ca168f1', 'cd37147b-c5c0-5863-a5ef-a377924adfb3', 'e10c2eec-cdd8-5009-9487-a8888519abb8', 'IPERC-C08', 'ADMINISTRATIVO', 'Hojas de datos de seguridad disponibles', true),
  ('05f1c5fc-0441-51dd-a1d2-f87e78c4e669', 'cd37147b-c5c0-5863-a5ef-a377924adfb3', 'e10c2eec-cdd8-5009-9487-a8888519abb8', 'IPERC-C08', 'EPP', 'Guantes y lentes', true),
  ('7ea01d2a-c839-596b-9f03-9495b45360af', 'cd37147b-c5c0-5863-a5ef-a377924adfb3', '0bded31b-8481-510c-b865-98b05dff3e91', 'IPERC-C09', 'ADMINISTRATIVO', 'Restringir el acceso hasta sostener la labor', false),
  ('157cea56-4002-527c-8321-8155065e8193', 'cd37147b-c5c0-5863-a5ef-a377924adfb3', '0bded31b-8481-510c-b865-98b05dff3e91', 'IPERC-C09', 'INGENIERIA', 'Sostenimiento con cuadros antes de reanudar el tránsito', false),
  ('b7873ded-6c59-5481-81a3-8d162232d5e4', '8e5ec102-d967-54bc-b370-1a067286ec4a', 'a94b8843-6c6f-5bb6-baec-ce711b499efe', 'IPERC-W01', 'INGENIERIA', 'Sillas regulables y soportes de monitor', false),
  ('2e1de17b-3dc8-5f89-b03c-0cb78b254edd', '8e5ec102-d967-54bc-b370-1a067286ec4a', 'a94b8843-6c6f-5bb6-baec-ce711b499efe', 'IPERC-W01', 'ADMINISTRATIVO', 'Pausas activas y evaluación ergonómica', false),
  ('6f7ab428-3a46-5d49-a920-6ae537c3eb84', '8e5ec102-d967-54bc-b370-1a067286ec4a', 'c27b58ef-05c1-58cc-8848-962b5cec3d87', 'IPERC-W02', 'INGENIERIA', 'Tablero con interruptores termomagnéticos', true),
  ('03ab91e2-c4cf-57b1-ab91-56264e1df21d', '8e5ec102-d967-54bc-b370-1a067286ec4a', 'c27b58ef-05c1-58cc-8848-962b5cec3d87', 'IPERC-W02', 'ADMINISTRATIVO', 'Prohibir extensiones en cascada e inspección semestral', false),
  ('a93ccce6-2517-53a9-b943-b01278fab109', '8e5ec102-d967-54bc-b370-1a067286ec4a', '894192d2-a9f7-5308-b00a-c78eaa9f5458', 'IPERC-W03', 'ADMINISTRATIVO', 'Stickers de advertencia en microondas y cafetera', false),
  ('ebb06d55-014b-5f30-99c9-1015fbe66fd9', '8e5ec102-d967-54bc-b370-1a067286ec4a', '61759e0f-1e0b-5de8-bde7-944dd72e7d37', 'IPERC-W04', 'EPP', 'Guantes', true),
  ('2f0f1f2b-ec19-5484-848a-a7eb0a2c7173', '8e5ec102-d967-54bc-b370-1a067286ec4a', 'dae903db-2d43-548e-82f3-60cd9572c8a4', 'IPERC-W05', 'ADMINISTRATIVO', 'Señal de piso mojado y limpieza fuera de horas punta', false),
  ('f851941e-02cc-5d55-81da-8dac4fe44289', '8e5ec102-d967-54bc-b370-1a067286ec4a', 'ffd80fac-8cc8-5fbe-96bc-d2e16c63c843', 'IPERC-W06', 'ADMINISTRATIVO', 'Plan de respuesta ante emergencias', true),
  ('8be64aef-49eb-5b18-b165-b9b786d3f6c6', '8e5ec102-d967-54bc-b370-1a067286ec4a', 'ffd80fac-8cc8-5fbe-96bc-d2e16c63c843', 'IPERC-W06', 'INGENIERIA', 'Anclaje de estantes', false),
  ('e27e565b-5c1a-50fa-a478-885c8b02eb77', '8e5ec102-d967-54bc-b370-1a067286ec4a', 'ffd80fac-8cc8-5fbe-96bc-d2e16c63c843', 'IPERC-W06', 'ADMINISTRATIVO', 'Brigada formalizada y 2 simulacros al año', false),
  ('e771e9a6-f1f0-5764-b149-8b238079d713', '8e5ec102-d967-54bc-b370-1a067286ec4a', '97c9b0e4-8e28-5860-a378-0020073f0146', 'IPERC-W07', 'ELIMINACION', 'Reuniones virtuales cuando sea posible', false),
  ('638ed67e-e753-5ae1-9295-b9bf3944eca2', '8e5ec102-d967-54bc-b370-1a067286ec4a', '97c9b0e4-8e28-5860-a378-0020073f0146', 'IPERC-W07', 'ADMINISTRATIVO', 'Capacitación en seguridad vial', false),
  ('96e4f6c2-3272-51fd-9c2a-8048b2c3f503', '8e5ec102-d967-54bc-b370-1a067286ec4a', '71bd9b80-bc62-5289-97c7-29b4b8841f2d', 'IPERC-W08', 'SUSTITUCION', 'Cuchillo especializado para pan', false),
  ('22081672-7b8e-53c7-862e-83e8992a1261', '8e5ec102-d967-54bc-b370-1a067286ec4a', '71bd9b80-bc62-5289-97c7-29b4b8841f2d', 'IPERC-W08', 'ADMINISTRATIVO', 'Indicar el uso de cada cuchillo', false);

insert into hito_documento (id, empresa_id, tipo, titulo, estado, fecha, responsable_id, ref_semilla, estado_dato, fuente) values
  ('03de1539-edbe-56b9-9f75-1be7a1453470', 'cd37147b-c5c0-5863-a5ef-a377924adfb3', 'DIAGNOSTICO', 'Diagnóstico de línea base completado (respuestas en la hoja Diagnóstico)', 'Completado', '2026-02-15', '8902c33a-40a4-5f7c-b4fc-44da76c680ad', 'E-C01', 'S', 'Supuesto basado en INT002'),
  ('43634a1d-0e38-541b-adef-a12066378913', 'cd37147b-c5c0-5863-a5ef-a377924adfb3', 'IPERC', 'IPERC de línea base 2026 v1 (metodología minería), 8 filas', 'Aprobado', '2026-03-10', '8902c33a-40a4-5f7c-b4fc-44da76c680ad', 'E-C02', 'S', 'Supuesto'),
  ('c17754a3-7646-5a2c-9119-91346b9f8a63', 'cd37147b-c5c0-5863-a5ef-a377924adfb3', 'PLAN', 'Programa anual de SSO 2026 v1', 'Aprobado', '2026-03-20', '8902c33a-40a4-5f7c-b4fc-44da76c680ad', 'E-C03', 'V', 'INT002 (programa anual)'),
  ('667b6224-de08-5d47-b9e2-287c88258278', 'cd37147b-c5c0-5863-a5ef-a377924adfb3', 'IPERC', 'IPERC 2026 v2 en borrador por apertura de nueva labor en Caracolito II', 'Borrador', '2026-11-06', '8902c33a-40a4-5f7c-b4fc-44da76c680ad', 'E-C12', 'S', 'Supuesto (escenario RF-36)'),
  ('3c4171d1-c3e1-54c7-b341-6819e19db212', '8e5ec102-d967-54bc-b370-1a067286ec4a', 'DIAGNOSTICO', 'Diagnóstico de línea base completado (respuestas en la hoja Diagnóstico)', 'Completado', '2026-01-30', '99af0518-7a54-5f07-94e5-b8fb305278c0', 'E-W01', 'S', 'Supuesto basado en INT001'),
  ('ec2d9964-6aa4-58d2-83fe-0db4d25969f3', '8e5ec102-d967-54bc-b370-1a067286ec4a', 'IPERC', 'IPERC 2026 v1 (metodología MTPE), 7 filas de muestra', 'Aprobado', '2026-02-20', '99af0518-7a54-5f07-94e5-b8fb305278c0', 'E-W02', 'V', 'INT001 (IPERC revisada y aprobada por el comité)'),
  ('215ac295-a9bc-5f0a-9f3f-b71caf69463e', '8e5ec102-d967-54bc-b370-1a067286ec4a', 'PLAN', 'Plan anual de SST 2026 v1', 'Aprobado', '2026-03-05', '99af0518-7a54-5f07-94e5-b8fb305278c0', 'E-W03', 'V', 'INT001 (plan y checklist)'),
  ('4d24ed0c-47fa-5c02-bde8-a54f78552db0', '8e5ec102-d967-54bc-b370-1a067286ec4a', 'IPERC', 'IPERC 2026 v2 en borrador creada con «Agregar a la IPERC» desde el hallazgo E-W15 (fila IPERC-W08 precargada)', 'Borrador', '2026-10-29', '99af0518-7a54-5f07-94e5-b8fb305278c0', 'E-W17', 'S', 'INT001 (riesgos de cocina añadidos)');

insert into hallazgo (id, empresa_id, origen, descripcion, ubicacion, criticidad, fecha, estado, fila_id, registrado_por, ref_semilla, estado_dato) values
  ('c42f8d4b-31d6-5f7a-8cf5-13e2cd6a3e49', 'cd37147b-c5c0-5863-a5ef-a377924adfb3', 'INSPECCION', 'Curvas sin señalización en la vía Caracolito II – Planta de beneficio (inspección del 20/08/2026). Criticidad alta', NULL, 'Alta', '2026-08-20', 'CON_ACCION', '8fd78c18-06df-5b0f-a871-156e9c45cc29', '8902c33a-40a4-5f7c-b4fc-44da76c680ad', 'E-C05', 'V'),
  ('417815b0-ba8f-515f-9ff2-b114a6898bee', '8e5ec102-d967-54bc-b370-1a067286ec4a', 'AUDITORIA', 'Carta de SUNAFIL: exige plan de contingencias y emergencias, brigada formada y capacitada y simulacros (15/09/2026)', NULL, NULL, '2026-09-15', 'CON_ACCION', NULL, '99af0518-7a54-5f07-94e5-b8fb305278c0', 'E-W04', 'V'),
  ('483e93aa-2b5d-5429-bc37-118701f313e8', '8e5ec102-d967-54bc-b370-1a067286ec4a', 'OBSERVACION', 'Incidente en la cocina: corte en la mano al usar un cuchillo inadecuado (observación del 28/10/2026)', NULL, NULL, '2026-10-28', 'CON_ACCION', '71bd9b80-bc62-5289-97c7-29b4b8841f2d', '99af0518-7a54-5f07-94e5-b8fb305278c0', 'E-W15', 'S');

insert into actividad (id, empresa_id, objetivo, origen, control_id, hallazgo_id, plantilla_codigo, brecha_item, descripcion, responsable_id, fecha_fin, estado, ref_semilla, estado_dato) values
  ('2715157e-2acd-50e1-b70e-0fae3e4cce49', 'cd37147b-c5c0-5863-a5ef-a377924adfb3', 'Controlar los riesgos significativos', 'CONTROL', 'aed59345-10d0-5230-97db-e371f7e41df3', NULL, NULL, NULL, 'Tramitar el carné para el personal que manipula explosivos', 'd204909c-c2e9-55b3-b918-89600c06d088', '2026-06-30', 'PROGRAMADA', 'E-C04', 'V'),
  ('d1796d93-f025-597f-9fd3-8beb0ad80451', 'cd37147b-c5c0-5863-a5ef-a377924adfb3', 'Cerrar brechas del sistema de gestión', 'BASE', NULL, NULL, 'AB-M01', NULL, 'Reunión ordinaria del Comité de SSO – octubre', '8902c33a-40a4-5f7c-b4fc-44da76c680ad', '2026-10-09', 'VERIFICADA', 'E-C07', 'S'),
  ('bb883c75-9b87-5731-ac62-bb900a31a685', 'cd37147b-c5c0-5863-a5ef-a377924adfb3', 'Cerrar brechas del sistema de gestión', 'BASE', NULL, NULL, 'AB-M01', NULL, 'Reunión ordinaria del Comité de SSO – noviembre', '8902c33a-40a4-5f7c-b4fc-44da76c680ad', '2026-11-10', 'PROGRAMADA', 'E-C09', 'S'),
  ('88907284-fc96-5f8d-b2f9-5174c845d9dd', 'cd37147b-c5c0-5863-a5ef-a377924adfb3', 'Controlar los riesgos significativos', 'BASE', NULL, NULL, 'AB-M06', NULL, 'Inspección de extintores y botiquines – octubre (formato fotografiado)', '8902c33a-40a4-5f7c-b4fc-44da76c680ad', '2026-10-31', 'VERIFICADA', 'E-C10', 'S'),
  ('3e89d3f2-c3e3-5b23-8915-3e87d61567f5', 'cd37147b-c5c0-5863-a5ef-a377924adfb3', 'Cerrar brechas del sistema de gestión', 'BRECHA', NULL, NULL, NULL, 92, 'Elaborar el procedimiento de gestión del cambio', '8902c33a-40a4-5f7c-b4fc-44da76c680ad', '2026-06-30', 'EN_CURSO', 'E-C11', 'S'),
  ('ef9cf140-3e42-5083-ad6c-c4b98a35a0d7', 'cd37147b-c5c0-5863-a5ef-a377924adfb3', 'Controlar los riesgos significativos', 'BASE', NULL, NULL, 'AB-M11', NULL, 'Simulacro de emergencia en interior mina – IV trimestre', 'a511194f-5628-505b-9aa2-1666af83ddbe', '2026-12-05', 'PROGRAMADA', 'E-C14', 'S'),
  ('74061b0c-f303-51fe-9600-ca2e8ee9e443', '8e5ec102-d967-54bc-b370-1a067286ec4a', 'Controlar los riesgos significativos', 'BASE', NULL, NULL, 'AB-G04', NULL, 'Simulacro de sismo (2.º del año)', '82e24213-dafa-5849-92d5-2416638a570d', '2026-11-20', 'PROGRAMADA', 'E-W08', 'V'),
  ('f5a8490a-8f30-5dad-afed-157b9fd4b7fb', '8e5ec102-d967-54bc-b370-1a067286ec4a', 'Controlar los riesgos significativos', 'BASE', NULL, NULL, 'AB-G06', NULL, 'Inspección de extintores y botiquín – octubre (botiquín con alcohol y gasas vencidos)', '82e24213-dafa-5849-92d5-2416638a570d', '2026-10-15', 'PROGRAMADA', 'E-W09', 'V'),
  ('42bafabe-577a-5b48-a131-605aa0f1b69d', '8e5ec102-d967-54bc-b370-1a067286ec4a', 'Controlar los riesgos significativos', 'BASE', NULL, NULL, 'AB-G08', NULL, 'Mantenimiento de alarmas, detectores y rociadores – II semestre', '82e24213-dafa-5849-92d5-2416638a570d', '2026-09-30', 'EN_CURSO', 'E-W10', 'V'),
  ('a5945523-7bab-5c63-a55a-4820d06df965', '8e5ec102-d967-54bc-b370-1a067286ec4a', 'Controlar los riesgos significativos', 'BASE', NULL, NULL, 'AB-G01', NULL, 'Capacitación en SST 3 de 4', '374efafc-0bb0-5e54-8763-bad3277ad758', '2026-09-30', 'VERIFICADA', 'E-W11', 'S'),
  ('d65c9eb3-f0aa-50e9-a15d-2c0bdf008207', '8e5ec102-d967-54bc-b370-1a067286ec4a', 'Controlar los riesgos significativos', 'BASE', NULL, NULL, 'AB-G01', NULL, 'Capacitación en SST 4 de 4', '374efafc-0bb0-5e54-8763-bad3277ad758', '2026-12-10', 'PROGRAMADA', 'E-W12', 'S'),
  ('f549aa68-6a7a-5a85-85b7-fed10c5d85b4', '8e5ec102-d967-54bc-b370-1a067286ec4a', 'Cerrar brechas del sistema de gestión', 'BRECHA', NULL, NULL, NULL, 53, 'Inducción en SST a los nuevos ingresos del segundo semestre', '374efafc-0bb0-5e54-8763-bad3277ad758', '2026-08-31', 'PROGRAMADA', 'E-W13', 'V'),
  ('ac93994b-414c-50b9-9e2d-5df06333b302', '8e5ec102-d967-54bc-b370-1a067286ec4a', 'Controlar los riesgos significativos', 'CONTROL', 'a93ccce6-2517-53a9-b943-b01278fab109', NULL, NULL, NULL, 'Colocar stickers de advertencia en el microondas y la cafetera', '82e24213-dafa-5849-92d5-2416638a570d', '2026-10-31', 'PROGRAMADA', 'E-W14', 'V'),
  ('5094dfc1-9497-5a37-a401-354d227288b1', '8e5ec102-d967-54bc-b370-1a067286ec4a', 'Cerrar brechas del sistema de gestión', 'BASE', NULL, NULL, 'AB-G03', NULL, 'Reunión del Comité de SST (quincenal)', '99af0518-7a54-5f07-94e5-b8fb305278c0', '2026-11-12', 'PROGRAMADA', 'E-W18', 'V');

insert into accion (id, empresa_id, hallazgo_id, control_id, descripcion, inmediata, responsable_id, vence_en, estado, verificada_por, ref_semilla, estado_dato) values
  ('d43fffa1-2878-5fa9-9044-bd5b28170beb', 'cd37147b-c5c0-5863-a5ef-a377924adfb3', 'c42f8d4b-31d6-5f7a-8cf5-13e2cd6a3e49', NULL, 'Instalar señalización vertical y espejos convexos en las curvas de la vía', false, 'ea84727a-4ba2-58a8-99f1-49646d6f3406', '2026-09-30T23:59:00-05:00'::timestamptz, 'ASIGNADA', NULL, 'E-C06', 'V'),
  ('83a6c27f-467b-5c25-8c07-7deae84d253a', 'cd37147b-c5c0-5863-a5ef-a377924adfb3', NULL, '7ea01d2a-c839-596b-9f03-9495b45360af', 'Restringir el acceso y sostener la nueva labor antes de reanudar el tránsito (riesgo Alto, nivel 5)', true, 'a511194f-5628-505b-9aa2-1666af83ddbe', '2026-11-07T18:30:00-05:00'::timestamptz, 'EN_IMPLEMENTACION', NULL, 'E-C13', 'S'),
  ('d165500e-a79c-50c1-86aa-df052d19a7e0', '8e5ec102-d967-54bc-b370-1a067286ec4a', '417815b0-ba8f-515f-9ff2-b114a6898bee', NULL, 'Actualizar el plan de respuesta ante emergencias', false, '99af0518-7a54-5f07-94e5-b8fb305278c0', '2026-09-25T23:59:00-05:00'::timestamptz, 'VERIFICADA', '44241aa2-eb43-5216-aca9-f9a818da767e', 'E-W05', 'V'),
  ('6581df62-1954-5dbe-bc6b-a53c86995d2c', '8e5ec102-d967-54bc-b370-1a067286ec4a', '417815b0-ba8f-515f-9ff2-b114a6898bee', NULL, 'Reunión extraordinaria del comité y acta de designación de brigadistas', false, '99af0518-7a54-5f07-94e5-b8fb305278c0', '2026-09-22T23:59:00-05:00'::timestamptz, 'VERIFICADA', '44241aa2-eb43-5216-aca9-f9a818da767e', 'E-W06', 'V'),
  ('1c4b730f-18ab-518e-890a-b3f79f6c89ac', '8e5ec102-d967-54bc-b370-1a067286ec4a', '417815b0-ba8f-515f-9ff2-b114a6898bee', NULL, 'Entrenamiento de brigadistas (evidencia: lista de asistencia)', false, '374efafc-0bb0-5e54-8763-bad3277ad758', '2026-10-15T23:59:00-05:00'::timestamptz, 'POR_VERIFICAR', NULL, 'E-W07', 'V'),
  ('fc1238c6-22a3-51cc-bc79-de8e8ea51348', '8e5ec102-d967-54bc-b370-1a067286ec4a', '483e93aa-2b5d-5429-bc37-118701f313e8', NULL, 'Designar un cuchillo para pan y colocar soporte y señalización', false, '82e24213-dafa-5849-92d5-2416638a570d', '2026-11-15T23:59:00-05:00'::timestamptz, 'ASIGNADA', NULL, 'E-W16', 'S');

insert into evidencia (id, empresa_id, actividad_id, accion_id, tipo, url, nota, registrado_por, ref_semilla) values
  ('fbe98fba-1fe6-5f41-be06-b71b9416e249', 'cd37147b-c5c0-5863-a5ef-a377924adfb3', 'd1796d93-f025-597f-9fd3-8beb0ad80451', NULL, 'PDF', 'demo://evidencias/E-C08.pdf', 'Acta del Comité de SSO – octubre 2026 (PDF)', '8902c33a-40a4-5f7c-b4fc-44da76c680ad', 'E-C08');

-- Para ensayar la demo con la hora real: deja la acción inmediata a 5 h 10 min de vencer y usa el reloj del sistema.
create or replace function demo_reiniciar_contador() returns void language sql as $$
  update config set valor = '' where clave = 'reloj_demo';
  update accion set vence_en = now() + interval '5 hours 10 minutes', estado = 'EN_IMPLEMENTACION' where ref_semilla = 'E-C13';
$$;
