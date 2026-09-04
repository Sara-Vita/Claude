import 'package:flutter/material.dart';

import '../data/mock_data.dart';
import '../models/flashcard.dart';
import '../theme/app_colors.dart';
import '../widgets/common/section_header.dart';

/// Studio: hub di creazione (nota, registrazione, immagine generata,
/// upload) e generazione flashcard. I mazzi generati confluiscono qui,
/// non dentro le singole materie (CLAUDE.md) — la materia di appartenenza
/// resta comunque visibile come metadato del mazzo.
class StudioScreen extends StatelessWidget {
  const StudioScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 28),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SectionHeader(titolo: 'Studio'),
          LayoutBuilder(
            builder: (context, constraints) {
              final colonne = constraints.maxWidth >= 640 ? 4 : 2;
              return GridView.count(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisCount: colonne,
                mainAxisSpacing: 12,
                crossAxisSpacing: 12,
                childAspectRatio: 2.4,
                children: [
                  _AzioneCard(
                    icona: Icons.notes,
                    etichetta: 'Nuova nota',
                    onTap: () {},
                  ),
                  _AzioneCard(
                    icona: Icons.mic_none,
                    etichetta: 'Registra lezione',
                    onTap: () {},
                  ),
                  _AzioneCard(
                    icona: Icons.photo_outlined,
                    etichetta: 'Genera immagine',
                    onTap: () => _apriSceltaStileImmagine(context),
                  ),
                  _AzioneCard(
                    icona: Icons.upload_outlined,
                    etichetta: 'Carica file',
                    onTap: () {},
                  ),
                ],
              );
            },
          ),
          const SizedBox(height: 22),
          const SectionLabel('I tuoi mazzi'),
          for (final mazzo in MockData.mazzi) _RigaMazzo(mazzo: mazzo),
          const SizedBox(height: 18),
          Wrap(
            spacing: 10,
            runSpacing: 10,
            children: [
              ElevatedButton.icon(
                onPressed: () {},
                style: ElevatedButton.styleFrom(backgroundColor: colors.accentOlive),
                icon: const Icon(Icons.add, size: 16),
                label: const Text('Genera flashcard manuale'),
              ),
              OutlinedButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.auto_awesome, size: 16),
                label: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text('Genera con AI'),
                    const SizedBox(width: 6),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 1),
                      color: colors.accentTerracotta,
                      child: Text('PRO', style: TextStyle(fontSize: 10, color: colors.navbarTextActive)),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  /// Tre proposte di stile invece di una sola immagine generica: la
  /// richiesta esplicita del progetto è di NON produrre "il solito" risultato
  /// AI riconoscibile a colpo d'occhio. Qui è solo la scelta dello stile —
  /// la generazione vera e propria è fuori dallo scope di questa interfaccia.
  void _apriSceltaStileImmagine(BuildContext context) {
    showModalBottomSheet<void>(
      context: context,
      builder: (context) {
        final colors = context.colors;
        const stili = [
          (nome: 'Schizzo a mano', icona: Icons.edit_outlined),
          (nome: 'Acquarello tenue', icona: Icons.water_drop_outlined),
          (nome: 'Linee minimali', icona: Icons.gesture),
        ];
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Scegli uno stile', style: TextStyle(fontSize: 16, color: colors.textPrimary)),
                const SizedBox(height: 14),
                for (final stile in stili)
                  ListTile(
                    contentPadding: EdgeInsets.zero,
                    leading: Icon(stile.icona, color: colors.accentOlive),
                    title: Text(stile.nome, style: TextStyle(color: colors.textPrimary)),
                    onTap: () => Navigator.of(context).pop(),
                  ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _AzioneCard extends StatelessWidget {
  const _AzioneCard({required this.icona, required this.etichetta, required this.onTap});

  final IconData icona;
  final String etichetta;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(border: Border.all(color: colors.border)),
        child: Row(
          children: [
            Icon(icona, size: 18, color: colors.accentOlive),
            const SizedBox(width: 10),
            Flexible(child: Text(etichetta, style: TextStyle(fontSize: 14, color: colors.textPrimary))),
          ],
        ),
      ),
    );
  }
}

class _RigaMazzo extends StatelessWidget {
  const _RigaMazzo({required this.mazzo});

  final FlashcardDeck mazzo;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(border: Border(bottom: BorderSide(color: colors.border))),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text(mazzo.titolo, style: TextStyle(fontSize: 14, color: colors.textPrimary)),
          ),
          if (mazzo.origine == OrigineMazzo.ai)
            Padding(
              padding: const EdgeInsets.only(right: 8),
              child: Icon(Icons.auto_awesome, size: 13, color: colors.accentTerracotta),
            ),
          Text('${mazzo.numeroCarte} carte', style: TextStyle(fontSize: 12, color: colors.textMuted)),
        ],
      ),
    );
  }
}
