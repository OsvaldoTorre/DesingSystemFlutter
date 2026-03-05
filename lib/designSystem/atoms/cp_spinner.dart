import 'package:design_system_mobile/design_system.dart';

/// Tamaños de spinner
enum SpinnerSizeDS { sm, md, lg }

/// CpSpinner — Indicador de carga circular.
///
/// ```dart
/// CpSpinner()
/// CpSpinner(size: SpinnerSizeDS.lg, color: ColorsDS.success)
/// CpSpinner(label: 'Cargando...')
/// ```
class CpSpinner extends StatelessWidget {
  const CpSpinner({
    super.key,
    this.size = SpinnerSizeDS.md,
    this.color,
    this.label,
    this.strokeWidth,
  });

  final SpinnerSizeDS size;
  final Color? color;
  final String? label;
  final double? strokeWidth;

  double get _diameter => switch (size) {
    SpinnerSizeDS.sm => 16,
    SpinnerSizeDS.md => 24,
    SpinnerSizeDS.lg => 40,
  };

  double get _stroke => strokeWidth ?? switch (size) {
    SpinnerSizeDS.sm => 2,
    SpinnerSizeDS.md => 2.5,
    SpinnerSizeDS.lg => 3,
  };

  @override
  Widget build(BuildContext context) {
    final spinner = SizedBox(
      width: _diameter,
      height: _diameter,
      child: CircularProgressIndicator(
        strokeWidth: _stroke,
        valueColor: AlwaysStoppedAnimation<Color>(color ?? ColorsDS.primary),
      ),
    );

    if (label != null) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          spinner,
          const SizedBox(height: SpacingsDS.sm),
          Text(label!, style: TypographyDS.caption),
        ],
      );
    }

    return spinner;
  }
}
