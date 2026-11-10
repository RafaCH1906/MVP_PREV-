"use client";
import { useAuth } from "@/lib/auth";
import { soloActividad } from "@/lib/roles";
import InicioSST from "@/components/InicioSST";
import Pendientes from "@/components/Pendientes";

export default function Inicio() {
  const { perfil } = useAuth();
  return soloActividad(perfil) ? <Pendientes /> : <InicioSST />;
}
