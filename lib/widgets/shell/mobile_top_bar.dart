import 'package:flutter/material.dart';

import '../../theme/app_colors.dart';

/// Barra in cima al contenuto, solo mobile: qui torna l'icona di ricerca
/// (in bottom bar non c'è più posto, ha già le 6 voci piene) insieme al
/// titolo della sezione corrente.
class MobileTopBar extends StatelessWidget implements PreferredSizeWidget {
  const MobileTopBar({
    super.key,
    required this.titolo,
    required this.onSearchTap,
    this.onBack,
  });

  final String titolo;
  final VoidCallback onSearchTap;
  final VoidCallback? onBack;

  @override
  Size get preferredSize => const Size.fromHeight(52);

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return SafeArea(
      bottom: false,
      child: SizedBox(
        height: preferredSize.height,
        child: Row(
          children: [
            if (onBack != null)
              IconButton(
                onPressed: onBack,
                icon: Icon(Icons.arrow_back, color: colors.textPrimary),
              )
            else
              const SizedBox(width: 12),
            Expanded(
              child: Text(
                titolo,
                style: TextStyle(
                  color: colors.textPrimary,
                  fontSize: 18,
                ),
              ),
            ),
            IconButton(
              onPressed: onSearchTap,
              icon: Icon(Icons.search, color: colors.textPrimary),
              tooltip: 'Cerca dispense',
            ),
          ],
        ),
      ),
    );
  }
}
