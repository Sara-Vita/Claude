import 'package:flutter/material.dart';

import '../data/mock_data.dart';
import '../models/documento_pubblico.dart';
import '../theme/app_colors.dart';
import '../widgets/common/pill_chip.dart';

/// Ricerca pubblica: materiale che altri studenti hanno scelto di
/// condividere gratuitamente (distinto dalle Dispense private). Risultati
/// in stile "elenco bibliografico" — niente card con thumbnail flottanti —
/// coerente con lo stile quaderno; i filtri (materia/tipo file/ateneo)
/// contano più della semplice rilevanza testuale perché la fonte è
/// pubblica e non verificata.
class RicercaScreen extends StatefulWidget {
  const RicercaScreen({super.key});

  @override
  State<RicercaScreen> createState() => _RicercaScreenState();
}

class _RicercaScreenState extends State<RicercaScreen> {
  String? _filtroAttivo = 'Fisica';

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: colors.surface,
              borderRadius: BorderRadius.circular(6),
              border: Border.all(color: colors.border),
            ),
            child: Row(
              children: [
                Icon(Icons.search, size: 16, color: colors.textMuted),
                const SizedBox(width: 8),
                Expanded(
                  child: TextField(
                    style: TextStyle(fontSize: 13, color: colors.textPrimary),
                    decoration: InputDecoration(
                      isDense: true,
                      border: InputBorder.none,
                      filled: false,
                      hintText: 'termodinamica...',
                      hintStyle: TextStyle(color: colors.textMuted),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 8,
            children: [
              for (final filtro in const ['Fisica', 'Appunti', 'Unipa'])
                PillChip(
                  label: filtro,
                  selezionato: filtro == _filtroAttivo,
                  onTap: () => setState(() => _filtroAttivo = filtro == _filtroAttivo ? null : filtro),
                ),
            ],
          ),
          const SizedBox(height: 16),
          for (final documento in MockData.risultatiRicerca) _RigaRisultato(documento: documento),
        ],
      ),
    );
  }
}

class _RigaRisultato extends StatelessWidget {
  const _RigaRisultato({required this.documento});

  final DocumentoPubblico documento;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12),
      decoration: BoxDecoration(border: Border(top: BorderSide(color: colors.border))),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(documento.titolo, style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: colors.textPrimary)),
          const SizedBox(height: 3),
          Text(
            '${documento.materia} · condiviso da ${documento.autore} · ${documento.ateneo} · ${documento.download} download',
            style: TextStyle(fontSize: 11, color: colors.textMuted),
          ),
        ],
      ),
    );
  }
}
