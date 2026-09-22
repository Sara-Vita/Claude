import { IconSearch, IconX } from "@tabler/icons-react";
import { useEffect, useRef, useState } from "react";
import styles from "./SearchOverlay.module.css";

/**
 * Pannello che compare quando si tocca l'icona di ricerca in sidebar
 * compatta (desktop compresso o tablet) — porting di
 * lib/widgets/shell/search_overlay.dart. La ricerca è troppo importante da
 * nascondere del tutto quando la sidebar è ridotta a sole icone, ma non c'è
 * spazio per un campo di testo permanente: un piccolo overlay ancorato in
 * alto è il compromesso descritto in CLAUDE.md.
 *
 * Il chiamante (AppShell) lo posiziona dentro un contenitore `position:
 * relative`; qui ci occupiamo solo di aspetto, focus automatico e submit.
 */
export function SearchOverlay({
  onSubmit,
  onDismiss,
}: {
  onSubmit: (value: string) => void;
  onDismiss: () => void;
}) {
  const [value, setValue] = useState("");
  const inputRef = useRef<HTMLInputElement>(null);

  // Il pannello appare già pronto per digitare: risparmia un tap a chi sta
  // solo cercando qualcosa al volo (stesso comportamento della versione
  // Flutter, che fa focus al primo frame post-render).
  useEffect(() => {
    inputRef.current?.focus();
  }, []);

  return (
    <div className={styles.panel}>
      <IconSearch size={16} color="var(--q-text-muted)" />
      <input
        ref={inputRef}
        className={styles.input}
        placeholder="cerca dispense..."
        value={value}
        onChange={(e) => setValue(e.target.value)}
        onKeyDown={(e) => {
          if (e.key === "Enter") onSubmit(value);
        }}
      />
      <button
        type="button"
        className={styles.closeButton}
        onClick={onDismiss}
        aria-label="Chiudi ricerca"
      >
        <IconX size={16} />
      </button>
    </div>
  );
}
