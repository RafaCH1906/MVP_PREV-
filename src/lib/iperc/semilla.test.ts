// Contrasta el motor TypeScript con las 17 filas IPERC del contenido semilla v0.1.
// Los niveles esperados los calcula tools/generar_seed_sql.py con las tablas del propio contenido semilla
// (semilla/semilla_datos.py), de forma independiente a engine.ts.
import { describe, it, expect } from "vitest";
import casos from "./semilla-casos.json";
import {
  indiceAMtpe, evaluarMtpe, evaluarMineria, severidadFinalMineria, esSignificativo, alertaResidual,
  type Clasif, type Metodologia,
} from "./engine";

type Caso = {
  id: string; metodologia: Metodologia; expuestos: number | null; significativo: boolean;
  inicial: { factores: any; nivel: number; clasificacion: string };
  residual: { factores: any; nivel: number; clasificacion: string } | null;
};

function calcular(c: Caso, f: any) {
  if (c.metodologia === "MTPE") {
    const A = c.expuestos ? indiceAMtpe(c.expuestos) : f.A;
    return { A, ...evaluarMtpe({ A, B: f.B, C: f.C, D: f.D, S: f.S }) };
  }
  const sev = severidadFinalMineria({ lesion: f.lesion, propiedad: f.propiedad, proceso: f.proceso });
  return { sev, ...evaluarMineria(sev, f.prob) };
}

describe("Contenido semilla v0.1 contra el motor", () => {
  it("trae las 17 filas esperadas", () => expect((casos as Caso[]).length).toBe(17));

  for (const c of casos as unknown as Caso[]) {
    it(`${c.id}: evaluación inicial`, () => {
      const r: any = calcular(c, c.inicial.factores);
      if (c.metodologia === "MTPE") expect(r.A).toBe(c.inicial.factores.A);
      else expect(r.sev).toBe(c.inicial.factores.severidad);
      expect(r.nivel).toBe(c.inicial.nivel);
      expect(r.clasificacion).toBe(c.inicial.clasificacion);
      expect(esSignificativo(c.metodologia, r.clasificacion as Clasif)).toBe(c.significativo);
    });

    if (c.residual) {
      it(`${c.id}: evaluación residual`, () => {
        const r: any = calcular(c, c.residual!.factores);
        expect(r.nivel).toBe(c.residual!.nivel);
        expect(r.clasificacion).toBe(c.residual!.clasificacion);
      });
    }
  }

  it("alertas residuales del escenario: Caracol C05 (9→13) y Wirbi W03 (10→9) no mejoran de clasificación", () => {
    for (const id of ["IPERC-C05", "IPERC-W03"]) {
      const c = (casos as unknown as Caso[]).find((x) => x.id === id)!;
      expect(alertaResidual(c.metodologia, c.inicial.clasificacion as Clasif, c.residual!.clasificacion as Clasif)).toBe(true);
    }
  });

  it("C01, C03 y W01 sí mejoran de clasificación (sin alerta)", () => {
    for (const id of ["IPERC-C01", "IPERC-C03", "IPERC-W01"]) {
      const c = (casos as unknown as Caso[]).find((x) => x.id === id)!;
      expect(alertaResidual(c.metodologia, c.inicial.clasificacion as Clasif, c.residual!.clasificacion as Clasif)).toBe(false);
    }
  });
});
