import 'package:design_system_mobile/design_system.dart';

/// GradientsDS - Tokens para gradientes.
/// Define una colección de gradientes predefinidos para usar en fondos y decoraciones.
class GradientsDS {
  GradientsDS._();

  /// Gradiente estándar de Primary a una versión más clara.
  static const LinearGradient primary = LinearGradient(
    colors: [ColorsDS.primary, ColorsDS.primary300],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  /// Gradiente sutil para fondos de "hero sections" o cards especiales.
  static const LinearGradient subtle = LinearGradient(
    colors: [ColorsDS.white, ColorsDS.gray100],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );
}
