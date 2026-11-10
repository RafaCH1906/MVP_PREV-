# -*- coding: utf-8 -*-
"""Datos semilla de Prevé: empresas, estructura, procesos, catálogo, actividades base,
metodologías, usuarios y escenario demo.

Convención de estado del dato:  V = verificado (dato real, entrevista o norma)  |  S = supuesto por validar
"""

FECHA_REFERENCIA = "2026-11-07"   # "hoy" en el escenario demo
ANIO_GESTION = 2026

# ---------------------------------------------------------------------------
# EMPRESAS
# ---------------------------------------------------------------------------
EMPRESAS = [
    dict(codigo="CAR", razon_social="MINERA CARACOL S.A.C.", ruc="20452673267",
         ciiu="0729 – Extracción de otros minerales metalíferos no ferrosos",
         ciiu_sec="4662 – Venta al por mayor de metales y minerales metalíferos; 4923 – Transporte de carga por carretera",
         sector="Minería", metodologia="MIN", n_trabajadores=168,
         domicilio="Av. San Luis N.° 2113, Dpto. 402, Urb. San Borja, San Borja, Lima",
         inicio="20/06/2005", organo_sst="Comité de SSO", fiscalizador="Gobierno Regional (pequeña minería) – por confirmar",
         etiquetas="Programa anual de SSO; Comité de SSO",
         fuente="datosperu.org (consulta 07/11/2026): RUC, CIIU, domicilio, trabajadores 2026-08. INT002: comité, fiscalizador.",
         estado="V"),
    dict(codigo="WIR", razon_social="WIRBI S.A.C.", ruc="20488111672",
         ciiu="6202 – Consultoría de informática y gestión de instalaciones informáticas",
         ciiu_sec="6201 – Programación informática; 6311 – Procesamiento de datos, hospedaje y actividades conexas",
         sector="Servicios (tecnología)", metodologia="MTPE", n_trabajadores=40,
         domicilio="Av. Jorge Basadre Grohmann N.° 702, Urb. Orrantia, San Isidro, Lima",
         inicio="01/08/2012", organo_sst="Comité de SST", fiscalizador="SUNAFIL",
         etiquetas="Plan anual de SST; Comité de SST",
         fuente="datosperu.org (consulta 07/11/2026): RUC, CIIU, domicilio. N.° de trabajadores = 40, supuesto acordado con el equipo. INT001: comité, SUNAFIL.",
         estado="V"),
]

# ---------------------------------------------------------------------------
# ESTRUCTURA: sede -> área -> puestos (nombre, n.º trabajadores)
# ---------------------------------------------------------------------------
SEDES = [
    # empresa, código, nombre, ubicación, tipo, estado del dato
    ("CAR", "CAR-S1", "Oficina administrativa", "San Borja, Lima", "Administrativa", "V"),
    ("CAR", "CAR-S2", "Unidad de explotación Caracolito I", "Ámbar, Huaura, Lima", "Productiva (mina subterránea)", "V"),
    ("CAR", "CAR-S3", "Unidad de explotación Caracolito II", "Supe, Barranca, Lima", "Productiva (mina subterránea)", "V"),
    ("CAR", "CAR-S4", "Planta de beneficio Minera Caracol", "Supe, Barranca, Lima", "Productiva (planta)", "V"),
    ("WIR", "WIR-S1", "Oficina principal", "San Isidro, Lima", "Administrativa", "V"),
]

ESTRUCTURA = {
    "CAR-S1": {
        "Gerencia": [("Gerente general", 1), ("Gerente de operaciones", 1)],
        "Administración y RR. HH.": [("Jefa de administración y RR. HH.", 1), ("Asistente administrativo-contable", 5), ("Asistente de RR. HH.", 2)],
        "Logística": [("Comprador", 2)],
    },
    "CAR-S2": {
        "Mina": [("Jefe de guardia", 3), ("Perforista", 16), ("Ayudante de perforista", 16), ("Cargador-disparador", 6),
                 ("Sostenedor (enmaderador)", 12), ("Operador de winche/scoop", 8), ("Bodeguero de polvorín", 2)],
        "Mantenimiento": [("Mecánico", 4), ("Electricista", 2)],
        "Seguridad y Salud Ocupacional": [("Jefe de seguridad y salud ocupacional", 1), ("Supervisor de seguridad", 2), ("Enfermero(a)", 1)],
        "Geología": [("Geólogo", 1), ("Topógrafo", 1)],
        "Servicios generales": [("Vigilante", 1)],
    },
    "CAR-S3": {
        "Mina": [("Jefe de guardia", 2), ("Perforista", 8), ("Ayudante de perforista", 8), ("Cargador-disparador", 4),
                 ("Sostenedor (enmaderador)", 6), ("Operador de winche/scoop", 7), ("Bodeguero de polvorín", 1)],
        "Mantenimiento": [("Mecánico", 2)],
        "Seguridad y Salud Ocupacional": [("Supervisor de seguridad", 1)],
    },
    "CAR-S4": {
        "Planta": [("Jefa de planta", 1), ("Operador de chancado", 6), ("Operador de molienda", 6), ("Operador de procesos", 6), ("Laboratorista", 3)],
        "Mantenimiento": [("Mecánico de planta", 4), ("Electricista", 2)],
        "Transporte": [("Conductor de volquete", 10)],
        "Almacén": [("Almacenero", 2)],
        "Seguridad y Salud Ocupacional": [("Enfermero(a)", 1)],
    },
    "WIR-S1": {
        "Gerencia": [("Gerente general", 1)],
        "Tecnología": [("Jefe de proyectos", 4), ("Desarrollador de software", 18), ("Analista QA", 4), ("Especialista de infraestructura y soporte", 3)],
        "Administración y finanzas": [("Jefa de administración y finanzas", 1), ("Analista contable-administrativo", 2)],
        "Talento Humano": [("Analista de Talento Humano", 2)],
        "Cumplimiento": [("Oficial de cumplimiento", 1)],
        "Comercial": [("Ejecutivo comercial", 2)],
        "Servicios generales": [("Asistente de servicios generales", 1), ("Personal de limpieza", 1)],
    },
}

# ---------------------------------------------------------------------------
# PROCESOS: (empresa, proceso, actividad, tipo, código tarea, tarea, sedes, puestos, fuente, estado)
# ---------------------------------------------------------------------------
PROCESOS = [
    ("CAR", "Explotación subterránea", "Perforación", "Rutinaria", "CAR-T01", "Desatado de rocas e inspección de la labor al inicio de la guardia", "Caracolito I; Caracolito II", "Perforista; Ayudante de perforista; Jefe de guardia", "INT002 (minería subterránea) + supuesto", "S"),
    ("CAR", "Explotación subterránea", "Perforación", "Rutinaria", "CAR-T02", "Perforación de taladros con perforadora neumática", "Caracolito I; Caracolito II", "Perforista; Ayudante de perforista", "Supuesto", "S"),
    ("CAR", "Explotación subterránea", "Voladura", "Rutinaria", "CAR-T03", "Transporte de explosivos del polvorín a la labor", "Caracolito I; Caracolito II", "Cargador-disparador; Bodeguero de polvorín", "INT002 (explosivos)", "S"),
    ("CAR", "Explotación subterránea", "Voladura", "Rutinaria", "CAR-T04", "Carguío de taladros y encendido", "Caracolito I; Caracolito II", "Cargador-disparador; Jefe de guardia", "INT002 (carné para manipular explosivos)", "S"),
    ("CAR", "Explotación subterránea", "Voladura", "Rutinaria", "CAR-T05", "Ventilación y verificación de gases después de la voladura", "Caracolito I; Caracolito II", "Jefe de guardia; Supervisor de seguridad", "Supuesto", "S"),
    ("CAR", "Explotación subterránea", "Sostenimiento", "Rutinaria", "CAR-T06", "Instalación de cuadros de madera y puntales", "Caracolito I; Caracolito II", "Sostenedor (enmaderador)", "Supuesto", "S"),
    ("CAR", "Explotación subterránea", "Limpieza y extracción de mineral", "Rutinaria", "CAR-T07", "Limpieza de mineral con winche o scoop", "Caracolito I; Caracolito II", "Operador de winche/scoop", "Supuesto", "S"),
    ("CAR", "Explotación subterránea", "Apertura de nueva labor", "No rutinaria", "CAR-T08", "Habilitación y sostenimiento de una nueva labor", "Caracolito II", "Jefe de guardia; Sostenedor (enmaderador); Perforista", "Supuesto (escenario RF-36)", "S"),
    ("CAR", "Transporte de mineral", "Transporte mina–planta", "Rutinaria", "CAR-T09", "Carguío de volquete en cancha de mineral", "Caracolito I; Caracolito II", "Conductor de volquete", "Supuesto", "S"),
    ("CAR", "Transporte de mineral", "Transporte mina–planta", "Rutinaria", "CAR-T10", "Conducción por vía de acceso con curvas", "Caracolito II; Planta de beneficio", "Conductor de volquete", "INT002 (curvas sin señalización, EV010)", "V"),
    ("CAR", "Beneficio de mineral", "Chancado", "Rutinaria", "CAR-T11", "Alimentación de tolva y operación de chancadora", "Planta de beneficio", "Operador de chancado", "Supuesto", "S"),
    ("CAR", "Beneficio de mineral", "Molienda y procesamiento", "Rutinaria", "CAR-T12", "Operación de molino", "Planta de beneficio", "Operador de molienda", "Supuesto", "S"),
    ("CAR", "Beneficio de mineral", "Molienda y procesamiento", "Rutinaria", "CAR-T13", "Preparación y dosificación de reactivos", "Planta de beneficio", "Operador de procesos", "Supuesto", "S"),
    ("CAR", "Beneficio de mineral", "Laboratorio", "Rutinaria", "CAR-T14", "Preparación y análisis de muestras", "Planta de beneficio", "Laboratorista", "Supuesto", "S"),
    ("CAR", "Mantenimiento", "Mantenimiento mecánico", "Rutinaria", "CAR-T15", "Mantenimiento de equipos con bloqueo y etiquetado", "Caracolito I; Caracolito II; Planta de beneficio", "Mecánico; Mecánico de planta", "Supuesto", "S"),
    ("CAR", "Mantenimiento", "Reparaciones con soldadura", "No rutinaria", "CAR-T16", "Soldadura y corte en reparaciones", "Planta de beneficio", "Mecánico de planta", "Supuesto", "S"),
    ("CAR", "Mantenimiento", "Mantenimiento eléctrico", "Rutinaria", "CAR-T17", "Revisión de tableros e instalaciones eléctricas", "Caracolito I; Planta de beneficio", "Electricista", "Supuesto", "S"),
    ("CAR", "Almacenamiento de explosivos", "Gestión de polvorín", "Rutinaria", "CAR-T18", "Recepción, almacenamiento e inventario de explosivos", "Caracolito I; Caracolito II", "Bodeguero de polvorín", "Supuesto", "S"),
    ("CAR", "Gestión administrativa", "Trabajo de oficina", "Rutinaria", "CAR-T19", "Trabajo en computadora", "Oficina administrativa", "Jefa de administración y RR. HH.; Asistente administrativo-contable; Asistente de RR. HH.; Comprador", "Supuesto", "S"),
    ("WIR", "Desarrollo y soporte de software", "Trabajo en computadora", "Rutinaria", "WIR-T01", "Desarrollo, pruebas y soporte frente a computadora", "Oficina principal", "Jefe de proyectos; Desarrollador de software; Analista QA; Especialista de infraestructura y soporte", "INT001 (trabajo administrativo)", "V"),
    ("WIR", "Gestión administrativa", "Trabajo en computadora", "Rutinaria", "WIR-T02", "Trabajo administrativo en computadora", "Oficina principal", "Gerente general; Jefa de administración y finanzas; Analista contable-administrativo; Analista de Talento Humano; Oficial de cumplimiento; Ejecutivo comercial", "INT001", "V"),
    ("WIR", "Desarrollo y soporte de software", "Soporte de infraestructura", "Rutinaria", "WIR-T03", "Instalación y revisión de equipos y cableado", "Oficina principal", "Especialista de infraestructura y soporte", "Supuesto", "S"),
    ("WIR", "Uso de cocina", "Preparación y consumo de alimentos", "Rutinaria", "WIR-T04", "Calentar alimentos y bebidas (microondas, cafetera)", "Oficina principal", "Todos los puestos", "INT001 (kitchen, microondas, cafetera)", "V"),
    ("WIR", "Uso de cocina", "Preparación y consumo de alimentos", "Rutinaria", "WIR-T05", "Cortar y servir alimentos", "Oficina principal", "Todos los puestos", "INT001 (incidente con cuchillo)", "V"),
    ("WIR", "Limpieza y servicios generales", "Limpieza", "Rutinaria", "WIR-T06", "Limpieza de oficinas, cocina y servicios higiénicos con productos químicos", "Oficina principal", "Personal de limpieza", "INT001 (riesgos de limpieza)", "V"),
    ("WIR", "Limpieza y servicios generales", "Limpieza", "Rutinaria", "WIR-T07", "Traslado de residuos y bidones de agua", "Oficina principal", "Personal de limpieza; Asistente de servicios generales", "Supuesto", "S"),
    ("WIR", "Atención a clientes", "Visitas a clientes", "Rutinaria", "WIR-T08", "Desplazamiento en la ciudad hacia el cliente", "Oficina principal", "Ejecutivo comercial; Jefe de proyectos", "INT001 (seguridad fuera de la oficina)", "S"),
    ("WIR", "Atención a clientes", "Visitas a clientes", "Rutinaria", "WIR-T09", "Trabajo en instalaciones del cliente", "Oficina principal", "Jefe de proyectos; Especialista de infraestructura y soporte", "INT001 (seguridad dentro del cliente)", "S"),
    ("WIR", "Gestión de emergencias", "Mantenimiento de equipos de seguridad", "No rutinaria", "WIR-T10", "Coordinación de recarga de extintores y revisión de alarmas y rociadores (ejecuta proveedor)", "Oficina principal", "Asistente de servicios generales", "INT001 (mantenimientos que vencen, EV006)", "V"),
    ("WIR", "Gestión de emergencias", "Evacuación", "No rutinaria", "WIR-T11", "Evacuación ante sismo o simulacro", "Oficina principal", "Todos los puestos", "INT001 (simulacros, brigadistas)", "V"),
]

# ---------------------------------------------------------------------------
# CATÁLOGO DE PELIGROS
# (código, sector, tipo, peligro, riesgo, consecuencia, sev_MTPE 1-3, sev_minería 1-5,
#  eliminación, sustitución, ingeniería, administrativo/señalización, EPP)
# ---------------------------------------------------------------------------
_ = "—"
CATALOGO = [
    ("PEL-M01", "Minería", "Mecánico / locativo", "Rocas sueltas en techo y hastiales", "Caída de rocas", "Aplastamiento, politraumatismo, muerte", 3, 2, _, _, "Sostenimiento sistemático (pernos, malla, cuadros)", "Desatado obligatorio, PETS, inspección de la labor al inicio de la guardia", "Casco, botas con puntera de acero"),
    ("PEL-M02", "Minería", "Explosivos", "Explosivos (dinamita, emulsiones, ANFO)", "Detonación prematura o no controlada", "Muerte, amputaciones, quemaduras", 3, 1, _, "Explosivos de mayor seguridad y sistemas de iniciación no eléctricos", "Polvorín según norma, cajas de transporte de explosivos", "Personal autorizado con carné vigente, PETS de voladura, vigías y señalización", "EPP completo, lámpara"),
    ("PEL-M03", "Minería", "Explosivos", "Tiros cortados (fallados)", "Detonación al perforar o limpiar", "Muerte, lesiones graves", 3, 1, _, _, _, "Inspección post-voladura, procedimiento de tiros cortados, prohibición de perforar en restos", "EPP completo"),
    ("PEL-M04", "Minería", "Químico", "Gases de voladura (CO, NO2)", "Inhalación de gases tóxicos", "Intoxicación, asfixia, muerte", 3, 2, _, _, "Ventilación mecánica (ventiladores y mangas)", "Tiempo de espera post-voladura, medición con detector de gases antes del ingreso", "Autorrescatador"),
    ("PEL-M05", "Minería", "Químico", "Atmósfera deficiente en oxígeno", "Asfixia", "Pérdida de conciencia, muerte", 3, 2, _, _, "Ventilación forzada", "Medición de oxígeno antes del ingreso, permiso para espacios confinados", "Autorrescatador"),
    ("PEL-M06", "Minería", "Físico", "Polvo con sílice", "Inhalación de polvo", "Silicosis, neumoconiosis", 3, 3, _, _, "Perforación húmeda, riego de frentes, ventilación", "Monitoreo de polvo, rotación de personal", "Respirador con filtro para polvo"),
    ("PEL-M07", "Minería", "Físico", "Ruido de perforadoras", "Exposición a ruido", "Hipoacusia", 2, 3, _, "Equipos de menor emisión", "Silenciadores", "Monitoreo de ruido, audiometrías, rotación", "Protección auditiva doble"),
    ("PEL-M08", "Minería", "Físico", "Vibración de perforadora manual", "Exposición a vibración mano-brazo", "Trastornos vasculares y musculoesqueléticos", 2, 4, _, "Equipos con antivibración", "Empuñaduras amortiguadas", "Pausas y rotación", "Guantes antivibración"),
    ("PEL-M09", "Minería", "Mecánico", "Barreno y partes móviles de perforadora", "Atrapamiento, golpes", "Fracturas, amputaciones", 2, 3, _, _, "Protecciones en equipos", "PETS de perforación, capacitación", "Guantes, ropa ajustada"),
    ("PEL-M10", "Minería", "Locativo", "Piso irregular, desniveles y agua en labores", "Caída al mismo nivel", "Contusiones, esguinces", 1, 4, _, _, "Cunetas y nivelación de piso", "Orden y limpieza, iluminación", "Botas de jebe con puntera"),
    ("PEL-M11", "Minería", "Locativo", "Chimeneas, piques y echaderos abiertos", "Caída a distinto nivel", "Politraumatismo, muerte", 3, 2, _, _, "Barandas, parrillas y tapas en aberturas", "Señalización, permiso de trabajo en altura", "Arnés y línea de vida"),
    ("PEL-M12", "Minería", "Mecánico", "Winche o scoop en operación", "Atropello, atrapamiento", "Fracturas, muerte", 3, 2, _, _, "Guardas en tambores, alarmas de retroceso", "Operador autorizado, zona de exclusión", "Chaleco reflectivo"),
    ("PEL-M13", "Minería", "Mecánico", "Carros mineros y locomotora", "Atropello, descarrilamiento", "Fracturas, muerte", 3, 2, _, _, "Refugios en galerías, mantenimiento de rieles", "Señalización, velocidad controlada", "Chaleco reflectivo"),
    ("PEL-M14", "Minería", "Transporte", "Vías con curvas sin señalización", "Choque o volcadura del vehículo", "Politraumatismo, muerte, daño a equipos", 3, 2, _, _, "Bermas de seguridad, guardavías, ensanche de curvas", "Señalización vertical, espejos convexos, límite de velocidad, conductores autorizados", "Cinturón de seguridad"),
    ("PEL-M15", "Minería", "Psicosocial / transporte", "Fatiga del conductor en turnos largos", "Pérdida de control del vehículo", "Politraumatismo, muerte", 3, 2, _, _, _, "Control de horas de manejo, pausas, evaluación de fatiga", _),
    ("PEL-M16", "Minería", "Transporte", "Tránsito de personal en vías de volquetes", "Atropello", "Politraumatismo, muerte", 3, 2, "Separar vías peatonales de vehículos", _, "Pasos peatonales delimitados", "Señalización, prioridad de paso, vigías", "Chaleco reflectivo"),
    ("PEL-M17", "Minería", "Eléctrico", "Tableros y cables sin protección en mina", "Contacto eléctrico directo o indirecto", "Quemaduras, electrocución, muerte", 3, 2, _, _, "Interruptores diferenciales, puesta a tierra, cables protegidos", "Bloqueo y etiquetado, personal autorizado", "Guantes y calzado dieléctricos"),
    ("PEL-M18", "Minería", "Mecánico", "Partes móviles de chancadora y fajas", "Atrapamiento", "Amputación, muerte", 3, 2, _, _, "Guardas fijas, paradas de emergencia, interbloqueos", "Bloqueo y etiquetado en mantenimiento", "Ropa ajustada"),
    ("PEL-M19", "Minería", "Mecánico", "Proyección de fragmentos en chancado", "Golpe por proyección", "Lesión ocular, contusiones", 2, 4, _, _, "Cortinas y guardas", "Zona restringida", "Lentes de seguridad, careta"),
    ("PEL-M20", "Minería", "Químico", "Reactivos de procesamiento (p. ej., cianuro, cal, ácidos)", "Contacto, inhalación o ingestión", "Intoxicación, quemaduras químicas", 3, 2, _, "Reactivos menos tóxicos cuando sea viable", "Sistemas cerrados, extracción localizada", "Hojas de datos de seguridad, rotulado SGA, ducha y lavaojos", "Respirador, guantes de nitrilo, lentes, mandil"),
    ("PEL-M21", "Minería", "Físico", "Polvo en chancado y molienda", "Inhalación de polvo", "Neumoconiosis", 2, 3, _, _, "Captación de polvo, riego", "Monitoreo de polvo", "Respirador"),
    ("PEL-M22", "Minería", "Físico", "Ruido de molinos", "Exposición a ruido", "Hipoacusia", 2, 3, _, _, "Cabinas aisladas", "Monitoreo de ruido, audiometrías", "Protección auditiva"),
    ("PEL-M23", "Minería", "Locativo", "Trabajo sobre tolvas y plataformas elevadas", "Caída a distinto nivel", "Politraumatismo, muerte", 3, 2, _, _, "Barandas y plataformas con rodapié", "Permiso de trabajo en altura", "Arnés y línea de vida"),
    ("PEL-M24", "Minería", "Mecánico", "Izaje de cargas en mantenimiento", "Caída de objetos suspendidos", "Aplastamiento, muerte", 3, 2, _, _, "Equipos de izaje certificados", "Rigger autorizado, zona de exclusión", "Casco"),
    ("PEL-M25", "Minería", "Mecánico", "Herramientas manuales en mal estado", "Golpes y cortes", "Contusiones, heridas", 1, 4, _, "Reemplazo de herramientas dañadas", _, "Inspección de herramientas manuales (código de colores)", "Guantes"),
    ("PEL-M26", "Minería", "Físico", "Soldadura y corte (radiación, chispas)", "Quemaduras, lesión ocular, incendio", "Quemaduras, conjuntivitis actínica", 2, 3, _, _, "Biombos, extracción de humos", "Permiso de trabajo en caliente, extintor a la mano", "Careta, guantes y mandil de cuero"),
    ("PEL-M27", "Minería", "Químico", "Humos metálicos de soldadura", "Inhalación", "Fiebre de humos metálicos, enfermedad respiratoria", 2, 3, _, _, "Extracción localizada", "Trabajo en zona ventilada", "Respirador para humos"),
    ("PEL-M28", "Minería", "Físico", "Temperaturas extremas y altitud", "Exposición a frío o calor", "Hipotermia, golpe de calor, mal de altura", 2, 3, _, _, _, "Aclimatación, hidratación, evaluación médica", "Ropa térmica"),
    ("PEL-M29", "Minería", "Ergonómico", "Carga manual de madera, sacos y materiales", "Sobreesfuerzo", "Lumbalgia, hernias", 2, 4, _, _, "Ayudas mecánicas", "Técnicas de levantamiento, límite de peso", "Faja (solo si la indica el médico)"),
    ("PEL-M30", "Minería", "Ergonómico", "Posturas forzadas en labores estrechas", "Trastornos musculoesqueléticos", "Lesiones de espalda y rodillas", 2, 4, _, _, "Dimensiones adecuadas de labores", "Pausas y rotación", "Rodilleras"),
    ("PEL-M31", "Minería", "Psicosocial", "Turnos rotativos y trabajo nocturno", "Fatiga y estrés", "Trastornos del sueño, mayor probabilidad de accidentes", 2, 4, _, _, _, "Diseño de turnos, descansos, vigilancia de la fatiga", _),
    ("PEL-M32", "Minería", "Biológico", "Agua contaminada y roedores en interior mina", "Contacto con agentes biológicos", "Infecciones", 1, 4, _, _, "Drenaje", "Control de plagas, agua segura", "Guantes, botas"),
    ("PEL-M33", "Minería", "Incendio", "Combustibles y madera en interior mina", "Incendio subterráneo", "Asfixia por humos, muerte", 3, 1, _, _, "Extintores, rutas de escape, cámara de refugio", "Plan de emergencia, simulacros, control de combustibles", "Autorrescatador"),
    ("PEL-M34", "Minería", "Locativo", "Bolsonadas de agua y labores antiguas inundadas", "Inundación de la labor", "Ahogamiento, atrapamiento", 3, 1, _, _, "Sondajes de drenaje", "Planos actualizados, perforación con taladros de avance", _),
    ("PEL-M35", "Minería", "Físico", "Iluminación deficiente en labores", "Golpes y caídas", "Contusiones", 1, 4, _, _, "Iluminación fija en zonas de tránsito", "Revisión de lámparas", "Lámpara minera"),
    ("PEL-M36", "Minería", "Explosivos", "Almacenamiento inadecuado en polvorín", "Explosión, incendio", "Muerte, destrucción de instalaciones", 3, 1, _, _, "Polvorín con ventilación, pararrayos y separación de explosivos y accesorios", "Inventario, acceso restringido, señalización", _),
    ("PEL-G01", "General", "Ergonómico", "Trabajo prolongado frente a computadora (PVD)", "Postura sedente prolongada", "Trastornos musculoesqueléticos (cuello, espalda, muñeca)", 2, 4, _, _, "Sillas regulables, soportes de monitor y reposapiés", "Pausas activas, evaluación ergonómica del puesto (RM N.° 375-2008-TR)", _),
    ("PEL-G02", "General", "Ergonómico", "Uso intensivo de pantalla", "Fatiga visual", "Cefalea, sequedad ocular", 1, 5, _, _, "Pantallas con ajuste de brillo, filtro", "Regla 20-20-20, pausas", _),
    ("PEL-G03", "General", "Psicosocial", "Carga de trabajo y plazos de entrega", "Estrés laboral", "Ansiedad, agotamiento", 2, 4, _, _, _, "Planificación de cargas, canal de apoyo", _),
    ("PEL-G04", "General", "Eléctrico", "Instalaciones y equipos eléctricos (enchufes, extensiones)", "Contacto eléctrico, cortocircuito", "Quemaduras, electrocución, incendio", 2, 3, _, _, "Interruptores termomagnéticos y diferenciales, puesta a tierra", "Prohibir extensiones en cascada, inspección periódica", _),
    ("PEL-G05", "General", "Incendio", "Material combustible y sobrecarga eléctrica", "Incendio", "Quemaduras, intoxicación por humo", 3, 2, _, _, "Detectores, rociadores, extintores", "Plan de emergencias, brigada, mantenimiento de equipos", _),
    ("PEL-G06", "General", "Natural", "Sismo", "Atrapamiento, golpes por caída de objetos", "Lesiones graves, muerte", 3, 2, _, _, "Anclaje de muebles y estantes", "Plan de evacuación, señalización de rutas y zonas seguras, simulacros", _),
    ("PEL-G07", "General", "Locativo", "Pisos mojados o resbaladizos", "Caída al mismo nivel", "Contusiones, fracturas", 2, 4, _, _, "Pisos antideslizantes", "Señal de piso mojado, limpieza fuera de horas punta", "Calzado antideslizante (limpieza)"),
    ("PEL-G08", "General", "Locativo", "Cables y objetos en zonas de tránsito", "Tropiezo", "Contusiones", 1, 4, _, _, "Canaletas para cables", "Orden y limpieza", _),
    ("PEL-G09", "General", "Locativo", "Escaleras", "Caída a distinto nivel", "Fracturas", 2, 4, _, _, "Pasamanos, cinta antideslizante", "No correr ni usar el celular en escaleras", _),
    ("PEL-G10", "General", "Mecánico", "Cuchillos y utensilios cortantes (cocina)", "Cortes", "Heridas cortantes", 1, 4, _, "Cuchillos especializados por tipo de alimento", "Soporte para cuchillos", "Señalización del uso de cada cuchillo", _),
    ("PEL-G11", "General", "Térmico", "Superficies y líquidos calientes (microondas, cafetera, hervidor)", "Contacto con superficies o líquidos calientes", "Quemaduras", 1, 4, _, _, "Ubicación estable de los equipos", "Stickers de advertencia, instrucciones de uso", _),
    ("PEL-G12", "General", "Eléctrico", "Electrodomésticos de cocina", "Contacto eléctrico", "Quemaduras, electrocución", 2, 3, _, _, "Tomacorrientes con puesta a tierra", "Revisión de cables y enchufes", _),
    ("PEL-G13", "General", "Químico", "Productos de limpieza (lejía, desinfectantes)", "Contacto con piel u ojos, inhalación", "Dermatitis, irritación", 1, 4, _, "Productos menos agresivos", "Ventilación", "Hojas de datos de seguridad, rotulado, no mezclar productos", "Guantes de nitrilo, lentes"),
    ("PEL-G14", "General", "Biológico", "Residuos y servicios higiénicos", "Contacto con agentes biológicos", "Infecciones", 1, 4, _, _, _, "Procedimiento de limpieza y manejo de residuos", "Guantes, mascarilla"),
    ("PEL-G15", "General", "Ergonómico", "Traslado de bolsas de residuos y bidones de agua", "Sobreesfuerzo", "Lumbalgia", 2, 4, _, "Dispensadores con bomba", "Carretilla", "Técnicas de levantamiento", _),
    ("PEL-G16", "General", "Mecánico", "Objetos en estanterías altas", "Caída de objetos", "Golpes", 1, 4, _, _, "Anclaje de estanterías", "Objetos pesados en niveles bajos", _),
    ("PEL-G17", "General", "Transporte", "Desplazamiento en la ciudad (visitas a clientes)", "Accidente de tránsito, atropello", "Lesiones graves, muerte", 3, 2, "Reuniones virtuales cuando sea posible", _, _, "Planificación de rutas, transporte seguro, capacitación en seguridad vial", _),
    ("PEL-G18", "General", "Social", "Delincuencia en la vía pública", "Asalto", "Lesiones, estrés", 2, 3, _, _, _, "Rutas y horarios seguros, protocolo ante asaltos", _),
    ("PEL-G19", "General", "Locativo", "Instalaciones del cliente con peligros no conocidos", "Exposición a peligros no identificados", "Variable según el lugar", 2, 3, _, _, _, "Inducción de seguridad del cliente, coordinación previa", "EPP exigido por el cliente"),
    ("PEL-G20", "General", "Biológico", "Enfermedades respiratorias transmisibles", "Contagio", "Infección respiratoria", 2, 4, _, _, "Ventilación", "Higiene de manos, trabajo remoto con síntomas", _),
    ("PEL-G21", "General", "Psicosocial", "Hostigamiento o conflictos interpersonales", "Estrés, ansiedad", "Afectación de la salud mental", 2, 4, _, _, _, "Política y canal de denuncias", _),
    ("PEL-G22", "General", "Físico", "Iluminación inadecuada", "Fatiga visual", "Cefalea", 1, 5, _, _, "Iluminación según la tarea", "Medición de iluminación", _),
    ("PEL-G23", "General", "Físico", "Ruido en oficina abierta", "Disconfort acústico", "Fatiga, falta de concentración", 1, 5, _, _, "Paneles acústicos, salas de reunión", "Normas de convivencia", _),
    ("PEL-G24", "General", "Físico", "Temperatura y ventilación inadecuadas", "Disconfort térmico", "Malestar", 1, 5, _, _, "Climatización", "Mantenimiento del aire acondicionado", _),
    ("PEL-G25", "General", "Emergencia", "Equipos de emergencia sin mantenimiento (extintores, alarmas, rociadores)", "Respuesta fallida ante emergencia", "Agravamiento de lesiones y daños", 3, 2, _, _, _, "Programa de mantenimiento, inspección mensual, registro de equipos de emergencia", _),
    ("PEL-G26", "General", "Emergencia", "Botiquín incompleto o con insumos vencidos", "Atención inadecuada de primeros auxilios", "Agravamiento de lesiones", 1, 4, _, _, _, "Revisión mensual del botiquín con lista de verificación", _),
    ("PEL-G27", "General", "Locativo", "Puertas de vidrio y mamparas", "Golpe, cortes", "Contusiones, heridas", 1, 4, _, "Vidrio templado o laminado", _, "Señalización en vidrios", _),
    ("PEL-G28", "General", "Químico", "Tóner y polvo de impresoras", "Inhalación", "Irritación respiratoria", 1, 5, _, _, "Ubicación ventilada de impresoras", "Procedimiento de cambio de tóner", "Guantes"),
]

# ---------------------------------------------------------------------------
# ACTIVIDADES BASE
# (código, sector, actividad, tipo, frecuencia mínima normativa, base normativa,
#  frecuencia Caracol, frecuencia Wirbi, mes(es) sugerido(s), objetivo, fuente, estado)
# ---------------------------------------------------------------------------
NA = "No aplica"
ACTIVIDADES_BASE = [
    ("AB-G01", "General", "Capacitación en SST", "Capacitación", "Mínimo 4 al año", "Ley N.° 29783, art. 35", NA, "4 al año (trimestral)", "Mar, Jun, Sep, Dic", "Controlar los riesgos significativos", "Norma + INT001", "V"),
    ("AB-G02", "General", "Inducción en SST a nuevos ingresos", "Capacitación", "Al ingreso de cada trabajador", "Ley N.° 29783, art. 49", NA, "Por ingreso", "Según ingresos", "Cerrar brechas del sistema de gestión", "Norma + INT001 (inducciones pendientes)", "V"),
    ("AB-G03", "General", "Reunión ordinaria del comité de SST", "Comité", "Mensual", "DS N.° 005-2012-TR, art. 69 (verificar)", NA, "Quincenal (práctica de la empresa)", "Todos los meses", "Cerrar brechas del sistema de gestión", "INT001 (comité quincenal) + norma", "S"),
    ("AB-G04", "General", "Simulacro de evacuación (sismo)", "Simulacro", "Según plan de emergencias (verificar)", "Ley N.° 29783; normativa de INDECI (verificar)", NA, "2 al año", "May, Nov", "Controlar los riesgos significativos", "INT001 (2 simulacros al año)", "S"),
    ("AB-G05", "General", "Inspección de seguridad de instalaciones", "Inspección", "Periódica (según programa)", "RM N.° 050-2013-TR (registro de inspecciones)", NA, "Semestral", "Abr, Oct", "Controlar los riesgos significativos", "INT001 (inspecciones cada 6 meses)", "S"),
    ("AB-G06", "General", "Inspección de extintores y botiquín", "Inspección", "Mensual (buena práctica)", "RM N.° 050-2013-TR (registro de equipos de emergencia)", NA, "Mensual", "Todos los meses", "Controlar los riesgos significativos", "INT001 (botiquín con insumos vencidos, EV006)", "S"),
    ("AB-G07", "General", "Recarga y mantenimiento de extintores", "Mantenimiento", "Anual (verificar NTP vigente)", "NTP 350.043 (verificar)", NA, "Anual", "Oct", "Controlar los riesgos significativos", "INT001 (EV006)", "S"),
    ("AB-G08", "General", "Mantenimiento de alarmas, detectores y rociadores", "Mantenimiento", "Según fabricante y normativa de edificaciones (verificar)", "Reglamento Nacional de Edificaciones (verificar)", NA, "Semestral", "Mar, Sep", "Controlar los riesgos significativos", "INT001 (EV006)", "S"),
    ("AB-G09", "General", "Exámenes médicos ocupacionales (ingreso, periódico, retiro)", "Salud ocupacional", "Periódico al menos cada 2 años (verificar)", "Ley N.° 29783, art. 49; DS N.° 005-2012-TR, art. 101", NA, "Ingreso / periódico / retiro", "Según calendario", "Cerrar brechas del sistema de gestión", "INT001 (Talento Humano)", "S"),
    ("AB-G10", "General", "Actualización de la IPERC", "Gestión", "Anual y ante cambios o daños", "DS N.° 005-2012-TR, art. 77", NA, "Anual", "Ene", "Controlar los riesgos significativos", "Norma + INT001 (revisión anual)", "V"),
    ("AB-G11", "General", "Elaboración y aprobación del plan anual de SST", "Gestión", "Anual", "DS N.° 005-2012-TR, art. 32", NA, "Anual", "Dic", "Cerrar brechas del sistema de gestión", "Norma", "V"),
    ("AB-G12", "General", "Revisión por la dirección", "Gestión", "Anual (verificar)", "Ley N.° 29783, art. 41 (verificar)", NA, "Anual", "Dic", "Cerrar brechas del sistema de gestión", "Norma", "S"),
    ("AB-G13", "General", "Auditoría del sistema de gestión de SST", "Auditoría", "Periódica (verificar plazo vigente)", "Ley N.° 29783, art. 43; DS N.° 005-2012-TR, art. 109", NA, "Anual (interna)", "Nov", "Cerrar brechas del sistema de gestión", "Norma", "S"),
    ("AB-G14", "General", "Monitoreo de agentes ocupacionales (ergonómico, iluminación)", "Monitoreo", "Según IPERC", "RM N.° 050-2013-TR (registro de monitoreo); RM N.° 375-2008-TR", NA, "Anual", "Jul", "Controlar los riesgos significativos", "Supuesto", "S"),
    ("AB-M01", "Minería", "Reunión ordinaria del comité de SSO (primeros 10 días del mes)", "Comité", "Mensual", "DS N.° 024-2016-EM (verificar artículo)", "Mensual", NA, "Todos los meses", "Cerrar brechas del sistema de gestión", "INT002 (reunión en los 10 primeros días)", "S"),
    ("AB-M02", "Minería", "Elaboración y presentación del programa anual de SSO", "Gestión", "Anual, antes del cierre del año", "DS N.° 024-2016-EM (verificar artículo)", "Anual", NA, "Dic", "Cerrar brechas del sistema de gestión", "INT002 (antes del 31 de diciembre)", "S"),
    ("AB-M03", "Minería", "Actualización de la IPERC de línea base y del mapa de riesgos", "Gestión", "Anual y ante cambios, incidentes peligrosos o cambios legales", "DS N.° 024-2016-EM, art. 97 (mod. DS N.° 023-2017-EM)", "Anual", NA, "Ene", "Controlar los riesgos significativos", "Norma (verificada)", "V"),
    ("AB-M04", "Minería", "Inducción y orientación básica al ingreso", "Capacitación", "Al ingreso", "DS N.° 024-2016-EM, anexos 4 y 5 (verificar)", "Por ingreso", NA, "Según ingresos", "Cerrar brechas del sistema de gestión", "INT002 (anexos 4 y 5)", "S"),
    ("AB-M05", "Minería", "Capacitación anual en temas de seguridad", "Capacitación", "Anual, temas definidos por norma", "DS N.° 024-2016-EM, anexo 6 (verificar)", "Mensual (programa anual)", NA, "Todos los meses", "Controlar los riesgos significativos", "INT002 (anexo 6)", "S"),
    ("AB-M06", "Minería", "Inspección de botiquines", "Inspección", "Según programa de inspecciones", "DS N.° 024-2016-EM (verificar)", "Mensual", NA, "Todos los meses", "Controlar los riesgos significativos", "INT002 (programa de inspecciones)", "S"),
    ("AB-M07", "Minería", "Inspección de extintores", "Inspección", "Según programa de inspecciones", "DS N.° 024-2016-EM (verificar)", "Mensual", NA, "Todos los meses", "Controlar los riesgos significativos", "INT002", "S"),
    ("AB-M08", "Minería", "Inspección de cámara de refugio (salvataje)", "Inspección", "Según programa de inspecciones", "DS N.° 024-2016-EM (verificar)", "Trimestral", NA, "Mar, Jun, Sep, Dic", "Controlar los riesgos significativos", "INT002", "S"),
    ("AB-M09", "Minería", "Inspección de herramientas manuales", "Inspección", "Según programa de inspecciones", "DS N.° 024-2016-EM (verificar)", "Trimestral", NA, "Feb, May, Ago, Nov", "Controlar los riesgos significativos", "INT002", "S"),
    ("AB-M10", "Minería", "Inspección de la alta gerencia", "Inspección", "Según programa de inspecciones", "DS N.° 024-2016-EM (verificar)", "Trimestral", NA, "Mar, Jun, Sep, Dic", "Cerrar brechas del sistema de gestión", "INT002", "S"),
    ("AB-M11", "Minería", "Simulacro de emergencia en interior mina", "Simulacro", "Según plan de emergencias (verificar)", "DS N.° 024-2016-EM (verificar)", "Trimestral", NA, "Mar, Jun, Sep, Dic", "Controlar los riesgos significativos", "INT002 (programa de simulacros)", "S"),
    ("AB-M12", "Minería", "Auditoría del sistema de gestión de SSO", "Auditoría", "Anual (verificar)", "DS N.° 024-2016-EM (verificar)", "Anual", NA, "Nov", "Cerrar brechas del sistema de gestión", "INT002 (programa de auditorías)", "S"),
    ("AB-M13", "Minería", "Monitoreo de agentes (gases, polvo, ruido)", "Monitoreo", "Según IPERC (verificar)", "DS N.° 024-2016-EM (verificar)", "Trimestral", NA, "Mar, Jun, Sep, Dic", "Controlar los riesgos significativos", "Supuesto", "S"),
    ("AB-M14", "Minería", "Exámenes médicos ocupacionales", "Salud ocupacional", "Ingreso, anual y retiro (verificar)", "DS N.° 024-2016-EM (verificar)", "Ingreso / anual / retiro", NA, "Según calendario", "Cerrar brechas del sistema de gestión", "INT002 (médico ocupacional remoto)", "S"),
]

# ---------------------------------------------------------------------------
# METODOLOGÍAS (de Capítulo III v0.6, apartado 3.2.3)
# ---------------------------------------------------------------------------
MTPE_INDICES = [
    ("A. Personas expuestas", "1 a 3", "4 a 12", "Más de 12"),
    ("B. Procedimientos existentes", "Existen, son satisfactorios y suficientes", "Existen parcialmente y no son satisfactorios o suficientes", "No existen"),
    ("C. Capacitación", "Personal entrenado; conoce el peligro y lo previene", "Parcialmente entrenado; conoce el peligro pero no toma acciones de control", "No entrenado; no conoce el peligro"),
    ("D. Exposición al riesgo", "Al menos una vez al año (esporádica)", "Al menos una vez al mes (eventual)", "Al menos una vez al día (permanente)"),
    ("S. Severidad", "Lesión sin incapacidad; disconfort", "Lesión con incapacidad temporal; daño a la salud reversible", "Lesión con incapacidad permanente; daño irreversible"),
]
MTPE_NIVELES = [  # (min, max, clasificación, interpretación, plazo, orden de gravedad 1=menos grave)
    (4, 4, "Trivial", "No requiere acción específica", "—", 1),
    (5, 8, "Tolerable", "Mantener controles; revisar soluciones de bajo costo", "Revisión anual", 2),
    (9, 16, "Moderado", "Reducir el riesgo en un periodo determinado", "Dentro del año", 3),
    (17, 24, "Importante", "No iniciar el trabajo hasta reducir el riesgo", "30 días o antes de iniciar", 4),
    (25, 36, "Intolerable", "No iniciar ni continuar el trabajo hasta reducir el riesgo", "Inmediato", 5),
]
MTPE_UMBRAL = "Moderado"

MIN_PROB = ["A", "B", "C", "D", "E"]
MIN_PROB_NOMBRE = {"A": "Común (muy probable)", "B": "Ha sucedido (probable)", "C": "Podría suceder (posible)",
                   "D": "Raro que suceda (poco probable)", "E": "Prácticamente imposible"}
MIN_PROB_CRIT = {
    "A": ("Sucede con demasiada frecuencia", "6 o más personas expuestas varias veces al día"),
    "B": ("Sucede con frecuencia", "3 a 5 personas expuestas varias veces al día"),
    "C": ("Sucede ocasionalmente", "1 a 2 personas varias veces al día, o muchas personas ocasionalmente"),
    "D": ("Rara vez ocurre; no es muy probable", "3 a 5 personas expuestas ocasionalmente"),
    "E": ("Muy rara vez ocurre", "1 a 2 personas expuestas ocasionalmente"),
}
MIN_SEV_NOMBRE = {1: "Catastrófico", 2: "Mortalidad", 3: "Pérdida permanente", 4: "Pérdida temporal", 5: "Pérdida menor"}
MIN_SEV_CRIT = {
    1: ("Varias fatalidades; varias personas con lesiones permanentes", "Pérdidas mayores a US$ 100 000", "Paralización de más de 1 mes o definitiva"),
    2: ("Una mortalidad; estado vegetal", "Entre US$ 10 001 y 100 000", "Más de 1 semana y menos de 1 mes"),
    3: ("Lesiones que incapacitan de por vida; enfermedades ocupacionales avanzadas", "Entre US$ 5 001 y 10 000", "Más de 1 día hasta 1 semana"),
    4: ("Lesiones que incapacitan temporalmente; lesiones por posición ergonómica", "Entre US$ 1 000 y menos de 5 000", "1 día"),
    5: ("Lesión que no incapacita; lesiones leves", "Menos de US$ 1 000", "Menos de 1 día"),
}
MIN_MATRIZ = {  # severidad -> valores para A..E
    1: [1, 2, 4, 7, 11],
    2: [3, 5, 8, 12, 16],
    3: [6, 9, 13, 17, 20],
    4: [10, 14, 18, 21, 23],
    5: [15, 19, 22, 24, 25],
}
MIN_NIVELES = [  # (min, max, clasificación, descripción, plazo, orden de gravedad 1=menos grave)
    (1, 8, "Alto", "Riesgo intolerable; requiere controles inmediatos y, si no se puede controlar el peligro, se paralizan los trabajos en la labor", "0 a 24 horas", 3),
    (9, 15, "Medio", "Iniciar medidas para eliminar o reducir el riesgo; evaluar si la acción se puede ejecutar de inmediato", "0 a 72 horas", 2),
    (16, 25, "Bajo", "El riesgo puede ser tolerable", "1 mes", 1),
]
MIN_UMBRAL = "Medio"

# ---------------------------------------------------------------------------
# USUARIOS DEMO (nombres ficticios)
# ---------------------------------------------------------------------------
USUARIOS = [
    ("CAR", "U-C1", "Rosa Medina Ugarte", "Jefa de administración y RR. HH.", "Administrador de empresa", "Oficina administrativa", "rosa.medina@caracol.demo"),
    ("CAR", "U-C2", "Jorge Quispe Valdivia", "Jefe de seguridad y salud ocupacional; secretario del Comité de SSO", "Responsable de SST", "Caracolito I", "jorge.quispe@caracol.demo"),
    ("CAR", "U-C3", "Luis Huamán Cárdenas", "Jefe de guardia mina", "Responsable de actividad", "Caracolito II", "luis.huaman@caracol.demo"),
    ("CAR", "U-C4", "Carmen Rojas Villanueva", "Jefa de planta de beneficio", "Responsable de actividad", "Planta de beneficio", "carmen.rojas@caracol.demo"),
    ("CAR", "U-C5", "Víctor Mendoza Arias", "Gerente de operaciones", "Lector", "Oficina administrativa", "victor.mendoza@caracol.demo"),
    ("WIR", "U-W1", "Daniela Torres Ríos", "Jefa de administración y finanzas", "Administrador de empresa", "Oficina principal", "daniela.torres@wirbi.demo"),
    ("WIR", "U-W2", "Martín Vega Soto", "Oficial de cumplimiento; miembro del Comité de SST", "Responsable de SST", "Oficina principal", "martin.vega@wirbi.demo"),
    ("WIR", "U-W3", "Lucía Campos Herrera", "Analista de Talento Humano", "Responsable de actividad", "Oficina principal", "lucia.campos@wirbi.demo"),
    ("WIR", "U-W4", "Pedro Ramírez León", "Asistente de servicios generales", "Responsable de actividad", "Oficina principal", "pedro.ramirez@wirbi.demo"),
    ("WIR", "U-W5", "Andrés Castillo Núñez", "Gerente general", "Lector", "Oficina principal", "andres.castillo@wirbi.demo"),
]

# ---------------------------------------------------------------------------
# IPERC DEMO
# Minería: factores = (sev_lesion, sev_propiedad, sev_proceso, prob)
# MTPE:    factores = (A, B, C, D, S)   [A se deriva de expuestos]
# (id, empresa, versión, tarea, peligro, expuestos, controles existentes, factores iniciales,
#  controles propuestos, factores residuales, registrada en, fuente)
# ---------------------------------------------------------------------------
IPERC_DEMO = [
    ("IPERC-C01", "CAR", "v1 Aprobada", "CAR-T01", "PEL-M01", None, "Administrativo: desatado con barretilla y PETS",
     (2, 4, 4, "B"), "Ingeniería: sostenimiento sistemático con pernos y malla | Administrativo: capacitación en desatado y verificación del jefe de guardia", (2, 4, 4, "D"), "2026-03-02", "Supuesto"),
    ("IPERC-C02", "CAR", "v1 Aprobada", "CAR-T04", "PEL-M02", None, "Administrativo: PETS de voladura | EPP: equipo completo",
     (1, 3, 3, "C"), "Administrativo: carné vigente para todo el personal que manipula explosivos | Señalización: vigías y señales en accesos durante la voladura", (1, 3, 3, "E"), "2026-03-02", "INT002 (EV010: trámite de carné postergado)"),
    ("IPERC-C03", "CAR", "v1 Aprobada", "CAR-T05", "PEL-M04", None, "Administrativo: tiempo de espera de 30 minutos",
     (2, 5, 4, "C"), "Ingeniería: ventilador auxiliar con manga | Administrativo: medición con detector de gases antes del ingreso | EPP: autorrescatador", (2, 5, 4, "E"), "2026-03-02", "Supuesto"),
    ("IPERC-C04", "CAR", "v1 Aprobada", "CAR-T10", "PEL-M14", None, "Administrativo: límite de velocidad indicado verbalmente",
     (2, 3, 4, "C"), "Señalización: señales verticales y espejos convexos en curvas | Ingeniería: bermas de seguridad", (2, 3, 4, "D"), "2026-03-02", "INT002 (EV010: señalización de curvas)"),
    ("IPERC-C05", "CAR", "v1 Aprobada", "CAR-T02", "PEL-M07", None, "EPP: tapones auditivos",
     (3, 5, 5, "B"), "Administrativo: monitoreo de ruido y audiometrías | EPP: protección auditiva doble", (3, 5, 5, "C"), "2026-03-02", "Supuesto (caso de alerta residual: 9 → 13 sigue en Medio)"),
    ("IPERC-C06", "CAR", "v1 Aprobada", "CAR-T02", "PEL-M06", None, "Administrativo: riego ocasional del frente",
     (3, 5, 5, "B"), "Ingeniería: perforación húmeda | EPP: respirador con filtro para polvo", (3, 5, 5, "D"), "2026-03-02", "Supuesto"),
    ("IPERC-C07", "CAR", "v1 Aprobada", "CAR-T11", "PEL-M18", None, "Ingeniería: guardas parciales",
     (3, 4, 3, "C"), "Ingeniería: completar guardas y parada de emergencia | Administrativo: bloqueo y etiquetado", (3, 4, 3, "E"), "2026-03-02", "Supuesto"),
    ("IPERC-C08", "CAR", "v1 Aprobada", "CAR-T13", "PEL-M20", None, "Administrativo: hojas de datos de seguridad disponibles | EPP: guantes y lentes",
     (4, 5, 5, "C"), "—", None, "2026-03-02", "Supuesto"),
    ("IPERC-C09", "CAR", "v2 Borrador", "CAR-T08", "PEL-M01", None, "—",
     (2, 4, 3, "B"), "Administrativo: restringir el acceso hasta sostener la labor | Ingeniería: sostenimiento con cuadros antes de reanudar el tránsito", (2, 4, 3, "D"), "2026-11-06 18:30", "Supuesto (escenario RF-36)"),
    ("IPERC-W01", "WIR", "v1 Aprobada", "WIR-T01", "PEL-G01", 29, "—",
     (None, 2, 2, 3, 2), "Ingeniería: sillas regulables y soportes de monitor | Administrativo: pausas activas y evaluación ergonómica", (None, 1, 1, 3, 2), "2026-02-10", "INT001 (trabajo de oficina)"),
    ("IPERC-W02", "WIR", "v1 Aprobada", "WIR-T02", "PEL-G04", 11, "Ingeniería: tablero con interruptores termomagnéticos",
     (None, 1, 2, 3, 2), "Administrativo: prohibir extensiones en cascada e inspección semestral", (None, 1, 1, 3, 2), "2026-02-10", "INT001 (conexiones, cortocircuito)"),
    ("IPERC-W03", "WIR", "v1 Aprobada", "WIR-T04", "PEL-G11", 40, "—",
     (None, 2, 2, 3, 1), "Señalización: stickers de advertencia en microondas y cafetera", (None, 2, 1, 3, 1), "2026-02-10", "INT001 (stickers pendientes)"),
    ("IPERC-W04", "WIR", "v1 Aprobada", "WIR-T06", "PEL-G13", 1, "EPP: guantes",
     (None, 2, 2, 3, 1), "—", None, "2026-02-10", "INT001 (riesgos de limpieza)"),
    ("IPERC-W05", "WIR", "v1 Aprobada", "WIR-T06", "PEL-G07", 40, "—",
     (None, 2, 2, 3, 2), "Administrativo: señal de piso mojado y limpieza fuera de horas punta", (None, 1, 1, 3, 2), "2026-02-10", "INT001 (riesgos de limpieza)"),
    ("IPERC-W06", "WIR", "v1 Aprobada", "WIR-T11", "PEL-G06", 40, "Administrativo: plan de respuesta ante emergencias",
     (None, 2, 2, 1, 3), "Ingeniería: anclaje de estantes | Administrativo: brigada formalizada y 2 simulacros al año", (None, 1, 1, 1, 3), "2026-02-10", "INT001 (sismo, brigadistas)"),
    ("IPERC-W07", "WIR", "v1 Aprobada", "WIR-T08", "PEL-G17", 6, "—",
     (None, 2, 2, 2, 3), "Eliminación: reuniones virtuales cuando sea posible | Administrativo: capacitación en seguridad vial", (None, 1, 1, 1, 3), "2026-02-10", "INT001 (seguridad fuera de la oficina)"),
    ("IPERC-W08", "WIR", "v2 Borrador", "WIR-T05", "PEL-G10", 40, "—",
     (None, 3, 2, 3, 1), "Sustitución: cuchillo especializado para pan | Señalización: indicar el uso de cada cuchillo", (None, 1, 1, 3, 1), "2026-10-29", "INT001 (incidente con cuchillo); creada con RF-34"),
]

# ---------------------------------------------------------------------------
# ESCENARIO DEMO
# (id, empresa, módulo, tipo, descripción, estado, fecha/plazo, responsable, origen o vínculo, fuente, estado del dato)
# ---------------------------------------------------------------------------
ESCENARIO = [
    ("E-C01", "CAR", "M2 Diagnóstico", "Diagnóstico 2026", "Diagnóstico de línea base completado (respuestas en la hoja Diagnóstico)", "Completado", "2026-02-15", "U-C2", "—", "Supuesto basado en INT002", "S"),
    ("E-C02", "CAR", "M3 IPERC", "Documento", "IPERC de línea base 2026 v1 (metodología minería), 8 filas", "Aprobado", "2026-03-10", "U-C2", "Hoja IPERC demo", "Supuesto", "S"),
    ("E-C03", "CAR", "M4 Plan", "Documento", "Programa anual de SSO 2026 v1", "Aprobado", "2026-03-20", "U-C2", "Brechas + controles + actividades base minería", "INT002 (programa anual)", "V"),
    ("E-C04", "CAR", "M4/M5", "Actividad del plan", "Tramitar el carné para el personal que manipula explosivos", "Vencida (programada sin ejecución)", "2026-06-30", "U-C1", "Control propuesto de IPERC-C02", "INT002, EV010 (postergado varios meses)", "V"),
    ("E-C05", "CAR", "M5 Seguimiento", "Hallazgo", "Curvas sin señalización en la vía Caracolito II – Planta de beneficio (inspección del 20/08/2026). Criticidad alta", "Con acción", "2026-08-20", "U-C2", "Vinculado a IPERC-C04", "INT002, EV010 (pedido del presidente del comité)", "V"),
    ("E-C06", "CAR", "M5 Seguimiento", "Acción correctiva", "Instalar señalización vertical y espejos convexos en las curvas de la vía", "Asignada (vencida)", "2026-09-30", "U-C4", "Hallazgo E-C05", "INT002, EV010", "V"),
    ("E-C07", "CAR", "M4/M5", "Actividad base", "Reunión ordinaria del Comité de SSO – octubre", "Verificada", "2026-10-09", "U-C2", "AB-M01", "INT002", "S"),
    ("E-C08", "CAR", "M5 Seguimiento", "Evidencia", "Acta del Comité de SSO – octubre 2026 (PDF)", "Registrada", "2026-10-09", "U-C2", "Actividad E-C07", "Supuesto", "S"),
    ("E-C09", "CAR", "M4/M5", "Actividad base", "Reunión ordinaria del Comité de SSO – noviembre", "Programada", "2026-11-10", "U-C2", "AB-M01", "INT002", "S"),
    ("E-C10", "CAR", "M4/M5", "Actividad base", "Inspección de extintores y botiquines – octubre (formato fotografiado)", "Verificada", "2026-10-31", "U-C2", "AB-M06 / AB-M07", "INT002 (libro de seguridad)", "S"),
    ("E-C11", "CAR", "M4/M5", "Actividad de brecha", "Elaborar el procedimiento de gestión del cambio", "En curso", "2026-06-30", "U-C2", "Brecha del ítem 92 (NC)", "Supuesto", "S"),
    ("E-C12", "CAR", "M3 IPERC", "Documento", "IPERC 2026 v2 en borrador por apertura de nueva labor en Caracolito II", "Borrador", "2026-11-06", "U-C2", "Cambio de proceso (DS N.° 024-2016-EM, art. 97)", "Supuesto (escenario RF-36)", "S"),
    ("E-C13", "CAR", "M5 Seguimiento", "Acción inmediata (RF-36)", "Restringir el acceso y sostener la nueva labor antes de reanudar el tránsito (riesgo Alto, nivel 5)", "En implementación; aviso en campana al responsable de SST", "2026-11-07 18:30 (24 h desde el registro)", "U-C3", "Evaluación de IPERC-C09 registrada el 06/11/2026 18:30", "Supuesto (escenario RF-36)", "S"),
    ("E-C14", "CAR", "M4/M5", "Actividad base", "Simulacro de emergencia en interior mina – IV trimestre", "Programada", "2026-12-05", "U-C3", "AB-M11", "INT002 (programa de simulacros)", "S"),
    ("E-W01", "WIR", "M2 Diagnóstico", "Diagnóstico 2026", "Diagnóstico de línea base completado (respuestas en la hoja Diagnóstico)", "Completado", "2026-01-30", "U-W2", "—", "Supuesto basado en INT001", "S"),
    ("E-W02", "WIR", "M3 IPERC", "Documento", "IPERC 2026 v1 (metodología MTPE), 7 filas de muestra", "Aprobado", "2026-02-20", "U-W2", "Hoja IPERC demo", "INT001 (IPERC revisada y aprobada por el comité)", "V"),
    ("E-W03", "WIR", "M4 Plan", "Documento", "Plan anual de SST 2026 v1", "Aprobado", "2026-03-05", "U-W2", "Brechas + controles + actividades base generales", "INT001 (plan y checklist)", "V"),
    ("E-W04", "WIR", "M5 Seguimiento", "Hallazgo", "Carta de SUNAFIL: exige plan de contingencias y emergencias, brigada formada y capacitada y simulacros (15/09/2026)", "Con acción", "2026-09-15", "U-W2", "Origen: auditoría (requerimiento de fiscalización)", "INT001, EV004", "V"),
    ("E-W05", "WIR", "M5 Seguimiento", "Acción correctiva", "Actualizar el plan de respuesta ante emergencias", "Verificada", "2026-09-25", "U-W2", "Hallazgo E-W04", "INT001, EV004", "V"),
    ("E-W06", "WIR", "M5 Seguimiento", "Acción correctiva", "Reunión extraordinaria del comité y acta de designación de brigadistas", "Verificada", "2026-09-22", "U-W2", "Hallazgo E-W04", "INT001, EV004", "V"),
    ("E-W07", "WIR", "M5 Seguimiento", "Acción correctiva", "Entrenamiento de brigadistas (evidencia: lista de asistencia)", "Por verificar (debe verificarla un usuario distinto del responsable)", "2026-10-15", "U-W3", "Hallazgo E-W04", "INT001, EV004", "V"),
    ("E-W08", "WIR", "M4/M5", "Actividad base", "Simulacro de sismo (2.º del año)", "Programada", "2026-11-20", "U-W4", "AB-G04", "INT001 (2 simulacros al año)", "V"),
    ("E-W09", "WIR", "M4/M5", "Actividad base", "Inspección de extintores y botiquín – octubre (botiquín con alcohol y gasas vencidos)", "Vencida", "2026-10-15", "U-W4", "AB-G06", "INT001, EV006", "V"),
    ("E-W10", "WIR", "M4/M5", "Actividad base", "Mantenimiento de alarmas, detectores y rociadores – II semestre", "En curso", "2026-09-30", "U-W4", "AB-G08", "INT001, EV006", "V"),
    ("E-W11", "WIR", "M4/M5", "Actividad base", "Capacitación en SST 3 de 4", "Verificada", "2026-09-30", "U-W3", "AB-G01", "INT001 (4 capacitaciones al año)", "S"),
    ("E-W12", "WIR", "M4/M5", "Actividad base", "Capacitación en SST 4 de 4", "Programada", "2026-12-10", "U-W3", "AB-G01", "INT001", "S"),
    ("E-W13", "WIR", "M4/M5", "Actividad de brecha", "Inducción en SST a los nuevos ingresos del segundo semestre", "Vencida", "2026-08-31", "U-W3", "Brecha del ítem 53 (P)", "INT001 (inducciones pendientes)", "V"),
    ("E-W14", "WIR", "M4/M5", "Actividad de control", "Colocar stickers de advertencia en el microondas y la cafetera", "Vencida (diseñados, no colocados; sin evidencia)", "2026-10-31", "U-W4", "Control propuesto de IPERC-W03", "INT001 (stickers pendientes)", "V"),
    ("E-W15", "WIR", "M5 Seguimiento", "Hallazgo", "Incidente en la cocina: corte en la mano al usar un cuchillo inadecuado (observación del 28/10/2026)", "Con acción", "2026-10-28", "U-W2", "Origen: observación", "INT001 (incidente con cuchillo)", "S"),
    ("E-W16", "WIR", "M5 Seguimiento", "Acción correctiva", "Designar un cuchillo para pan y colocar soporte y señalización", "Asignada", "2026-11-15", "U-W4", "Hallazgo E-W15", "INT001", "S"),
    ("E-W17", "WIR", "M3 IPERC", "Documento (RF-34)", "IPERC 2026 v2 en borrador creada con «Agregar a la IPERC» desde el hallazgo E-W15 (fila IPERC-W08 precargada)", "Borrador", "2026-10-29", "U-W2", "Hallazgo E-W15", "INT001 (riesgos de cocina añadidos)", "S"),
    ("E-W18", "WIR", "M4/M5", "Actividad base", "Reunión del Comité de SST (quincenal)", "Programada", "2026-11-12", "U-W2", "AB-G03", "INT001 (comité quincenal)", "V"),
]
