import { describe, it, expect } from "vitest";
import {
  indiceAMtpe, evaluarMtpe, evaluarMineria, severidadFinalMineria, esSignificativo,
  alertaResidual, requiereAccionInmediata, venceAccionInmediata, minutosRestantes, formatoRestante,
  MATRIZ_MINERIA, clasificarMtpe, clasificarMineria,
} from "./engine";

describe("MTPE", () => {
  it("índice A desde expuestos", () => {
    expect(indiceAMtpe(1)).toBe(1);
    expect(indiceAMtpe(3)).toBe(1);
    expect(indiceAMtpe(4)).toBe(2);
    expect(indiceAMtpe(12)).toBe(2);
    expect(indiceAMtpe(13)).toBe(3);
    expect(indiceAMtpe(29)).toBe(3); // Wirbi W01
  });

  it("Wirbi W01: 3+2+2+3=10, S=2 → NR 20 Importante", () => {
    const r = evaluarMtpe({ A: 3, B: 2, C: 2, D: 3, S: 2 });
    expect(r.P).toBe(10);
    expect(r.nivel).toBe(20);
    expect(r.clasificacion).toBe("Importante");
    expect(esSignificativo("MTPE", r.clasificacion)).toBe(true);
  });

  it("Wirbi W01 residual: 3+1+1+3=8 → NR 16 Moderado (mejora)", () => {
    const r = evaluarMtpe({ A: 3, B: 1, C: 1, D: 3, S: 2 });
    expect(r.nivel).toBe(16);
    expect(r.clasificacion).toBe("Moderado");
    expect(alertaResidual("MTPE", "Importante", r.clasificacion)).toBe(false);
  });

  it("límites de clasificación", () => {
    expect(clasificarMtpe(4)).toBe("Trivial");
    expect(clasificarMtpe(5)).toBe("Tolerable");
    expect(clasificarMtpe(8)).toBe("Tolerable");
    expect(clasificarMtpe(9)).toBe("Moderado");
    expect(clasificarMtpe(16)).toBe("Moderado");
    expect(clasificarMtpe(17)).toBe("Importante");
    expect(clasificarMtpe(24)).toBe("Importante");
    expect(clasificarMtpe(25)).toBe("Intolerable");
    expect(clasificarMtpe(36)).toBe("Intolerable");
  });

  it("MTPE 20 → 18 sigue en Importante: alerta (RF-17)", () => {
    expect(alertaResidual("MTPE", clasificarMtpe(20), clasificarMtpe(18))).toBe(true);
  });

  it("Wirbi W03: de 10 a 9 sigue en Moderado: alerta", () => {
    expect(alertaResidual("MTPE", clasificarMtpe(10), clasificarMtpe(9))).toBe(true);
  });

  it("rechaza índices inválidos", () => {
    // @ts-expect-error valor fuera de rango a propósito
    expect(() => evaluarMtpe({ A: 4, B: 1, C: 1, D: 1, S: 1 })).toThrow();
  });
});

describe("Minería", () => {
  it("matriz coincide con el Anexo 7 (25 celdas distintas del 1 al 25)", () => {
    const todas = Object.values(MATRIZ_MINERIA).flat().sort((a, b) => a - b);
    expect(todas).toEqual(Array.from({ length: 25 }, (_, i) => i + 1));
  });

  it("Caracol C01: severidad 2, prob B → 5 Alto", () => {
    const r = evaluarMineria(2, "B");
    expect(r.nivel).toBe(5);
    expect(r.clasificacion).toBe("Alto");
    expect(r.plazoHoras).toBe(24);
    expect(esSignificativo("MINERIA", r.clasificacion)).toBe(true);
  });

  it("filas de la matriz de Caracol (C01–C08)", () => {
    const esperado: [1 | 2 | 3 | 4 | 5, "A" | "B" | "C" | "D" | "E", number, string][] = [
      [2, "B", 5, "Alto"], [1, "C", 4, "Alto"], [2, "C", 8, "Alto"], [2, "C", 8, "Alto"],
      [3, "B", 9, "Medio"], [3, "B", 9, "Medio"], [3, "C", 13, "Medio"], [4, "C", 18, "Bajo"],
    ];
    for (const [s, p, n, c] of esperado) {
      const r = evaluarMineria(s, p);
      expect(r.nivel).toBe(n);
      expect(r.clasificacion).toBe(c);
    }
  });

  it("Bajo no es significativo con el umbral por defecto (Medio)", () => {
    expect(esSignificativo("MINERIA", "Bajo")).toBe(false);
    expect(esSignificativo("MINERIA", "Medio")).toBe(true);
  });

  it("límites de clasificación", () => {
    expect(clasificarMineria(1)).toBe("Alto");
    expect(clasificarMineria(8)).toBe("Alto");
    expect(clasificarMineria(9)).toBe("Medio");
    expect(clasificarMineria(15)).toBe("Medio");
    expect(clasificarMineria(16)).toBe("Bajo");
    expect(clasificarMineria(25)).toBe("Bajo");
  });

  it("severidad final = la más grave de las dimensiones (C01: 2, 4, 4 → 2)", () => {
    expect(severidadFinalMineria({ lesion: 2, propiedad: 4, proceso: 4 })).toBe(2);
    expect(severidadFinalMineria({ propiedad: 5 })).toBe(5);
    expect(() => severidadFinalMineria({})).toThrow();
  });

  it("residual C01: Alto → Medio (12) mejora; C05: 9 → 13 sigue Medio (alerta)", () => {
    expect(alertaResidual("MINERIA", "Alto", evaluarMineria(2, "D").clasificacion)).toBe(false);
    expect(evaluarMineria(2, "D").nivel).toBe(12);
    expect(alertaResidual("MINERIA", "Medio", evaluarMineria(3, "C").clasificacion)).toBe(true);
    expect(evaluarMineria(3, "C").nivel).toBe(13);
  });
});

describe("Acción inmediata (RF-36)", () => {
  it("solo minería, solo Alto y Medio", () => {
    expect(requiereAccionInmediata("MINERIA", "Alto")).toBe(true);
    expect(requiereAccionInmediata("MINERIA", "Medio")).toBe(true);
    expect(requiereAccionInmediata("MINERIA", "Bajo")).toBe(false);
    expect(requiereAccionInmediata("MTPE", "Importante")).toBe(false);
  });

  it("Alto vence a las 24 h; Medio a las 72 h", () => {
    const t0 = new Date("2026-11-06T23:30:00Z");
    expect(venceAccionInmediata(t0, "Alto").toISOString()).toBe("2026-11-07T23:30:00.000Z");
    expect(venceAccionInmediata(t0, "Medio").toISOString()).toBe("2026-11-09T23:30:00.000Z");
  });

  it("contador del wireframe W1: hoy 13:20, vence 18:30 → quedan 5 h 10 min", () => {
    const ahora = new Date("2026-11-07T13:20:00-05:00");
    const vence = new Date("2026-11-07T18:30:00-05:00");
    const min = minutosRestantes(vence, ahora);
    expect(min).toBe(310);
    expect(formatoRestante(min)).toBe("quedan 5 h 10 min");
  });

  it("vencida", () => {
    expect(formatoRestante(-125)).toBe("vencida hace 2 h 5 min");
  });
});
