import 'package:flutter/material.dart';

/// Tutte le "schermate" raggiungibili nella shell.
///
/// Aggiornamento rispetto alla prima bozza: Calendario è ora una voce fissa
/// di navigazione (richiesta esplicita), quindi la sidebar/bottom bar mostra
/// sei voci: Home, Calendario, Dispense, Studio, Gruppi, Profilo.
/// [ricerca] resta l'unica sezione "secondaria": si raggiunge dall'icona di
/// ricerca sempre visibile in cima alla sidebar, non da una voce di
/// navigazione — esattamente come descritto nei mockup ("un elemento di
/// primo livello sempre visibile", non una voce di navigazione).
enum AppSection {
  home(icona: Icons.home_outlined, iconaAttiva: Icons.home, etichetta: 'Home'),
  calendario(
    icona: Icons.calendar_month_outlined,
    iconaAttiva: Icons.calendar_month,
    etichetta: 'Calendario',
  ),
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
  );

  const AppSection({
    required this.icona,
    required this.iconaAttiva,
    required this.etichetta,
  });

  final IconData icona;
  final IconData iconaAttiva;
  final String etichetta;

  /// Le sei voci mostrate in sidebar/bottom bar, nell'ordine giusto.
  static const vociPrincipali = [home, calendario, dispense, studio, gruppi, profilo];

  /// true per le sezioni raggiunte "di passaggio" (mostrano una freccia
  /// indietro invece di essere evidenziate in navigazione). Con Calendario
  /// promosso a voce fissa, l'unica rimasta è Ricerca.
  bool get isSecondaria => this == ricerca;
}
