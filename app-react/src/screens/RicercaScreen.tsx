import { IconSearch } from "@tabler/icons-react";
import { useState } from "react";
import { risultatiRicerca } from "../data/mockData";
import { PillChip } from "../widgets/common/PillChip";
import styles from "./RicercaScreen.module.css";

const filtri = ["Fisica", "Appunti", "Unipa"];

/**
 * Ricerca pubblica — porting di lib/screens/ricerca_screen.dart. Materiale
 * che altri studenti hanno scelto di condividere gratuitamente (distinto
 * dalle Dispense private). Risultati in stile "elenco bibliografico" —
 * niente card con thumbnail flottanti — coerente con lo stile quaderno; i
 * filtri contano più della semplice rilevanza testuale perché la fonte è
 * pubblica e non verificata.
 */
export function RicercaScreen() {
  const [query, setQuery] = useState("");
  const [filtroAttivo, setFiltroAttivo] = useState<string | null>("Fisica");

  return (
    <div className={styles.page}>
      <div className={styles.searchBox}>
        <IconSearch size={16} color="var(--q-text-muted)" />
        <input
          className={styles.searchInput}
          placeholder="termodinamica..."
          value={query}
          onChange={(e) => setQuery(e.target.value)}
        />
      </div>

      <div className={styles.filters}>
        {filtri.map((filtro) => (
          <PillChip
            key={filtro}
            label={filtro}
            selected={filtro === filtroAttivo}
            onClick={() =>
              setFiltroAttivo(filtro === filtroAttivo ? null : filtro)
            }
          />
        ))}
      </div>

      {risultatiRicerca.map((documento) => (
        <div key={documento.titolo} className={styles.result}>
          <div className={styles.resultTitle}>{documento.titolo}</div>
          <div className={styles.resultMeta}>
            {documento.materia} · condiviso da {documento.autore} ·{" "}
            {documento.ateneo} · {documento.download} download
          </div>
        </div>
      ))}
    </div>
  );
}
