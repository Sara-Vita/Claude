import 'package:flutter/material.dart';

/// Tutte le "schermate" raggiungibili nella shell.
///
/// Le prime cinque sono le voci fisse di navigazione (sidebar/bottom bar),
/// nell'ordine deciso in CLAUDE.md: Home, Dispense, Studio, Gruppi, Profilo.
/// [ricerca] e [calendario] sono sezioni "secondarie": si raggiungono da
/// un'azione dentro il contenuto (icona di ricerca, bottone "vedi
/// calendario completo" in Home) e non hanno una voce propria in sidebar —
/// esattamente come descritto nei mockup, dove la ricerca è "un elemento di
/// primo livello sempre visibile", non una voce di navigazione.
enum AppSection {
  home(icona: Icons.home_outlined, iconaAttiva: Icons.home, etichetta: 'Home'),
  dispense(
    icona: Icons.menu_book_outlined,
    iconaAttiva: Icons.menu_book,
    etichetta: 'Dispense',
  ),
  studio(
    icona: Icons.lightbulb_outline,
    iconaAttiva: Icons.lightbulb,
    etichetta: 'Studio',
  ),
  gruppi(
    icona: Icons.groups_outlined,
    iconaAttiva: Icons.groups,
    etichetta: 'Gruppi',
  ),
  profilo(
    icona: Icons.person_outline,
    iconaAttiva: Icons.person,
    etichetta: 'Profilo',
  ),
  ricerca(
    icona: Icons.search,
    iconaAttiva: Icons.search,
    etichetta: 'Ricerca',
  ),
  calendario(
    icona: Icons.calendar_month_outlined,
    iconaAttiva: Icons.calendar_month,
    etichetta: 'Calendario',
  );

  const AppSection({
    required this.icona,
    required this.iconaAttiva,
    required this.etichetta,
  });

  final IconData icona;
  final IconData iconaAttiva;
  final String etichetta;

  /// Le cinque voci mostrate in sidebar/bottom bar, nell'ordine giusto.
  static const vociPrincipali = [home, dispense, studio, gruppi, profilo];

  /// true per le sezioni raggiunte "di passaggio" (mostrano una freccia
  /// indietro invece di essere evidenziate in navigazione).
  bool get isSecondaria => this == ricerca || this == calendario;
}
