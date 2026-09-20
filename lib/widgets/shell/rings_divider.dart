import 'package:flutter/material.dart';

import '../../theme/app_colors.dart';

/// Gli "anelletti" decorativi che corrono accanto alla navbar, a simulare
/// la rilegatura di un quaderno — su desktop/tablet come colonna verticale
/// tra sidebar e contenuto, su mobile come striscia orizzontale appena
/// sopra la bottom bar (dove la "navbar" è orizzontale, non più laterale).
/// Presente su tutti e tre i breakpoint per richiesta esplicita di
/// progetto: qui non è mai la stessa metafora "riga di puntini fissi con
/// passo costante" nelle due direzioni, ma la stessa idea — un bordo
/// forato — applicata all'orientamento giusto per ciascun layout.
///
/// Regola non negoziabile (CLAUDE.md): è puramente decorativo — nessun
/// `onTap`, nessun cambio di aspetto al hover. `ExcludeSemantics` lo
/// nasconde anche a screen reader/navigazione da tastiera, equivalente
/// Flutter dell'`aria-hidden` usato nei mockup.
class RingsDivider extends StatelessWidget {
  const RingsDivider({
    super.key,
    this.numeroAnelli = 6,
    this.direzione = Axis.vertical,
  });

  final int numeroAnelli;
  final Axis direzione;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final anello = Container(
      width: 11,
      height: 11,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: colors.ringFill,
        border: Border.all(color: colors.ringBorder),
      ),
    );

    if (direzione == Axis.horizontal) {
      // Niente passo fisso qui: la larghezza dello schermo mobile varia
      // molto più della lunghezza tipica di una sidebar, quindi distribuire
      // i punti con `spaceEvenly` evita sia l'overflow su schermi stretti
      // sia buchi enormi su schermi larghi — restano sempre leggibili come
      // fila di forellini, qualunque sia il telefono.
      return ExcludeSemantics(
        child: Container(
          height: 20,
          color: colors.pageBackground,
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: List.generate(numeroAnelli, (_) => anello),
          ),
        ),
      );
    }

    return ExcludeSemantics(
      child: Container(
        width: 22,
        color: colors.pageBackground,
        padding: const EdgeInsets.only(top: 26),
        child: Column(
          children: [
            for (var i = 0; i < numeroAnelli; i++)
              Padding(padding: const EdgeInsets.only(bottom: 22), child: anello),
          ],
        ),
      ),
    );
  }
}
