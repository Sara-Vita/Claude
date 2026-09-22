import {
  createContext,
  useContext,
  useEffect,
  useMemo,
  useState,
  type ReactNode,
} from "react";
import { type AppColors, cssVarName, darkColors, lightColors } from "./colors";

/** Equivalente di Flutter ThemeMode: "auto" segue prefers-color-scheme del
 * sistema finché l'utente non sceglie esplicitamente chiaro/scuro da Profilo
 * (preferenze.aspetto.modalita in CLAUDE.md). Nessuna persistenza per ora:
 * solo stato in memoria, coerente con lo scope "niente JSON utente". */
export type ThemeMode = "light" | "dark" | "auto";

interface ThemeContextValue {
  mode: ThemeMode;
  /** Il tema effettivamente applicato ("auto" risolto in light/dark). */
  resolved: "light" | "dark";
  colors: AppColors;
  setMode: (mode: ThemeMode) => void;
}

const ThemeContext = createContext<ThemeContextValue | null>(null);

function useSystemPrefersDark(): boolean {
  const query = "(prefers-color-scheme: dark)";
  const [prefersDark, setPrefersDark] = useState(
    () => window.matchMedia?.(query).matches ?? false,
  );

  useEffect(() => {
    const mql = window.matchMedia(query);
    const listener = (e: MediaQueryListEvent) => setPrefersDark(e.matches);
    mql.addEventListener("change", listener);
    return () => mql.removeEventListener("change", listener);
  }, []);

  return prefersDark;
}

export function ThemeProvider({ children }: { children: ReactNode }) {
  const [mode, setMode] = useState<ThemeMode>("auto");
  const systemPrefersDark = useSystemPrefersDark();

  const resolved: "light" | "dark" =
    mode === "auto" ? (systemPrefersDark ? "dark" : "light") : mode;
  const colors = resolved === "dark" ? darkColors : lightColors;

  // Le schermate/i widget non leggono `colors` via prop-drilling: leggono
  // variabili CSS (var(--q-page-background) ecc.) dai loro .module.css.
  // Questo effect è l'unico punto che traduce l'oggetto `colors` in
  // variabili scritte su :root — cambiare tema è quindi un solo giro di
  // scrittura DOM, non un re-render di ogni widget colorato a mano.
  useEffect(() => {
    const root = document.documentElement;
    (Object.keys(colors) as (keyof AppColors)[]).forEach((key) => {
      if (key === "avatarPalette") {
        colors.avatarPalette.forEach((value, i) => {
          root.style.setProperty(`--q-avatar-${i}`, value);
        });
        return;
      }
      root.style.setProperty(cssVarName(key), colors[key] as string);
    });
    root.dataset.theme = resolved;
  }, [colors, resolved]);

  const value = useMemo(
    () => ({ mode, resolved, colors, setMode }),
    [mode, resolved, colors],
  );

  return (
    <ThemeContext.Provider value={value}>{children}</ThemeContext.Provider>
  );
}

/** Scorciatoia equivalente a `context.colors` in Dart (vedi AppColorsX). */
export function useTheme(): ThemeContextValue {
  const ctx = useContext(ThemeContext);
  if (!ctx) throw new Error("useTheme va usato dentro <ThemeProvider>");
  return ctx;
}
