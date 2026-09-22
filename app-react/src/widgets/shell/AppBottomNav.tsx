import { NavLink } from "react-router-dom";
import { mainSections } from "../../navigation/sections";
import styles from "./AppBottomNav.module.css";

/**
 * Barra di navigazione inferiore per mobile — porting di
 * lib/widgets/shell/app_bottom_nav.dart. Sotto il breakpoint tablet la
 * sidebar smette di esistere come colonna laterale (il pollice raggiunge il
 * fondo schermo molto più comodamente della cima, vedi CLAUDE.md).
 *
 * Come in AppSidebar, nessuna sezione risulta attiva se ci si trova su una
 * sezione "secondaria" (Ricerca) — `NavLink` lo gestisce da solo perché
 * "/ricerca" non combacia con nessuno dei `to` qui sotto.
 */
export function AppBottomNav() {
  return (
    <nav className={styles.bar}>
      {mainSections.map((section) => {
        const Icon = section.icon;
        return (
          <NavLink
            key={section.id}
            to={section.path}
            end={section.id === "home"}
            className={({ isActive }) =>
              `${styles.item} ${isActive ? styles.itemActive : ""}`
            }
          >
            <Icon size={22} />
            <span>{section.label}</span>
          </NavLink>
        );
      })}
    </nav>
  );
}
