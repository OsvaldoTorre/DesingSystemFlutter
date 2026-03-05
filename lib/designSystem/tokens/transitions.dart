import 'package:design_system_mobile/design_system.dart';
/// TransitionsDS — Tokens de transiciones específicos por componente.
/// Más granular que AnimationDS — define duración + curva por tipo de interacción.
///
/// Uso:
/// ```dart
/// AnimatedContainer(
///   duration: TransitionsDS.button.duration,
///   curve:    TransitionsDS.button.curve,
/// )
/// ```
class TransitionsDS {
  TransitionsDS._();

  // ─── Transición de botón ─────────────────────────────────────────────────────
  /// Hover/press en botones — rápido y sutil
  static const _Transition button = _Transition(
    duration: Duration(milliseconds: 150),
    curve: Curves.easeInOut,
  );

  // ─── Transición de input ─────────────────────────────────────────────────────
  /// Focus/blur en campos de texto
  static const _Transition input = _Transition(
    duration: Duration(milliseconds: 150),
    curve: Curves.easeInOut,
  );

  // ─── Transición de modal / dialog ────────────────────────────────────────────
  /// Aparición y desaparición de modales
  static const _Transition modal = _Transition(
    duration: Duration(milliseconds: 300),
    curve: Curves.easeOut,
    reverseCurve: Curves.easeIn,
  );

  // ─── Transición de drawer / sidebar ─────────────────────────────────────────
  /// Panel lateral deslizante
  static const _Transition drawer = _Transition(
    duration: Duration(milliseconds: 300),
    curve: Curves.easeInOut,
  );

  // ─── Transición de toast / snackbar ─────────────────────────────────────────
  static const _Transition toast = _Transition(
    duration: Duration(milliseconds: 250),
    curve: Curves.easeOut,
    reverseCurve: Curves.easeIn,
  );

  // ─── Transición de accordion / collapse ─────────────────────────────────────
  static const _Transition collapse = _Transition(
    duration: Duration(milliseconds: 350),
    curve: Curves.easeInOut,
  );

  // ─── Transición de tabs ──────────────────────────────────────────────────────
  static const _Transition tab = _Transition(
    duration: Duration(milliseconds: 200),
    curve: Curves.easeInOut,
  );

  // ─── Transición de tooltip ───────────────────────────────────────────────────
  static const _Transition tooltip = _Transition(
    duration: Duration(milliseconds: 150),
    curve: Curves.easeOut,
  );

  // ─── Transición de fade genérico ─────────────────────────────────────────────
  static const _Transition fade = _Transition(
    duration: Duration(milliseconds: 200),
    curve: Curves.easeInOut,
  );

  // ─── Transición de página ────────────────────────────────────────────────────
  static const _Transition page = _Transition(
    duration: Duration(milliseconds: 400),
    curve: Curves.easeInOut,
  );
}

/// Modelo inmutable que agrupa duration + curve + reverseCurve.
class _Transition {
  const _Transition({
    required this.duration,
    required this.curve,
    this.reverseCurve,
  });

  final Duration duration;
  final Curve curve;

  /// Curva al revertir la animación (salida). Si es null usa [curve].
  final Curve? reverseCurve;
}
