import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'app_colors.dart';

/// Costruisce i due [ThemeData] (chiaro/scuro) dell'app a partire dai token
/// in [AppColors]. Tenerli in un solo posto evita che le schermate scelgano
/// colori "a mano" (es. `Color(0xFFC1502E)` sparso ovunque) invece di leggerli
/// dal tema: se domani cambia una tonalità, si cambia qui una volta sola.
class AppTheme {
  const AppTheme._();

  static ThemeData light() => _build(Brightness.light, AppColors.light);

  static ThemeData dark() => _build(Brightness.dark, AppColors.dark);

  static ThemeData _build(Brightness brightness, AppColors colors) {
    // ColorScheme.fromSeed genera un'intera scala di colori Material
    // (container, onContainer, ecc.) partendo da un solo colore. Usiamo il
    // terracotta come seed così tutti i widget Material "di base" (Switch,
    // Checkbox, effetti ripple...) restano coerenti con l'identità visiva
    // anche dove non abbiamo definito uno stile esplicito.
    final baseScheme = ColorScheme.fromSeed(
      seedColor: colors.accentTerracotta,
      brightness: brightness,
    ).copyWith(
      primary: colors.accentTerracotta,
      secondary: colors.accentOlive,
      surface: colors.pageBackground,
      onSurface: colors.textPrimary,
      outline: colors.border,
    );

    // GoogleFonts.loraTextTheme applica "Lora" (il sostituto serif di
    // Georgia scelto in pubspec.yaml, vedi commento lì) a tutta la
    // TextTheme di Material, poi la coloriamo col marrone/crema del brand
    // invece del nero/bianco di default.
    final textTheme = GoogleFonts.loraTextTheme().apply(
      bodyColor: colors.textPrimary,
      displayColor: colors.textPrimary,
    );

    return ThemeData(
      useMaterial3: true,
      brightness: brightness,
      colorScheme: baseScheme,
      scaffoldBackgroundColor: colors.pageBackground,
      textTheme: textTheme,
      dividerColor: colors.border,
      // Registriamo i nostri token custom sul tema: da qui in poi qualunque
      // widget figlio li legge con `context.colors.xyz` (vedi app_colors.dart).
      extensions: <ThemeExtension<dynamic>>[colors],
      appBarTheme: AppBarTheme(
        backgroundColor: colors.pageBackground,
        foregroundColor: colors.textPrimary,
        elevation: 0,
        surfaceTintColor: Colors.transparent,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: colors.accentTerracotta,
          foregroundColor: colors.navbarTextActive,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(4),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: colors.accentTerracotta,
          side: BorderSide(color: colors.accentTerracotta),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(4),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        ),
      ),
      cardTheme: CardThemeData(
        color: colors.surface,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(6),
          side: BorderSide(color: colors.border),
        ),
      ),
      dividerTheme: DividerThemeData(color: colors.border, thickness: 1),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: colors.surface,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(6),
          borderSide: BorderSide(color: colors.border),
        ),
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      ),
    );
  }
}
