"use client";
import { useEffect, useState } from "react";
import { supabase } from "@/lib/supabase";
import { useAuth } from "@/lib/auth";
import { useCarga, ok } from "@/lib/hooks";
import { Cargando } from "@/lib/ui";
import { puedeGestionar } from "@/lib/roles";

type E = { id: string; razon_social: string; ruc: string; ciiu: string | null; sector: string; metodologia: string; n_trabajadores: number | null; domicilio: string | null };
type S = { id: string; codigo: string; nombre: string; ubicacion: string | null };
type A = { id: string; sede_id: string; nombre: string };
type P = { id: string; area_id: string; nombre: string; n_trabajadores: number };
type T = { id: string; codigo: string; proceso: string; nombre: string; en_alcance: boolean | null };

/** E01–E04 · Datos de la empresa, sedes → áreas → puestos y tareas en alcance (RF-01…RF-04). */
export default function Empresa() {
  const { perfil } = useAuth();
  const gest = puedeGestionar(perfil);
  const [v, setV] = useState(0);
  const [msg, setMsg] = useState<string | null>(null);
  const { datos, cargando, error } = useCarga(async () => ({
    e: (ok(await supabase.from("empresa").select("id,razon_social,ruc,ciiu,sector,metodologia,n_trabajadores,domicilio").limit(1)) as E[])[0],
    s: ok(await supabase.from("sede").select("id,codigo,nombre,ubicacion").order("codigo")) as S[],
    a: ok(await supabase.from("area").select("id,sede_id,nombre").order("nombre")) as A[],
    p: ok(await supabase.from("puesto").select("id,area_id,nombre,n_trabajadores").order("nombre")) as P[],
    t: ok(await supabase.from("tarea").select("id,codigo,proceso,nombre,en_alcance").order("codigo")) as T[],
  }), [perfil, v]);
  const [f, setF] = useState<Partial<E>>({});
  useEffect(() => { if (datos) setF(datos.e); }, [datos]);
  if (cargando) return <Cargando />;
  if (error || !datos) return <Cargando error={error} />;
  const { e, s, a, p, t } = datos;
  const run = async (q: PromiseLike<{ error: { message: string } | null }>, okMsg: string) => {
    const { error: er } = await q; setMsg(er ? `No se pudo guardar: ${er.message}` : okMsg); if (!er) setV((x) => x + 1);
  };
  const guardarEmpresa = () => run(supabase.from("empresa").update({ ciiu: f.ciiu || null, n_trabajadores: f.n_trabajadores ?? null, domicilio: f.domicilio || null }).eq("id", e.id), "✓ Datos de la empresa guardados");
  const nuevaArea = (sede_id: string) => { const n = prompt("Nombre del área"); if (n) run(supabase.from("area").insert({ id: crypto.randomUUID(), empresa_id: e.id, sede_id, nombre: n }), "✓ Área creada"); };
  const nuevoPuesto = (area_id: string) => { const n = prompt("Nombre del puesto"); if (!n) return; const c = Number(prompt("N.º de trabajadores en el puesto", "1")) || 1; run(supabase.from("puesto").insert({ id: crypto.randomUUID(), empresa_id: e.id, area_id, nombre: n, n_trabajadores: c }), "✓ Puesto creado"); };
  const nuevaSede = () => { const n = prompt("Nombre de la sede"); if (n) run(supabase.from("sede").insert({ id: crypto.randomUUID(), empresa_id: e.id, codigo: `SED-S${String(s.length + 1).padStart(2, "0")}-${Date.now() % 1000}`, nombre: n }), "✓ Sede creada"); };
  const alcance = (x: T) => run(supabase.from("tarea").update({ en_alcance: x.en_alcance === false }).eq("id", x.id), "✓ Alcance actualizado");
  const nuevaTarea = () => {
    const n = prompt("Nombre de la tarea"); if (!n) return; const pr = prompt("Proceso al que pertenece", t[0]?.proceso ?? ""); if (!pr) return;
    run(supabase.from("tarea").insert({ id: crypto.randomUUID(), empresa_id: e.id, codigo: `TAR-${Date.now() % 100000}`, proceso: pr, nombre: n, en_alcance: true }), "✓ Tarea agregada");
  };
  const inp = (k: keyof E, lbl: string, num = false) => (
    <div className="field"><span className="k">{lbl}</span>
      {gest ? <input className="in" type={num ? "number" : "text"} value={(f[k] as string | number | null) ?? ""} onChange={(ev) => setF({ ...f, [k]: num ? (ev.target.value === "" ? null : Number(ev.target.value)) : ev.target.value })} /> : <span className="in">{(e[k] as string | number | null) ?? "—"}</span>}
    </div>);
  const fijo = (lbl: string, val: string) => <div className="field"><span className="k">{lbl}</span><span className="in">{val}</span></div>;
  const enAlcance = t.filter((x) => x.en_alcance !== false).length;
  return (
    <div>
      {msg && <p className="warn" style={{ fontSize: 13 }}>{msg}</p>}
      <div className="row">
        <div className="col"><div className="blk"><h4>Datos de la empresa</h4>
          {fijo("Razón social", e.razon_social)}{fijo("RUC", e.ruc)}{inp("ciiu", "CIIU")}{fijo("Sector", e.sector)}
          {fijo("Metodología IPERC", e.metodologia === "MINERIA" ? "Minería (DS 024-2016-EM)" : "MTPE (RM 050-2013-TR)")}
          {inp("n_trabajadores", "N.º de trabajadores", true)}{inp("domicilio", "Domicilio")}
          {gest && <button className="btn pri" onClick={guardarEmpresa}>Guardar datos</button>}</div></div>
        <div className="col"><div className="blk"><h4>Sedes, áreas y puestos</h4>
          {s.map((x) => <div key={x.id} style={{ fontSize: 13, margin: "6px 0" }}>
            <b>{x.codigo}</b> · {x.nombre}{x.ubicacion ? ` · ${x.ubicacion}` : ""} {gest && <button className="btn" onClick={() => nuevaArea(x.id)}>+ Área</button>}
            {a.filter((y) => y.sede_id === x.id).map((y) => <div key={y.id} style={{ marginLeft: 14 }}>▸ {y.nombre} {gest && <button className="btn" onClick={() => nuevoPuesto(y.id)}>+ Puesto</button>}
              {p.filter((z) => z.area_id === y.id).map((z) => <div key={z.id} style={{ marginLeft: 16, color: "var(--muted, #555)" }}>· {z.nombre} ({z.n_trabajadores} trab.)</div>)}</div>)}
          </div>)}
          {gest && <button className="btn" onClick={nuevaSede}>+ Sede</button>}</div></div>
      </div>
      <div className="blk"><h4>Tareas en alcance · {enAlcance} de {t.length}</h4>
        <div className="scroll"><table className="mini"><thead><tr><th>Código</th><th>Proceso</th><th>Tarea</th><th>En alcance</th></tr></thead><tbody>
          {t.map((x) => <tr key={x.id}><td>{x.codigo}</td><td>{x.proceso}</td><td>{x.nombre}</td>
            <td>{gest ? <input type="checkbox" checked={x.en_alcance !== false} onChange={() => alcance(x)} /> : x.en_alcance === false ? "No" : "Sí"}</td></tr>)}
        </tbody></table></div>
        {gest && <button className="btn" onClick={nuevaTarea}>+ Tarea</button>}</div>
    </div>
  );
}
