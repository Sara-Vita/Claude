import type { ReactNode } from "react";
import styles from "./SectionHeader.module.css";

/**
 * Titolo di pagina col trattino oliva sotto — porting di
 * lib/widgets/common/section_header.dart. Ripreso identico da tutti i
 * mockup delle schermate principali (Home, Studio, ...); un componente
 * dedicato invece di ripeterlo in ogni schermata: se cambia lo stile del
 * titolo, cambia in un solo posto.
 */
export function SectionHeader({
  title,
  trailing,
}: {
  title: string;
  trailing?: ReactNode;
}) {
  return (
    <>
      <div className={styles.header}>
        <h1 className={styles.title}>{title}</h1>
        {trailing}
      </div>
      <hr className={styles.rule} />
    </>
  );
}

/** Etichetta piccola, maiuscola, in oliva — usata sopra le liste (es.
 * "IMPEGNI", "DA STUDIARE" in Home; "I TUOI MAZZI" in Studio). */
export function SectionLabel({ children }: { children: ReactNode }) {
  return <p className={styles.label}>{children}</p>;
}
