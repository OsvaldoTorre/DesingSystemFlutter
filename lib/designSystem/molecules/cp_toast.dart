import 'package:design_system_mobile/design_system.dart';

/// CpToast — Notificación temporal flotante.
/// Molecule que combina icono + texto + dismiss con animación y auto-cierre.
///
/// Uso recomendado via helper estático:
/// ```dart
/// CpToast.show(
///   context,
///   message: 'Guardado correctamente',
///   variant: VariantDS.success,
/// )
///
/// CpToast.show(
///   context,
///   message: 'Error al conectar',
///   variant: VariantDS.danger,
///   duration: Duration(seconds: 5),
/// )
/// ```
class CpToast extends StatefulWidget {
  const CpToast({
    super.key,
    required this.message,
    this.title,
    this.variant = VariantDS.dark,
    this.duration = const Duration(seconds: 3),
    this.onDismiss,
    this.action,
    this.actionLabel,
  });

  final String message;
  final String? title;
  final VariantDS variant;
  final Duration duration;
  final VoidCallback? onDismiss;
  final VoidCallback? action;
  final String? actionLabel;

  /// Muestra un Toast usando ScaffoldMessenger (SnackBar con estilo DS)
  static void show(
    BuildContext context, {
    required String message,
    String? title,
    VariantDS variant = VariantDS.dark,
    Duration duration = const Duration(seconds: 3),
    String? actionLabel,
    VoidCallback? onAction,
  }) {
    final colors = _ToastColors.from(variant);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: duration,
        backgroundColor: colors.bg,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: RadiusDS.borderMd),
        margin: const EdgeInsets.all(SpacingsDS.md),
        content: Row(
          children: [
            Icon(colors.icon, color: colors.fg, size: 18),
            const SizedBox(width: SpacingsDS.sm),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (title != null)
                    Text(title,
                        style: TypographyDS.label.copyWith(
                          color: colors.fg,
                          fontWeight: TypographyDS.weightBold,
                        )),
                  Text(message,
                      style: TypographyDS.small.copyWith(color: colors.fg)),
                ],
              ),
            ),
          ],
        ),
        action: actionLabel != null && onAction != null
            ? SnackBarAction(
                label: actionLabel,
                textColor: colors.fg,
                onPressed: onAction,
              )
            : null,
      ),
    );
  }

  @override
  State<CpToast> createState() => _CpToastState();
}

class _CpToastState extends State<CpToast>
    with SingleTickerProviderStateMixin {
  late AnimationController _ctrl;
  late Animation<double> _opacity;
  late Animation<Offset> _slide;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      vsync: this,
      duration: TransitionsDS.toast.duration,
    );
    _opacity = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _ctrl, curve: TransitionsDS.toast.curve),
    );
    _slide = Tween<Offset>(
      begin: const Offset(0, 0.2),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _ctrl, curve: TransitionsDS.toast.curve));

    _ctrl.forward();

    Future.delayed(widget.duration, () {
      if (mounted) _dismiss();
    });
  }

  void _dismiss() {
    _ctrl.reverse().then((_) => widget.onDismiss?.call());
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colors = _ToastColors.from(widget.variant);

    return SlideTransition(
      position: _slide,
      child: FadeTransition(
        opacity: _opacity,
        child: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: SpacingsDS.md,
            vertical: SpacingsDS.sm,
          ),
          decoration: BoxDecoration(
            color: colors.bg,
            borderRadius: RadiusDS.borderMd,
            boxShadow: ShadowsDS.lg,
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(colors.icon, color: colors.fg, size: 18),
              const SizedBox(width: SpacingsDS.sm),
              Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (widget.title != null)
                      Text(widget.title!,
                          style: TypographyDS.label.copyWith(
                            color: colors.fg,
                            fontWeight: TypographyDS.weightBold,
                          )),
                    Text(widget.message,
                        style: TypographyDS.small.copyWith(color: colors.fg)),
                  ],
                ),
              ),
              if (widget.actionLabel != null && widget.action != null) ...[
                const SizedBox(width: SpacingsDS.sm),
                GestureDetector(
                  onTap: widget.action,
                  child: Text(
                    widget.actionLabel!,
                    style: TypographyDS.label.copyWith(
                      color: colors.fg,
                      fontWeight: TypographyDS.weightBold,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
              ],
              const SizedBox(width: SpacingsDS.sm),
              GestureDetector(
                onTap: _dismiss,
                child: Icon(Icons.close, size: 16, color: colors.fg),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ToastColors {
  const _ToastColors({
    required this.bg,
    required this.fg,
    required this.icon,
  });

  final Color bg;
  final Color fg;
  final IconData icon;

  static _ToastColors from(VariantDS variant) => switch (variant) {
    VariantDS.success   => const _ToastColors(bg: ColorsDS.success,   fg: ColorsDS.white, icon: Icons.check_circle_outline),
    VariantDS.danger    => const _ToastColors(bg: ColorsDS.danger,    fg: ColorsDS.white, icon: Icons.error_outline),
    VariantDS.warning   => const _ToastColors(bg: ColorsDS.warning,   fg: ColorsDS.gray900, icon: Icons.warning_amber_outlined),
    VariantDS.info      => const _ToastColors(bg: ColorsDS.info,      fg: ColorsDS.gray900, icon: Icons.info_outline),
    VariantDS.primary   => const _ToastColors(bg: ColorsDS.primary,   fg: ColorsDS.white, icon: Icons.notifications_none),
    VariantDS.secondary => const _ToastColors(bg: ColorsDS.secondary, fg: ColorsDS.white, icon: Icons.notifications_none),
    VariantDS.light     => const _ToastColors(bg: ColorsDS.gray100,   fg: ColorsDS.gray900, icon: Icons.notifications_none),
    VariantDS.dark      => const _ToastColors(bg: ColorsDS.gray900,   fg: ColorsDS.white, icon: Icons.notifications_none),
  };
}
