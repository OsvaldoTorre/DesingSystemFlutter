import 'package:flutter/painting.dart';
import 'colors.dart';

/// RadiusDS — Tokens de border-radius basados en Bootstrap 5
class RadiusDS {
  RadiusDS._();

  static const double none   = 0;
  static const double sm     = 4;    // .25rem
  static const double md     = 8;    // .375rem  ← default Bootstrap
  static const double lg     = 12;   // .5rem
  static const double xl     = 16;   // 1rem
  static const double pill   = 50;   // border-radius: 50rem
  static const double circle = 999;  // círculo completo

  static BorderRadius borderNone   = BorderRadius.zero;
  static BorderRadius borderSm     = BorderRadius.circular(sm);
  static BorderRadius borderMd     = BorderRadius.circular(md);
  static BorderRadius borderLg     = BorderRadius.circular(lg);
  static BorderRadius borderXl     = BorderRadius.circular(xl);
  static BorderRadius borderPill   = BorderRadius.circular(pill);
  static BorderRadius borderCircle = BorderRadius.circular(circle);
}

/// ShadowsDS — Tokens de sombras basados en Bootstrap 5 (box-shadow)
class ShadowsDS {
  ShadowsDS._();

  static const List<BoxShadow> none = [];

  static const List<BoxShadow> sm = [
    BoxShadow(
      color: Color(0x1A000000),
      blurRadius: 4,
      offset: Offset(0, 1),
    ),
  ];

  static const List<BoxShadow> md = [
    BoxShadow(color: Color(0x26000000), blurRadius: 6, offset: Offset(0, 2)),
    BoxShadow(color: Color(0x0D000000), blurRadius: 2, offset: Offset(0, 1)),
  ];

  static const List<BoxShadow> lg = [
    BoxShadow(color: Color(0x26000000), blurRadius: 15, offset: Offset(0, 4)),
    BoxShadow(color: Color(0x0D000000), blurRadius: 6,  offset: Offset(0, 2)),
  ];

  static const List<BoxShadow> xl = [
    BoxShadow(color: Color(0x26000000), blurRadius: 30, offset: Offset(0, 10)),
    BoxShadow(color: Color(0x0D000000), blurRadius: 10, offset: Offset(0, 4)),
  ];

  /// Sombra de foco al estilo Bootstrap (focus-ring)
  static List<BoxShadow> focusRing(Color color) => [
    BoxShadow(color: color.withValues(alpha: 0.25), blurRadius: 0, spreadRadius: 4),
  ];
}

/// BorderDS — Tokens de borde (ancho y color)
class BorderDS {
  BorderDS._();

  static const double widthThin  = 1;
  static const double widthMd    = 2;
  static const double widthThick = 4;

  static const Color colorDefault = ColorsDS.gray300;
  static const Color colorLight   = ColorsDS.gray200;
  static const Color colorDark    = ColorsDS.gray700;

  static Border all({
    Color color = colorDefault,
    double width = widthThin,
  }) => Border.all(color: color, width: width);

  /// BoxDecoration conveniente con borde + radio + sombra
  static BoxDecoration box({
    Color color = colorDefault,
    double width = widthThin,
    double radius = RadiusDS.md,
    List<BoxShadow> shadows = const [],
    Color? fillColor,
  }) => BoxDecoration(
    color: fillColor,
    border: Border.all(color: color, width: width),
    borderRadius: BorderRadius.circular(radius),
    boxShadow: shadows,
  );
}
