import 'package:design_system_mobile/design_system.dart';

/// CpAlert — Equivalente a <div class="alert alert-*"> de Bootstrap
///
/// ```dart
/// CpAlert(message: 'Guardado correctamente.', variant: VariantDS.success)
///
/// CpAlert(
///   title: 'Error',
///   message: 'No se pudo conectar.',
///   variant: VariantDS.danger,
///   dismissible: true,
///   onDismiss: () => setState(() => _show = false),
/// )
/// ```
class CpAlert extends StatelessWidget {
  const CpAlert({
    super.key,
    required this.message,
    this.title,
    this.variant = VariantDS.primary,
    this.dismissible = false,
    this.onDismiss,
    this.icon,
  });

  final String message;
  final String? title;
  final VariantDS variant;
  final bool dismissible;
  final VoidCallback? onDismiss;
  final IconData? icon;

  Color get _bg => switch (variant) {
    VariantDS.primary   => ColorsDS.primarySubtle,
    VariantDS.secondary => ColorsDS.secondarySubtle,
    VariantDS.success   => ColorsDS.successSubtle,
    VariantDS.danger    => ColorsDS.dangerSubtle,
    VariantDS.warning   => ColorsDS.warningSubtle,
    VariantDS.info      => ColorsDS.infoSubtle,
    VariantDS.light     => ColorsDS.gray100,
    VariantDS.dark      => ColorsDS.gray800,
  };

  Color get _fg => switch (variant) {
    VariantDS.primary   => ColorsDS.primaryEmphasis,
    VariantDS.secondary => ColorsDS.secondaryEmphasis,
    VariantDS.success   => ColorsDS.successEmphasis,
    VariantDS.danger    => ColorsDS.dangerEmphasis,
    VariantDS.warning   => ColorsDS.warningEmphasis,
    VariantDS.info      => ColorsDS.infoEmphasis,
    VariantDS.light     => ColorsDS.gray700,
    VariantDS.dark      => ColorsDS.gray100,
  };

  Color get _border => switch (variant) {
    VariantDS.primary   => ColorsDS.primary,
    VariantDS.secondary => ColorsDS.secondary,
    VariantDS.success   => ColorsDS.success,
    VariantDS.danger    => ColorsDS.danger,
    VariantDS.warning   => ColorsDS.warning,
    VariantDS.info      => ColorsDS.info,
    VariantDS.light     => ColorsDS.gray300,
    VariantDS.dark      => ColorsDS.gray600,
  };

  IconData get _defaultIcon => switch (variant) {
    VariantDS.success   => Icons.check_circle_outline,
    VariantDS.danger    => Icons.error_outline,
    VariantDS.warning   => Icons.warning_amber_outlined,
    VariantDS.info      => Icons.info_outline,
    _                   => Icons.notifications_none_outlined,
  };

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(SpacingsDS.md),
      decoration: BoxDecoration(
        color: _bg,
        borderRadius: RadiusDS.borderMd,
        border: Border.all(color: _border.withValues(alpha: 0.3)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon ?? _defaultIcon, color: _fg, size: 20),
          const SizedBox(width: SpacingsDS.sm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (title != null) ...[
                  Text(
                    title!,
                    style: TypographyDS.body.copyWith(
                      fontWeight: TypographyDS.weightSemi,
                      color: _fg,
                    ),
                  ),
                  const SizedBox(height: SpacingsDS.xs),
                ],
                Text(message, style: TypographyDS.body.copyWith(color: _fg)),
              ],
            ),
          ),
          if (dismissible && onDismiss != null) ...[
            const SizedBox(width: SpacingsDS.sm),
            GestureDetector(
              onTap: onDismiss,
              child: Icon(Icons.close, size: 16, color: _fg),
            ),
          ],
        ],
      ),
    );
  }
}
