import 'package:design_system_mobile/design_system.dart';

class CpParagraph extends StatelessWidget {
  final List<InlineSpan> text;
  const CpParagraph(this.text, {super.key});

  @override
  Widget build(BuildContext context) {
    return RichText(text: TextSpan(children: text));
  }
}
