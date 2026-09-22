import { IconArrowLeft, IconSearch } from "@tabler/icons-react";
import styles from "./MobileTopBar.module.css";

/**
 * Barra in cima al contenuto, solo mobile — porting di
 * lib/widgets/shell/mobile_top_bar.dart. Qui torna l'icona di ricerca (in
 * bottom bar non c'è più posto, ha già le sei voci piene) insieme al titolo
 * della sezione corrente e, quando si arriva da Ricerca, la freccia indietro.
 */
export function MobileTopBar({
  title,
  onSearchTap,
  onBack,
}: {
  title: string;
  onSearchTap: () => void;
  onBack?: () => void;
}) {
  return (
    <header className={styles.bar}>
      {onBack ? (
        <button
          type="button"
          className={styles.iconButton}
          onClick={onBack}
          aria-label="Indietro"
        >
          <IconArrowLeft size={20} />
        </button>
      ) : (
        <div className={styles.spacer} />
      )}
      <div className={styles.title}>{title}</div>
      <button
        type="button"
        className={styles.iconButton}
        onClick={onSearchTap}
        aria-label="Cerca dispense"
        title="Cerca dispense"
      >
        <IconSearch size={20} />
      </button>
    </header>
  );
}
