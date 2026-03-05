import 'package:design_system_mobile/design_system.dart';

/// CpText — Atom base de texto con soporte para estilos del Design System.
///
/// ```dart
/// CpText('Hola mundo')
/// CpText('Título', style: TypographyDS.h1)
/// CpText('Error', color: ColorsDS.danger, textBold: FontWeight.bold)
/// CpText('Subrayado', typeLine: TextDecoration.underline)
/// ```
class CpText extends StatelessWidget {
  const CpText(
    this.texto, {
    this.color = ColorsDS.dark,
    this.style = TypographyDS.body,
    this.padding = EdgeInsets.zero,
    this.typeLine = TextDecoration.none,
    this.lineColor = ColorsDS.dark,
    this.lineSize = 1,
    this.textBold = FontWeight.normal,
    this.textItalic = FontStyle.normal,
    this.maxLines,
    this.overflow,
    this.textAlign,
    super.key,
  });

  final String texto;
  final Color color;
  final TextStyle style;
  final EdgeInsetsGeometry padding;
  final TextDecoration typeLine;
  final Color lineColor;
  final double lineSize;
  final FontWeight textBold;
  final FontStyle textItalic;
  final int? maxLines;
  final TextOverflow? overflow;
  final TextAlign? textAlign;

  @override
  Widget build(BuildContext context) {
    // Si el color no fue cambiado del default, usa el del estilo
    final resolvedColor =
        color == ColorsDS.dark ? (style.color ?? ColorsDS.dark) : color;

    return Padding(
      padding: padding,
      child: Text(
        texto,
        maxLines: maxLines,
        overflow: overflow,
        textAlign: textAlign,
        style: style.copyWith(
          color: resolvedColor,
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
