import 'package:design_system_mobile/design_system.dart';

/// TypographyDS — Escala tipográfica basada en Bootstrap 5
///
/// Soporta `fontFamily` personalizable via [TypographyDS.configure()].
/// Si no se configura, usa la fuente del sistema.
///
/// ```dart
/// // En main(), antes de runApp():
/// TypographyDS.configure(fontFamily: 'Inter');
/// ```
class TypographyDS {
  TypographyDS._();

  // ─── Font family configurable ───────────────────────────────────────────────
  static String? _fontFamily;

  /// Configura la fuente global del Design System.
  /// Llamar en main() antes de runApp().
  static void configure({String? fontFamily}) {
    _fontFamily = fontFamily;
  }

  static String? get fontFamily => _fontFamily;

  // ─── Font sizes ─────────────────────────────────────────────────────────────
  static const double fontSizeXs   = 10;
  static const double fontSizeSm   = 12;
  static const double fontSizeBase = 16;
  static const double fontSizeLg   = 20;
  static const double fontSizeXl   = 24;

  // ─── Font weights ───────────────────────────────────────────────────────────
  static const FontWeight weightLight  = FontWeight.w300;
  static const FontWeight weightNormal = FontWeight.w400;
  static const FontWeight weightMedium = FontWeight.w500;
  static const FontWeight weightSemi   = FontWeight.w600;
  static const FontWeight weightBold   = FontWeight.w700;

  // ─── Line heights ───────────────────────────────────────────────────────────
  static const double lineHeightSm   = 1.25;
  static const double lineHeightBase = 1.5;
  static const double lineHeightLg   = 2.0;

  // ─── Letter spacing ─────────────────────────────────────────────────────────
  static const double trackingTight  = -0.5;
  static const double trackingNormal = 0.0;
  static const double trackingWide   = 0.5;

  // ─── Helper interno ──────────────────────────────────────────────────────────
  static TextStyle _base({
    required double fontSize,
    required FontWeight fontWeight,
    required Color color,
    required double height,
    double letterSpacing = 0,
  }) => TextStyle(
    fontFamily: _fontFamily,
    fontSize: fontSize,
    fontWeight: fontWeight,
    color: color,
    height: height,
    letterSpacing: letterSpacing,
  );

  // ─── Headings ───────────────────────────────────────────────────────────────
  static TextStyle get h1 => _base(fontSize: 40, fontWeight: FontWeight.w500, color: ColorsDS.dark, height: lineHeightSm);
  static TextStyle get h2 => _base(fontSize: 32, fontWeight: FontWeight.w500, color: ColorsDS.dark, height: lineHeightSm);
  static TextStyle get h3 => _base(fontSize: 28, fontWeight: FontWeight.w500, color: ColorsDS.dark, height: lineHeightSm);
  static TextStyle get h4 => _base(fontSize: 24, fontWeight: FontWeight.w500, color: ColorsDS.dark, height: lineHeightSm);
  static TextStyle get h5 => _base(fontSize: 20, fontWeight: FontWeight.w500, color: ColorsDS.dark, height: lineHeightSm);
  static TextStyle get h6 => _base(fontSize: 16, fontWeight: FontWeight.w500, color: ColorsDS.dark, height: lineHeightSm);

  // ─── Body ───────────────────────────────────────────────────────────────────
  static TextStyle get lead  => _base(fontSize: 20, fontWeight: FontWeight.w300, color: ColorsDS.dark,      height: lineHeightBase);
  static TextStyle get body  => _base(fontSize: 16, fontWeight: FontWeight.normal, color: ColorsDS.dark,    height: lineHeightBase);
  static TextStyle get small => _base(fontSize: 14, fontWeight: FontWeight.normal, color: ColorsDS.secondary, height: lineHeightBase);

  // ─── Utilidades ─────────────────────────────────────────────────────────────
  static TextStyle get label   => _base(fontSize: 12, fontWeight: FontWeight.w500, color: ColorsDS.dark,    height: lineHeightBase, letterSpacing: trackingWide);
  static TextStyle get caption => _base(fontSize: 10, fontWeight: FontWeight.normal, color: ColorsDS.gray600, height: lineHeightBase);
  static TextStyle get mono    => TextStyle(fontFamily: 'RobotoMono', fontSize: 14, fontWeight: FontWeight.normal, color: ColorsDS.dark, height: lineHeightBase);

  // ─── Display ────────────────────────────────────────────────────────────────
  static TextStyle get displayLg => _base(fontSize: 72, fontWeight: FontWeight.w700, color: ColorsDS.dark, height: lineHeightSm, letterSpacing: trackingTight);
  static TextStyle get displayMd => _base(fontSize: 58, fontWeight: FontWeight.w700, color: ColorsDS.dark, height: lineHeightSm);
  static TextStyle get displaySm => _base(fontSize: 46, fontWeight: FontWeight.w700, color: ColorsDS.dark, height: lineHeightSm);

  // ─── Helper: heading por nivel ───────────────────────────────────────────────
  static TextStyle heading(int level) {
    assert(level >= 1 && level <= 6, 'level debe ser entre 1 y 6');
    return [h1, h2, h3, h4, h5, h6][level - 1];
  }

  // ─── Helper: aplicar fontFamily a cualquier TextStyle externo ────────────────
  /// Aplica el fontFamily configurado a cualquier TextStyle existente.
  ///
  /// ```dart
  /// TypographyDS.apply(Theme.of(context).textTheme.bodyLarge!)
  /// ```
  static TextStyle apply(TextStyle style) {
    if (_fontFamily == null) return style;
    return style.copyWith(fontFamily: _fontFamily);
  }
}
