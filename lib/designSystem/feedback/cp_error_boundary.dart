import 'package:design_system_mobile/design_system.dart';

/// Tipo de pantalla de error
enum ErrorTypeDS { general, network, notFound, forbidden, serverError }

/// CpErrorBoundary — Pantalla de error con retry y tipo semántico.
///
/// ```dart
/// // Error general con retry
/// CpErrorBoundary(
///   onRetry: () => _reloadData(),
/// )
///
/// // Sin conexión
/// CpErrorBoundary(
///   type: ErrorTypeDS.network,
///   title: 'Sin conexión',
///   description: 'Verifica tu red e intenta de nuevo.',
///   onRetry: () => _checkConnection(),
/// )
///
/// // Como wrapper reactivo
/// CpErrorBoundary.wrap(
///   error: _error,
///   onRetry: () => setState(() => _error = null),
///   child: MyContent(),
/// )
/// ```
class CpErrorBoundary extends StatelessWidget {
  const CpErrorBoundary({
    super.key,
    this.type = ErrorTypeDS.general,
    this.title,
    this.description,
    this.onRetry,
    this.retryLabel = 'Intentar de nuevo',
    this.actions,
    this.compact = false,
    this.icon,
  });

  final ErrorTypeDS type;
  final String? title;
  final String? description;
  final VoidCallback? onRetry;
  final String retryLabel;
  final List<Widget>? actions;
  final bool compact;
  final IconData? icon;

  /// Wrapper que muestra el error si [error] != null, o el [child] si es null
  static Widget wrap({
    required Widget child,
    required Object? error,
    required VoidCallback onRetry,
    ErrorTypeDS type = ErrorTypeDS.general,
    String? title,
    String? description,
  }) {
    if (error == null) return child;
    return CpErrorBoundary(
      type: type,
      title: title,
      description: description ?? error.toString(),
      onRetry: onRetry,
    );
  }

  _ErrorConfig get _config => switch (type) {
    ErrorTypeDS.network => _ErrorConfig(
        icon: Icons.wifi_off_outlined,
        title: 'Sin conexión',
        description: 'Verifica tu conexión a internet e intenta de nuevo.',
        color: ColorsDS.warning,
      ),
    ErrorTypeDS.notFound => _ErrorConfig(
        icon: Icons.search_off_outlined,
        title: 'Página no encontrada',
        description: 'El recurso que buscas no existe o fue eliminado.',
        color: ColorsDS.info,
      ),
    ErrorTypeDS.forbidden => _ErrorConfig(
        icon: Icons.lock_outline,
        title: 'Acceso denegado',
        description: 'No tienes permisos para ver este contenido.',
        color: ColorsDS.warning,
      ),
    ErrorTypeDS.serverError => _ErrorConfig(
        icon: Icons.cloud_off_outlined,
        title: 'Error del servidor',
        description: 'Algo salió mal en nuestros servidores. Intenta más tarde.',
        color: ColorsDS.danger,
      ),
    ErrorTypeDS.general => _ErrorConfig(
        icon: Icons.error_outline,
        title: 'Algo salió mal',
        description: 'Ocurrió un error inesperado. Por favor intenta de nuevo.',
        color: ColorsDS.danger,
      ),
  };

  @override
  Widget build(BuildContext context) {
    final cfg        = _config;
    final iconWidget = icon ?? cfg.icon;
    final iconSize   = compact ? 40.0 : SizesDS.iconHero;
    final titleStyle = compact ? TypographyDS.h6 : TypographyDS.h4;
    final padding    = compact ? SpacingsDS.md : SpacingsDS.xl;

    return Center(
      child: Padding(
        padding: EdgeInsets.all(padding),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // ─── Ilustración ────────────────────────────────────────────────
            Container(
              width: iconSize * 2,
              height: iconSize * 2,
              decoration: BoxDecoration(
                color: cfg.color.withValues(alpha: 0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(iconWidget, size: iconSize, color: cfg.color),
            ),

            SizedBox(height: compact ? SpacingsDS.sm : SpacingsDS.lg),

            // ─── Título ─────────────────────────────────────────────────────
            Text(
              title ?? cfg.title,
              style: titleStyle,
              textAlign: TextAlign.center,
            ),

            const SizedBox(height: SpacingsDS.sm),

            // ─── Descripción ────────────────────────────────────────────────
            Text(
              description ?? cfg.description,
              style: TypographyDS.body.copyWith(color: ColorsDS.gray500),
              textAlign: TextAlign.center,
            ),

            SizedBox(height: compact ? SpacingsDS.md : SpacingsDS.lg),

            // ─── Acciones ────────────────────────────────────────────────────
            if (actions != null)
              Wrap(
                spacing: SpacingsDS.sm,
                runSpacing: SpacingsDS.sm,
                alignment: WrapAlignment.center,
                children: actions!,
              )
            else if (onRetry != null)
              CpButton(
                label: retryLabel,
                prefixIcon: Icons.refresh,
                onPressed: onRetry,
                size: compact ? ButtonSizeDS.sm : ButtonSizeDS.md,
              ),
          ],
        ),
      ),
    );
  }
}

class _ErrorConfig {
  const _ErrorConfig({
    required this.icon,
    required this.title,
    required this.description,
    required this.color,
  });
  final IconData icon;
  final String title;
  final String description;
  final Color color;
}
