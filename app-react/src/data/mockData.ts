import type {
  Calendario,
  DocumentoPubblico,
  FlashcardDeck,
  Gruppo,
  Materia,
  Utente,
} from "../models/types";

/**
 * Porting di lib/data/mock_data.dart. Dati statici SOLO per popolare
 * visivamente l'interfaccia — nessun layer di rete/persistenza in questa
 * fase (fuori scope, come da richiesta). Quando arriverà un'API reale,
 * questo file si sostituisce con un modulo che espone le stesse forme dei
 * tipi in models/types.ts (es. via fetch + React Query), senza toccare le
 * schermate che lo consumano.
 */

const terracotta = "#C1502E";
const oliva = "#7C8A4E";
const marroneChiaro = "#8A6E5C";

export const utente: Utente = {
  nome: "Mario",
  cognome: "Rossi",
  email: "mario.rossi@studenti.unipa.it",
  piano: "free",
  libretto: {
    corsoDiLaurea: "Ingegneria Informatica",
    media: 27.4,
    cfuConseguiti: 96,
    cfuTotali: 180,
    esami: [
      { nome: "Analisi Matematica 1", voto: 28, cfu: 12, data: new Date(2024, 0, 20) },
      { nome: "Fisica I", voto: 26, cfu: 9, data: new Date(2024, 5, 14) },
      { nome: "Programmazione I", voto: 30, cfu: 9, data: new Date(2024, 6, 3) },
      { nome: "Geometria", voto: 24, cfu: 6, data: new Date(2025, 0, 28) },
    ],
  },
};

export const materie: Materia[] = [
  {
    id: "mat_a13f",
    nome: "Fisica II",
    colore: oliva,
    docente: "Prof. Bianchi",
    dataEsame: new Date(2026, 8, 18),
    numeroNote: 5,
    numeroRegistrazioni: 2,
    numeroFoto: 0,
    numeroFlashcard: 12,
  },
  {
    id: "mat_b207",
    nome: "Analisi 1",
    colore: terracotta,
    docente: "Prof.ssa Greco",
    dataEsame: new Date(2026, 8, 25),
    numeroNote: 8,
    numeroRegistrazioni: 0,
    numeroFoto: 4,
    numeroFlashcard: 0,
  },
  {
    id: "mat_c391",
    nome: "Chimica generale",
    colore: marroneChiaro,
    docente: "Prof. Ferro",
    dataEsame: new Date(2026, 9, 6),
    numeroNote: 3,
    numeroRegistrazioni: 1,
    numeroFoto: 0,
    numeroFlashcard: 20,
  },
];

export const mazzi: FlashcardDeck[] = [
  {
    id: "deck_11c9",
    materiaId: "mat_a13f",
    titolo: "Fisica II — Termodinamica",
    origine: "ai",
    numeroCarte: 12,
  },
  {
    id: "deck_22d1",
    materiaId: "mat_c391",
    titolo: "Chimica — Legami chimici",
    origine: "manuale",
    numeroCarte: 20,
  },
];

export const calendari: Calendario[] = [
  {
    id: "cal_personale",
    nome: "Personale",
    colore: terracotta,
    eventi: [
      {
        id: "evt_991",
        titolo: "Ripasso Fisica II",
        giorno: 5,
        oraInizio: { ore: 14, minuti: 0 },
        oraFine: { ore: 16, minuti: 0 },
        materiaId: "mat_a13f",
      },
    ],
  },
  {
    id: "cal_gruppo_analisi",
    nome: "Gruppo Analisi 1",
    colore: oliva,
    eventi: [
      {
        id: "evt_992",
        titolo: "Sessione di studio comune",
        giorno: 9,
        oraInizio: { ore: 10, minuti: 0 },
        oraFine: { ore: 12, minuti: 0 },
        materiaId: "mat_b207",
      },
    ],
  },
  {
    id: "cal_lezioni",
    nome: "Lezioni",
    colore: marroneChiaro,
    eventi: [
      {
        id: "evt_993",
        titolo: "Analisi matematica, aula 3",
        giorno: 9,
        oraInizio: { ore: 9, minuti: 0 },
        oraFine: { ore: 11, minuti: 0 },
        materiaId: "mat_b207",
      },
    ],
  },
];

export const gruppi: Gruppo[] = [
  {
    id: "grp_7a1",
    nome: "Analisi 1 — corso A",
    membri: [{ iniziali: "MR" }, { iniziali: "LB" }],
    fileCondivisi: 18,
    calendarioCondivisoId: "cal_gruppo_analisi",
  },
  {
    id: "grp_9c3",
    nome: "Erasmus study group",
    membri: [{ iniziali: "MR" }, { iniziali: "JD" }],
    fileCondivisi: 6,
  },
];

export const risultatiRicerca: DocumentoPubblico[] = [
  {
    titolo: "Termodinamica — appunti completi",
    materia: "Fisica II",
    autore: "g.russo",
    ateneo: "Unipa",
    download: 34,
  },
  {
    titolo: "Esercizi svolti — primo principio",
    materia: "Fisica II",
    autore: "m.b_92",
    ateneo: "Unipa",
    download: 19,
  },
];
