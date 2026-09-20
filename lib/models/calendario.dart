import 'package:flutter/material.dart';

/// Un calendario (Personale, Lezioni, Gruppo X, ...).
///
/// L'app supporta calendari multipli anziché un unico calendario con colori
/// per evento: il calendario è l'unità che si accende/spegne e si condivide
/// per intero (es. "condividi solo gli impegni del gruppo Analisi 1" senza
/// esporre gli impegni personali) — esattamente come in Google Calendar.
@immutable
class Calendario {
  const Calendario({
    required this.id,
    required this.nome,
    required this.colore,
    this.eventi = const [],
  });

  final String id;
  final String nome;
  final Color colore;
  final List<Evento> eventi;
}

@immutable
class Evento {
  const Evento({
    required this.id,
    required this.titolo,
    required this.giorno,
    required this.inizio,
    required this.fine,
    this.materiaId,
    this.colore,
  });

  final String id;
  final String titolo;

  /// Giorno del mese (1-31) nella griglia settimanale mostrata in Calendario.
  final int giorno;
  final TimeOfDay inizio;
  final TimeOfDay fine;
  final String? materiaId;

  /// Se null, l'evento eredita il colore del calendario a cui appartiene
  /// (pattern usato per non dover ripetere lo stesso colore su ogni evento
  /// quando non serve un'eccezione visiva).
  final Color? colore;
}
