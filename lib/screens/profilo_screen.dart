import 'package:flutter/material.dart';

import '../data/mock_data.dart';
import '../models/utente.dart';
import '../theme/app_colors.dart';
import '../widgets/common/section_header.dart';

enum _Tab { anagrafica, libretto }

/// Profilo: dati anagrafici + aspetto/impostazioni in un tab, Libretto
/// nell'altro. CLAUDE.md tiene il Libretto volutamente separato
/// dall'anagrafica (dati ad alta frequenza di consultazione — voti, media —
/// contro dati pressoché statici); qui si traduce in due tab dentro la
/// stessa schermata invece che due voci separate in sidebar, per non far
/// crescere la navigazione principale oltre le sei voci già decise.
class ProfiloScreen extends StatefulWidget {
  const ProfiloScreen({
    super.key,
    required this.themeMode,
    required this.onToggleThemeMode,
  });

  final ThemeMode themeMode;
  final ValueChanged<ThemeMode> onToggleThemeMode;

  @override
  State<ProfiloScreen> createState() => _ProfiloScreenState();
}

class _ProfiloScreenState extends State<ProfiloScreen> {
  _Tab _tab = _Tab.anagrafica;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final utente = MockData.utente;

    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 28),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SectionHeader(titolo: 'Profilo'),
          Row(
            children: [
              CircleAvatar(
                radius: 26,
                backgroundColor: colors.accentTerracotta,
                child: Text(
                  // Dart non ha un operatore [] su String (a differenza di
                  // JS): substring(0, 1) è il modo corretto per prendere
                  // la prima lettera.
                  '${utente.nome.substring(0, 1)}${utente.cognome.substring(0, 1)}',
                  style: TextStyle(color: colors.navbarTextActive, fontSize: 16),
                ),
              ),
              const SizedBox(width: 14),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(utente.nomeCompleto, style: TextStyle(fontSize: 16, color: colors.textPrimary)),
                  Text(utente.email, style: TextStyle(fontSize: 12, color: colors.textMuted)),
                ],
              ),
              const SizedBox(width: 10),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                color: utente.isPro ? colors.accentTerracotta : colors.border,
                child: Text(
                  utente.isPro ? 'PRO' : 'FREE',
                  style: TextStyle(
                    fontSize: 10,
                    color: utente.isPro ? colors.navbarTextActive : colors.textMuted,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          _SelettoreTab(tab: _tab, onChanged: (t) => setState(() => _tab = t)),
          const SizedBox(height: 20),
          if (_tab == _Tab.anagrafica)
            _TabAnagrafica(
              utente: utente,
              themeMode: widget.themeMode,
              onToggleThemeMode: widget.onToggleThemeMode,
            )
          else
            _TabLibretto(libretto: utente.libretto),
        ],
      ),
    );
  }
}

class _SelettoreTab extends StatelessWidget {
  const _SelettoreTab({required this.tab, required this.onChanged});

  final _Tab tab;
  final ValueChanged<_Tab> onChanged;

  @override
  Widget build(BuildContext context) {
    return SegmentedButton<_Tab>(
      segments: const [
        ButtonSegment(value: _Tab.anagrafica, label: Text('Anagrafica')),
        ButtonSegment(value: _Tab.libretto, label: Text('Libretto')),
      ],
      selected: {tab},
      onSelectionChanged: (selezione) => onChanged(selezione.first),
    );
  }
}

class _TabAnagrafica extends StatelessWidget {
  const _TabAnagrafica({
    required this.utente,
    required this.themeMode,
    required this.onToggleThemeMode,
  });

  final Utente utente;
  final ThemeMode themeMode;
  final ValueChanged<ThemeMode> onToggleThemeMode;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SectionLabel('Aspetto'),
        const SizedBox(height: 8),
        Text(
          'Tema "Originale" — nel piano Pro arriveranno altre palette '
          '(rosa, verde, azzurro, temi stagionali): sono estetica pura, '
          'mai una funzione di studio a pagamento.',
          style: TextStyle(fontSize: 12, color: colors.textMuted),
        ),
        const SizedBox(height: 10),
        SegmentedButton<ThemeMode>(
          segments: const [
            ButtonSegment(value: ThemeMode.light, icon: Icon(Icons.light_mode_outlined), label: Text('Chiaro')),
            ButtonSegment(value: ThemeMode.dark, icon: Icon(Icons.dark_mode_outlined), label: Text('Scuro')),
            ButtonSegment(value: ThemeMode.system, icon: Icon(Icons.brightness_auto_outlined), label: Text('Auto')),
          ],
          selected: {themeMode},
          onSelectionChanged: (selezione) => onToggleThemeMode(selezione.first),
        ),
        const SizedBox(height: 28),
        const SectionLabel('Impostazioni Pro'),
        const SizedBox(height: 4),
        Text(
          'Il diritto allo studio è gratuito: il Pro paga solo comodità, '
          'estetica o scala — mai accesso. Ogni voce qui sotto resta '
          'disponibile anche sul piano free, in versione più limitata ma '
          'mai a zero.',
          style: TextStyle(fontSize: 12, color: colors.textMuted),
        ),
        const SizedBox(height: 12),
        for (final voce in _voci) _RigaImpostazionePro(voce: voce),
      ],
    );
  }

  static const _voci = [
    (
      icona: Icons.auto_awesome,
      titolo: 'Generazione AI illimitata',
      free: 'Free: 20 generazioni AI al mese + manuale sempre illimitata',
    ),
    (
      icona: Icons.cloud_outlined,
      titolo: 'Storage cloud maggiorato',
      free: 'Free: storage locale/offline illimitato sul device',
    ),
    (
      icona: Icons.history,
      titolo: 'Cronologia versioni delle note',
      free: 'Free: nota corrente sempre modificabile ed esportabile',
    ),
    (
      icona: Icons.query_stats,
      titolo: 'Statistiche libretto avanzate',
      free: 'Free: media, CFU e libretto visibili e calcolati per tutti',
    ),
    (
      icona: Icons.groups_outlined,
      titolo: 'Calendari e gruppi senza limite',
      free: 'Free: fino a 5 calendari e 10 gruppi, tetto generoso',
    ),
    (
      icona: Icons.picture_as_pdf_outlined,
      titolo: 'Esportazione con template curati',
      free: 'Free: esportazione grezza (markdown/testo) sempre gratuita',
    ),
    (
      icona: Icons.bolt_outlined,
      titolo: 'Priorità di elaborazione AI',
      free: 'Free: stessa risposta, solo qualche secondo più lenta',
    ),
  ];
}

class _RigaImpostazionePro extends StatelessWidget {
  const _RigaImpostazionePro({required this.voce});

  final ({IconData icona, String titolo, String free}) voce;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(border: Border.all(color: colors.border)),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(voce.icona, size: 18, color: colors.accentOlive),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(voce.titolo, style: TextStyle(fontSize: 13, color: colors.textPrimary)),
                const SizedBox(height: 2),
                Text(voce.free, style: TextStyle(fontSize: 11, color: colors.textMuted)),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 1),
            color: colors.accentTerracotta,
            child: Text('PRO', style: TextStyle(fontSize: 9, color: colors.navbarTextActive)),
          ),
        ],
      ),
    );
  }
}

class _TabLibretto extends StatelessWidget {
  const _TabLibretto({required this.libretto});

  final Libretto libretto;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(libretto.corsoDiLaurea, style: TextStyle(fontSize: 16, color: colors.textPrimary)),
        const SizedBox(height: 16),
        Row(
          children: [
            _Statistica(etichetta: 'Media', valore: libretto.media.toStringAsFixed(1), colors: colors),
            const SizedBox(width: 24),
            _Statistica(
              etichetta: 'CFU',
              valore: '${libretto.cfuConseguiti}/${libretto.cfuTotali}',
              colors: colors,
            ),
          ],
        ),
        const SizedBox(height: 10),
        ClipRRect(
          borderRadius: BorderRadius.circular(4),
          child: LinearProgressIndicator(
            value: libretto.percentualeCompletamento,
            minHeight: 6,
            backgroundColor: colors.border,
            valueColor: AlwaysStoppedAnimation(colors.accentOlive),
          ),
        ),
        const SizedBox(height: 24),
        const SectionLabel('Esami sostenuti'),
        const SizedBox(height: 8),
        for (final esame in libretto.esami)
          Container(
            padding: const EdgeInsets.symmetric(vertical: 9),
            decoration: BoxDecoration(border: Border(bottom: BorderSide(color: colors.border))),
            child: Row(
              children: [
                Expanded(child: Text(esame.nome, style: TextStyle(fontSize: 13, color: colors.textPrimary))),
                Text('${esame.cfu} CFU', style: TextStyle(fontSize: 11, color: colors.textMuted)),
                const SizedBox(width: 14),
                Text('${esame.voto}', style: TextStyle(fontSize: 14, color: colors.accentTerracotta)),
              ],
            ),
          ),
      ],
    );
  }
}

class _Statistica extends StatelessWidget {
  const _Statistica({required this.etichetta, required this.valore, required this.colors});

  final String etichetta;
  final String valore;
  final AppColors colors;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(etichetta.toUpperCase(), style: TextStyle(fontSize: 10, letterSpacing: 1, color: colors.textMuted)),
        Text(valore, style: TextStyle(fontSize: 22, color: colors.textPrimary)),
      ],
    );
  }
}
