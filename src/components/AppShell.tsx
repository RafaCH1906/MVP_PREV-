"use client";
import Link from "next/link";
import { usePathname, useRouter } from "next/navigation";
import { ReactNode, useEffect } from "react";
import { useAuth } from "@/lib/auth";
import { ROL_NOMBRE, etiquetas } from "@/lib/consultas";
import { soloActividad } from "@/lib/roles";
import Campana from "./Campana";

export default function AppShell({ children }: { children: ReactNode }) {
  const { perfil, cargando, salir } = useAuth();
  const ruta = usePathname();
  const router = useRouter();
  useEffect(() => { if (!cargando && !perfil) router.replace("/login"); }, [cargando, perfil, router]);
  if (cargando || !perfil) return <p style={{ padding: 20 }} className="muted">Cargando…</p>;

  const et = etiquetas(perfil.empresa?.metodologia);
  const on = (h: string) => (h === "/" ? ruta === "/" : ruta.startsWith(h));

  // Responsable de actividad: pantalla de celular (W7)
  if (soloActividad(perfil)) {
    return (
      <div className="phone">
        {children}
        <div className="pbar">
          <Link href="/" className={ruta === "/" || ruta.startsWith("/registro") ? "on" : ""}>Pendientes</Link>
          <Link href="/reportar" className={on("/reportar") ? "on" : ""}>Hallazgos</Link>
          <Link href="/perfil" className={on("/perfil") ? "on" : ""}>Perfil</Link>
        </div>
      </div>
    );
  }

  const NAV = [
    ["/", "Inicio"], ["/empresa", "Empresa"], ["/diagnostico", "Diagnóstico"], ["/iperc", "IPERC"],
    ["/plan", et.plan], ["/seguimiento", "Seguimiento"], ["/tablero", "Tablero"], ["/admin", "Administración"],
  ];
  const MOV = [["/", "Inicio"], ["/iperc", "IPERC"], ["/plan", "Plan"], ["/seguimiento", "Seguim."], ["/tablero", "Tablero"]];
  const rol = perfil.roles.map((r) => ROL_NOMBRE[r] ?? r).join(" / ");

  return (
    <div>
      <div className="bar">
        <Link href="/" className="logo">PREVÉ</Link>
        <select className="sel" value="" onChange={(e) => e.target.value && salir()} aria-label="Empresa">
          <option value="">{perfil.empresa?.nombre} ▾</option>
          <option value="x">Cambiar de empresa (ingresar con otro usuario)</option>
        </select>
        <span className="sp" />
        <span className="sel">Año 2026</span>
        <Campana />
        <span style={{ fontSize: 13 }}>{perfil.nombre} · {rol} · <a href="#" onClick={(e) => { e.preventDefault(); salir(); }}>Salir</a></span>
      </div>
      <div className="body">
        <nav className="side">{NAV.map(([h, t]) => <Link key={h} href={h} className={on(h) ? "on" : ""}>{t}</Link>)}</nav>
        <main className="main">{children}</main>
      </div>
      <nav className="nav-m">{MOV.map(([h, t]) => <Link key={h} href={h} className={on(h) ? "on" : ""}>{t}</Link>)}</nav>
    </div>
  );
}
