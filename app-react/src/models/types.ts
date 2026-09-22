/**
 * Porting di lib/models/*.dart in interfacce TypeScript. Stessa scelta di
 * fondo documentata in CLAUDE.md e nei commenti Dart originali: niente
 * liste annidate dove il modello relazionale prevede una tabella a parte
 * (es. Materia non contiene i suoi Contenuti, solo i conteggi). Qui sono
 * semplici `interface` invece di classi perché non serve immutabilità
 * imposta dal linguaggio (TypeScript non la applica comunque a runtime) né
 * costruttori con validazione — sono solo la "forma" dei dati mock.
 */

export type Piano = "free" | "pro";

/** Un singolo esame sostenuto (riga del libretto). */
export interface Esame {
  nome: string;
  /** 18-30, o 31 per convenzione "30 e lode". */
  voto: number;
  cfu: number;
  data: Date;
}

/** Il libretto, tenuto 1:1 nell'utente (vedi commento Dart: normalizzare in
 * tabella a parte solo se un domani serve interrogarlo indipendentemente). */
export interface Libretto {
  corsoDiLaurea: string;
  media: number;
  cfuConseguiti: number;
  cfuTotali: number;
  esami: Esame[];
}

export function percentualeCompletamento(l: Libretto): number {
  return l.cfuTotali === 0 ? 0 : l.cfuConseguiti / l.cfuTotali;
}

export interface Utente {
  nome: string;
  cognome: string;
  email: string;
  piano: Piano;
  libretto: Libretto;
}

export const nomeCompleto = (u: Utente) => `${u.nome} ${u.cognome}`;
export const isPro = (u: Utente) => u.piano === "pro";

/** Una materia universitaria (schermata Dispense). Volutamente senza
 * contenuti annidati, vedi lib/models/materia.dart. */
export interface Materia {
  id: string;
  nome: string;
  /** Colore identificativo, usato come bordo della card qui e come
   * "etichetta" quando la stessa materia compare altrove (es. Studio). */
  colore: string;
  docente: string;
  dataEsame: Date;
  numeroNote: number;
  numeroRegistrazioni: number;
  numeroFoto: number;
  numeroFlashcard: number;
}

/** Tipo di contenuto creato/caricato in Studio o nelle Dispense — rispecchia
 * la tabella polimorfica `Contenuti` di CLAUDE.md. */
export type TipoContenuto = "nota" | "registrazione" | "foto" | "flashcardDeck";
export type OrigineContenuto = "studio" | "dispense_import_locale";

export interface Contenuto {
  id: string;
  materiaId: string;
  tipo: TipoContenuto;
  origine: OrigineContenuto;
  titolo: string;
  createdAt: Date;
  /** Testo della nota; assente per registrazione/foto/mazzo. */
  corpo?: string;
  /** Percorso/URL del file; assente per una nota testuale pura. */
  urlFile?: string;
}

export type OrigineMazzo = "manuale" | "ai";

export interface FlashcardDeck {
  id: string;
  materiaId: string;
  titolo: string;
  origine: OrigineMazzo;
  numeroCarte: number;
}

/** Un calendario (Personale, Lezioni, Gruppo X, ...) — l'app supporta
 * calendari multipli invece di un unico calendario con colori per evento,
 * perché il calendario è l'unità di condivisione/visibilità (CLAUDE.md). */
export interface Calendario {
  id: string;
  nome: string;
  colore: string;
  eventi: Evento[];
}

export interface Evento {
  id: string;
  titolo: string;
  /** Giorno del mese (1-31) nella griglia settimanale mostrata in Calendario. */
  giorno: number;
  oraInizio: { ore: number; minuti: number };
  oraFine: { ore: number; minuti: number };
  materiaId?: string;
  /** Se assente, l'evento eredita il colore del calendario a cui appartiene. */
  colore?: string;
}

export interface MembroGruppo {
  iniziali: string;
}

export interface Gruppo {
  id: string;
  nome: string;
  membri: MembroGruppo[];
  /** Storage di gruppo: conteggio dei file condivisi (spazio separato dal
   * materiale individuale delle Dispense). */
  fileCondivisi: number;
  /** Se presente, il gruppo ha un Calendario collegato tramite una riga in
   * CalendarioCondivisioni. */
  calendarioCondivisoId?: string;
}

/** Un risultato della sezione Ricerca: materiale pubblico e gratuito
 * condiviso da un altro studente (distinto dal materiale privato di
 * Dispense, vedi CLAUDE.md). */
export interface DocumentoPubblico {
  titolo: string;
  materia: string;
  autore: string;
  ateneo: string;
  download: number;
}
