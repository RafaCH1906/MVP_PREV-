"use client";
import { supabase } from "@/lib/supabase";
import { useAuth } from "@/lib/auth";
import { useCarga, ok } from "@/lib/hooks";
import { Cargando } from "@/lib/ui";

type E = { razon_social: string; ruc: string; ciiu: string | null; sector: string; metodologia: string; n_trabajadores: number | null; domicilio: string | null };
type S = { id: string; codigo: string; nombre: string; ubicacion: string | null };

/** E01/E02 · Datos de la empresa y sedes (consulta). */
export default function Empresa() {
  const { perfil } = useAuth();
  const { datos, cargando, error } = useCarga(async () => ({
    e: (ok(await supabase.from("empresa").select("razon_social,ruc,ciiu,sector,metodologia,n_trabajadores,domicilio").limit(1)) as E[])[0],
    s: ok(await supabase.from("sede").select("id,codigo,nombre,ubicacion").order("codigo")) as S[],
    t: (await supabase.from("tarea").select("id", { count: "exact", head: true })).count ?? 0,
  }), [perfil]);
  if (cargando) return <Cargando />;
  if (error || !datos) return <Cargando error={error} />;
  const { e, s, t } = datos;
  const f = (k: string, v: string | number | null) => <div className="field"><span className="k">{k}</span><span className="in">{v ?? "—"}</span></div>;
  return (
    <div className="row">
      <div className="col"><div className="blk"><h4>Datos de la empresa</h4>{f("Razón social", e.razon_social)}{f("RUC", e.ruc)}{f("CIIU", e.ciiu)}{f("Sector", e.sector)}
        {f("Metodología IPERC", e.metodologia === "MINERIA" ? "Minería (DS 024-2016-EM)" : "MTPE (RM 050-2013-TR)")}{f("N.º de trabajadores", e.n_trabajadores)}{f("Domicilio", e.domicilio)}</div></div>
      <div className="col"><div className="blk"><h4>Sedes · {t} tareas en alcance</h4>
        {s.map((x) => <div key={x.id} style={{ fontSize: 13, margin: "3px 0" }}><b>{x.codigo}</b> · {x.nombre}{x.ubicacion ? ` · ${x.ubicacion}` : ""}</div>)}</div></div>
    </div>
  );
}
