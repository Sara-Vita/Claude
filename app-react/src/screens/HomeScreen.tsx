import { IconCalendarMonth } from "@tabler/icons-react";
import { useNavigate } from "react-router-dom";
import { calendari, materie } from "../data/mockData";
import { sections } from "../navigation/sections";
import { SectionHeader, SectionLabel } from "../widgets/common/SectionHeader";
import styles from "./HomeScreen.module.css";
import pageStyles from "./screens.module.css";

const mesi = [
  "gennaio", "febbraio", "marzo", "aprile", "maggio", "giugno",
  "luglio", "agosto", "settembre", "ottobre", "novembre", "dicembre",
]; // niente libreria solo per formattare una data: non vale la dipendenza extra.

const pad2 = (n: number) => n.toString().padStart(2, "0");

/**
 * Home — porting di lib/screens/home_screen.dart. Tre blocchi: obiettivo
 * della giornata (titolo + link al Calendario completo), impegni di oggi,
 * materie da studiare ordinate per esame più vicino.
 */
export function HomeScreen() {
  const navigate = useNavigate();
  const oggi = new Date();

  const impegniOggi = calendari
    .flatMap((c) => c.eventi.map((evento) => ({ calendario: c, evento })))
    .filter(({ evento }) => evento.giorno === oggi.getDate())
    .sort((a, b) => a.evento.oraInizio.ore - b.evento.oraInizio.ore);

  const daStudiare = [...materie]
    .sort((a, b) => a.dataEsame.getTime() - b.dataEsame.getTime())
    .slice(0, 3);

  return (
    <div className={pageStyles.page}>
      <SectionHeader
        title={`Oggi, ${oggi.getDate()} ${mesi[oggi.getMonth()]}`}
        trailing={
          <button
            type="button"
            className={styles.headerAction}
            onClick={() => navigate(sections.calendario.path)}
          >
            <IconCalendarMonth size={16} />
            Calendario completo
          </button>
        }
      />

      <SectionLabel>Impegni</SectionLabel>
      {impegniOggi.length === 0 ? (
        <div className={styles.rigaVuota}>Nessun impegno per oggi.</div>
      ) : (
        impegniOggi.map(({ calendario, evento }) => (
          <div key={evento.id} className={styles.impegnoRow}>
            <span
              className={styles.impegnoDot}
              style={{ background: evento.colore ?? calendario.colore }}
            />
            <span className={styles.impegnoOra}>
              {pad2(evento.oraInizio.ore)}:{pad2(evento.oraInizio.minuti)}
            </span>
            <span className={styles.impegnoTitolo}>{evento.titolo}</span>
          </div>
        ))
      )}

      <div style={{ height: 20 }} />
      <SectionLabel>Da studiare</SectionLabel>
      {daStudiare.map((materia) => {
        const giorniMancanti = Math.round(
          (materia.dataEsame.getTime() - oggi.getTime()) / 86_400_000,
        );
        return (
          <div key={materia.id} className={styles.cardMateria}>
            <span
              className={styles.cardMateriaBar}
              style={{ background: materia.colore }}
            />
            <span className={styles.cardMateriaText}>
              {materia.nome} — esame tra {giorniMancanti} giorni
              {materia.numeroFlashcard > 0
                ? ` — ${materia.numeroFlashcard} flashcard da ripassare`
                : ""}
            </span>
          </div>
        );
      })}
    </div>
  );
}
