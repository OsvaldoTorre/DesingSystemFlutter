import 'package:design_system_mobile/design_system.dart';

/// CpDivider — Línea separadora horizontal o vertical.
///
/// ```dart
/// CpDivider()                                          // horizontal
/// CpDivider.vertical(height: 24)                      // vertical
/// CpDivider(label: 'o continúa con')                  // con texto central
/// CpDivider(color: ColorsDS.primary, thickness: 2)    // personalizado
/// ```
class CpDivider extends StatelessWidget {
  const CpDivider({
    super.key,
    this.color,
    this.thickness,
    this.label,
    this.indent = 0,
    this.endIndent = 0,
  }) : _vertical = false, _height = null;

  const CpDivider.vertical({
    super.key,
    this.color,
    this.thickness,
    double? height,
  })  : _vertical = true,
        _height = height,
        label = null,
        indent = 0,
        endIndent = 0;

  final Color? color;
  final double? thickness;
  final String? label;
  final double indent;
  final double endIndent;
  final bool _vertical;
  final double? _height;

  Color get _color => color ?? ColorsDS.gray200;
  double get _thickness => thickness ?? SizesDS.dividerThickness;

  @override
  Widget build(BuildContext context) {
    if (_vertical) {
      return SizedBox(
        height: _height ?? SpacingsDS.xl,
        child: VerticalDivider(
          color: _color,
          thickness: _thickness,
          width: _thickness + SpacingsDS.sm,
        ),
      );
    }

    if (label != null) {
      return Row(
        children: [
          Expanded(child: Divider(color: _color, thickness: _thickness, endIndent: SpacingsDS.sm)),
          Text(label!, style: TypographyDS.caption),
          Expanded(child: Divider(color: _color, thickness: _thickness, indent: SpacingsDS.sm)),
        ],
      );
    }

    return Divider(
      color: _color,
      thickness: _thickness,
      indent: indent,
      endIndent: endIndent,
    );
  }
}
