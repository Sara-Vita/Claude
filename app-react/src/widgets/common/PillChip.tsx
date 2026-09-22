import styles from "./PillChip.module.css";

/**
 * Chip a "pillola" usato come filtro nella schermata Ricerca (materia, tipo
 * file, ateneo) — porting di lib/widgets/common/pill_chip.dart. `selected`
 * usa l'oliva pieno per bordo/testo (come il filtro "Fisica" già attivo nel
 * mockup schermata_ricerca.html); altrimenti resta nel grigio-bordo neutro.
 */
export function PillChip({
  label,
  selected = false,
  onClick,
}: {
  label: string;
  selected?: boolean;
  onClick?: () => void;
}) {
  return (
    <button
      type="button"
      className={`${styles.chip} ${selected ? styles.selected : ""}`}
      onClick={onClick}
    >
      {label}
    </button>
  );
}
