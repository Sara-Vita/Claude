import 'package:flutter/material.dart';

import '../../theme/app_colors.dart';

/// Titolo di pagina con il trattino oliva sotto, ripreso identico da tutti
/// i mockup delle schermate principali (Home, Studio, ...). Un widget
/// dedicato invece di ripetere Text + SizedBox + Container in ogni
/// schermata: se cambia lo stile del titolo, cambia in un solo posto.
class SectionHeader extends StatelessWidget {
  const SectionHeader({super.key, required this.titolo, this.trailing});

  final String titolo;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: Text(
                titolo,
                style: TextStyle(fontSize: 24, color: colors.textPrimary),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            if (trailing != null) ...[
              const SizedBox(width: 12),
              trailing!,
            ],
          ],
        ),
        const SizedBox(height: 10),
        Container(width: 60, height: 1, color: colors.accentOlive),
        const SizedBox(height: 20),
      ],
    );
  }
}

/// Etichetta piccola, maiuscola, in oliva — usata sopra le liste (es.
/// "IMPEGNI", "DA STUDIARE" in Home; "I TUOI MAZZI" in Studio).
class SectionLabel extends StatelessWidget {
  const SectionLabel(this.testo, {super.key});

  final String testo;

  @override
  Widget build(BuildContext context) {
    return Text(
      testo.toUpperCase(),
      style: TextStyle(
        fontSize: 13,
        letterSpacing: 1.5,
        color: context.colors.accentOlive,
      ),
    );
  }
}
