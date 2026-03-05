import 'package:design_system_mobile/design_system.dart';

/// CpProgressBar — Barra de progreso horizontal animada.
///
/// ```dart
/// CpProgressBar(value: 0.65)
/// CpProgressBar(value: 0.4, label: 'Cargando...', showPercent: true)
/// CpProgressBar(value: 0.8, color: ColorsDS.success, height: 8)
/// CpProgressBar(variant: VariantDS.danger, value: 0.3)
/// ```
class CpProgressBar extends StatelessWidget {
  const CpProgressBar({
    super.key,
    required this.value,
    this.label,
    this.showPercent = false,
    this.height = 6,
    this.color,
    this.trackColor,
    this.variant,
    this.animated = true,
  }) : assert(value >= 0 && value <= 1, 'value debe estar entre 0.0 y 1.0');

  /// Valor entre 0.0 y 1.0
  final double value;
  final String? label;
  final bool showPercent;
  final double height;
  final Color? color;
  final Color? trackColor;
  final VariantDS? variant;
  final bool animated;

  Color get _barColor {
    if (color != null) return color!;
    return switch (variant) {
      VariantDS.success   => ColorsDS.success,
      VariantDS.danger    => ColorsDS.danger,
      VariantDS.warning   => ColorsDS.warning,
      VariantDS.info      => ColorsDS.info,
      VariantDS.secondary => ColorsDS.secondary,
      _                   => ColorsDS.primary,
    };
  }

  @override
  Widget build(BuildContext context) {
    final percent = '${(value * 100).toInt()}%';

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (label != null || showPercent) ...[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              if (label != null)
                Text(label!, style: TypographyDS.label),
              if (showPercent)
                Text(percent, style: TypographyDS.caption),
            ],
          ),
          const SizedBox(height: SpacingsDS.xs),
        ],
        ClipRRect(
          borderRadius: RadiusDS.borderPill,
          child: SizedBox(
            height: height,
            child: animated
                ? TweenAnimationBuilder<double>(
                    tween: Tween(begin: 0, end: value),
                    duration: TransitionsDS.collapse.duration,
                    curve: TransitionsDS.collapse.curve,
                    builder: (_, v, __) => LinearProgressIndicator(
                      value: v,
                      backgroundColor: trackColor ?? ColorsDS.gray200,
                      valueColor: AlwaysStoppedAnimation(_barColor),
                    ),
                  )
                : LinearProgressIndicator(
                    value: value,
                    backgroundColor: trackColor ?? ColorsDS.gray200,
                    valueColor: AlwaysStoppedAnimation(_barColor),
                  ),
          ),
        ),
      ],
    );
  }
}

/// CpProgressRing — Indicador de progreso circular con valor central.
///
/// ```dart
/// CpProgressRing(value: 0.72)
/// CpProgressRing(value: 0.5, size: 80, label: 'Completado', color: ColorsDS.success)
/// ```
class CpProgressRing extends StatelessWidget {
  const CpProgressRing({
    super.key,
    required this.value,
    this.size = 64,
    this.strokeWidth = 6,
    this.color,
    this.trackColor,
    this.label,
    this.showPercent = true,
    this.variant,
  }) : assert(value >= 0 && value <= 1, 'value debe estar entre 0.0 y 1.0');

  final double value;
  final double size;
  final double strokeWidth;
  final Color? color;
  final Color? trackColor;
  final String? label;
  final bool showPercent;
  final VariantDS? variant;

  Color get _ringColor {
    if (color != null) return color!;
    return switch (variant) {
      VariantDS.success   => ColorsDS.success,
      VariantDS.danger    => ColorsDS.danger,
      VariantDS.warning   => ColorsDS.warning,
      VariantDS.info      => ColorsDS.info,
      VariantDS.secondary => ColorsDS.secondary,
      _                   => ColorsDS.primary,
    };
  }

  @override
  Widget build(BuildContext context) {
    final percent = '${(value * 100).toInt()}%';

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        TweenAnimationBuilder<double>(
          tween: Tween(begin: 0, end: value),
          duration: TransitionsDS.collapse.duration,
          curve: TransitionsDS.collapse.curve,
          builder: (_, v, __) => SizedBox(
            width: size,
            height: size,
            child: Stack(
              alignment: Alignment.center,
              children: [
                CircularProgressIndicator(
                  value: v,
                  strokeWidth: strokeWidth,
                  backgroundColor: trackColor ?? ColorsDS.gray200,
                  valueColor: AlwaysStoppedAnimation(_ringColor),
                  strokeCap: StrokeCap.round,
                ),
                if (showPercent)
                  Text(
                    percent,
                    style: TypographyDS.label.copyWith(
                      fontWeight: TypographyDS.weightBold,
                    ),
                  ),
              ],
            ),
          ),
        ),
        if (label != null) ...[
          const SizedBox(height: SpacingsDS.xs),
          Text(label!, style: TypographyDS.caption, textAlign: TextAlign.center),
        ],
      ],
    );
  }
}
