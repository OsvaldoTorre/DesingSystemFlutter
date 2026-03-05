/// SizesDS — Tokens de tamaños fijos para componentes del Design System.
/// Define alturas, anchos mínimos y tamaños estándar reutilizables.
///
/// Uso:
/// ```dart
/// SizedBox(height: SizesDS.inputMd)
/// ConstrainedBox(constraints: BoxConstraints(minWidth: SizesDS.buttonMinWidth))
/// ```
class SizesDS {
  SizesDS._();

  // ─── Alturas de inputs / form controls ──────────────────────────────────────
  /// Equivalente a .form-control-sm  → 31px
  static const double inputSm = 31.0;

  /// Equivalente a .form-control     → 38px
  static const double inputMd = 38.0;

  /// Equivalente a .form-control-lg  → 48px
  static const double inputLg = 48.0;

  // ─── Alturas de botones ─────────────────────────────────────────────────────
  /// Equivalente a .btn-sm  → 31px
  static const double buttonSm = 31.0;

  /// Equivalente a .btn     → 38px
  static const double buttonMd = 38.0;

  /// Equivalente a .btn-lg  → 48px
  static const double buttonLg = 48.0;

  /// Ancho mínimo de cualquier botón
  static const double buttonMinWidth = 80.0;

  // ─── Alturas de navbar / appbar ─────────────────────────────────────────────
  static const double navbarSm  = 48.0;
  static const double navbarMd  = 56.0;
  static const double navbarLg  = 64.0;

  // ─── Anchos de sidebar ───────────────────────────────────────────────────────
  static const double sidebarCollapsed = 64.0;
  static const double sidebarExpanded  = 240.0;

  // ─── Avatares ────────────────────────────────────────────────────────────────
  static const double avatarXs = 24.0;
  static const double avatarSm = 32.0;
  static const double avatarMd = 48.0;
  static const double avatarLg = 64.0;
  static const double avatarXl = 96.0;

  // ─── Badges ──────────────────────────────────────────────────────────────────
  static const double badgeSm = 16.0;
  static const double badgeMd = 20.0;
  static const double badgeLg = 24.0;

  // ─── Iconos en contexto ──────────────────────────────────────────────────────
  /// Icono dentro de un input o badge
  static const double iconInline  = 16.0;

  /// Icono dentro de un botón md
  static const double iconButton  = 18.0;

  /// Icono standalone (nav, card header)
  static const double iconStandalone = 24.0;

  /// Icono decorativo grande (empty state, hero)
  static const double iconHero = 48.0;

  // ─── Cards ───────────────────────────────────────────────────────────────────
  static const double cardMinWidth  = 200.0;
  static const double cardMaxWidth  = 560.0;
  static const double cardImageHeight = 200.0;

  // ─── Modales ─────────────────────────────────────────────────────────────────
  static const double modalSm = 300.0;
  static const double modalMd = 500.0;
  static const double modalLg = 800.0;

  // ─── Dividers ────────────────────────────────────────────────────────────────
  static const double dividerThickness = 1.0;
  static const double dividerThickMd   = 2.0;

  // ─── Touch targets (accesibilidad) ───────────────────────────────────────────
  /// Tamaño mínimo recomendado para elementos interactivos (WCAG / Material)
  static const double touchTarget = 48.0;
}
