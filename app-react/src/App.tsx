import { RouterProvider } from "react-router-dom";
import { router } from "./navigation/router";
import { ThemeProvider } from "./theme/ThemeContext";

/**
 * Radice dell'app — equivalente di lib/main.dart::QuadernoApp. `ThemeProvider`
 * sta sopra il router (non dentro AppShell) per lo stesso motivo per cui in
 * Flutter il ThemeMode viveva in QuadernoApp e non in AppShell: la
 * preferenza di tema non è "roba di shell", riguarda l'app intera.
 */
export function App() {
  return (
    <ThemeProvider>
      <RouterProvider router={router} />
    </ThemeProvider>
  );
}
