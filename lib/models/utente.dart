import 'package:flutter/foundation.dart';

enum Piano { free, pro }

/// Un singolo esame sostenuto (riga del libretto).
@immutable
class Esame {
  const Esame({
    required this.nome,
    required this.voto,
    required this.cfu,
    required this.data,
  });

  final String nome;

  /// 18-30, o 31 per convenzione "30 e lode" (gestito a parte in UI se
  /// servirà davvero distinguerlo; per ora un intero è sufficiente).
  final int voto;
  final int cfu;
  final DateTime data;
}

/// Il libretto, tenuto come oggetto 1:1 annidato nell'utente: a differenza
/// degli Esami (1:molti → tabella a parte con `utenteId` come FK), qui non
/// ha senso normalizzare finché non serve interrogare i libretti
/// indipendentemente dagli utenti a cui appartengono.
@immutable
class Libretto {
  const Libretto({
    required this.corsoDiLaurea,
    required this.media,
    required this.cfuConseguiti,
    required this.cfuTotali,
    required this.esami,
  });

  final String corsoDiLaurea;
  final double media;
  final int cfuConseguiti;
  final int cfuTotali;
  final List<Esame> esami;

  double get percentualeCompletamento =>
      cfuTotali == 0 ? 0 : cfuConseguiti / cfuTotali;
}

/// Nota: qui teniamo solo i campi che servono a popolare la UI di questa
/// interfaccia (Profilo, saluto in Home, ecc.). Non è la struttura dati
/// dell'utente lato backend/persistenza — quella non è richiesta in questa
/// fase, come specificato nel task.
@immutable
class Utente {
  const Utente({
    required this.nome,
    required this.cognome,
    required this.email,
    required this.piano,
    required this.libretto,
  });

  final String nome;
  final String cognome;
  final String email;
  final Piano piano;
  final Libretto libretto;

  String get nomeCompleto => '$nome $cognome';
  bool get isPro => piano == Piano.pro;
}
