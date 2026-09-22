import { IconPlus } from "@tabler/icons-react";
import { useElementWidth } from "../layout/useElementWidth";
import { calendari } from "../data/mockData";
import type { Calendario, Evento } from "../models/types";
import styles from "./CalendarioScreen.module.css";

const giorniSettimana = ["Lun", "Mar", "Mer", "Gio", "Ven"];

/**
 * Calendario — porting di lib/screens/calendario_screen.dart. Colonna
 * sinistra con l'elenco dei Calendari (puntino colorato = calendario.colore,
 * pattern Google Calendar), "Nuovo calendario" sempre visibile perché
 * creare calendari multipli è un'azione centrale in questo modello, non
 * un'opzione secondaria (CLAUDE.md); a destra la griglia settimanale.
 *
 * Nota implementativa (identica a quella Dart): gli eventi vengono
 * posizionati nella griglia in base al giorno del mese preso da
 * `Evento.giorno`, sempre nella prima colonna utile — semplificazione
 * ragionevole per dati di esempio; con un backend reale ogni evento
 * porterebbe una data completa e il posizionamento si calcolerebbe da quella.
 */
export function CalendarioScreen() {
  const { ref, width } = useElementWidth<HTMLDivElement>();
  const narrow = width > 0 && width < 640;

  return (
    <div
      ref={ref}
      className={`${styles.page} ${narrow ? styles.pageNarrow : ""}`}
    >
      <ListaCalendari calendari={calendari} />
      <GrigliaSettimanale />
    </div>
  );
}

function ListaCalendari({ calendari }: { calendari: Calendario[] }) {
  return (
    <div className={styles.listaCalendari}>
      <p className={styles.listaTitolo}>Calendari</p>
      {calendari.map((c) => (
        <div key={c.id} className={styles.calendarioRiga}>
          <span className={styles.pallino} style={{ background: c.colore }} />
          <span>{c.nome}</span>
        </div>
      ))}
      <button type="button" className={styles.nuovoCalendario}>
        <IconPlus size={13} />
        Nuovo calendario
      </button>
    </div>
  );
}

function GrigliaSettimanale() {
  // Raggruppa tutti gli eventi di tutti i calendari per giorno del mese,
  // così ogni riga della griglia mostra tutti gli impegni di quel giorno
  // indipendentemente da quale Calendario appartengano.
  const eventiPerGiorno = new Map<number, { evento: Evento; colore: string }[]>();
  for (const calendario of calendari) {
    for (const evento of calendario.eventi) {
      const lista = eventiPerGiorno.get(evento.giorno) ?? [];
      lista.push({ evento, colore: evento.colore ?? calendario.colore });
      eventiPerGiorno.set(evento.giorno, lista);
    }
  }
  const giorni = [...eventiPerGiorno.keys()].sort((a, b) => a - b);

  return (
    <table className={styles.griglia}>
      <colgroup>
        <col style={{ width: 40 }} />
      </colgroup>
      <thead>
        <tr>
          <th />
          {giorniSettimana.map((g) => (
            <th key={g}>{g}</th>
          ))}
        </tr>
      </thead>
      <tbody>
        {giorni.map((giorno) => {
          const [primo] = eventiPerGiorno.get(giorno)!;
          return (
            <tr key={giorno}>
              <td className={styles.giornoCella}>{giorno}</td>
              <td>
                <div
                  className={styles.eventoChip}
                  style={{ background: primo.colore }}
                >
                  {primo.evento.titolo}
                </div>
              </td>
              {giorniSettimana.slice(1).map((_, i) => (
                <td key={i} />
              ))}
            </tr>
          );
        })}
      </tbody>
    </table>
  );
}
