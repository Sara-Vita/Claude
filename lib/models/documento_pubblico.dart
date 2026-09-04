import 'package:flutter/foundation.dart';

/// Un risultato della sezione Ricerca: materiale che un altro studente ha
/// scelto di rendere pubblico e gratuito (vedi CLAUDE.md — la ricerca
/// pubblica è separata dal materiale privato delle Dispense).
@immutable
class DocumentoPubblico {
  const DocumentoPubblico({
    required this.titolo,
    required this.materia,
    required this.autore,
    required this.ateneo,
    required this.download,
  });

  final String titolo;
  final String materia;
  final String autore;
  final String ateneo;
  final int download;
}
