import 'package:design_system_mobile/design_system.dart';

/// Modelo de item para CpBreadcrumb
class BreadcrumbItem {
  const BreadcrumbItem({
    required this.label,
    this.onTap,
    this.icon,
  });

  final String label;
  final VoidCallback? onTap;
  final IconData? icon;
}

/// CpBreadcrumb — Ruta de navegación jerárquica.
/// Molecule que combina texto e iconos para mostrar la ubicación actual.
///
/// ```dart
/// CpBreadcrumb(
///   items: [
///     BreadcrumbItem(label: 'Inicio', onTap: () => _goHome()),
///     BreadcrumbItem(label: 'Productos', onTap: () => _goProducts()),
///     BreadcrumbItem(label: 'Detalle'),  // último = activo, sin onTap
///   ],
/// )
/// ```
class CpBreadcrumb extends StatelessWidget {
  const CpBreadcrumb({
    super.key,
    required this.items,
    this.separator = '/',
    this.separatorIcon,
  });

  final List<BreadcrumbItem> items;

  /// Texto separador (ignorado si separatorIcon está definido)
  final String separator;

  /// Icono separador — reemplaza al texto si se provee
  final IconData? separatorIcon;

  @override
  Widget build(BuildContext context) {
    final widgets = <Widget>[];

    for (int i = 0; i < items.length; i++) {
      final item     = items[i];
      final isLast   = i == items.length - 1;
      final isActive = isLast;

      // ─── Item ──────────────────────────────────────────────────────────────
      final label = Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (item.icon != null) ...[
            Icon(
              item.icon,
              size: 14,
              color: isActive ? ColorsDS.bodyColor : ColorsDS.gray500,
            ),
            const SizedBox(width: 4),
          ],
          Text(
            item.label,
            style: TypographyDS.small.copyWith(
              color: isActive ? ColorsDS.bodyColor : ColorsDS.primary,
              fontWeight: isActive ? TypographyDS.weightMedium : TypographyDS.weightNormal,
              decoration: (!isActive && item.onTap != null)
                  ? TextDecoration.none
                  : TextDecoration.none,
            ),
          ),
        ],
      );

      widgets.add(
        item.onTap != null && !isActive
            ? GestureDetector(
                onTap: item.onTap,
                child: MouseRegion(
                  cursor: SystemMouseCursors.click,
                  child: label,
                ),
              )
            : label,
      );

      // ─── Separador ─────────────────────────────────────────────────────────
      if (!isLast) {
        widgets.add(
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: SpacingsDS.xs),
            child: separatorIcon != null
                ? Icon(separatorIcon, size: 12, color: ColorsDS.gray400)
                : Text(separator,
                    style: TypographyDS.small.copyWith(color: ColorsDS.gray400)),
          ),
        );
      }
    }

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: widgets,
      ),
    );
  }
}
