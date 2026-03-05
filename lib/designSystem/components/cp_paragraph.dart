import 'package:flutter/material.dart';

class CpParagraph extends StatelessWidget {
  final List<InlineSpan> text;
  const CpParagraph(this.text, {super.key});

  @override
  Widget build(BuildContext context) {
    return RichText(text: TextSpan(children: text));
  }
}
