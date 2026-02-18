import 'package:design_system_mobile/desigSystem/componets/cp_text.dart';
import 'package:design_system_mobile/desigSystem/tokens/colors.dart';
import 'package:design_system_mobile/desigSystem/tokens/spacings.dart';
import 'package:design_system_mobile/desigSystem/tokens/typography.dart';
import 'package:flutter/material.dart';

class CpBlockquote extends StatelessWidget {
  final String texto;
  final String author;
  final String source;

  const CpBlockquote(
    this.texto, {
    this.author = "Default Author",
    this.source = "Default Source",
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.only(
          bottom: SpacingsDS.s2,
          top: SpacingsDS.s2,
        ),
        child: Row(
          children: [
            Container(color: ColorsDS.secondary, width: 5, height: 50),
            SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(children: [CpText(texto, style: TypographyDS.lead)]),
                Row(
                  children: [
                    CpText("─ $author $source", style: TypographyDS.small),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
