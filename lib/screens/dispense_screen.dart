import 'package:flutter/material.dart';

import '../data/mock_data.dart';
import '../models/materia.dart';
import '../theme/app_colors.dart';
import '../widgets/common/section_header.dart';

/// "Dispense" (ex "Materiale"): elenco delle materie, ciascuna come card
/// col bordo colorato = materia.colore e i conteggi di note/registrazioni/
/// foto/flashcard che contiene (senza doverli caricare tutti, vedi il
/// commento nel modello Materia).
class DispenseScreen extends StatelessWidget {
  const DispenseScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 28),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SectionHeader(
            titolo: 'Dispense',
            trailing: ElevatedButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.add, size: 16),
              label: const Text('Aggiungi materia'),
            ),
          ),
          LayoutBuilder(
            builder: (context, constraints) {
              // Più colonne quando c'è spazio: 1 sotto i 420px (tipico
              // mobile in verticale), poi 2, poi 3 oltre gli 900px. Non è
              // legato ai breakpoint della shell perché qui la larghezza
              // rilevante è quella del contenuto, non della finestra intera
              // (su desktop con sidebar espansa il contenuto è più stretto
              // della finestra).
              final colonne = constraints.maxWidth >= 900
                  ? 3
                  : constraints.maxWidth >= 420
                      ? 2
                      : 1;
              return GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: MockData.materie.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: colonne,
                  mainAxisExtent: 108,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                ),
                itemBuilder: (context, index) => _CardMateria(materia: MockData.materie[index]),
              );
            },
          ),
        ],
      ),
    );
  }
}

class _CardMateria extends StatelessWidget {
  const _CardMateria({required this.materia});

  final Materia materia;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(color: colors.border),
          right: BorderSide(color: colors.border),
          bottom: BorderSide(color: colors.border),
          left: BorderSide(color: materia.colore, width: 4),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(materia.nome, style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: colors.textPrimary)),
          const SizedBox(height: 4),
          Text(
            'Esame ${materia.dataEsame.day}/${materia.dataEsame.month}',
            style: TextStyle(fontSize: 11, color: colors.textMuted),
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              if (materia.numeroNote > 0) _Conteggio(Icons.notes, materia.numeroNote, colors.textMuted),
              if (materia.numeroRegistrazioni > 0) ...[
                const SizedBox(width: 10),
                _Conteggio(Icons.mic_none, materia.numeroRegistrazioni, colors.textMuted),
              ],
              if (materia.numeroFoto > 0) ...[
                const SizedBox(width: 10),
                _Conteggio(Icons.photo_outlined, materia.numeroFoto, colors.textMuted),
              ],
              if (materia.numeroFlashcard > 0) ...[
                const SizedBox(width: 10),
                _Conteggio(Icons.style_outlined, materia.numeroFlashcard, colors.textMuted),
              ],
            ],
          ),
        ],
      ),
    );
  }
}

class _Conteggio extends StatelessWidget {
  const _Conteggio(this.icona, this.valore, this.colore);

  final IconData icona;
  final int valore;
  final Color colore;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icona, size: 12, color: colore),
        const SizedBox(width: 3),
        Text('$valore', style: TextStyle(fontSize: 11, color: colore)),
      ],
    );
  }
}
