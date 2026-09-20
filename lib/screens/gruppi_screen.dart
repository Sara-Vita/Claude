import 'package:flutter/material.dart';

import '../data/mock_data.dart';
import '../models/gruppo.dart';
import '../theme/app_colors.dart';
import '../widgets/common/avatar_stack.dart';
import '../widgets/common/section_header.dart';

/// Gruppi: storage/calendario condiviso tra colleghi, distinto dal
/// materiale individuale delle Dispense. Il badge "calendario condiviso"
/// compare solo per i gruppi che hanno effettivamente un Calendario
/// collegato — non è un requisito per creare un gruppo (la messaggistica
/// resta una funzione ancora da decidere, quindi questo design funziona
/// anche come puro storage).
class GruppiScreen extends StatelessWidget {
  const GruppiScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 28),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SectionHeader(
            titolo: 'Gruppi',
            trailing: ElevatedButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.add, size: 16),
              label: const Text('Crea gruppo'),
            ),
          ),
          for (final gruppo in MockData.gruppi) _CardGruppo(gruppo: gruppo),
        ],
      ),
    );
  }
}

class _CardGruppo extends StatelessWidget {
  const _CardGruppo({required this.gruppo});

  final Gruppo gruppo;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(border: Border.all(color: colors.border)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(gruppo.nome, style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: colors.textPrimary)),
              ),
              if (gruppo.calendarioCondivisoId != null)
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: colors.accentOlive),
                  ),
                  child: Text('calendario condiviso', style: TextStyle(fontSize: 10, color: colors.accentOlive)),
                ),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              AvatarStack(membri: gruppo.membri),
              const SizedBox(width: 8),
              Text('${gruppo.fileCondivisi} file condivisi', style: TextStyle(fontSize: 11, color: colors.textMuted)),
            ],
          ),
        ],
      ),
    );
  }
}
