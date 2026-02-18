import 'package:design_system_mobile/desigSystem/componets/cp_blockquote.dart';
import 'package:design_system_mobile/desigSystem/componets/cp_text-paragraph_highlight.dart';
import 'package:design_system_mobile/desigSystem/componets/cp_paragraph.dart';
import 'package:design_system_mobile/desigSystem/componets/cp_text.dart';
import 'package:design_system_mobile/desigSystem/tokens/typography.dart';
import 'package:flutter/material.dart';

class TypographyGallery extends StatelessWidget {
  const TypographyGallery({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CpText(
            "Typography",
            style: TypographyDS.h1,
            padding: EdgeInsetsGeometry.only(top: 20, bottom: 20),
          ),

          CpText("H1", style: TypographyDS.h1),
          CpText("H2", style: TypographyDS.h2),
          CpText("H3", style: TypographyDS.h3),
          CpText("H4", style: TypographyDS.h4),
          CpText("H5", style: TypographyDS.h5),
          CpText("H6", style: TypographyDS.h6),
          SizedBox(height: 20),
          CpText("Parrafo normal", style: TypographyDS.h2),
          CpText(
            "Nisi elit reprehenderit sit cupidatat. Ad officia aliqua consectetur non Lorem duis ipsum excepteur dolor voluptate non labore sint ut sit nostrud tempor.",
            style: TypographyDS.body,
            padding: EdgeInsetsGeometry.only(bottom: 20),
          ),
          CpText("Parrafo introductivo", style: TypographyDS.h2),
          CpText(
            "Ex sit dolor in irure quis pariatur ipsum ea laborum Alunt pariatur Lorem duis Lorem laborum. Est cupidatat do ut labore dolore consectetur.",
            style: TypographyDS.lead,
            padding: EdgeInsetsGeometry.only(bottom: 20),
          ),
          CpText("Parrafo pequeño", style: TypographyDS.h2),
          CpText(
            "Consequat magna cupidatat laborum dolor irure pariatur tempor eiusmod reprehenderit cupidatat elit cillum adipisicing.",
            style: TypographyDS.small,
            padding: EdgeInsetsGeometry.only(bottom: 20),
          ),
          SizedBox(height: 20),
          // Highlight
          CpParagraph([
            CpTextParagraph(
              "Hola mundo, el dia de hoy voy hacer un texto para destacar",
            ),
            CpTextParagraph("Ganador", style: TypographyDS.h1),
          ]),
          SizedBox(height: 20),
          CpText(
            "Amet aliquip cillum laboris consectetur consequat.",
            typeLine: TextDecoration.overline,
            padding: EdgeInsetsGeometry.only(bottom: 5),
          ),
          CpText(
            "Amet aliquip cillum laboris consectetur consequat.",
            typeLine: TextDecoration.lineThrough,
            padding: EdgeInsetsGeometry.only(bottom: 5),
          ),
          CpText(
            "Amet aliquip cillum laboris consectetur consequat.",
            typeLine: TextDecoration.underline,
            padding: EdgeInsetsGeometry.only(bottom: 5),
          ),

          CpText(
            "Small: Amet aliquip cillum laboris consectetur consequat.",
            style: TypographyDS.small,
            padding: EdgeInsetsGeometry.only(bottom: 5),
          ),
          CpText(
            "Bold: Amet aliquip cillum laboris consectetur consequat.",
            textBold: FontWeight.bold,
            padding: EdgeInsetsGeometry.only(bottom: 5),
          ),
          CpText(
            "Italic: Amet aliquip cillum laboris consectetur consequat.",
            textItalic: FontStyle.italic,
            padding: EdgeInsetsGeometry.only(bottom: 5),
          ),
          SizedBox(height: 20),
          CpBlockquote("Irure incididunt nostrud officia eu Lorem."),
          SizedBox(height: 20),
        ],
      ),
    );
  }
}
