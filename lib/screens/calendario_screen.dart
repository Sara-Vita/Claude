import 'package:flutter/material.dart';

import '../data/mock_data.dart';
import '../models/calendario.dart';
import '../theme/app_colors.dart';

const _giorniSettimana = ['Lun', 'Mar', 'Mer', 'Gio', 'Ven'];

/// Calendario: colonna sinistra con l'elenco dei Calendari (puntino colorato
/// = calendario.colore, pattern Google Calendar), "Nuovo calendario" sempre
/// visibile perché creare calendari multipli è un'azione centrale in questo
/// modello, non un'opzione secondaria; a destra la griglia settimanale con
/// gli eventi.
///
/// Nota implementativa: qui gli eventi vengono posizionati nella griglia
/// in base al giorno della settimana calcolato da [Evento.giorno] preso
/// come giorno del mese corrente — è una semplificazione ragionevole per
/// dati di esempio; con un backend reale ogni evento porterebbe una data
/// completa e il posizionamento si calcolerebbe da quella.
class CalendarioScreen extends StatelessWidget {
  const CalendarioScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final layoutStretto = constraints.maxWidth < 640;
        final listaCalendari = _ListaCalendari(calendari: MockData.calendari);
        final griglia = const _GrigliaSettimanale();

        if (layoutStretto) {
          // Sotto una certa larghezza (contenuto stretto su mobile/tablet
          // in verticale) la colonna dei calendari va sopra la griglia
          // invece che affiancata, altrimenti la griglia non avrebbe più
          // spazio per essere leggibile.
          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [listaCalendari, const SizedBox(height: 20), griglia],
            ),
          );
        }

        return Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(padding: const EdgeInsets.all(20), child: listaCalendari),
            Expanded(child: Padding(padding: const EdgeInsets.all(20), child: griglia)),
          ],
        );
      },
    );
  }
}

class _ListaCalendari extends StatelessWidget {
  const _ListaCalendari({required this.calendari});

  final List<Calendario> calendari;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return SizedBox(
      width: 180,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Calendari', style: TextStyle(fontSize: 16, color: colors.textPrimary)),
          const SizedBox(height: 14),
          for (final calendario in calendari)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 6),
              child: Row(
                children: [
                  Container(width: 9, height: 9, decoration: BoxDecoration(shape: BoxShape.circle, color: calendario.colore)),
                  const SizedBox(width: 8),
                  Expanded(child: Text(calendario.nome, style: TextStyle(fontSize: 12, color: colors.textPrimary))),
                ],
              ),
            ),
          const SizedBox(height: 10),
          InkWell(
            onTap: () {},
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.add, size: 13, color: colors.accentOlive),
                const SizedBox(width: 6),
                Text('Nuovo calendario', style: TextStyle(fontSize: 12, color: colors.accentOlive)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _GrigliaSettimanale extends StatelessWidget {
  const _GrigliaSettimanale();

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    // Raggruppa tutti gli eventi di tutti i calendari per giorno del mese,
    // così ogni riga della griglia mostra tutti gli impegni di quel giorno
    // indipendentemente da quale Calendario appartengano — proprio come
    // nel mockup, dove Analisi (Lezioni) e Ripasso Fisica (Personale)
    // convivono nella stessa vista.
    final eventiPerGiorno = <int, List<({Evento evento, Color colore})>>{};
    for (final calendario in MockData.calendari) {
      for (final evento in calendario.eventi) {
        eventiPerGiorno
            .putIfAbsent(evento.giorno, () => [])
            .add((evento: evento, colore: evento.colore ?? calendario.colore));
      }
    }
    final giorni = eventiPerGiorno.keys.toList()..sort();

    return Table(
      columnWidths: const {0: FixedColumnWidth(40)},
      children: [
        TableRow(
          children: [
            const SizedBox.shrink(),
            for (final giorno in _giorniSettimana)
              Padding(
                padding: const EdgeInsets.only(bottom: 6),
                child: Text(giorno, textAlign: TextAlign.center, style: TextStyle(fontSize: 11, color: colors.textMuted)),
              ),
          ],
        ),
        for (final giorno in giorni)
          TableRow(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 6),
                child: Text('$giorno', style: TextStyle(fontSize: 10, color: colors.textMuted)),
              ),
              // Nei dati di esempio ogni giorno ha un solo evento: lo
              // mostriamo tutto nella prima colonna disponibile. Con dati
              // reali multi-evento, qui andrebbe la logica di posizionamento
              // per giorno-della-settimana effettivo.
              _CellaEvento(dato: eventiPerGiorno[giorno]!.first),
              for (var i = 1; i < _giorniSettimana.length; i++) const SizedBox.shrink(),
            ],
          ),
      ],
    );
  }
}

class _CellaEvento extends StatelessWidget {
  const _CellaEvento({required this.dato});

  final ({Evento evento, Color colore}) dato;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return Padding(
      padding: const EdgeInsets.all(2),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
        decoration: BoxDecoration(color: dato.colore, borderRadius: BorderRadius.circular(4)),
        child: Text(
          dato.evento.titolo,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(fontSize: 9, color: colors.navbarTextActive),
        ),
      ),
    );
  }
}
