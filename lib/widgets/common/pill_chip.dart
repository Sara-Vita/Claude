import 'package:flutter/material.dart';

import '../../theme/app_colors.dart';

/// Chip a "pillola" usato come filtro nella schermata Ricerca (materia,
/// tipo file, ateneo). [selezionato] usa l'oliva pieno per il bordo/testo
/// (come il filtro "Fisica" già attivo nel mockup); altrimenti resta nel
/// grigio-bordo neutro.
class PillChip extends StatelessWidget {
  const PillChip({
    super.key,
    required this.label,
    this.selezionato = false,
    this.onTap,
  });

  final String label;
  final bool selezionato;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final colore = selezionato ? colors.accentOlive : colors.textMuted;
    final bordo = selezionato ? colors.accentOlive : colors.border;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: bordo),
        ),
        child: Text(label, style: TextStyle(fontSize: 10, color: colore)),
      ),
    );
  }
}
