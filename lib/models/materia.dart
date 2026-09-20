import 'package:flutter/material.dart';

/// Una materia universitaria (schermata "Dispense").
///
/// Volutamente NON contiene una lista annidata di contenuti: nel modello
/// dati discusso in CLAUDE.md i contenuti (note/registrazioni/foto/mazzi)
/// vivono in una tabella a parte collegata da `materiaId`, proprio per non
/// dover caricare tutti i contenuti di una materia solo per mostrarne la
/// card riassuntiva. Qui teniamo solo i conteggi già calcolati
/// ([numeroNote], [numeroRegistrazioni], ...), come farebbe una query
/// `COUNT(*) GROUP BY tipo` lato server.
@immutable
class Materia {
  const Materia({
    required this.id,
    required this.nome,
    required this.colore,
    required this.docente,
    required this.dataEsame,
    this.numeroNote = 0,
    this.numeroRegistrazioni = 0,
    this.numeroFoto = 0,
    this.numeroFlashcard = 0,
  });

  final String id;
  final String nome;

  /// Colore identificativo della materia: usato come bordo della card qui
  /// in Dispense, ma anche come "etichetta" quando lo stesso contenuto
  /// compare altrove (es. tag materia in Studio).
  final Color colore;

  final String docente;
  final DateTime dataEsame;

  final int numeroNote;
  final int numeroRegistrazioni;
  final int numeroFoto;
  final int numeroFlashcard;
}
