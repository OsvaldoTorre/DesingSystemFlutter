import 'package:design_system_mobile/design_system.dart';

/// CpTooltip — Texto informativo flotante sobre un widget hijo.
/// Molecule que envuelve el Tooltip de Flutter con estilos del Design System.
///
/// ```dart
/// CpTooltip(
///   message: 'Eliminar permanentemente',
///   child: CpButton(label: 'Eliminar', variant: ButtonVariantDS.danger, onPressed: () {}),
/// )
///
/// CpTooltip(
///   message: 'Requerido para continuar',
///   position: TooltipPosition.bottom,
///   child: CpIcon(Icons.info_outline),
/// )
/// ```
enum TooltipPositionDS { top, bottom, left, right }

class CpTooltip extends StatelessWidget {
  const CpTooltip({
    super.key,
    required this.message,
    required this.child,
    this.position = TooltipPositionDS.top,
    this.backgroundColor,
    this.textColor,
    this.maxWidth = 200,
  });

  final String message;
  final Widget child;
  final TooltipPositionDS position;
  final Color? backgroundColor;
  final Color? textColor;
  final double maxWidth;

  VerticalDirection get _vertical => switch (position) {
    TooltipPositionDS.bottom => VerticalDirection.down,
    _                        => VerticalDirection.up,
  };

  @override
  Widget build(BuildContext context) {
    final bg = backgroundColor ?? ColorsDS.gray900;
    final fg = textColor ?? ColorsDS.white;

    return Tooltip(
      message: message,
      preferBelow: position == TooltipPositionDS.bottom,
      verticalOffset: 12,
      decoration: BoxDecoration(
        color: bg,
        borderRadius: RadiusDS.borderSm,
        boxShadow: ShadowsDS.md,
      ),
      textStyle: TypographyDS.caption.copyWith(color: fg),
      padding: const EdgeInsets.symmetric(
        horizontal: SpacingsDS.sm,
        vertical: SpacingsDS.xs,
      ),
      child: child,
    );
  }
}
