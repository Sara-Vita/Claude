import 'package:flutter/material.dart';

import '../../layout/breakpoints.dart';
import '../../navigation/app_section.dart';
import '../../screens/calendario_screen.dart';
import '../../screens/dispense_screen.dart';
import '../../screens/gruppi_screen.dart';
import '../../screens/home_screen.dart';
import '../../screens/profilo_screen.dart';
import '../../screens/ricerca_screen.dart';
import '../../screens/studio_screen.dart';
import '../../theme/app_colors.dart';
import 'app_bottom_nav.dart';
import 'app_sidebar.dart';
import 'mobile_top_bar.dart';
import 'rings_divider.dart';
import 'search_overlay.dart';

/// Il guscio dell'app: decide, in base alla larghezza disponibile, se
/// mostrare il layout desktop (sidebar espandibile), tablet (sidebar
/// sempre compatta) o mobile (bottom bar), e tiene lo stato di
/// navigazione condiviso da tutti e tre — quale sezione è aperta, se la
/// sidebar desktop è espansa o compressa, se il pannello di ricerca
/// rapida è visibile.
///
/// Tenere questo stato qui (e non dentro ogni singolo layout) è ciò che
/// permette, ad esempio, di ridimensionare la finestra da desktop a
/// tablet senza perdere la sezione aperta: è la stessa istanza di stato,
/// cambia solo quale albero di widget la mostra.
class AppShell extends StatefulWidget {
  const AppShell({
    super.key,
    required this.themeMode,
    required this.onToggleThemeMode,
  });

  final ThemeMode themeMode;
  final ValueChanged<ThemeMode> onToggleThemeMode;

  @override
  State<AppShell> createState() => _AppShellState();
}

class _AppShellState extends State<AppShell> {
  AppSection _section = AppSection.home;

  /// Sezione a cui torna il pulsante "indietro" quando si è dentro Ricerca
  /// (l'unica sezione secondaria rimasta ora che Calendario è una voce
  /// fissa). Salvata solo al momento in cui SI ENTRA in Ricerca.
  AppSection? _sezionePrecedente;

  /// Preferenza "per breakpoint" descritta in CLAUDE.md
  /// (`preferenze.navbar.desktop`): qui la teniamo in memoria invece che
  /// persistita, dato che il JSON utente è fuori scope in questa fase.
  bool _desktopEspansa = true;

  bool _overlayRicercaVisibile = false;

  void _naviga(AppSection sezione) {
    setState(() {
      if (sezione.isSecondaria && !_section.isSecondaria) {
        _sezionePrecedente = _section;
      }
      _section = sezione;
      _overlayRicercaVisibile = false;
    });
  }

  void _tornaIndietro() {
    setState(() {
      _section = _sezionePrecedente ?? AppSection.home;
      _sezionePrecedente = null;
    });
  }

  void _toggleSidebarDesktop() =>
      setState(() => _desktopEspansa = !_desktopEspansa);

  void _toggleOverlayRicerca() =>
      setState(() => _overlayRicercaVisibile = !_overlayRicercaVisibile);

  void _submitRicercaOverlay(String testo) => _naviga(AppSection.ricerca);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final deviceType = Breakpoints.of(constraints.maxWidth);

        if (deviceType == DeviceType.mobile) {
          return _MobileLayout(
            section: _section,
            onSelect: _naviga,
            onBack: _sezionePrecedente == null ? null : _tornaIndietro,
            content: _buildContent(),
          );
        }

        // Desktop e tablet condividono lo stesso scheletro (sidebar +
        // anelletti + contenuto): cambia solo se la sidebar può essere
        // espansa/compressa dall'utente.
        final espansa = deviceType == DeviceType.desktop && _desktopEspansa;
        return _SidebarLayout(
          section: _section,
          expanded: espansa,
          showToggle: deviceType == DeviceType.desktop,
          overlayRicercaVisibile: _overlayRicercaVisibile,
          onSelect: _naviga,
          onToggleSidebar: _toggleSidebarDesktop,
          onSearchTap: espansa ? () => _naviga(AppSection.ricerca) : _toggleOverlayRicerca,
          onSubmitRicerca: _submitRicercaOverlay,
          onDismissOverlay: () => setState(() => _overlayRicercaVisibile = false),
          content: _buildContent(),
        );
      },
    );
  }

  Widget _buildContent() {
    return switch (_section) {
      AppSection.home => HomeScreen(onVediCalendario: () => _naviga(AppSection.calendario)),
      AppSection.dispense => const DispenseScreen(),
      AppSection.studio => const StudioScreen(),
      AppSection.gruppi => const GruppiScreen(),
      AppSection.profilo => ProfiloScreen(
          themeMode: widget.themeMode,
          onToggleThemeMode: widget.onToggleThemeMode,
        ),
      AppSection.ricerca => const RicercaScreen(),
      AppSection.calendario => const CalendarioScreen(),
    };
  }
}

/// Layout condiviso da desktop e tablet: Sidebar | Anelletti | Contenuto.
class _SidebarLayout extends StatelessWidget {
  const _SidebarLayout({
    required this.section,
    required this.expanded,
    required this.showToggle,
    required this.overlayRicercaVisibile,
    required this.onSelect,
    required this.onToggleSidebar,
    required this.onSearchTap,
    required this.onSubmitRicerca,
    required this.onDismissOverlay,
    required this.content,
  });

  final AppSection section;
  final bool expanded;
  final bool showToggle;
  final bool overlayRicercaVisibile;
  final ValueChanged<AppSection> onSelect;
  final VoidCallback onToggleSidebar;
  final VoidCallback onSearchTap;
  final ValueChanged<String> onSubmitRicerca;
  final VoidCallback onDismissOverlay;
  final Widget content;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return ColoredBox(
      color: colors.pageBackground,
      child: Stack(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              AppSidebar(
                expanded: expanded,
                showToggle: showToggle,
                currentSection: section,
                onSelect: onSelect,
                onSearchTap: onSearchTap,
                onToggle: onToggleSidebar,
              ),
              const RingsDivider(),
              Expanded(child: SafeArea(left: false, child: content)),
            ],
          ),
          if (overlayRicercaVisibile)
            Positioned(
              top: 16,
              left: 62,
              child: SearchOverlay(
                onSubmit: onSubmitRicerca,
                onDismiss: onDismissOverlay,
              ),
            ),
        ],
      ),
    );
  }
}

/// Layout mobile: barra in alto (titolo + ricerca) sopra il contenuto,
/// striscia di anelletti orizzontale, bottom bar sotto. Niente sidebar
/// laterale qui, ma gli anelletti restano — solo ruotati di 90° per
/// affiancare la navbar orizzontale invece di quella verticale.
class _MobileLayout extends StatelessWidget {
  const _MobileLayout({
    required this.section,
    required this.onSelect,
    required this.onBack,
    required this.content,
  });

  final AppSection section;
  final ValueChanged<AppSection> onSelect;
  final VoidCallback? onBack;
  final Widget content;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return ColoredBox(
      color: colors.pageBackground,
      child: Column(
        children: [
          MobileTopBar(
            titolo: section.etichetta,
            onSearchTap: () => onSelect(AppSection.ricerca),
            onBack: onBack,
          ),
          Expanded(child: content),
          const RingsDivider(direzione: Axis.horizontal, numeroAnelli: 10),
          AppBottomNav(currentSection: section, onSelect: onSelect),
        ],
      ),
    );
  }
}
