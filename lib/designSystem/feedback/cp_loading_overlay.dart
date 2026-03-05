import 'package:design_system_mobile/design_system.dart';

/// CpLoadingOverlay — Pantalla de carga bloqueante sobre el contenido.
/// Se puede usar como wrapper o via helper estático.
///
/// ```dart
/// // Como wrapper reactivo
/// CpLoadingOverlay(
///   loading: _submitting,
///   message: 'Guardando...',
///   child: MyForm(),
/// )
///
/// // Bloqueante global via Navigator
/// CpLoadingOverlay.show(context, message: 'Procesando pago...');
/// CpLoadingOverlay.hide(context);
/// ```
class CpLoadingOverlay extends StatelessWidget {
  const CpLoadingOverlay({
    super.key,
    required this.child,
    this.loading = false,
    this.message,
    this.color,
    this.barrierOpacity = 0.5,
    this.blur = false,
  });

  final Widget child;
  final bool loading;
  final String? message;
  final Color? color;
  final double barrierOpacity;

  /// true → aplica blur al contenido bajo el overlay (requiere ImageFiltered)
  final bool blur;

  // ─── Static API ────────────────────────────────────────────────────────────

  static OverlayEntry? _entry;

  /// Muestra overlay global bloqueante en el Navigator raíz
  static void show(
    BuildContext context, {
    String? message,
    Color? color,
  }) {
    hide(context);
    _entry = OverlayEntry(
      builder: (_) => _OverlayContent(message: message, color: color),
    );
    Overlay.of(context).insert(_entry!);
  }

  /// Oculta el overlay global
  static void hide(BuildContext context) {
    _entry?.remove();
    _entry = null;
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        child,
        if (loading)
          AnimatedOpacity(
            opacity: loading ? 1 : 0,
            duration: TransitionsDS.fade.duration,
            child: _OverlayContent(
              message: message,
              color: color,
              opacity: barrierOpacity,
            ),
          ),
      ],
    );
  }
}

class _OverlayContent extends StatelessWidget {
  const _OverlayContent({
    this.message,
    this.color,
    this.opacity = 0.5,
  });

  final String? message;
  final Color? color;
  final double opacity;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black.withValues(alpha: opacity),
      child: Center(
        child: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: SpacingsDS.lg,
            vertical: SpacingsDS.md,
          ),
          decoration: BoxDecoration(
            color: color ?? ColorsDS.white,
            borderRadius: RadiusDS.borderLg,
            boxShadow: ShadowsDS.xl,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CpSpinner(
                size: SpinnerSizeDS.lg,
                color: ColorsDS.primary,
              ),
              if (message != null) ...[
                const SizedBox(height: SpacingsDS.md),
                Text(
                  message!,
                  style: TypographyDS.body.copyWith(
                    color: ColorsDS.gray700,
                    fontWeight: TypographyDS.weightMedium,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
