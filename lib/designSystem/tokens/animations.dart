import 'package:flutter/widgets.dart';

/// AnimationDS - Tokens para duraciones y curvas de animación.
/// Estandariza el "motion design" de la aplicación.
class AnimationDS {
  AnimationDS._();

  // --- Duraciones ---
  /// 150ms - Para transiciones rápidas y sutiles (ej. hover).
  static const Duration fast = Duration(milliseconds: 150);

  /// 300ms - Duración estándar para la mayoría de animaciones.
  static const Duration base = Duration(milliseconds: 300);

  /// 500ms - Para animaciones más lentas y notorias (ej. paneles).
  static const Duration slow = Duration(milliseconds: 500);

  // --- Curvas de Easing ---
  static const Curve easeInOut = Curves.easeInOut;
  static const Curve easeIn = Curves.easeIn;
  static const Curve easeOut = Curves.easeOut;
}
