import 'package:flutter/material.dart';

import '../../models/gruppo.dart';
import '../../theme/app_colors.dart';

/// Fila di avatar "a iniziali" sovrapposti, come i membri di un gruppo nel
/// mockup di Gruppi. Se i membri sono più di [massimoVisibili], gli ultimi
/// si comprimono in un unico cerchio "+N" invece di allungare la fila
/// all'infinito.
class AvatarStack extends StatelessWidget {
  const AvatarStack({
    super.key,
    required this.membri,
    this.massimoVisibili = 2,
  });

  final List<MembroGruppo> membri;
  final int massimoVisibili;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final visibili = membri.take(massimoVisibili).toList();
    final restanti = membri.length - visibili.length;

    Widget cerchio(String testo, Color sfondo) => Container(
          width: 22,
          height: 22,
          alignment: Alignment.center,
          decoration: BoxDecoration(shape: BoxShape.circle, color: sfondo),
          child: Text(testo, style: const TextStyle(fontSize: 9)),
        );

    return Row(
      children: [
        for (var i = 0; i < visibili.length; i++) ...[
          if (i > 0) const SizedBox(width: 6),
          cerchio(visibili[i].iniziali, colors.avatarPalette[i % colors.avatarPalette.length]),
        ],
        if (restanti > 0) ...[
          const SizedBox(width: 6),
          cerchio('+$restanti', colors.avatarPalette.last),
        ],
      ],
    );
  }
}
