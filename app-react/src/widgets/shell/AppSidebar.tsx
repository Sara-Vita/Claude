import { IconChevronLeft, IconChevronRight, IconSearch } from "@tabler/icons-react";
import { NavLink } from "react-router-dom";
import { mainSections } from "../../navigation/sections";
import styles from "./AppSidebar.module.css";

/**
 * Sidebar verticale usata sia su desktop (espansa o compatta, con toggle)
 * sia su tablet (sempre compatta, senza toggle) — porting di
 * lib/widgets/shell/app_sidebar.dart. È un solo componente per entrambi i
 * breakpoint invece di due, per lo stesso motivo spiegato lì: la differenza
 * è solo di parametri (larghezza, presenza etichette/freccia), non di
 * struttura.
 *
 * `NavLink` di react-router-dom invece di un semplice onClick+useNavigate:
 * calcola da solo lo stato "attivo" confrontando il proprio `to` con l'URL
 * corrente, la stessa cosa che in Flutter faceva confrontare
 * `sezione == currentSection` a mano.
 */
export function AppSidebar({
  expanded,
  showToggle,
  onToggle,
  onSearchTap,
}: {
  expanded: boolean;
  showToggle: boolean;
  onToggle?: () => void;
  onSearchTap: () => void;
}) {
  return (
    <nav
      className={`${styles.sidebar} ${expanded ? styles.expanded : styles.compact}`}
    >
      {expanded ? (
        <div className={styles.header}>Quaderno</div>
      ) : (
        <div className={styles.headerCompact}>Q</div>
      )}

      {expanded ? (
        <button
          type="button"
          className={styles.searchExpanded}
          onClick={onSearchTap}
        >
          <IconSearch size={15} />
          <span>cerca dispense...</span>
        </button>
      ) : (
        <button
          type="button"
          className={styles.searchCompact}
          onClick={onSearchTap}
          aria-label="Cerca dispense"
          title="Cerca dispense"
        >
          <IconSearch size={20} />
        </button>
      )}

      <div className={styles.nav}>
        {mainSections.map((section) => {
          const Icon = section.icon;
          return (
            <NavLink
              key={section.id}
              to={section.path}
              end={section.id === "home"}
              className={({ isActive }) =>
                [
                  styles.navItem,
                  !expanded && styles.navItemCompact,
                  isActive && styles.navItemActive,
                ]
                  .filter(Boolean)
                  .join(" ")
              }
              title={!expanded ? section.label : undefined}
            >
              <Icon size={expanded ? 17 : 20} />
              {expanded && <span>{section.label}</span>}
            </NavLink>
          );
        })}
      </div>

      {showToggle && (
        <button
          type="button"
          className={`${styles.toggle} ${!expanded ? styles.toggleCompact : ""}`}
          onClick={onToggle}
          aria-label={expanded ? "Comprimi barra laterale" : "Espandi barra laterale"}
          title={expanded ? "Comprimi barra laterale" : "Espandi barra laterale"}
        >
          {expanded ? <IconChevronLeft size={18} /> : <IconChevronRight size={18} />}
        </button>
      )}
    </nav>
  );
}
