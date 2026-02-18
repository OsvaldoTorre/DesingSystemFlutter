import 'package:design_system_mobile/desigSystem/tokens/colors.dart';
import 'package:design_system_mobile/desigSystem/tokens/typography.dart';
import 'package:flutter/material.dart';

class CpTextParagraph extends TextSpan {
  final String texthighlight;
  final bool highlightable;
  final Color? textColor;
  final Color backgroundColor;

  CpTextParagraph(
    this.texthighlight, {
    TextStyle style = TypographyDS.body,
    this.textColor,
    this.backgroundColor = ColorsDS.white,
    this.highlightable = false,
  }) : super(
         text: texthighlight,
         style: style.copyWith(
           color: textColor,
           backgroundColor: highlightable ? ColorsDS.warning : backgroundColor,
         ),
       );
}
