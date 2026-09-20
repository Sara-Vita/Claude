import 'package:flutter/material.dart';

import '../../theme/app_colors.dart';

/// Pannello che compare quando si tocca l'icona di ricerca in sidebar
/// compatta (desktop compresso o tablet): la ricerca è troppo importante da
/// nascondere del tutto quando la sidebar è ridotta a sole icone, ma non
/// c'è spazio per un campo di testo permanente — un piccolo overlay
/// ancorato in alto è il compromesso descritto in CLAUDE.md.
///
/// Va posizionato dal chiamante dentro uno [Stack] (vedi app_shell.dart):
/// qui dentro ci occupiamo solo dell'aspetto e della logica di submit,
/// non del posizionamento assoluto.
class SearchOverlay extends StatefulWidget {
  const SearchOverlay({
    super.key,
    required this.onSubmit,
    required this.onDismiss,
  });

  final ValueChanged<String> onSubmit;
  final VoidCallback onDismiss;

  @override
  State<SearchOverlay> createState() => _SearchOverlayState();
}

class _SearchOverlayState extends State<SearchOverlay> {
  final _controller = TextEditingController();
  final _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    // Il pannello appare già pronto per digitare: risparmia un tap a chi
    // sta solo cercando qualcosa al volo.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) _focusNode.requestFocus();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return Material(
      elevation: 6,
      borderRadius: BorderRadius.circular(8),
      color: colors.surface,
      child: Container(
        width: 260,
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: colors.border),
        ),
        child: Row(
          children: [
            Icon(Icons.search, size: 16, color: colors.textMuted),
            const SizedBox(width: 8),
            Expanded(
              child: TextField(
                controller: _controller,
                focusNode: _focusNode,
                style: TextStyle(fontSize: 13, color: colors.textPrimary),
                decoration: const InputDecoration(
                  isDense: true,
                  border: InputBorder.none,
                  hintText: 'cerca dispense...',
                ),
                onSubmitted: widget.onSubmit,
              ),
            ),
            IconButton(
              onPressed: widget.onDismiss,
              icon: Icon(Icons.close, size: 16, color: colors.textMuted),
              padding: EdgeInsets.zero,
              constraints: const BoxConstraints(),
              visualDensity: VisualDensity.compact,
            ),
          ],
        ),
      ),
    );
  }
}
