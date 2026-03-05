import 'package:design_system_mobile/design_system.dart';

/// Tamaños semánticos de icono
enum IconSizeDS { sm, md, lg, xl, hero }

/// CpIcon — Wrapper semántico sobre Icon de Flutter.
/// Garantiza tamaños y colores consistentes usando tokens del Design System.
///
/// ```dart
/// CpIcon(Icons.home)
/// CpIcon(Icons.star, size: IconSizeDS.lg, color: ColorsDS.warning)
/// CpIcon(Icons.add_circle, size: IconSizeDS.hero, color: ColorsDS.primary)
/// ```
class CpIcon extends StatelessWidget {
  const CpIcon(
    this.icon, {
    super.key,
    this.size = IconSizeDS.md,
    this.color,
    this.semanticLabel,
  });

  final IconData icon;
  final IconSizeDS size;
  final Color? color;
  final String? semanticLabel;

  double get _size => switch (size) {
    IconSizeDS.sm   => IconSizesDS.sm,
    IconSizeDS.md   => IconSizesDS.md,
    IconSizeDS.lg   => IconSizesDS.lg,
    IconSizeDS.xl   => IconSizesDS.xl,
    IconSizeDS.hero => SizesDS.iconHero,
  };

  @override
  Widget build(BuildContext context) {
    return Icon(
      icon,
      size: _size,
      color: color ?? ColorsDS.gray700,
      semanticLabel: semanticLabel,
    );
  }
}
