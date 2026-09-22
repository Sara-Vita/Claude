/**
 * Token di colore "semantici" del design a tema quaderno — porting 1:1 di
 * lib/theme/app_colors.dart. In Flutter questi vivevano in una classe
 * ThemeExtension; qui non serve una classe: sono semplici oggetti TypeScript,
 * perché il meccanismo di "applicazione al tema" non passa da un albero di
 * widget ma da CSS custom properties (vedi ThemeContext.tsx) — un oggetto
 * piatto {chiave: valore-esadecimale} è già la forma giusta per generare
 * `--nome-variabile: valore` senza passaggi intermedi.
 *
 * Le chiavi ricalcano esattamente i campi di AppColors in Dart, comprese
 * le note sulla loro provenienza (vedi i commenti lì per il "perché" di
 * ciascun token, qui non ripetuti per non duplicare la documentazione).
 */
export interface AppColors {
  navbarBackground: string;
  navbarSearchBackground: string;
  navbarTextActive: string;
  navbarTextInactive: string;
  navbarActiveIndicator: string;
  pageBackground: string;
  surface: string;
  textPrimary: string;
  textMuted: string;
  border: string;
  accentOlive: string;
  accentTerracotta: string;
  ringFill: string;
  ringBorder: string;
  avatarPalette: readonly [string, string, string];
}

export const lightColors: AppColors = {
  navbarBackground: "#C1502E",
  navbarSearchBackground: "#A8421F",
  navbarTextActive: "#F2EBDD",
  navbarTextInactive: "#EAC9B8",
  navbarActiveIndicator: "#F2EBDD",
  pageBackground: "#F2EBDD",
  surface: "#FFFDF8",
  textPrimary: "#4A3323",
  textMuted: "#8A7358",
  border: "#D9C9AE",
  accentOlive: "#7C8A4E",
  accentTerracotta: "#C1502E",
  ringFill: "#E4D7BE",
  ringBorder: "#C9B896",
  avatarPalette: ["#E4D7BE", "#DCE3C4", "#F0DCC8"],
};

/**
 * Variante "grafite neutro" scelta per la dark mode. Come in Flutter: i
 * valori non presenti nei mockup (anelletti e palette avatar in scuro) sono
 * estrapolati dalla stessa formula del resto della palette scura — base
 * neutra desaturata, accenti (terracotta/oliva) invariati nella tinta ma
 * schiariti per restare leggibili su fondo scuro.
 */
export const darkColors: AppColors = {
  navbarBackground: "#262523",
  navbarSearchBackground: "#1C1B19",
  navbarTextActive: "#E8E4DC",
  navbarTextInactive: "#8F8A80",
  navbarActiveIndicator: "#E2643A",
  pageBackground: "#1C1B19",
  surface: "#262523",
  textPrimary: "#E8E4DC",
  textMuted: "#8F8A80",
  border: "#35332F",
  accentOlive: "#8FA05C",
  accentTerracotta: "#E2643A",
  ringFill: "#35332F",
  ringBorder: "#4A4640",
  avatarPalette: ["#4A4636", "#3E4433", "#4A3D30"],
};

/** Mappa {chiave AppColors -> nome variabile CSS}, usata sia per generare
 * il blocco `:root { --x: ... }` sia per leggerlo da `var(--x)` nei CSS
 * Modules dei widget, senza dover scrivere due volte gli stessi nomi. */
export const cssVarName = (key: keyof AppColors): string =>
  `--q-${key.replace(/[A-Z]/g, (c) => `-${c.toLowerCase()}`)}`;
