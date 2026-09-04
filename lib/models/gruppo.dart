import 'package:flutter/foundation.dart';

@immutable
class MembroGruppo {
  const MembroGruppo({required this.iniziali});

  /// Solo le iniziali: l'avatar è un cerchio con due lettere (vedi
  /// mockup schermata Gruppi), niente foto profilo per ora.
  final String iniziali;
}

@immutable
class Gruppo {
  const Gruppo({
    required this.id,
    required this.nome,
    required this.membri,
    required this.fileCondivisi,
    this.calendarioCondivisoId,
  });

  final String id;
  final String nome;
  final List<MembroGruppo> membri;

  /// Storage di gruppo: conteggio dei file condivisi. Da non confondere con
  /// il materiale individuale delle Dispense — è uno spazio separato.
  final int fileCondivisi;

  /// Se non null, il gruppo ha un Calendario collegato tramite una riga in
  /// `CalendarioCondivisioni` — non tutti i gruppi ne hanno uno, dato che la
  /// messaggistica (e quindi l'uso "sociale" del gruppo) è ancora da
  /// decidere: questo modello funziona anche come puro storage condiviso.
  final String? calendarioCondivisoId;
}
