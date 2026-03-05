import 'package:design_system_mobile/design_system.dart';

/// StatesDS — Tokens de estados interactivos del Design System.
/// Define los colores de overlay para hover, focus, active y disabled.
///
/// En Flutter los estados se aplican como capas de color sobre el widget base.
/// Uso típico con InkWell o MaterialState:
///
/// ```dart
/// // Hover manual
/// color: isHovered ? StatesDS.hoverOverlay(ColorsDS.primary) : Colors.transparent
///
/// // Con MaterialStateProperty
/// overlayColor: MaterialStateProperty.resolveWith((states) {
///   if (states.contains(MaterialState.hovered))  return StatesDS.hoverOverlay(color);
///   if (states.contains(MaterialState.pressed))  return StatesDS.pressOverlay(color);
///   if (states.contains(MaterialState.focused))  return StatesDS.focusOverlay(color);
///   return null;
/// })
/// ```
class StatesDS {
  StatesDS._();

  // ─── Opacidades de overlay ───────────────────────────────────────────────────
  static const double _hoverAlpha   = 0.08;
  static const double _pressAlpha   = 0.16;
  static const double _focusAlpha   = 0.12;
  static const double _selectAlpha  = 0.12;

  // ─── Overlays dinámicos (sobre cualquier color base) ────────────────────────

  /// Overlay semitransparente para estado hover
  static Color hoverOverlay(Color base) =>
      base.withValues(alpha: _hoverAlpha);

  /// Overlay semitransparente para estado pressed / active
  static Color pressOverlay(Color base) =>
      base.withValues(alpha: _pressAlpha);

  /// Overlay semitransparente para estado focused
  static Color focusOverlay(Color base) =>
      base.withValues(alpha: _focusAlpha);

  /// Overlay semitransparente para estado selected
  static Color selectOverlay(Color base) =>
      base.withValues(alpha: _selectAlpha);

  // ─── Colores de estado fijos (sobre fondo blanco) ────────────────────────────

  /// Hover sobre fondo blanco con color primary
  static Color get primaryHover  => ColorsDS.primary.withValues(alpha: _hoverAlpha);

  /// Press sobre fondo blanco con color primary
  static Color get primaryPress  => ColorsDS.primary.withValues(alpha: _pressAlpha);

  /// Focus sobre fondo blanco con color primary
  static Color get primaryFocus  => ColorsDS.primary.withValues(alpha: _focusAlpha);

  // ─── Estado disabled ─────────────────────────────────────────────────────────

  /// Opacidad estándar para widgets deshabilitados
  static const double disabledOpacity = OpacityDS.disabled;

  /// Color de fondo para elementos deshabilitados
  static const Color disabledBg   = ColorsDS.gray200;

  /// Color de texto/icono para elementos deshabilitados
  static const Color disabledFg   = ColorsDS.gray500;

  /// Color de borde para elementos deshabilitados
  static const Color disabledBorder = ColorsDS.gray300;

  // ─── Estado error ────────────────────────────────────────────────────────────
  static const Color errorBg     = ColorsDS.dangerSubtle;
  static const Color errorFg     = ColorsDS.dangerEmphasis;
  static const Color errorBorder = ColorsDS.danger;

  // ─── Estado success ──────────────────────────────────────────────────────────
  static const Color successBg     = ColorsDS.successSubtle;
  static const Color successFg     = ColorsDS.successEmphasis;
  static const Color successBorder = ColorsDS.success;

  // ─── Estado warning ──────────────────────────────────────────────────────────
  static const Color warningBg     = ColorsDS.warningSubtle;
  static const Color warningFg     = ColorsDS.warningEmphasis;
  static const Color warningBorder = ColorsDS.warning;

  // ─── MaterialStateProperty helper ───────────────────────────────────────────

  /// Genera un MaterialStateProperty<Color?> con hover, press y focus
  /// automáticos a partir de un color base.
  ///
  /// ```dart
  /// overlayColor: StatesDS.overlayFor(ColorsDS.primary)
  /// ```
  static MaterialStateProperty<Color?> overlayFor(Color base) {
    return MaterialStateProperty.resolveWith((states) {
      if (states.contains(MaterialState.pressed)) return pressOverlay(base);
      if (states.contains(MaterialState.hovered)) return hoverOverlay(base);
      if (states.contains(MaterialState.focused))  return focusOverlay(base);
      return null;
    });
  }
}
