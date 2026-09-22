import {
  IconBook,
  IconBulb,
  IconCalendarMonth,
  IconHome,
  IconSearch,
  IconUser,
  IconUsers,
  type Icon as TablerIcon,
} from "@tabler/icons-react";

/**
 * Porting di lib/navigation/app_section.dart. Le icone sono quelle di
 * @tabler/icons-react perché i mockup .html usano già la webfont Tabler
 * (classi `ti ti-home`, `ti ti-book`, `ti ti-bulb`, `ti ti-users`,
 * `ti ti-user`, `ti ti-search`) — stessa libreria, versione React invece
 * della webfont, per restare fedeli al design di origine senza dipendere
 * da un file di font esterno.
 *
 * A differenza della versione Flutter non teniamo un'icona "attiva" diversa
 * da quella "inattiva": nei mockup la voce attiva si distingue solo per
 * colore + bordo sinistro (vedi navbar_shrink_web.html, home_notebook_*),
 * mai per una forma d'icona diversa — qui replichiamo esattamente quello.
 */
export type SectionId =
  | "home"
  | "calendario"
  | "dispense"
  | "studio"
  | "gruppi"
  | "profilo"
  | "ricerca";

export interface AppSection {
  id: SectionId;
  /** Percorso di React Router associato (vedi navigation/router.tsx). */
  path: string;
  icon: TablerIcon;
  label: string;
}

export const sections: Record<SectionId, AppSection> = {
  home: { id: "home", path: "/", icon: IconHome, label: "Home" },
  calendario: {
    id: "calendario",
    path: "/calendario",
    icon: IconCalendarMonth,
    label: "Calendario",
  },
  dispense: {
    id: "dispense",
    path: "/dispense",
    icon: IconBook,
    label: "Dispense",
  },
  studio: { id: "studio", path: "/studio", icon: IconBulb, label: "Studio" },
  gruppi: { id: "gruppi", path: "/gruppi", icon: IconUsers, label: "Gruppi" },
  profilo: {
    id: "profilo",
    path: "/profilo",
    icon: IconUser,
    label: "Profilo",
  },
  ricerca: {
    id: "ricerca",
    path: "/ricerca",
    icon: IconSearch,
    label: "Ricerca",
  },
};

/** Le sei voci mostrate in sidebar/bottom bar, nell'ordine dei mockup. */
export const mainSections: AppSection[] = [
  sections.home,
  sections.calendario,
  sections.dispense,
  sections.studio,
  sections.gruppi,
  sections.profilo,
];

/** true per le sezioni raggiunte "di passaggio" (Ricerca): mostrano una
 * freccia indietro invece di essere evidenziate in navigazione. */
export function isSecondary(id: SectionId): boolean {
  return id === "ricerca";
}
