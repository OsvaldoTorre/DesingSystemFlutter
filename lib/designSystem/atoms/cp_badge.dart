import 'package:design_system_mobile/design_system.dart';

/// Variante semántica compartida — equivalente a las clases bg-* / alert-*
enum VariantDS {
  primary, secondary, success, danger, warning, info, light, dark
}

/// Tamaños de badge
enum BadgeSizeDS { sm, md, lg }

/// CpBadge — Equivalente a <span class="badge bg-*"> de Bootstrap
///
/// ```dart
/// CpBadge(label: 'Nuevo')
/// CpBadge(label: '3', variant: VariantDS.danger, pill: true)
/// CpBadge(label: 'Beta', variant: VariantDS.warning, size: BadgeSizeDS.lg)
/// ```
class CpBadge extends StatelessWidget {
  const CpBadge({
    super.key,
    required this.label,
    this.variant = VariantDS.primary,
    this.pill = false,
    this.size = BadgeSizeDS.md,
  });

  final String label;
  final VariantDS variant;
  final bool pill;
  final BadgeSizeDS size;

  Color get _bg => switch (variant) {
    VariantDS.primary   => ColorsDS.primary,
    VariantDS.secondary => ColorsDS.secondary,
    VariantDS.success   => ColorsDS.success,
    VariantDS.danger    => ColorsDS.danger,
    VariantDS.warning   => ColorsDS.warning,
    VariantDS.info      => ColorsDS.info,
    VariantDS.light     => ColorsDS.light,
    VariantDS.dark      => ColorsDS.dark,
  };

  Color get _fg => ColorsDS.contrastOn(_bg);

  double get _height => switch (size) {
    BadgeSizeDS.sm => SizesDS.badgeSm,
    BadgeSizeDS.md => SizesDS.badgeMd,
    BadgeSizeDS.lg => SizesDS.badgeLg,
  };

  double get _fontSize => switch (size) {
    BadgeSizeDS.sm => 9,
    BadgeSizeDS.md => 11,
    BadgeSizeDS.lg => 13,
  };

  @override
  Widget build(BuildContext context) {
    return Container(
      height: _height,
      padding: const EdgeInsets.symmetric(horizontal: 8),
      decoration: BoxDecoration(
        color: _bg,
        borderRadius: BorderRadius.circular(pill ? RadiusDS.pill : RadiusDS.sm),
      ),
      alignment: Alignment.center,
      child: Text(
        label,
        style: TextStyle(
          fontSize: _fontSize,
          fontWeight: TypographyDS.weightBold,
          color: _fg,
          height: 1.2,
          letterSpacing: 0.5,
        ),
      ),
    );
  }
}
