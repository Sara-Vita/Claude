import {
  IconMicrophone,
  IconNotes,
  IconPhoto,
  IconPlus,
  IconCards,
} from "@tabler/icons-react";
import { materie } from "../data/mockData";
import type { Materia } from "../models/types";
import { SectionHeader } from "../widgets/common/SectionHeader";
import styles from "./DispenseScreen.module.css";
import pageStyles from "./screens.module.css";

/**
 * Dispense (ex "Materiale") — porting di lib/screens/dispense_screen.dart.
 * Elenco delle materie, ciascuna come card col bordo colorato =
 * materia.colore e i conteggi di note/registrazioni/foto/flashcard che
 * contiene, senza doverli caricare tutti (vedi il commento sul modello
 * Materia in models/types.ts).
 */
export function DispenseScreen() {
  return (
    <div className={pageStyles.page}>
      <SectionHeader
        title="Dispense"
        trailing={
          <button type="button" className={styles.addButton}>
            <IconPlus size={16} />
            Aggiungi materia
          </button>
        }
      />
      <div className={styles.grid}>
        {materie.map((materia) => (
          <CardMateria key={materia.id} materia={materia} />
        ))}
      </div>
    </div>
  );
}

function CardMateria({ materia }: { materia: Materia }) {
  return (
    <div className={styles.card} style={{ borderLeftColor: materia.colore }}>
      <span className={styles.cardTitle}>{materia.nome}</span>
      <span className={styles.cardMeta}>
        Esame {materia.dataEsame.getDate()}/{materia.dataEsame.getMonth() + 1}
      </span>
      <div className={styles.counts}>
        {materia.numeroNote > 0 && (
          <Conteggio icon={IconNotes} value={materia.numeroNote} />
        )}
        {materia.numeroRegistrazioni > 0 && (
          <Conteggio icon={IconMicrophone} value={materia.numeroRegistrazioni} />
        )}
        {materia.numeroFoto > 0 && (
          <Conteggio icon={IconPhoto} value={materia.numeroFoto} />
        )}
        {materia.numeroFlashcard > 0 && (
          <Conteggio icon={IconCards} value={materia.numeroFlashcard} />
        )}
      </div>
    </div>
  );
}

function Conteggio({
  icon: Icon,
  value,
}: {
  icon: typeof IconNotes;
  value: number;
}) {
  return (
    <span className={styles.count}>
      <Icon size={12} />
      {value}
    </span>
  );
}
