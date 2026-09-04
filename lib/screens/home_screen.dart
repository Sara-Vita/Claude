import 'package:flutter/material.dart';

import '../data/mock_data.dart';
import '../models/materia.dart';
import '../theme/app_colors.dart';
import '../widgets/common/section_header.dart';

const _mesi = [
  'gennaio', 'febbraio', 'marzo', 'aprile', 'maggio', 'giugno',
  'luglio', 'agosto', 'settembre', 'ottobre', 'novembre', 'dicembre',
]; // niente package intl solo per formattare una data: non vale la dipendenza extra.

/// Home: obiettivo della giornata, impegni di oggi, materie da studiare in
/// vista degli esami — i tre blocchi descritti nella proposta originale.
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key, required this.onVediCalendario});

  final VoidCallback onVediCalendario;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final oggi = DateTime.now();
    final impegniOggi = MockData.calendari
        .expand((c) => c.eventi.map((e) => (calendario: c, evento: e)))
        .where((coppia) => coppia.evento.giorno == oggi.day)
        .toList()
      ..sort((a, b) => a.evento.inizio.hour.compareTo(b.evento.inizio.hour));

    final daStudiare = [...MockData.materie]
      ..sort((a, b) => a.dataEsame.compareTo(b.dataEsame));

    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 28),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SectionHeader(
            titolo: 'Oggi, ${oggi.day} ${_mesi[oggi.month - 1]}',
            trailing: TextButton.icon(
              onPressed: onVediCalendario,
              icon: Icon(Icons.calendar_month_outlined, size: 16, color: colors.accentOlive),
              label: Text('Calendario completo', style: TextStyle(color: colors.accentOlive)),
            ),
          ),
          const SectionLabel('Impegni'),
          const SizedBox(height: 8),
          if (impegniOggi.isEmpty)
            _rigaVuota(colors, 'Nessun impegno per oggi.')
          else
            for (final coppia in impegniOggi)
              _RigaImpegno(
                orario: coppia.evento.inizio,
                titolo: coppia.evento.titolo,
                colore: coppia.evento.colore ?? coppia.calendario.colore,
              ),
          const SizedBox(height: 20),
          const SectionLabel('Da studiare'),
          const SizedBox(height: 8),
          for (final materia in daStudiare.take(3))
            _CardDaStudiare(materia: materia),
        ],
      ),
    );
  }

  Widget _rigaVuota(AppColors colors, String testo) => Container(
        padding: const EdgeInsets.symmetric(vertical: 9),
        decoration: BoxDecoration(border: Border.symmetric(horizontal: BorderSide(color: colors.border))),
        child: Text(testo, style: TextStyle(fontSize: 13, color: colors.textMuted)),
      );
}

class _RigaImpegno extends StatelessWidget {
  const _RigaImpegno({required this.orario, required this.titolo, required this.colore});

  final TimeOfDay orario;
  final String titolo;
  final Color colore;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final ora = orario.hour.toString().padLeft(2, '0');
    final minuti = orario.minute.toString().padLeft(2, '0');
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 9),
      decoration: BoxDecoration(border: Border(bottom: BorderSide(color: colors.border))),
      child: Row(
        children: [
          Container(width: 8, height: 8, decoration: BoxDecoration(shape: BoxShape.circle, color: colore)),
          const SizedBox(width: 10),
          Text('$ora:$minuti', style: TextStyle(fontSize: 14, color: colors.textMuted)),
          const SizedBox(width: 10),
          Expanded(child: Text(titolo, style: TextStyle(fontSize: 14, color: colors.textPrimary))),
        ],
      ),
    );
  }
}

class _CardDaStudiare extends StatelessWidget {
  const _CardDaStudiare({required this.materia});

  final Materia materia;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final giorniMancanti = materia.dataEsame.difference(DateTime.now()).inDays;
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(border: Border.all(color: colors.border)),
      child: Row(
        children: [
          Container(width: 4, height: 32, color: materia.colore),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              '${materia.nome} — esame tra $giorniMancanti giorni'
              '${materia.numeroFlashcard > 0 ? ' — ${materia.numeroFlashcard} flashcard da ripassare' : ''}',
              style: TextStyle(fontSize: 13, color: colors.textMuted),
            ),
          ),
        ],
      ),
    );
  }
}
