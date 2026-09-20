import 'package:flutter/material.dart';

/// Token di colore "semantici" specifici del design a tema quaderno.
///
/// Perché non basta [ColorScheme] di Material: in questo design la sidebar
/// ha uno sfondo (terracotta / grafite) completamente diverso dallo sfondo
/// della pagina (beige / grafite scuro), e alcuni elementi (anelletti,
/// badge PRO, avatar dei gruppi) non hanno un equivalente diretto nei ruoli
/// standard di Material (primary/secondary/surface...). Un [ThemeExtension]
/// permette di aggiungere questi token al [ThemeData] e leggerli ovunque con
/// `Theme.of(context).extension<AppColors>()!`, con interpolazione automatica
/// tra chiaro/scuro quando serve (qui non serve animarli, ma il meccanismo
/// resta quello corretto per estendere il tema in modo tipizzato).
@immutable
class AppColors extends ThemeExtension<AppColors> {
  const AppColors({
    required this.navbarBackground,
    required this.navbarSearchBackground,
    required this.navbarTextActive,
    required this.navbarTextInactive,
    required this.navbarActiveIndicator,
    required this.pageBackground,
    required this.surface,
    required this.textPrimary,
    required this.textMuted,
    required this.border,
    required this.accentOlive,
    required this.accentTerracotta,
    required this.ringFill,
    required this.ringBorder,
    required this.avatarPalette,
  });

  /// Sfondo pieno della sidebar/navbar.
  final Color navbarBackground;

  /// Sfondo della "pillola" di ricerca dentro la sidebar (leggermente
  /// diverso dallo sfondo navbar per dare un effetto "incassato").
  final Color navbarSearchBackground;

  /// Colore testo/icona per la voce di navigazione attiva.
  final Color navbarTextActive;

  /// Colore testo/icona per le voci di navigazione non attive.
  final Color navbarTextInactive;

  /// Colore della barra verticale che indica la voce attiva. In chiaro è
  /// lo stesso beige dello sfondo pagina (perché la sidebar è terracotta,
  /// quindi "spicca" comunque); in scuro è il terracotta acceso, perché lì
  /// la sidebar è grafite neutra e serve un vero colore d'accento.
  final Color navbarActiveIndicator;

  /// Sfondo della pagina/contenuto (beige in chiaro, grafite scuro in buio).
  final Color pageBackground;

  /// Sfondo di elementi "sollevati" sopra la pagina (input di ricerca nella
  /// schermata Ricerca, eventuali card più chiare della pagina).
  final Color surface;

  /// Colore testo principale (marrone in chiaro, quasi bianco caldo in buio).
  final Color textPrimary;

  /// Colore testo secondario/didascalie (date, contatori, meta-informazioni).
  final Color textMuted;

  /// Colore dei bordi sottili (separatori, card, chip).
  final Color border;

  /// Verde oliva — colore "di rottura" per titoli di sezione ed elementi
  /// secondari d'accento (non i pulsanti principali, quelli sono terracotta).
  final Color accentOlive;

  /// Terracotta — colore primario per pulsanti d'azione e badge PRO.
  final Color accentTerracotta;

  /// Riempimento degli "anelletti" decorativi tra sidebar e contenuto.
  final Color ringFill;

  /// Bordo degli "anelletti", leggermente più scuro del riempimento per
  /// simulare un foro perforato piuttosto che un pallino pieno.
  final Color ringBorder;

  /// Palette cromatica per gli avatar "iniziali" dei membri dei gruppi:
  /// si cicla su questi colori assegnandoli per indice, così ogni membro
  /// ha un colore stabile e distinguibile senza dover salvare un colore
  /// dedicato per persona.
  final List<Color> avatarPalette;

  static const light = AppColors(
    navbarBackground: Color(0xFFC1502E),
    navbarSearchBackground: Color(0xFFA8421F),
    navbarTextActive: Color(0xFFF2EBDD),
    navbarTextInactive: Color(0xFFEAC9B8),
    navbarActiveIndicator: Color(0xFFF2EBDD),
    pageBackground: Color(0xFFF2EBDD),
    surface: Color(0xFFFFFDF8),
    textPrimary: Color(0xFF4A3323),
    textMuted: Color(0xFF8A7358),
    border: Color(0xFFD9C9AE),
    accentOlive: Color(0xFF7C8A4E),
    accentTerracotta: Color(0xFFC1502E),
    ringFill: Color(0xFFE4D7BE),
    ringBorder: Color(0xFFC9B896),
    avatarPalette: [
      Color(0xFFE4D7BE),
      Color(0xFFDCE3C4),
      Color(0xFFF0DCC8),
    ],
  );

  /// Variante "grafite neutro" scelta per la dark mode. I valori dei
  /// componenti non presenti nei mockup (anelletti e palette avatar in
  /// scuro) sono estrapolati seguendo la stessa formula del resto della
  /// palette scura: base neutra desaturata, accenti (terracotta/oliva)
  /// invariati nella tinta ma leggermente schiariti per restare leggibili
  /// su fondo scuro. Vanno rifiniti a occhio quando si avrà lo schermo reale.
  static const dark = AppColors(
    navbarBackground: Color(0xFF262523),
    navbarSearchBackground: Color(0xFF1C1B19),
    navbarTextActive: Color(0xFFE8E4DC),
    navbarTextInactive: Color(0xFF8F8A80),
    navbarActiveIndicator: Color(0xFFE2643A),
    pageBackground: Color(0xFF1C1B19),
    surface: Color(0xFF262523),
    textPrimary: Color(0xFFE8E4DC),
    textMuted: Color(0xFF8F8A80),
    border: Color(0xFF35332F),
    accentOlive: Color(0xFF8FA05C),
    accentTerracotta: Color(0xFFE2643A),
    ringFill: Color(0xFF35332F),
    ringBorder: Color(0xFF4A4640),
    avatarPalette: [
      Color(0xFF4A4636),
      Color(0xFF3E4433),
      Color(0xFF4A3D30),
    ],
  );

  @override
  AppColors copyWith({
    Color? navbarBackground,
    Color? navbarSearchBackground,
    Color? navbarTextActive,
    Color? navbarTextInactive,
    Color? navbarActiveIndicator,
    Color? pageBackground,
    Color? surface,
    Color? textPrimary,
    Color? textMuted,
    Color? border,
    Color? accentOlive,
    Color? accentTerracotta,
    Color? ringFill,
    Color? ringBorder,
    List<Color>? avatarPalette,
  }) {
    return AppColors(
      navbarBackground: navbarBackground ?? this.navbarBackground,
      navbarSearchBackground:
          navbarSearchBackground ?? this.navbarSearchBackground,
      navbarTextActive: navbarTextActive ?? this.navbarTextActive,
      navbarTextInactive: navbarTextInactive ?? this.navbarTextInactive,
      navbarActiveIndicator:
          navbarActiveIndicator ?? this.navbarActiveIndicator,
      pageBackground: pageBackground ?? this.pageBackground,
      surface: surface ?? this.surface,
      textPrimary: textPrimary ?? this.textPrimary,
      textMuted: textMuted ?? this.textMuted,
      border: border ?? this.border,
      accentOlive: accentOlive ?? this.accentOlive,
      accentTerracotta: accentTerracotta ?? this.accentTerracotta,
      ringFill: ringFill ?? this.ringFill,
      ringBorder: ringBorder ?? this.ringBorder,
      avatarPalette: avatarPalette ?? this.avatarPalette,
    );
  }

  @override
  AppColors lerp(ThemeExtension<AppColors>? other, double t) {
    if (other is! AppColors) return this;
    Color c(Color a, Color b) => Color.lerp(a, b, t)!;
    return AppColors(
      navbarBackground: c(navbarBackground, other.navbarBackground),
      navbarSearchBackground:
          c(navbarSearchBackground, other.navbarSearchBackground),
      navbarTextActive: c(navbarTextActive, other.navbarTextActive),
      navbarTextInactive: c(navbarTextInactive, other.navbarTextInactive),
      navbarActiveIndicator:
          c(navbarActiveIndicator, other.navbarActiveIndicator),
      pageBackground: c(pageBackground, other.pageBackground),
      surface: c(surface, other.surface),
      textPrimary: c(textPrimary, other.textPrimary),
      textMuted: c(textMuted, other.textMuted),
      border: c(border, other.border),
      accentOlive: c(accentOlive, other.accentOlive),
      accentTerracotta: c(accentTerracotta, other.accentTerracotta),
      ringFill: c(ringFill, other.ringFill),
      ringBorder: c(ringBorder, other.ringBorder),
      avatarPalette: avatarPalette,
    );
  }
}

/// Scorciatoia per leggere i token custom senza ripetere ovunque
/// `Theme.of(context).extension<AppColors>()!`.
extension AppColorsX on BuildContext {
  AppColors get colors => Theme.of(this).extension<AppColors>()!;
}
