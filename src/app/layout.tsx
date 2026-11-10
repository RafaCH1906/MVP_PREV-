import "./globals.css";
import type { Metadata, Viewport } from "next";
import { ReactNode } from "react";
import { AuthProvider } from "@/lib/auth";
import { RelojProvider } from "@/lib/reloj";

export const metadata: Metadata = { title: "Prevé – Gestión continua de SST" };
export const viewport: Viewport = { width: "device-width", initialScale: 1 };

export default function RootLayout({ children }: { children: ReactNode }) {
  return (
    <html lang="es">
      <body>
        <AuthProvider>
          <RelojProvider>{children}</RelojProvider>
        </AuthProvider>
      </body>
    </html>
  );
}
