import 'package:flutter/material.dart';

import '../../theme/app_colors.dart';

/// Gli "anelletti" decorativi tra sidebar e contenuto, a simulare la
/// rilegatura di un quaderno.
///
/// Due regole non negoziabili concordate in CLAUDE.md, applicate qui:
/// 1. È puramente decorativo — nessun `onTap`, nessun cambio di aspetto al
///    hover: un elemento cliccabile qui creerebbe un'aspettativa falsa.
///    `ExcludeSemantics` lo nasconde anche a screen reader/navigazione da
///    tastiera, equivalente Flutter dell'`aria-hidden` usato nei mockup.
/// 2. Va mostrato solo su desktop e tablet: su mobile il widget chiamante
///    semplicemente non lo istanzia (vedi app_shell.dart), non lo comprime.
class RingsDivider extends StatelessWidget {
  const RingsDivider({super.key, this.numeroAnelli = 6});

  final int numeroAnelli;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return ExcludeSemantics(
      child: Container(
        width: 22,
        color: colors.pageBackground,
        padding: const EdgeInsets.only(top: 26),
        child: Column(
          children: List.generate(numeroAnelli, (index) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 22),
              child: Container(
                width: 11,
                height: 11,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: colors.ringFill,
                  border: Border.all(color: colors.ringBorder),
                ),
              ),
            );
          }),
        ),
      ),
    );
  }
}
