import 'package:flutter/material.dart';

import '../../navigation/app_section.dart';
import '../../theme/app_colors.dart';

/// Barra di navigazione inferiore per mobile: sotto il breakpoint tablet la
/// sidebar smette di esistere come colonna laterale e viene sostituita da
/// questo pattern, perché a quelle dimensioni il pollice raggiunge il fondo
/// schermo molto più comodamente della cima (vedi CLAUDE.md).
class AppBottomNav extends StatelessWidget {
  const AppBottomNav({
    super.key,
    required this.currentSection,
    required this.onSelect,
  });

  final AppSection currentSection;
  final ValueChanged<AppSection> onSelect;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    // L'indice selezionato deve restare valido anche quando siamo su una
    // sezione "secondaria" (ricerca/calendario, che non hanno una voce
    // propria qui): in quel caso nessuna icona risulta evidenziata.
    final indiceAttivo = AppSection.vociPrincipali.indexOf(currentSection);

    return DecoratedBox(
      decoration: BoxDecoration(
        color: colors.navbarBackground,
        border: Border(top: BorderSide(color: colors.border)),
      ),
      child: SafeArea(
        top: false,
        child: SizedBox(
          height: 58,
          child: Row(
            children: [
              for (final sezione in AppSection.vociPrincipali)
                Expanded(
                  child: _BottomNavButton(
                    sezione: sezione,
                    attiva: sezione ==
                        (indiceAttivo == -1 ? null : currentSection),
                    colors: colors,
                    onTap: () => onSelect(sezione),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class _BottomNavButton extends StatelessWidget {
  const _BottomNavButton({
    required this.sezione,
    required this.attiva,
    required this.colors,
    required this.onTap,
  });

  final AppSection sezione;
  final bool attiva;
  final AppColors colors;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final colore = attiva ? colors.navbarTextActive : colors.navbarTextInactive;
    return InkWell(
      onTap: onTap,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(attiva ? sezione.iconaAttiva : sezione.icona, color: colore, size: 22),
          const SizedBox(height: 3),
          Text(sezione.etichetta, style: TextStyle(color: colore, fontSize: 10)),
        ],
      ),
    );
  }
}
