import {
  IconBolt,
  IconChartBar,
  IconCloud,
  IconDeviceDesktop,
  IconFileText,
  IconHistory,
  IconMoon,
  IconSparkles,
  IconSun,
  IconUsers,
  type Icon as TablerIcon,
} from "@tabler/icons-react";
import { useState } from "react";
import { utente } from "../data/mockData";
import { isPro, nomeCompleto, percentualeCompletamento } from "../models/types";
import type { Libretto } from "../models/types";
import { useTheme, type ThemeMode } from "../theme/ThemeContext";
import { SectionHeader, SectionLabel } from "../widgets/common/SectionHeader";
import styles from "./ProfiloScreen.module.css";
import pageStyles from "./screens.module.css";

type Tab = "anagrafica" | "libretto";

const voceProImpostazioni: {
  icon: TablerIcon;
  titolo: string;
  free: string;
}[] = [
  {
    icon: IconSparkles,
    titolo: "Generazione AI illimitata",
    free: "Free: 20 generazioni AI al mese + manuale sempre illimitata",
  },
  {
    icon: IconCloud,
    titolo: "Storage cloud maggiorato",
    free: "Free: storage locale/offline illimitato sul device",
  },
  {
    icon: IconHistory,
    titolo: "Cronologia versioni delle note",
    free: "Free: nota corrente sempre modificabile ed esportabile",
  },
  {
    icon: IconChartBar,
    titolo: "Statistiche libretto avanzate",
    free: "Free: media, CFU e libretto visibili e calcolati per tutti",
  },
  {
    icon: IconUsers,
    titolo: "Calendari e gruppi senza limite",
    free: "Free: fino a 5 calendari e 10 gruppi, tetto generoso",
  },
  {
    icon: IconFileText,
    titolo: "Esportazione con template curati",
    free: "Free: esportazione grezza (markdown/testo) sempre gratuita",
  },
  {
    icon: IconBolt,
    titolo: "Priorità di elaborazione AI",
    free: "Free: stessa risposta, solo qualche secondo più lenta",
  },
];

/**
 * Profilo — porting di lib/screens/profilo_screen.dart. Due tab dentro la
 * stessa schermata (Anagrafica/Libretto) invece di due voci separate in
 * sidebar: CLAUDE.md tiene il Libretto volutamente distinto dall'anagrafica
 * (dati ad alta frequenza di consultazione — voti, media — contro dati
 * pressoché statici) senza però far crescere la navigazione principale
 * oltre le sei voci già decise.
 *
 * Differenza rispetto al porting Dart: qui il tema (chiaro/scuro/auto) si
 * legge e si scrive con `useTheme()` (Context, vedi theme/ThemeContext.tsx)
 * invece che tramite prop passate giù da AppShell — è l'equivalente React
 * idiomatico dello stesso meccanismo, evita di far attraversare due livelli
 * di componenti a una preferenza che riguarda solo qui e il tema globale.
 */
export function ProfiloScreen() {
  const [tab, setTab] = useState<Tab>("anagrafica");

  return (
    <div className={pageStyles.page}>
      <SectionHeader title="Profilo" />

      <div className={styles.identityRow}>
        <div className={styles.avatar}>
          {utente.nome[0]}
          {utente.cognome[0]}
        </div>
        <div>
          <div className={styles.name}>{nomeCompleto(utente)}</div>
          <div className={styles.email}>{utente.email}</div>
        </div>
        <span
          className={`${styles.planBadge} ${
            isPro(utente) ? styles.planBadgePro : styles.planBadgeFree
          }`}
        >
          {isPro(utente) ? "PRO" : "FREE"}
        </span>
      </div>

      <div className={styles.segmented} role="tablist">
        <button
          type="button"
          role="tab"
          aria-selected={tab === "anagrafica"}
          className={`${styles.segment} ${tab === "anagrafica" ? styles.segmentActive : ""}`}
          onClick={() => setTab("anagrafica")}
        >
          Anagrafica
        </button>
        <button
          type="button"
          role="tab"
          aria-selected={tab === "libretto"}
          className={`${styles.segment} ${tab === "libretto" ? styles.segmentActive : ""}`}
          onClick={() => setTab("libretto")}
        >
          Libretto
        </button>
      </div>

      <div style={{ height: 20 }} />

      {tab === "anagrafica" ? <TabAnagrafica /> : <TabLibretto libretto={utente.libretto} />}
    </div>
  );
}

function TabAnagrafica() {
  const { mode, setMode } = useTheme();

  return (
    <>
      <SectionLabel>Aspetto</SectionLabel>
      <p className={styles.hint}>
        Tema "Originale" — nel piano Pro arriveranno altre palette (rosa,
        verde, azzurro, temi stagionali): sono estetica pura, mai una
        funzione di studio a pagamento.
      </p>
      <div style={{ height: 10 }} />
      <div className={styles.segmented} role="radiogroup" aria-label="Modalità colore">
        {(
          [
            ["light", "Chiaro", IconSun],
            ["dark", "Scuro", IconMoon],
            ["auto", "Auto", IconDeviceDesktop],
          ] as [ThemeMode, string, TablerIcon][]
        ).map(([value, label, Icon]) => (
          <button
            key={value}
            type="button"
            role="radio"
            aria-checked={mode === value}
            className={`${styles.segment} ${mode === value ? styles.segmentActive : ""}`}
            onClick={() => setMode(value)}
          >
            <Icon size={14} />
            {label}
          </button>
        ))}
      </div>

      <div style={{ height: 28 }} />
      <SectionLabel>Impostazioni Pro</SectionLabel>
      <p className={styles.hint}>
        Il diritto allo studio è gratuito: il Pro paga solo comodità,
        estetica o scala — mai accesso. Ogni voce qui sotto resta
        disponibile anche sul piano free, in versione più limitata ma mai a
        zero.
      </p>
      <div style={{ height: 12 }} />
      {voceProImpostazioni.map((voce) => (
        <div key={voce.titolo} className={styles.proRow}>
          <voce.icon size={18} className={styles.proRowIcon} />
          <div style={{ flex: 1 }}>
            <div className={styles.proRowTitle}>{voce.titolo}</div>
            <div className={styles.proRowFree}>{voce.free}</div>
          </div>
          <span className={styles.proRowBadge}>PRO</span>
        </div>
      ))}
    </>
  );
}

function TabLibretto({ libretto }: { libretto: Libretto }) {
  const percentuale = percentualeCompletamento(libretto);

  return (
    <>
      <p className={styles.name}>{libretto.corsoDiLaurea}</p>
      <div style={{ height: 16 }} />
      <div className={styles.stats}>
        <div>
          <div className={styles.statLabel}>Media</div>
          <div className={styles.statValue}>{libretto.media.toFixed(1)}</div>
        </div>
        <div>
          <div className={styles.statLabel}>CFU</div>
          <div className={styles.statValue}>
            {libretto.cfuConseguiti}/{libretto.cfuTotali}
          </div>
        </div>
      </div>
      <div className={styles.progressTrack}>
        <div
          className={styles.progressFill}
          style={{ width: `${Math.min(percentuale, 1) * 100}%` }}
        />
      </div>

      <SectionLabel>Esami sostenuti</SectionLabel>
      {libretto.esami.map((esame) => (
        <div key={esame.nome} className={styles.examRow}>
          <span className={styles.examName}>{esame.nome}</span>
          <span className={styles.examCfu}>{esame.cfu} CFU</span>
          <span className={styles.examVoto}>{esame.voto}</span>
        </div>
      ))}
    </>
  );
}
