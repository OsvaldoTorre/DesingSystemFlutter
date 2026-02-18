import 'package:design_system_mobile/desigSystem/tokens/colors.dart';
import 'package:design_system_mobile/desigSystem/tokens/typography.dart';
import 'package:flutter/material.dart';

class CpText extends StatelessWidget {
  final String texto;
  // Parametros opcionales
  final Color color;
  final TextStyle style;
  final FontWeight textBold;
  final FontStyle textItalic;
  final TextDecoration typeLine;
  final Color lineColor;
  final double lineSize;
  final EdgeInsetsGeometry padding;

  const CpText(
    this.texto, { // Parametros opcionales
    this.color = ColorsDS.dark,
    this.style = TypographyDS.body,
    this.padding = const EdgeInsetsGeometry.all(0),
    this.typeLine = TextDecoration.none,
    this.lineColor = ColorsDS.dark,
    this.lineSize = 1,
    this.textBold = FontWeight.normal,
    this.textItalic = FontStyle.normal,

    super.key,
  });

  @override
  Widget build(BuildContext context) {
    Color colorLocal = color;
    if (colorLocal == ColorsDS.dark) {
      colorLocal = style.color!;
    }
    return Padding(
      padding: padding,
      child: Text(
        texto,
        style: style.copyWith(
          color: colorLocal,
          fontWeight: textBold,
          fontStyle: textItalic,
          decoration: typeLine,
          decorationColor: lineColor,
          decorationThickness: lineSize,
        ),
      ),
    );
  }
}
