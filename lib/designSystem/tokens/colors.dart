import 'package:design_system_mobile/design_system.dart';

/// ColorsDS — Paleta de color basada en Bootstrap 5 (modo claro)
class ColorsDS {
  ColorsDS._();

  // ─── Semánticos principales ─────────────────────────────────────────────────
  static const Color primary   = Color(0xFF0D6EFD);
  static const Color secondary = Color(0xFF6C757D);
  static const Color success   = Color(0xFF198754);
  static const Color info      = Color(0xFF0DCAF0);
  static const Color warning   = Color(0xFFFFC107);
  static const Color danger    = Color(0xFFDC3545);
  static const Color light     = Color(0xFFF8F9FA);
  static const Color dark      = Color(0xFF212529);

  static const Color white = Color(0xFFFFFFFF);
  static const Color black = Color(0xFF000000);

  // ─── Escala primary ─────────────────────────────────────────────────────────
  static const Color primary100 = Color(0xFFCFE2FF);
  static const Color primary200 = Color(0xFF9EC5FE);
  static const Color primary300 = Color(0xFF6EA8FE);
  static const Color primary400 = Color(0xFF3D8BFD);
  static const Color primary500 = Color(0xFF0D6EFD);
  static const Color primary600 = Color(0xFF0A58CA);

  // ─── Variantes subtle ───────────────────────────────────────────────────────
  static const Color primarySubtle   = Color(0xFFCFE2FF);
  static const Color secondarySubtle = Color(0xFFE2E3E5);
  static const Color successSubtle   = Color(0xFFD1E7DD);
  static const Color dangerSubtle    = Color(0xFFF8D7DA);
  static const Color warningSubtle   = Color(0xFFFFF3CD);
  static const Color infoSubtle      = Color(0xFFCFF4FC);

  // ─── Variantes emphasis ─────────────────────────────────────────────────────
  static const Color primaryEmphasis   = Color(0xFF084298);
  static const Color secondaryEmphasis = Color(0xFF41464B);
  static const Color successEmphasis   = Color(0xFF0A3622);
  static const Color dangerEmphasis    = Color(0xFF58151C);
  static const Color warningEmphasis   = Color(0xFF664D03);
  static const Color infoEmphasis      = Color(0xFF055160);

  // ─── Escala de grises ───────────────────────────────────────────────────────
  static const Color gray100 = Color(0xFFF8F9FA);
  static const Color gray200 = Color(0xFFE9ECEF);
  static const Color gray300 = Color(0xFFDEE2E6);
  static const Color gray400 = Color(0xFFCED4DA);
  static const Color gray500 = Color(0xFFADB5BD);
  static const Color gray600 = Color(0xFF6C757D);
  static const Color gray700 = Color(0xFF495057);
  static const Color gray800 = Color(0xFF343A40);
  static const Color gray900 = Color(0xFF212529);

  // ─── Surface / Body ─────────────────────────────────────────────────────────
  static const Color bodyBg    = Color(0xFFFFFFFF);
  static const Color bodyColor = Color(0xFF212529);

  // ─── Links ──────────────────────────────────────────────────────────────────
  static const Color link      = Color(0xFF0D6EFD);
  static const Color linkHover = Color(0xFF0A58CA);

  // ─── Utilidades ─────────────────────────────────────────────────────────────

  /// Retorna blanco o negro según la luminance del fondo dado.
  static Color contrastOn(Color background) =>
      background.computeLuminance() > 0.4 ? gray900 : white;

  static Color withOpacity(Color color, double opacity) =>
      color.withValues(alpha: opacity);

  // ─── Helper: color semántico adaptado al tema actual ─────────────────────────
  /// Retorna [light] en modo claro y [dark] en modo oscuro.
  ///
  /// ```dart
  /// color: ColorsDS.adaptive(context,
  ///   light: ColorsDS.white,
  ///   dark: ColorsDS.gray800,
  /// )
  /// ```
  static Color adaptive(
    BuildContext context, {
    required Color light,
    required Color dark,
  }) {
    final brightness = Theme.of(context).brightness;
    return brightness == Brightness.dark ? dark : light;
  }
}

/// DarkColorsDS — Paleta de color para modo oscuro.
/// Referencia: https://getbootstrap.com/docs/5.3/customize/color-modes/
///
/// ```dart
/// // Uso manual
/// final bg = isDark ? DarkColorsDS.surface : ColorsDS.white;
///
/// // Uso con helper
/// final bg = ColorsDS.adaptive(context, light: ColorsDS.white, dark: DarkColorsDS.surface);
/// ```
class DarkColorsDS {
  DarkColorsDS._();

  // ─── Semánticos adaptados ────────────────────────────────────────────────────
  static const Color primary   = Color(0xFF6EA8FE);   // más claro para legibilidad
  static const Color secondary = Color(0xFFA7ADB5);
  static const Color success   = Color(0xFF75B798);
  static const Color info      = Color(0xFF6EDFF6);
  static const Color warning   = Color(0xFFFFDA6A);
  static const Color danger    = Color(0xFFEA868F);
  static const Color light     = Color(0xFFF8F9FA);
  static const Color dark      = Color(0xFF343A40);

  // ─── Superficies ─────────────────────────────────────────────────────────────
  static const Color background = Color(0xFF1A1D20); // --bs-body-bg
  static const Color surface    = Color(0xFF212529); // cards, modales
  static const Color surfaceAlt = Color(0xFF2B3035); // headers de tabla, sidebar
  static const Color border     = Color(0xFF373B3E); // --bs-border-color

  // ─── Texto ───────────────────────────────────────────────────────────────────
  static const Color bodyColor  = Color(0xFFDEE2E6);
  static const Color muted      = Color(0xFFADB5BD);
  static const Color heading    = Color(0xFFE9ECEF);

  // ─── Variantes subtle (fondos de alertas en dark) ────────────────────────────
  static const Color primarySubtle   = Color(0xFF031633);
  static const Color secondarySubtle = Color(0xFF161719);
  static const Color successSubtle   = Color(0xFF051B11);
  static const Color dangerSubtle    = Color(0xFF2C0B0E);
  static const Color warningSubtle   = Color(0xFF332701);
  static const Color infoSubtle      = Color(0xFF032830);

  // ─── Variantes emphasis (texto sobre fondos subtle dark) ──────────────────────
  static const Color primaryEmphasis   = Color(0xFF6EA8FE);
  static const Color secondaryEmphasis = Color(0xFFA7ADB5);
  static const Color successEmphasis   = Color(0xFF75B798);
  static const Color dangerEmphasis    = Color(0xFFEA868F);
  static const Color warningEmphasis   = Color(0xFFFFDA6A);
  static const Color infoEmphasis      = Color(0xFF6EDFF6);
}

/// ThemeColorsDS — Accessor que devuelve el conjunto de colores correcto
/// según el Brightness del contexto actual.
///
/// ```dart
/// final c = ThemeColorsDS.of(context);
/// color: c.surface      // blanco en light, gris oscuro en dark
/// color: c.bodyColor    // negro en light, gris claro en dark
/// ```
class ThemeColorsDS {
  const ThemeColorsDS._({
    required this.surface,
    required this.background,
    required this.bodyColor,
    required this.border,
    required this.muted,
    required this.primary,
    required this.danger,
    required this.success,
    required this.warning,
    required this.info,
    required this.primarySubtle,
    required this.dangerSubtle,
    required this.successSubtle,
  });

  final Color surface;
  final Color background;
  final Color bodyColor;
  final Color border;
  final Color muted;
  final Color primary;
  final Color danger;
  final Color success;
  final Color warning;
  final Color info;
  final Color primarySubtle;
  final Color dangerSubtle;
  final Color successSubtle;

  static ThemeColorsDS of(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return isDark ? _dark : _light;
  }

  static const _light = ThemeColorsDS._(
    surface: ColorsDS.white,
    background: ColorsDS.gray100,
    bodyColor: ColorsDS.bodyColor,
    border: ColorsDS.gray200,
    muted: ColorsDS.gray500,
    primary: ColorsDS.primary,
    danger: ColorsDS.danger,
    success: ColorsDS.success,
    warning: ColorsDS.warning,
    info: ColorsDS.info,
    primarySubtle: ColorsDS.primarySubtle,
    dangerSubtle: ColorsDS.dangerSubtle,
    successSubtle: ColorsDS.successSubtle,
  );

  static const _dark = ThemeColorsDS._(
    surface: DarkColorsDS.surface,
    background: DarkColorsDS.background,
    bodyColor: DarkColorsDS.bodyColor,
    border: DarkColorsDS.border,
    muted: DarkColorsDS.muted,
    primary: DarkColorsDS.primary,
    danger: DarkColorsDS.danger,
    success: DarkColorsDS.success,
    warning: DarkColorsDS.warning,
    info: DarkColorsDS.info,
    primarySubtle: DarkColorsDS.primarySubtle,
    dangerSubtle: DarkColorsDS.dangerSubtle,
    successSubtle: DarkColorsDS.successSubtle,
  );
}
