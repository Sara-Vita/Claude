import {
  IconEdit,
  IconLineDashed,
  IconMicrophone,
  IconNotes,
  IconPhoto,
  IconPlus,
  IconSparkles,
  IconUpload,
  IconDroplet,
} from "@tabler/icons-react";
import { useState } from "react";
import { mazzi } from "../data/mockData";
import type { FlashcardDeck } from "../models/types";
import { SectionHeader, SectionLabel } from "../widgets/common/SectionHeader";
import styles from "./StudioScreen.module.css";
import pageStyles from "./screens.module.css";

const stiliImmagine = [
  { nome: "Schizzo a mano", icon: IconEdit },
  { nome: "Acquarello tenue", icon: IconDroplet },
  { nome: "Linee minimali", icon: IconLineDashed },
];

/**
 * Studio — porting di lib/screens/studio_screen.dart. Hub di creazione
 * (nota, registrazione, immagine generata, upload) e generazione flashcard.
 * I mazzi generati confluiscono qui, non dentro le singole materie
 * (CLAUDE.md) — la materia di appartenenza resta comunque un metadato del
 * mazzo, non mostrato in questa vista riassuntiva.
 */
export function StudioScreen() {
  const [sceltaStileAperta, setSceltaStileAperta] = useState(false);

  return (
    <div className={pageStyles.page}>
      <SectionHeader title="Studio" />

      <div className={styles.actionGrid}>
        <button type="button" className={styles.actionCard}>
          <IconNotes size={18} color="var(--q-accent-olive)" />
          Nuova nota
        </button>
        <button type="button" className={styles.actionCard}>
          <IconMicrophone size={18} color="var(--q-accent-olive)" />
          Registra lezione
        </button>
        <button
          type="button"
          className={styles.actionCard}
          onClick={() => setSceltaStileAperta(true)}
        >
          <IconPhoto size={18} color="var(--q-accent-olive)" />
          Genera immagine
        </button>
        <button type="button" className={styles.actionCard}>
          <IconUpload size={18} color="var(--q-accent-olive)" />
          Carica file
        </button>
      </div>

      <SectionLabel>I tuoi mazzi</SectionLabel>
      {mazzi.map((mazzo) => (
        <RigaMazzo key={mazzo.id} mazzo={mazzo} />
      ))}

      <div className={styles.actions}>
        <button type="button" className={styles.manualButton}>
          <IconPlus size={16} />
          Genera flashcard manuale
        </button>
        <button type="button" className={styles.aiButton}>
          <IconSparkles size={16} />
          Genera con AI
          <span className={styles.proBadge}>PRO</span>
        </button>
      </div>

      {/* Tre proposte di stile invece di una sola immagine generica:
          richiesta esplicita per evitare l'estetica "riconoscibile" delle
          immagini AI generiche (CLAUDE.md / commento originale in
          studio_screen.dart). La generazione vera e propria richiede un
          backend/servizio AI, fuori scope qui. */}
      {sceltaStileAperta && (
        <div
          className={styles.sheetBackdrop}
          onClick={() => setSceltaStileAperta(false)}
        >
          <div className={styles.sheet} onClick={(e) => e.stopPropagation()}>
            <p className={styles.sheetTitle}>Scegli uno stile</p>
            {stiliImmagine.map(({ nome, icon: Icon }) => (
              <button
                key={nome}
                type="button"
                className={styles.sheetOption}
                onClick={() => setSceltaStileAperta(false)}
              >
                <Icon size={18} />
                {nome}
              </button>
            ))}
          </div>
        </div>
      )}
    </div>
  );
}

function RigaMazzo({ mazzo }: { mazzo: FlashcardDeck }) {
  return (
    <div className={styles.mazzoRow}>
      <span className={styles.mazzoTitolo}>{mazzo.titolo}</span>
      {mazzo.origine === "ai" && (
        <span className={styles.mazzoAiIcon}>
          <IconSparkles size={13} />
        </span>
      )}
      <span className={styles.mazzoCarte}>{mazzo.numeroCarte} carte</span>
    </div>
  );
}
