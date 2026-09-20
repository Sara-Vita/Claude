import 'package:flutter/material.dart';

import '../../navigation/app_section.dart';
import '../../theme/app_colors.dart';

/// Sidebar verticale usata sia su desktop (espansa o compatta, con toggle)
/// sia su tablet (sempre compatta, senza toggle — passare [showToggle] a
/// false in quel caso).
///
/// È lo stesso widget per entrambi i breakpoint invece di due widget
/// diversi perché la differenza è solo di "parametri" (larghezza, presenza
/// delle etichette, presenza della freccia), non di struttura: tenerli
/// uniti evita di dover sincronizzare due implementazioni ogni volta che
/// cambia un dettaglio visivo della sidebar.
class AppSidebar extends StatelessWidget {
  const AppSidebar({
    super.key,
    required this.expanded,
    required this.showToggle,
    required this.currentSection,
    required this.onSelect,
    required this.onSearchTap,
    this.onToggle,
  });

  final bool expanded;
  final bool showToggle;
  final AppSection currentSection;
  final ValueChanged<AppSection> onSelect;
  final VoidCallback onSearchTap;
  final VoidCallback? onToggle;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final width = expanded ? 190.0 : 56.0;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 180),
      width: width,
      color: colors.navbarBackground,
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Column(
        crossAxisAlignment:
            expanded ? CrossAxisAlignment.start : CrossAxisAlignment.center,
        children: [
          _Header(expanded: expanded, colors: colors),
          const SizedBox(height: 18),
          _SearchEntry(
            expanded: expanded,
            colors: colors,
            onTap: onSearchTap,
          ),
          const SizedBox(height: 20),
          for (final sezione in AppSection.vociPrincipali)
            _NavItem(
              sezione: sezione,
              expanded: expanded,
              attiva: sezione == currentSection,
              colors: colors,
              onTap: () => onSelect(sezione),
            ),
          const Spacer(),
          if (showToggle) _ToggleButton(expanded: expanded, colors: colors, onTap: onToggle),
        ],
      ),
    );
  }
}

class _Header extends StatelessWidget {
  const _Header({required this.expanded, required this.colors});

  final bool expanded;
  final AppColors colors;

  @override
  Widget build(BuildContext context) {
    if (!expanded) {
      // In modalità compatta il nome del brand non c'è spazio per stare per
      // esteso: un'iniziale dentro un cerchio basta a mantenere l'identità.
      return CircleAvatar(
        radius: 12,
        backgroundColor: colors.navbarSearchBackground,
        child: Text(
          'Q',
          style: TextStyle(color: colors.navbarTextActive, fontSize: 13),
        ),
      );
    }
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18),
      child: Text(
        'Quaderno',
        style: TextStyle(
          color: colors.navbarTextActive,
          fontSize: 19,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}

class _SearchEntry extends StatelessWidget {
  const _SearchEntry({
    required this.expanded,
    required this.colors,
    required this.onTap,
  });

  final bool expanded;
  final AppColors colors;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    if (!expanded) {
      return InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(20),
        child: Padding(
          padding: const EdgeInsets.all(6),
          child: Icon(Icons.search, color: colors.navbarTextInactive, size: 20),
        ),
      );
    }
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(6),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 9),
          decoration: BoxDecoration(
            color: colors.navbarSearchBackground,
            borderRadius: BorderRadius.circular(6),
          ),
          child: Row(
            children: [
              Icon(Icons.search, color: colors.navbarTextInactive, size: 15),
              const SizedBox(width: 6),
              Expanded(
                child: Text(
                  'cerca dispense...',
                  style: TextStyle(color: colors.navbarTextInactive, fontSize: 12),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _NavItem extends StatelessWidget {
  const _NavItem({
    required this.sezione,
    required this.expanded,
    required this.attiva,
    required this.colors,
    required this.onTap,
  });

  final AppSection sezione;
  final bool expanded;
  final bool attiva;
  final AppColors colors;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final colore = attiva ? colors.navbarTextActive : colors.navbarTextInactive;
    final bordo = Border(
      left: BorderSide(
        width: 3,
        color: attiva ? colors.navbarActiveIndicator : Colors.transparent,
      ),
    );

    if (!expanded) {
      return Tooltip(
        message: sezione.etichetta,
        child: InkWell(
          onTap: onTap,
          child: Container(
            margin: const EdgeInsets.symmetric(vertical: 3),
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(border: bordo),
            child: Icon(attiva ? sezione.iconaAttiva : sezione.icona, color: colore, size: 20),
          ),
        ),
      );
    }

    return InkWell(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 9),
        decoration: BoxDecoration(border: bordo),
        child: Row(
          children: [
            Icon(attiva ? sezione.iconaAttiva : sezione.icona, color: colore, size: 17),
            const SizedBox(width: 10),
            Text(sezione.etichetta, style: TextStyle(color: colore, fontSize: 13)),
          ],
        ),
      ),
    );
  }
}

class _ToggleButton extends StatelessWidget {
  const _ToggleButton({required this.expanded, required this.colors, this.onTap});

  final bool expanded;
  final AppColors colors;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: expanded ? 15 : 0),
      child: Align(
        alignment: expanded ? Alignment.centerRight : Alignment.center,
        child: IconButton(
          onPressed: onTap,
          tooltip: expanded ? 'Comprimi barra laterale' : 'Espandi barra laterale',
          icon: Icon(
            expanded ? Icons.chevron_left : Icons.chevron_right,
            color: colors.navbarTextInactive,
            size: 18,
          ),
        ),
      ),
    );
  }
}
