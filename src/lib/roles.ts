import { Perfil } from "./auth";
export const soloActividad = (p: Perfil | null) => !!p && p.roles.length > 0 && p.roles.every((r) => r === "ACTIVIDAD");
export const puedeGestionar = (p: Perfil | null) => !!p && p.roles.some((r) => r === "SST" || r === "ADMIN");
export const esLector = (p: Perfil | null) => !!p && p.roles.every((r) => r === "LECTOR");
