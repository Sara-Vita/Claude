import 'package:flutter/material.dart';

import 'theme/app_theme.dart';
import 'widgets/shell/app_shell.dart';

void main() {
  runApp(const QuadernoApp());
}

/// Radice dell'app. Tiene il [ThemeMode] qui (non dentro [AppShell]) perché
/// serve a [MaterialApp] stesso, non solo alla shell: se un domani si
/// aggiunge un secondo `MaterialApp` (es. per un flusso di onboarding a
/// schermo intero) condividerebbe comunque la stessa preferenza.
class QuadernoApp extends StatefulWidget {
  const QuadernoApp({super.key});

  @override
  State<QuadernoApp> createState() => _QuadernoAppState();
}

class _QuadernoAppState extends State<QuadernoApp> {
  // "auto" di default: segue il sistema finché l'utente non sceglie
  // esplicitamente chiaro/scuro da Profilo (preferenze.aspetto.modalita
  // in CLAUDE.md). Nessuna persistenza per ora: è solo stato in memoria,
  // coerente con lo scope di questa fase (niente JSON utente).
  ThemeMode _themeMode = ThemeMode.system;

  void _setThemeMode(ThemeMode mode) => setState(() => _themeMode = mode);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Quaderno',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light(),
      darkTheme: AppTheme.dark(),
      themeMode: _themeMode,
      home: AppShell(
        themeMode: _themeMode,
        onToggleThemeMode: _setThemeMode,
      ),
    );
  }
}
