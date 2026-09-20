/// Le tre "classi" di dispositivo su cui l'interfaccia si adatta.
///
/// Non usiamo `MediaQuery` per rilevare "è un telefono?" (il tipo di
/// dispositivo fisico non conta: una finestra desktop ridotta deve
/// comportarsi come mobile). Guardiamo solo la larghezza disponibile, che è
/// esattamente il criterio descritto nei mockup e in CLAUDE.md.
enum DeviceType { mobile, tablet, desktop }

class Breakpoints {
  const Breakpoints._();

  /// Sotto questa larghezza: layout mobile (bottom bar).
  static const double tablet = 700;

  /// Sotto questa larghezza (e sopra [tablet]): layout tablet (sidebar
  /// sempre compatta, senza toggle). Da qui in su: layout desktop
  /// (sidebar espandibile/comprimibile).
  static const double desktop = 1100;

  static DeviceType of(double width) {
    if (width >= desktop) return DeviceType.desktop;
    if (width >= tablet) return DeviceType.tablet;
    return DeviceType.mobile;
  }
}
