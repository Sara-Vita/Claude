import { createBrowserRouter } from "react-router-dom";
import { AppShell } from "../widgets/shell/AppShell";
import { HomeScreen } from "../screens/HomeScreen";
import { CalendarioScreen } from "../screens/CalendarioScreen";
import { DispenseScreen } from "../screens/DispenseScreen";
import { StudioScreen } from "../screens/StudioScreen";
import { GruppiScreen } from "../screens/GruppiScreen";
import { ProfiloScreen } from "../screens/ProfiloScreen";
import { RicercaScreen } from "../screens/RicercaScreen";
import { sections } from "./sections";

/**
 * Unico punto in cui si definisce "quale URL mostra quale schermata" — se
 * in futuro si aggiunge un'ottava sezione, questo è l'unico file da toccare
 * oltre a navigation/sections.ts (per la voce di menu) e screens/ (per il
 * contenuto): niente altro nell'app conosce le route in modo sparso.
 *
 * `AppShell` è una "layout route": renderizza sidebar/bottom-bar/anelletti
 * una sola volta e usa <Outlet /> per il contenuto che cambia — è
 * l'equivalente React del widget Flutter che sceglie il body dentro lo
 * stesso guscio invece di ricostruire sidebar e bottom bar a ogni cambio
 * schermata.
 */
export const router = createBrowserRouter([
  {
    path: "/",
    element: <AppShell />,
    children: [
      { index: true, element: <HomeScreen /> },
      { path: sections.calendario.path.slice(1), element: <CalendarioScreen /> },
      { path: sections.dispense.path.slice(1), element: <DispenseScreen /> },
      { path: sections.studio.path.slice(1), element: <StudioScreen /> },
      { path: sections.gruppi.path.slice(1), element: <GruppiScreen /> },
      { path: sections.profilo.path.slice(1), element: <ProfiloScreen /> },
      { path: sections.ricerca.path.slice(1), element: <RicercaScreen /> },
    ],
  },
]);
