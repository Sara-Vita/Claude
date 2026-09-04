import 'package:flutter/foundation.dart';

/// Come è stato generato un mazzo: manuale (sempre gratis) o con AI (quota
/// gratuita mensile + illimitato Pro, mai bloccato del tutto sul piano free
/// — vedi la "filosofia del piano Pro" in CLAUDE.md).
enum OrigineMazzo { manuale, ai }

@immutable
class FlashcardDeck {
  const FlashcardDeck({
    required this.id,
    required this.materiaId,
    required this.titolo,
    required this.origine,
    required this.numeroCarte,
  });

  final String id;
  final String materiaId;
  final String titolo;
  final OrigineMazzo origine;
  final int numeroCarte;
}
