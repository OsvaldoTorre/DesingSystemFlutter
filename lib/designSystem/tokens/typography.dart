import 'package:design_system_mobile/design_system.dart';

/// TypographyDS — Escala tipográfica basada en Bootstrap 5
/// Preserva todos los estilos existentes y añade utilidades adicionales.
class TypographyDS {
  TypographyDS._();

  // ─── Font sizes ─────────────────────────────────────────────────────────────
  static const double fontSizeXs = 10;
  static const double fontSizeSm = 12;
  static const double fontSizeBase = 16; // 1rem
  static const double fontSizeLg = 20;
  static const double fontSizeXl = 24;

  // ─── Font weights ───────────────────────────────────────────────────────────
  static const FontWeight weightLight = FontWeight.w300;
  static const FontWeight weightNormal = FontWeight.w400;
  static const FontWeight weightMedium = FontWeight.w500;
  static const FontWeight weightSemi = FontWeight.w600;
  static const FontWeight weightBold = FontWeight.w700;

  // ─── Line heights ───────────────────────────────────────────────────────────
  static const double lineHeightSm = 1.25;
  static const double lineHeightBase = 1.5;
  static const double lineHeightLg = 2.0;

  // ─── Letter spacing ─────────────────────────────────────────────────────────
  static const double trackingTight = -0.5;
  static const double trackingNormal = 0.0;
  static const double trackingWide = 0.5;

  // ─── Headings ───────────────────────────────────────────────────────────────
  static const TextStyle h1 = TextStyle(
    fontSize: 40,
    fontWeight: FontWeight.w500,
    color: ColorsDS.dark,
    height: lineHeightSm,
  );
  static const TextStyle h2 = TextStyle(
    fontSize: 32,
    fontWeight: FontWeight.w500,
    color: ColorsDS.dark,
    height: lineHeightSm,
  );
  static const TextStyle h3 = TextStyle(
    fontSize: 28,
    fontWeight: FontWeight.w500,
    color: ColorsDS.dark,
    height: lineHeightSm,
  );
  static const TextStyle h4 = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.w500,
    color: ColorsDS.dark,
    height: lineHeightSm,
  );
  static const TextStyle h5 = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w500,
    color: ColorsDS.dark,
    height: lineHeightSm,
  );
  static const TextStyle h6 = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w500,
    color: ColorsDS.dark,
    height: lineHeightSm,
  );

  // ─── Body ───────────────────────────────────────────────────────────────────
  static const TextStyle lead = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w300,
    color: ColorsDS.dark,
    height: lineHeightBase,
  );
  static const TextStyle body = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.normal,
    color: ColorsDS.dark,
    height: lineHeightBase,
  );
  static const TextStyle small = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.normal,
    color: ColorsDS.secondary,
    height: lineHeightBase,
  );

  // ─── Utilidades adicionales ─────────────────────────────────────────────────
  static const TextStyle label = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w500,
    color: ColorsDS.dark,
    height: lineHeightBase,
    letterSpacing: trackingWide,
  );
  static const TextStyle caption = TextStyle(
    fontSize: 10,
    fontWeight: FontWeight.normal,
    color: ColorsDS.gray600,
    height: lineHeightBase,
  );
  static const TextStyle mono = TextStyle(
    fontFamily: 'RobotoMono',
    fontSize: 14,
    fontWeight: FontWeight.normal,
    color: ColorsDS.dark,
    height: lineHeightBase,
  );
  static const TextStyle displayLg = TextStyle(
    fontSize: 72,
    fontWeight: FontWeight.w700,
    color: ColorsDS.dark,
    height: lineHeightSm,
    letterSpacing: trackingTight,
  );
  static const TextStyle displayMd = TextStyle(
    fontSize: 58,
    fontWeight: FontWeight.w700,
    color: ColorsDS.dark,
    height: lineHeightSm,
  );
  static const TextStyle displaySm = TextStyle(
    fontSize: 46,
    fontWeight: FontWeight.w700,
    color: ColorsDS.dark,
    height: lineHeightSm,
  );

  // ─── Helper: heading por nivel numérico ─────────────────────────────────────
  /// Retorna el TextStyle del heading según nivel (1–6)
  static TextStyle heading(int level) {
    assert(level >= 1 && level <= 6, 'level debe ser entre 1 y 6');
    return [h1, h2, h3, h4, h5, h6][level - 1];
  }
}
