import type { Config } from "tailwindcss";
const config: Config = {
  content: ["./src/**/*.{ts,tsx}"],
  theme: { extend: { colors: { marca: { DEFAULT: "#0f4c5c", claro: "#e6f0f2" } } } },
  plugins: [],
};
export default config;
