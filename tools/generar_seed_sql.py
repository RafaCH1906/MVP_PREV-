# -*- coding: utf-8 -*-
"""Genera supabase/seed.sql y src/lib/iperc/semilla-casos.json a partir del contenido semilla v0.1
(carpeta semilla/). Si el equipo corrige un dato en semilla_datos.py o semilla_diagnostico.py,
se vuelve a ejecutar:   python tools/generar_seed_sql.py

Todo es un ESCENARIO DE DEMOSTRACIÓN (no datos reales). La marca V/S (verificado/supuesto) se conserva
tal como la declaró el equipo MBA, solo como referencia de qué falta validar.
"""
import json, re, sys, uuid, unicodedata
from pathlib import Path

RAIZ = Path(__file__).resolve().parent.parent
sys.path.insert(0, str(RAIZ / "semilla"))
import semilla_datos as D          # noqa: E402
import semilla_diagnostico as G    # noqa: E402

NS = uuid.UUID("6f2a8c1e-3b7d-4e55-9a10-5e7e0c0de001")
def uid(*p): return str(uuid.uuid5(NS, "|".join(str(x) for x in p)))

def q(v):
    if v is None: return "NULL"
    if isinstance(v, bool): return "true" if v else "false"
    if isinstance(v, (int, float)): return str(v)
    return "'" + str(v).replace("'", "''") + "'"
def qj(v): return q(json.dumps(v, ensure_ascii=False)) + "::jsonb"
def qts(s): return q(s) + "::timestamptz"

out = []
def ins(tabla, cols, filas):
    if not filas: return
    out.append(f"insert into {tabla} ({', '.join(cols)}) values")
    out.append(",\n".join("  (" + ", ".join(f) + ")" for f in filas) + ";\n")

def sin_tildes(s): return "".join(c for c in unicodedata.normalize("NFD", s) if unicodedata.category(c) != "Mn")

# ---------------------------------------------------------------- config
ins("config", ["clave", "valor"], [[q("fecha_referencia"), q(D.FECHA_REFERENCIA)],
                                    [q("reloj_demo"), q("2026-11-07T13:20:00-05:00")]])

# ---------------------------------------------------------------- empresas
EMP = {}
filas = []
for e in D.EMPRESAS:
    EMP[e["codigo"]] = uid("empresa", e["codigo"])
    plan, comite = [x.strip() for x in e["etiquetas"].split(";")]
    filas.append([q(EMP[e["codigo"]]), q(e["codigo"]), q(e["ruc"]), q(e["razon_social"]), q(e["ciiu"]), q(e["domicilio"]),
                  q(e["sector"]), q("MINERIA" if e["metodologia"] == "MIN" else "MTPE"), q(e["n_trabajadores"]),
                  q(e["organo_sst"]), q(e["fiscalizador"]), q(plan), q(comite), "true", q(e["estado"]), q(e["fuente"])])
ins("empresa", ["id", "codigo", "ruc", "razon_social", "ciiu", "domicilio", "sector", "metodologia", "n_trabajadores",
                "organo_sst", "fiscalizador", "etiqueta_plan", "etiqueta_comite", "es_demo", "estado_dato", "fuente"], filas)

# ---------------------------------------------------------------- usuarios
ROL = {"Administrador de empresa": "ADMIN", "Responsable de SST": "SST", "Responsable de actividad": "ACTIVIDAD", "Lector": "LECTOR"}
USR, USR_EMP, USR_ROL = {}, {}, {}
filas = []
for emp, cod, nombre, cargo, rol, sede, correo in D.USUARIOS:
    login = correo.split("@")[0]        # usuario = parte local del correo de la semilla (ej. jorge.quispe); el correo no se guarda
    USR[cod] = uid("usuario", cod); USR_EMP[cod] = emp; USR_ROL[cod] = ROL[rol]
    filas.append([q(USR[cod]), q(EMP[emp]), q(cod), q(nombre), q(cargo), q(login), q("{" + ROL[rol] + "}"), q(sede)])
ins("usuario", ["id", "empresa_id", "codigo", "nombre", "cargo", "usuario_login", "roles", "sede"], filas)
def usuario_con_rol(emp, rol):
    return next(USR[c] for c in USR if USR_EMP[c] == emp and USR_ROL[c] == rol)

# ---------------------------------------------------------------- sedes / áreas / puestos
SEDE, SEDE_EMP = {}, {}
filas = []
for emp, cod, nombre, ubic, tipo, est in D.SEDES:
    SEDE[cod] = uid("sede", cod); SEDE_EMP[cod] = emp
    filas.append([q(SEDE[cod]), q(EMP[emp]), q(cod), q(nombre), q(ubic), q(tipo), q(est)])
ins("sede", ["id", "empresa_id", "codigo", "nombre", "ubicacion", "tipo", "estado_dato"], filas)
areas, puestos = [], []
for sede, ars in D.ESTRUCTURA.items():
    emp = SEDE_EMP[sede]
    for area, pts in ars.items():
        aid = uid("area", sede, area)
        areas.append([q(aid), q(EMP[emp]), q(SEDE[sede]), q(area)])
        for pn, n in pts:
            puestos.append([q(uid("puesto", sede, area, pn)), q(EMP[emp]), q(aid), q(pn), q(n)])
ins("area", ["id", "empresa_id", "sede_id", "nombre"], areas)
ins("puesto", ["id", "empresa_id", "area_id", "nombre", "n_trabajadores"], puestos)

# ---------------------------------------------------------------- tareas
TAREA = {}
filas, vinc = [], []
for emp, proc, act, tipo, cod, nombre, sedes, pts, fuente, est in D.PROCESOS:
    TAREA[cod] = uid("tarea", cod)
    filas.append([q(TAREA[cod]), q(EMP[emp]), q(cod), q(proc), q(act), q(nombre), q(tipo == "Rutinaria"), q(sedes), q(fuente), q(est)])
    nombres_p = [p.strip() for p in pts.split(";")]
    filtro = "" if "Todos los puestos" in nombres_p else " and p.nombre in (" + ", ".join(q(n) for n in nombres_p) + ")"
    vinc.append(f"insert into tarea_puesto select {q(TAREA[cod])}::uuid, p.id from puesto p where p.empresa_id = {q(EMP[emp])}::uuid{filtro};")
ins("tarea", ["id", "empresa_id", "codigo", "proceso", "actividad", "nombre", "rutinaria", "sedes", "fuente", "estado_dato"], filas)
out.append("\n".join(vinc) + "\n")

# ---------------------------------------------------------------- catálogo de peligros
JER = ["ELIMINACION", "SUSTITUCION", "INGENIERIA", "ADMINISTRATIVO", "EPP"]
PEL = {}
filas, ctrl = [], []
for c in D.CATALOGO:
    cod, sector, tipo, pel, riesgo, cons, smt, smi = c[:8]
    PEL[cod] = uid("peligro", cod)
    filas.append([q(PEL[cod]), q(cod), q(sector), q(tipo), q(pel), q(riesgo), q(cons), q(smt), q(smi)])
    for j, txt in zip(JER, c[8:13]):
        if txt and txt != "—": ctrl.append([q(uid("ccat", cod, j)), q(PEL[cod]), q(j), q(txt)])
ins("peligro_catalogo", ["id", "codigo", "sector", "tipo", "peligro", "riesgo", "consecuencia", "sev_mtpe", "sev_mineria"], filas)
ins("control_catalogo", ["id", "peligro_id", "jerarquia", "descripcion"], ctrl)

# ---------------------------------------------------------------- actividades base
OBJ_BASE = {}
filas = []
for a in D.ACTIVIDADES_BASE:
    cod, sector, act, tipo, fmin, base, fcar, fwir, meses, obj, fuente, est = a
    OBJ_BASE[cod] = obj
    filas.append([q(uid("ab", cod)), q(cod), q(sector), q(act), q(tipo), q(fmin), q(base),
                  qj({"CAR": fcar, "WIR": fwir}), q(meses), q(obj), q(fuente), q(est)])
ins("actividad_base_plantilla", ["id", "codigo", "sector", "actividad", "tipo", "frecuencia_minima", "base_normativa",
                                 "frecuencia_por_empresa", "meses", "objetivo", "fuente", "estado_dato"], filas)

# ---------------------------------------------------------------- diagnóstico
items = json.load(open(RAIZ / "semilla" / "diagnostico_lineabase_items.json", encoding="utf-8"))
filas = []
for it in items:
    ayuda, accion = G.AYUDA_ACCION[it["n"]]
    filas.append([q(it["n"]), q(it["bloque_num"]), q(it["bloque"]), q(it["subseccion"]), q(it["indicador"]),
                  q(ayuda), q(accion), q(G.BASE.get(it["subseccion"])), "1"])
ins("diagnostico_item", ["n", "bloque_num", "bloque", "subseccion", "indicador", "ayuda", "accion_sugerida", "base_normativa", "peso"], filas)
filas = []
for emp, resp in (("CAR", G.RESP_CARACOL), ("WIR", G.RESP_WIRBI)):
    for n, est in sorted(resp.items()):
        filas.append([q(EMP[emp]), q(n), q(est)])
ins("diagnostico_respuesta", ["empresa_id", "item_n", "estado"], filas)

# ---------------------------------------------------------------- motor de referencia (independiente del TS) para IPERC
def clasif_de(tabla, nivel):
    for mn, mx, nombre, *_r, orden in tabla:
        if mn <= nivel <= mx: return nombre, orden
    raise ValueError(nivel)
def eval_min(sl, sp, spr, prob):
    sev = min(sl, sp, spr)
    nivel = D.MIN_MATRIZ[sev][D.MIN_PROB.index(prob)]
    c, o = clasif_de(D.MIN_NIVELES, nivel)
    return dict(lesion=sl, propiedad=sp, proceso=spr, severidad=sev, prob=prob, modificada=False), nivel, c, o
def indice_a(exp): return 1 if exp <= 3 else (2 if exp <= 12 else 3)
def eval_mtpe(exp, B, C, Dd, S):
    A = indice_a(exp); nivel = (A + B + C + Dd) * S
    c, o = clasif_de(D.MTPE_NIVELES, nivel)
    return dict(A=A, B=B, C=C, D=Dd, S=S), nivel, c, o

# ---------------------------------------------------------------- IPERC
fecha_v1 = {}
for e in D.ESCENARIO:
    if e[3] == "Documento" and "IPERC" in e[4] and "v1" in e[4]: fecha_v1[e[1]] = e[6]
VER = {}
filas = []
for emp in EMP:
    sst = usuario_con_rol(emp, "SST")
    for v, est in ((1, "APROBADO"), (2, "BORRADOR")):
        VER[(emp, v)] = uid("ipercv", emp, v)
        filas.append([q(VER[(emp, v)]), q(EMP[emp]), "2026", str(v), q(est),
                      q(sst) if v == 1 else "NULL", q(fecha_v1.get(emp)) if v == 1 else "NULL"])
ins("iperc_version", ["id", "empresa_id", "anio", "version", "estado", "aprobado_por", "aprobado_en"], filas)

PREF = {"Eliminación": "ELIMINACION", "Sustitución": "SUSTITUCION", "Ingeniería": "INGENIERIA",
        "Administrativo": "ADMINISTRATIVO", "Señalización": "ADMINISTRATIVO", "EPP": "EPP"}
def partir_controles(txt):
    if not txt or txt.strip() == "—": return []
    res = []
    for parte in txt.split("|"):
        pref, _, desc = parte.strip().partition(":")
        res.append((PREF[pref.strip()], (desc.strip()[0].upper() + desc.strip()[1:]) if desc.strip() else pref))
    return res
def ts_registro(s): return s + ":00-05:00" if " " in s and len(s) > 10 else s + "T00:00:00-05:00"

FILA, CTRL_PROP, casos = {}, {}, []
filas_f, filas_c = [], []
empresa_de = {"C": "CAR", "W": "WIR"}
for (fid, emp, ver, tarea, pel, expuestos, ctrl_ex, fi, ctrl_pr, fr, reg, fuente) in D.IPERC_DEMO:
    mtpe = emp == "WIR"
    if mtpe:
        ei, ni, ci, oi = eval_mtpe(expuestos, *fi[1:])
        er = nr = cr = None
        if fr: er, nr, cr, orr = eval_mtpe(expuestos, *fr[1:])
        umbral = clasif_de(D.MTPE_NIVELES, 16)[1]   # Moderado
    else:
        ei, ni, ci, oi = eval_min(*fi)
        er = nr = cr = None
        if fr: er, nr, cr, orr = eval_min(*fr)
        umbral = 2                                  # Medio
    signif = oi >= umbral
    FILA[fid] = uid("fila", fid)
    v = 1 if ver.startswith("v1") else 2
    filas_f.append([q(FILA[fid]), q(EMP[emp]), q(VER[(emp, v)]), q(fid), q(TAREA[tarea]), q(PEL[pel]), q(expuestos),
                    qj(ei), q(ni), q(ci), q(signif), qj(er) if er else "NULL", q(nr), q(cr), qts(ts_registro(reg)), q(fuente)])
    CTRL_PROP[fid] = []
    for existente, txt in ((True, ctrl_ex), (False, ctrl_pr)):
        for j, (jer, desc) in enumerate(partir_controles(txt)):
            cid = uid("control", fid, existente, j)
            if not existente: CTRL_PROP[fid].append(cid)
            filas_c.append([q(cid), q(EMP[emp]), q(FILA[fid]), q(fid), q(jer), q(desc), q(existente)])
    casos.append(dict(id=fid, metodologia="MTPE" if mtpe else "MINERIA", expuestos=expuestos,
                      inicial=dict(factores=ei, nivel=ni, clasificacion=ci),
                      residual=dict(factores=er, nivel=nr, clasificacion=cr) if er else None,
                      significativo=signif))
ins("iperc_fila", ["id", "empresa_id", "iperc_id", "codigo", "tarea_id", "peligro_id", "n_expuestos", "eval_inicial", "nivel_inicial",
                   "clasif_inicial", "significativo", "eval_residual", "nivel_residual", "clasif_residual", "registrado_en", "fuente"], filas_f)
ins("control", ["id", "empresa_id", "fila_id", "codigo", "jerarquia", "descripcion", "existente"], filas_c)
(RAIZ / "src/lib/iperc").mkdir(parents=True, exist_ok=True)
(RAIZ / "src/lib/iperc/semilla-casos.json").write_text(json.dumps(casos, ensure_ascii=False, indent=1), encoding="utf-8")

# ---------------------------------------------------------------- escenario (documentos, hallazgos, actividades, acciones, evidencias)
FECHA = re.compile(r"(\d{4}-\d{2}-\d{2})(?: (\d{2}:\d{2}))?")
def fecha_de(s):
    m = FECHA.search(s); return m.group(1), m.group(2)
def vence(s):
    f, h = fecha_de(s); return f"{f}T{h or '23:59'}:00-05:00"
def estado_act(s):
    s = s.lower()
    if s.startswith("verificada"): return "VERIFICADA"
    if s.startswith("ejecutada"): return "EJECUTADA"
    if s.startswith("en curso"): return "EN_CURSO"
    return "PROGRAMADA"                         # "Vencida" se calcula con la fecha (v_actividad)
def estado_accion(s):
    s = s.lower()
    if s.startswith("verificada"): return "VERIFICADA"
    if s.startswith("por verificar"): return "POR_VERIFICAR"
    if s.startswith("en implementación"): return "EN_IMPLEMENTACION"
    return "ASIGNADA"

HITO, HALL, ACT, ACC, EVI = [], [], [], [], []
REF = {}                                        # ref semilla -> uuid
for e in D.ESCENARIO:
    ref, emp, mod, tipo, desc, estado, fecha, resp, vinculo, fuente, est = e
    REF[ref] = uid("esc", ref)
for e in D.ESCENARIO:
    ref, emp, mod, tipo, desc, estado, fecha, resp, vinculo, fuente, est = e
    rid, f = REF[ref], fecha_de(fecha)[0]
    if tipo.startswith("Diagnóstico") or tipo.startswith("Documento"):
        t = "DIAGNOSTICO" if tipo.startswith("Diagnóstico") else ("IPERC" if "IPERC" in desc else "PLAN")
        HITO.append([q(rid), q(EMP[emp]), q(t), q(desc), q(estado), q(f), q(USR[resp]), q(ref), q(est), q(fuente)])
    elif tipo == "Hallazgo":
        origen = "AUDITORIA" if "auditoría" in vinculo else ("OBSERVACION" if "observación" in (vinculo + desc).lower() else "INSPECCION")
        mfila = re.search(r"IPERC-[CW]\d+", vinculo)
        fila = FILA.get(mfila.group(0)) if mfila else None
        if ref == "E-W15": fila = FILA["IPERC-W08"]          # RF-34: fila creada desde este hallazgo
        crit = "Alta" if "criticidad alta" in desc.lower() else None
        HALL.append([q(rid), q(EMP[emp]), q(origen), q(desc), "NULL", q(crit), q(f), q("CON_ACCION"), q(fila), q(USR[resp]), q(ref), q(est)])
    elif tipo.startswith("Actividad"):
        if vinculo.startswith("AB-"):
            pc = vinculo.split("/")[0].strip(); origen, obj, ci_, br = "BASE", OBJ_BASE[pc], None, None
        elif vinculo.startswith("Brecha"):
            pc, origen, obj, ci_, br = None, "BRECHA", "Cerrar brechas del sistema de gestión", None, int(re.search(r"ítem (\d+)", vinculo).group(1))
        else:
            fid = re.search(r"IPERC-[CW]\d+", vinculo).group(0)
            pc, origen, obj, br, ci_ = None, "CONTROL", "Controlar los riesgos significativos", None, CTRL_PROP[fid][0]
        ACT.append([q(rid), q(EMP[emp]), q(obj), q(origen), q(ci_), "NULL", q(pc), q(br), q(desc), q(USR[resp]), q(f),
                    q(estado_act(estado)), q(ref), q(est)])
    elif tipo.startswith("Acción"):
        inm = "inmediata" in tipo.lower()
        if vinculo.startswith("Hallazgo"):
            h, c_ = REF[vinculo.split()[-1]], None
        else:
            h, c_ = None, CTRL_PROP[re.search(r"IPERC-[CW]\d+", vinculo).group(0)][0]
        est_a = estado_accion(estado)
        verif = None
        if est_a == "VERIFICADA":
            sst = usuario_con_rol(emp, "SST")
            verif = sst if sst != USR[resp] else usuario_con_rol(emp, "ADMIN")
        ACC.append([q(rid), q(EMP[emp]), q(h), q(c_), q(desc), q(inm), q(USR[resp]), qts(vence(fecha)), q(est_a), q(verif), q(ref), q(est)])
    elif tipo == "Evidencia":
        ACT_REF = REF[vinculo.split()[-1]]
        EVI.append([q(rid), q(EMP[emp]), q(ACT_REF), "NULL", q("PDF"), q(f"demo://evidencias/{ref}.pdf"), q(desc), q(USR[resp]), q(ref)])
    else:
        raise SystemExit(f"Tipo de escenario no manejado: {tipo} ({ref})")

ins("hito_documento", ["id", "empresa_id", "tipo", "titulo", "estado", "fecha", "responsable_id", "ref_semilla", "estado_dato", "fuente"], HITO)
ins("hallazgo", ["id", "empresa_id", "origen", "descripcion", "ubicacion", "criticidad", "fecha", "estado", "fila_id", "registrado_por", "ref_semilla", "estado_dato"], HALL)
ins("actividad", ["id", "empresa_id", "objetivo", "origen", "control_id", "hallazgo_id", "plantilla_codigo", "brecha_item", "descripcion",
                  "responsable_id", "fecha_fin", "estado", "ref_semilla", "estado_dato"], ACT)
ins("accion", ["id", "empresa_id", "hallazgo_id", "control_id", "descripcion", "inmediata", "responsable_id", "vence_en", "estado",
               "verificada_por", "ref_semilla", "estado_dato"], ACC)
ins("evidencia", ["id", "empresa_id", "actividad_id", "accion_id", "tipo", "url", "nota", "registrado_por", "ref_semilla"], EVI)

out.append("""-- Para ensayar la demo con la hora real: deja la acción inmediata a 5 h 10 min de vencer y usa el reloj del sistema.
create or replace function demo_reiniciar_contador() returns void language sql as $$
  update config set valor = '' where clave = 'reloj_demo';
  update accion set vence_en = now() + interval '5 hours 10 minutes', estado = 'EN_IMPLEMENTACION' where ref_semilla = 'E-C13';
$$;
""")

cab = ("-- GENERADO por tools/generar_seed_sql.py a partir de semilla/ (contenido semilla v0.1 del equipo MBA). No editar a mano.\n"
       "-- ESCENARIO DE DEMOSTRACIÓN: datos de entrevistas y supuestos, no reales. La marca estado_dato (V/S) es la que declaró el equipo.\n\n")
(RAIZ / "supabase/seed.sql").write_text(cab + "\n".join(out), encoding="utf-8")
print("seed.sql generado:", sum(1 for _ in open(RAIZ / "supabase/seed.sql", encoding="utf-8")), "líneas;",
      "filas IPERC:", len(filas_f), "| controles:", len(filas_c), "| actividades:", len(ACT), "| acciones:", len(ACC),
      "| hallazgos:", len(HALL), "| evidencias:", len(EVI), "| hitos:", len(HITO))
