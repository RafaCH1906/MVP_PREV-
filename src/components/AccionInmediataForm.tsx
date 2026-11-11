"use client";
import { Clasif } from "@/lib/iperc/engine";

export type Usr = { id: string; nombre: string; roles: string[] };
export type AccInm = { descripcion: string; responsableId: string };

/** RF-36: datos de la acción inmediata que se crea al guardar un riesgo Alto o Medio en minería. */
export default function AccionInmediataForm({ clasif, usuarios, value, onChange }: {
  clasif: Clasif; usuarios: Usr[]; value: AccInm; onChange: (v: AccInm) => void;
}) {
  const horas = clasif === "Alto" ? 24 : 72;
  return (
    <div className="alert" style={{ marginTop: 8 }}>
      <b>Al guardar se creará una acción inmediata</b> con plazo de <b>{horas} h desde el registro</b>, aunque la IPERC esté en borrador. Se avisará al responsable de SST (campana y tablero).
      <div className="field"><span className="k">Acción</span><input className="in" value={value.descripcion} onChange={(e) => onChange({ ...value, descripcion: e.target.value })} /></div>
      <div className="field"><span className="k">Responsable</span>
        <select className="in" value={value.responsableId} onChange={(e) => onChange({ ...value, responsableId: e.target.value })}>
          <option value="">Elegir…</option>{usuarios.map((u) => <option key={u.id} value={u.id}>{u.nombre}</option>)}</select></div>
    </div>
  );
}
