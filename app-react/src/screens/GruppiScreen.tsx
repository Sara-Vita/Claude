import { IconPlus } from "@tabler/icons-react";
import { gruppi } from "../data/mockData";
import type { Gruppo } from "../models/types";
import { AvatarStack } from "../widgets/common/AvatarStack";
import { SectionHeader } from "../widgets/common/SectionHeader";
import styles from "./GruppiScreen.module.css";
import pageStyles from "./screens.module.css";

/**
 * Gruppi — porting di lib/screens/gruppi_screen.dart. Storage/calendario
 * condiviso tra colleghi, distinto dal materiale individuale delle
 * Dispense. Il badge "calendario condiviso" compare solo per i gruppi che
 * hanno effettivamente un Calendario collegato — non è un requisito per
 * creare un gruppo (la messaggistica resta una funzione ancora da decidere,
 * vedi CLAUDE.md: questo design funziona anche come puro storage).
 */
export function GruppiScreen() {
  return (
    <div className={pageStyles.page}>
      <SectionHeader
        title="Gruppi"
        trailing={
          <button type="button" className={styles.createButton}>
            <IconPlus size={16} />
            Crea gruppo
          </button>
        }
      />
      {gruppi.map((gruppo) => (
        <CardGruppo key={gruppo.id} gruppo={gruppo} />
      ))}
    </div>
  );
}

function CardGruppo({ gruppo }: { gruppo: Gruppo }) {
  return (
    <div className={styles.card}>
      <div className={styles.cardHeader}>
        <span className={styles.cardTitle}>{gruppo.nome}</span>
        {gruppo.calendarioCondivisoId && (
          <span className={styles.badge}>calendario condiviso</span>
        )}
      </div>
      <div className={styles.cardFooter}>
        <AvatarStack members={gruppo.membri} />
        <span className={styles.fileCount}>
          {gruppo.fileCondivisi} file condivisi
        </span>
      </div>
    </div>
  );
}
