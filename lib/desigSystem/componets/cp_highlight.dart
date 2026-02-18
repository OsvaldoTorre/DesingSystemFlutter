import 'package:design_system_mobile/desigSystem/componets/cp_text.dart';
import 'package:design_system_mobile/desigSystem/tokens/colors.dart';
import 'package:design_system_mobile/desigSystem/tokens/typography.dart';
import 'package:flutter/material.dart';

class CpHighlight extends StatelessWidget {
  final String text;
  final Color textColor;
  final Color backgroundColor;
  final TextStyle style;

  const CpHighlight(
    this.text, {
    super.key,
    this.textColor = ColorsDS.dark,
    this.backgroundColor = ColorsDS.warning,
    this.style = TypographyDS.body,
  });

  @override
  Widget build(BuildContext context) {
    return CpText(
      text,
      style: style.copyWith(color: textColor, backgroundColor: backgroundColor),
    );
  }
}
