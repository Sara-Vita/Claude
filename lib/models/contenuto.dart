import 'package:flutter/foundation.dart';

/// Tipo di contenuto creato/caricato in Studio o nelle Dispense.
///
/// Rispecchia la tabella polimorfica `Contenuti` di CLAUDE.md: una sola
/// enum invece di quattro classi separate perché la UI mostra questi
/// elementi mescolati in un unico feed cronologico per materia.
enum TipoContenuto { nota, registrazione, foto, flashcardDeck }

/// Da dove nasce il contenuto: creato nell'hub Studio, oppure importato
/// nelle Dispense da storage locale del device.
enum OrigineContenuto { studio, dispenseImportLocale }

@immutable
class Contenuto {
  const Contenuto({
    required this.id,
    required this.materiaId,
    required this.tipo,
    required this.origine,
    required this.titolo,
    required this.createdAt,
    this.corpo,
    this.urlFile,
  });

  final String id;
  final String materiaId;
  final TipoContenuto tipo;
  final OrigineContenuto origine;
  final String titolo;
  final DateTime createdAt;

  /// Testo della nota; null per registrazione/foto/mazzo.
  final String? corpo;

  /// Percorso/URL del file; null per una nota testuale pura.
  final String? urlFile;
}
