import 'package:design_system_mobile/design_system.dart';

class CpTextParagraphHighlight extends TextSpan {
  final String texthighlight;
  final bool highlightable;
  final Color? textColor;
  final Color backgroundColor;
  final FontWeight textBold;
  final FontStyle textItalic;
  final TextDecoration typeLine;
  final Color lineColor;
  final double lineSize;

  CpTextParagraphHighlight(
    this.texthighlight, {
    TextStyle? style,
    this.highlightable = false,
    this.textColor,
    this.backgroundColor = ColorsDS.white,
    this.textBold = FontWeight.normal,
    this.textItalic = FontStyle.normal,
    this.typeLine = TextDecoration.none,
    this.lineColor = ColorsDS.dark,
    this.lineSize = 1,
  }) : super(
         text: texthighlight,
         style: (style ?? TypographyDS.body).copyWith(
           color: textColor,
           backgroundColor: highlightable ? ColorsDS.warning : backgroundColor,
           fontWeight: textBold,
           fontStyle: textItalic,
           decoration: typeLine,
           decorationColor: lineColor != ColorsDS.dark
               ? lineColor
               : ColorsDS.dark,
           decorationThickness: lineSize,
         ),
       );
}
