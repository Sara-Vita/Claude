import { useEffect, useRef, useState } from "react";
import { Outlet, useLocation, useNavigate } from "react-router-dom";
import { useDeviceType } from "../../layout/breakpoints";
import { sections } from "../../navigation/sections";
import { AppBottomNav } from "./AppBottomNav";
import { AppSidebar } from "./AppSidebar";
import styles from "./AppShell.module.css";
import { MobileTopBar } from "./MobileTopBar";
import { RingsDivider } from "./RingsDivider";
import { SearchOverlay } from "./SearchOverlay";

/**
 * Il guscio dell'app — porting di lib/widgets/shell/app_shell.dart. Decide,
 * in base alla larghezza disponibile (useDeviceType, non un `MediaQuery`
 * "che dispositivo sei": vedi layout/breakpoints.ts), se mostrare il layout
 * desktop (sidebar espandibile), tablet (sidebar sempre compatta) o mobile
 * (bottom bar).
 *
 * Differenza rispetto alla versione Flutter: lì lo stato "quale sezione è
 * aperta" viveva qui dentro (`_section`); qui la sezione aperta È l'URL
 * (gestito da React Router, vedi navigation/router.tsx) — è il posto giusto
 * in React/web, perché rende ogni schermata linkabile e usa il tasto
 * indietro del browser gratis. Lo stato che resta locale a questo componente
 * è solo quello "di shell": sidebar desktop espansa/compressa e overlay di
 * ricerca visibile — esattamente come in Flutter.
 */
export function AppShell() {
  const deviceType = useDeviceType();
  const location = useLocation();
  const navigate = useNavigate();

  // Preferenza "per breakpoint" descritta in CLAUDE.md
  // (`preferenze.navbar.desktop`): tenuta in memoria invece che persistita,
  // dato che il JSON utente è fuori scope in questa fase.
  const [desktopExpanded, setDesktopExpanded] = useState(true);
  const [searchOverlayVisible, setSearchOverlayVisible] = useState(false);

  // Sezione a cui torna il pulsante "indietro" quando si è dentro Ricerca
  // (l'unica sezione secondaria, vedi navigation/sections.ts): salviamo il
  // path corrente ogni volta che NON siamo su /ricerca, così quando ci si
  // entra il ref contiene già "da dove veniamo".
  const previousPath = useRef<string>(sections.home.path);
  useEffect(() => {
    if (location.pathname !== sections.ricerca.path) {
      previousPath.current = location.pathname;
    }
  }, [location.pathname]);

  const goToSearch = () => {
    setSearchOverlayVisible(false);
    navigate(sections.ricerca.path);
  };

  const onBack =
    location.pathname === sections.ricerca.path
      ? () => navigate(previousPath.current)
      : undefined;

  const currentLabel =
    Object.values(sections).find((s) => s.path === location.pathname)
      ?.label ?? sections.home.label;

  if (deviceType === "mobile") {
    return (
      <div className={`${styles.page} ${styles.mobileLayout}`}>
        <MobileTopBar
          title={currentLabel}
          onSearchTap={goToSearch}
          onBack={onBack}
        />
        <div className={styles.mobileContent}>
          <Outlet />
        </div>
        <RingsDivider direction="horizontal" count={10} />
        <AppBottomNav />
      </div>
    );
  }

  // Desktop e tablet condividono lo stesso scheletro (sidebar + anelletti +
  // contenuto): cambia solo se la sidebar può essere espansa/compressa
  // dall'utente (il toggle non ha senso su tablet, dove lo spazio è
  // comunque troppo stretto per una sidebar estesa).
  const expanded = deviceType === "desktop" && desktopExpanded;

  return (
    <div className={`${styles.page} ${styles.sidebarLayout}`}>
      <AppSidebar
        expanded={expanded}
        showToggle={deviceType === "desktop"}
        onToggle={() => setDesktopExpanded((v) => !v)}
        onSearchTap={
          expanded ? goToSearch : () => setSearchOverlayVisible((v) => !v)
        }
      />
      <RingsDivider direction="vertical" />
      <div className={styles.content}>
        <Outlet />
      </div>
      {searchOverlayVisible && (
        <SearchOverlay
          onSubmit={goToSearch}
          onDismiss={() => setSearchOverlayVisible(false)}
        />
      )}
    </div>
  );
}
