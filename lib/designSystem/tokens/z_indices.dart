/// ZIndicesDS - Tokens para gestionar la profundidad y el apilamiento (stacking context).
/// Evita conflictos de superposición entre componentes flotantes.
class ZIndicesDS {
  ZIndicesDS._();

  /// Para elementos fijos o "pegajosos" (ej. AppBars).
  static const int sticky = 100;

  /// Para menús desplegables, autocompletados, etc.
  static const int dropdown = 1000;

  /// Fondo semitransparente para modales y off-canvas.
  static const int modalBackdrop = 1040;

  /// Para el contenido de modales y off-canvas.
  static const int modal = 1050;

  /// Para popovers.
  static const int popover = 1060;

  /// Para tooltips, que deben estar por encima de todo.
  static const int tooltip = 1070;
}
