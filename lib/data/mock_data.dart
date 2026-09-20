import 'package:flutter/material.dart';

import '../models/calendario.dart';
import '../models/documento_pubblico.dart';
import '../models/flashcard.dart';
import '../models/gruppo.dart';
import '../models/materia.dart';
import '../models/utente.dart';

/// Dati statici di esempio, SOLO per popolare visivamente l'interfaccia.
///
/// Non c'è alcun layer di rete/persistenza in questa fase (richiesto
/// esplicitamente fuori scope): ogni schermata legge da qui invece che da
/// un ViewModel/Provider collegato a un backend. Quando arriverà un'API
/// reale, questo file si sostituisce con un repository che restituisce le
/// stesse classi in lib/models/, senza toccare le schermate.
class MockData {
  const MockData._();

  static const _terracotta = Color(0xFFC1502E);
  static const _oliva = Color(0xFF7C8A4E);
  static const _marroneChiaro = Color(0xFF8A6E5C);

  static final utente = Utente(
    nome: 'Mario',
    cognome: 'Rossi',
    email: 'mario.rossi@studenti.unipa.it',
    piano: Piano.free,
    libretto: Libretto(
      corsoDiLaurea: 'Ingegneria Informatica',
      media: 27.4,
      cfuConseguiti: 96,
      cfuTotali: 180,
      esami: [
        Esame(
            nome: 'Analisi Matematica 1',
            voto: 28,
            cfu: 12,
            data: DateTime(2024, 1, 20)),
        Esame(
            nome: 'Fisica I',
            voto: 26,
            cfu: 9,
            data: DateTime(2024, 6, 14)),
        Esame(
            nome: 'Programmazione I',
            voto: 30,
            cfu: 9,
            data: DateTime(2024, 7, 3)),
        Esame(
            nome: 'Geometria',
            voto: 24,
            cfu: 6,
            data: DateTime(2025, 1, 28)),
      ],
    ),
  );

  static final materie = <Materia>[
    Materia(
      id: 'mat_a13f',
      nome: 'Fisica II',
      colore: _oliva,
      docente: 'Prof. Bianchi',
      dataEsame: DateTime(2026, 9, 18),
      numeroNote: 5,
      numeroRegistrazioni: 2,
      numeroFlashcard: 12,
    ),
    Materia(
      id: 'mat_b207',
      nome: 'Analisi 1',
      colore: _terracotta,
      docente: 'Prof.ssa Greco',
      dataEsame: DateTime(2026, 9, 25),
      numeroNote: 8,
      numeroFoto: 4,
    ),
    Materia(
      id: 'mat_c391',
      nome: 'Chimica generale',
      colore: _marroneChiaro,
      docente: 'Prof. Ferro',
      dataEsame: DateTime(2026, 10, 6),
      numeroNote: 3,
      numeroRegistrazioni: 1,
      numeroFlashcard: 20,
    ),
  ];

  static final mazzi = <FlashcardDeck>[
    FlashcardDeck(
      id: 'deck_11c9',
      materiaId: 'mat_a13f',
      titolo: 'Fisica II — Termodinamica',
      origine: OrigineMazzo.ai,
      numeroCarte: 12,
    ),
    FlashcardDeck(
      id: 'deck_22d1',
      materiaId: 'mat_c391',
      titolo: 'Chimica — Legami chimici',
      origine: OrigineMazzo.manuale,
      numeroCarte: 20,
    ),
  ];

  static final calendari = <Calendario>[
    Calendario(
      id: 'cal_personale',
      nome: 'Personale',
      colore: _terracotta,
      eventi: [
        Evento(
          id: 'evt_991',
          titolo: 'Ripasso Fisica II',
          giorno: 5,
          inizio: const TimeOfDay(hour: 14, minute: 0),
          fine: const TimeOfDay(hour: 16, minute: 0),
          materiaId: 'mat_a13f',
        ),
      ],
    ),
    Calendario(
      id: 'cal_gruppo_analisi',
      nome: 'Gruppo Analisi 1',
      colore: _oliva,
      eventi: [
        Evento(
          id: 'evt_992',
          titolo: 'Sessione di studio comune',
          giorno: 9,
          inizio: const TimeOfDay(hour: 10, minute: 0),
          fine: const TimeOfDay(hour: 12, minute: 0),
          materiaId: 'mat_b207',
        ),
      ],
    ),
    Calendario(
      id: 'cal_lezioni',
      nome: 'Lezioni',
      colore: _marroneChiaro,
      eventi: [
        Evento(
          id: 'evt_993',
          titolo: 'Analisi matematica, aula 3',
          giorno: 9,
          inizio: const TimeOfDay(hour: 9, minute: 0),
          fine: const TimeOfDay(hour: 11, minute: 0),
          materiaId: 'mat_b207',
        ),
      ],
    ),
  ];

  static final gruppi = <Gruppo>[
    Gruppo(
      id: 'grp_7a1',
      nome: 'Analisi 1 — corso A',
      membri: const [
        MembroGruppo(iniziali: 'MR'),
        MembroGruppo(iniziali: 'LB'),
      ],
      fileCondivisi: 18,
      calendarioCondivisoId: 'cal_gruppo_analisi',
    ),
    Gruppo(
      id: 'grp_9c3',
      nome: 'Erasmus study group',
      membri: const [
        MembroGruppo(iniziali: 'MR'),
        MembroGruppo(iniziali: 'JD'),
      ],
      fileCondivisi: 6,
    ),
  ];

  static const risultatiRicerca = <DocumentoPubblico>[
    DocumentoPubblico(
      titolo: 'Termodinamica — appunti completi',
      materia: 'Fisica II',
      autore: 'g.russo',
      ateneo: 'Unipa',
      download: 34,
    ),
    DocumentoPubblico(
      titolo: 'Esercizi svolti — primo principio',
      materia: 'Fisica II',
      autore: 'm.b_92',
      ateneo: 'Unipa',
      download: 19,
    ),
  ];
}
