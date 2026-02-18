import 'package:flutter/material.dart';
import 'colors.dart';

class TypographyDS {
  TypographyDS._();
  // Encabezados
  static const TextStyle h1 = TextStyle(
    fontSize: 40,
    fontWeight: FontWeight.w500,
    color: ColorsDS.dark,
    height: 1.2,
  );
  static const TextStyle h2 = TextStyle(
    fontSize: 32,
    fontWeight: FontWeight.w500,
    color: ColorsDS.dark,
    height: 1.2,
  );
  static const TextStyle h3 = TextStyle(
    fontSize: 28,
    fontWeight: FontWeight.w500,
    color: ColorsDS.dark,
    height: 1.2,
  );
  static const TextStyle h4 = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.w500,
    color: ColorsDS.dark,
    height: 1.2,
  );
  static const TextStyle h5 = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w500,
    color: ColorsDS.dark,
    height: 1.2,
  );
  static const TextStyle h6 = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w500,
    color: ColorsDS.dark,
    height: 1.2,
  );

  // Cuerpo de texto
  static const TextStyle lead = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w300,
    color: ColorsDS.dark,
  );
  static const TextStyle body = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.normal,
    color: ColorsDS.dark,
  );
  static const TextStyle small = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.normal,
    color: ColorsDS.secondary,
  );
}
