import { MATRIZ_MINERIA, clasificarMineria, SeveridadMineria } from "@/lib/iperc/engine";
const COLS = ["A", "B", "C", "D", "E"];
const CL = { Alto: "al", Medio: "me", Bajo: "ba" } as const;

/** Matriz 5×5 de minería. sel = celda inicial; res = celda residual. */
export default function MatrizMineria({ sev, prob, sevR, probR }: { sev?: number; prob?: string; sevR?: number; probR?: string }) {
  return (
    <table className="matrix">
      <tbody>
        <tr><td className="h">S\P</td>{COLS.map((c) => <td key={c} className="h">{c}</td>)}</tr>
        {([1, 2, 3, 4, 5] as SeveridadMineria[]).map((s) => (
          <tr key={s}>
            <td className="h">{s}</td>
            {COLS.map((c, j) => {
              const v = MATRIZ_MINERIA[s][j];
              const cls = `${CL[clasificarMineria(v)]}${s === sev && c === prob ? " sel" : ""}${s === sevR && c === probR ? " res" : ""}`;
              return <td key={c} className={cls}>{v}</td>;
            })}
          </tr>
        ))}
      </tbody>
    </table>
  );
}
