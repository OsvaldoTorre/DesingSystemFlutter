import 'package:design_system_mobile/design_system.dart';

/// ShadowsDS — Tokens de sombras basados en Bootstrap 5 (box-shadow)
class ShadowsDS {
  ShadowsDS._();

  static const List<BoxShadow> none = [];

  /// Sombra sutil — para cards en reposo
  static const List<BoxShadow> sm = [
    BoxShadow(
      color: Color(0x1A000000),
      blurRadius: 4,
      offset: Offset(0, 1),
    ),
  ];

  /// Sombra estándar — elevación media
  static const List<BoxShadow> md = [
    BoxShadow(color: Color(0x26000000), blurRadius: 6,  offset: Offset(0, 2)),
    BoxShadow(color: Color(0x0D000000), blurRadius: 2,  offset: Offset(0, 1)),
  ];

  /// Sombra grande — paneles, modales
  static const List<BoxShadow> lg = [
    BoxShadow(color: Color(0x26000000), blurRadius: 15, offset: Offset(0, 4)),
    BoxShadow(color: Color(0x0D000000), blurRadius: 6,  offset: Offset(0, 2)),
  ];

  /// Sombra extra grande — drawers, popovers
  static const List<BoxShadow> xl = [
    BoxShadow(color: Color(0x26000000), blurRadius: 30, offset: Offset(0, 10)),
    BoxShadow(color: Color(0x0D000000), blurRadius: 10, offset: Offset(0, 4)),
  ];

  /// Sombra de foco al estilo Bootstrap (focus-ring)
  /// Uso: shadows: ShadowsDS.focusRing(ColorsDS.primary)
  static List<BoxShadow> focusRing(Color color) => [
    BoxShadow(color: color.withValues(alpha: 0.25), blurRadius: 0, spreadRadius: 4),
  ];
}
