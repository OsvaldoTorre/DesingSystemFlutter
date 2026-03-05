import 'package:design_system_mobile/design_system.dart';

/// Modelo de item clave-valor
class DataItemDS {
  const DataItemDS({
    required this.label,
    this.value,
    this.valueWidget,
    this.copyable = false,
    this.badge,
    this.icon,
    this.loading = false,
  }) : assert(
          value != null || valueWidget != null || loading,
          'Debe proveer value, valueWidget o loading: true',
        );

  final String label;
  final String? value;
  final Widget? valueWidget;
  final bool copyable;
  final String? badge;
  final IconData? icon;
  final bool loading;
}

/// Layout del DataList
enum DataListLayoutDS { vertical, horizontal, grid }

/// CpDataList — Lista de pares clave-valor para vistas de detalle.
/// Organism para mostrar información estructurada: perfiles, órdenes, configuración.
///
/// ```dart
/// CpDataList(
///   title: 'Información del usuario',
///   items: [
///     DataItemDS(label: 'Nombre',   value: 'Juan García'),
///     DataItemDS(label: 'Email',    value: 'juan@empresa.com', copyable: true),
///     DataItemDS(label: 'Plan',     badge: 'Pro', value: 'Pro'),
///     DataItemDS(label: 'Creado',   value: '12 Mar 2024'),
///     DataItemDS(label: 'Estado',   valueWidget: CpBadge(label: 'Activo', variant: VariantDS.success)),
///   ],
/// )
/// ```
class CpDataList extends StatelessWidget {
  const CpDataList({
    super.key,
    required this.items,
    this.title,
    this.layout = DataListLayoutDS.horizontal,
    this.columns = 2,
    this.divided = true,
    this.bordered = true,
    this.labelWidth = 140,
    this.actions,
  });

  final List<DataItemDS> items;
  final String? title;
  final DataListLayoutDS layout;

  /// Solo aplica cuando layout == grid
  final int columns;

  final bool divided;
  final bool bordered;

  /// Ancho del label en layout horizontal
  final double labelWidth;

  /// Widgets de acciones en el header (ej: botón Editar)
  final List<Widget>? actions;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: bordered
          ? BoxDecoration(
              border: Border.all(color: ColorsDS.gray200),
              borderRadius: RadiusDS.borderMd,
            )
          : null,
      clipBehavior: bordered ? Clip.antiAlias : Clip.none,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // ─── Header ────────────────────────────────────────────────────────
          if (title != null || actions != null)
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: SpacingsDS.md,
                vertical: SpacingsDS.sm,
              ),
              decoration: const BoxDecoration(
                color: ColorsDS.gray500,
                border: Border(bottom: BorderSide(color: ColorsDS.gray200)),
              ),
              child: Row(
                children: [
                  if (title != null)
                    Expanded(
                      child: Text(
                        title!,
                        style: TypographyDS.label.copyWith(
                          fontWeight: TypographyDS.weightSemi,
                          letterSpacing: 0.5,
                        ),
                      ),
                    ),
                  if (actions != null) ...actions!,
                ],
              ),
            ),

          // ─── Items ────────────────────────────────────────────────────────
          _buildItems(),
        ],
      ),
    );
  }

  Widget _buildItems() {
    return switch (layout) {
      DataListLayoutDS.grid => _GridLayout(
          items: items,
          columns: columns,
          divided: divided,
        ),
      DataListLayoutDS.vertical => _VerticalLayout(items: items, divided: divided),
      DataListLayoutDS.horizontal => _HorizontalLayout(
          items: items,
          divided: divided,
          labelWidth: labelWidth,
        ),
    };
  }
}

// ─── Layout horizontal (label | valor) ────────────────────────────────────────
class _HorizontalLayout extends StatelessWidget {
  const _HorizontalLayout({
    required this.items,
    required this.divided,
    required this.labelWidth,
  });

  final List<DataItemDS> items;
  final bool divided;
  final double labelWidth;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: items.asMap().entries.map((e) {
        final isLast = e.key == items.length - 1;
        return _DataRow(
          item: e.value,
          showDivider: divided && !isLast,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: labelWidth,
                child: _Label(item: e.value),
              ),
              const SizedBox(width: SpacingsDS.sm),
              Expanded(child: _Value(item: e.value)),
            ],
          ),
        );
      }).toList(),
    );
  }
}

// ─── Layout vertical (label encima del valor) ──────────────────────────────────
class _VerticalLayout extends StatelessWidget {
  const _VerticalLayout({required this.items, required this.divided});

  final List<DataItemDS> items;
  final bool divided;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: items.asMap().entries.map((e) {
        final isLast = e.key == items.length - 1;
        return _DataRow(
          item: e.value,
          showDivider: divided && !isLast,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _Label(item: e.value),
              const SizedBox(height: SpacingsDS.xs),
              _Value(item: e.value),
            ],
          ),
        );
      }).toList(),
    );
  }
}

// ─── Layout grid (n columnas) ─────────────────────────────────────────────────
class _GridLayout extends StatelessWidget {
  const _GridLayout({
    required this.items,
    required this.columns,
    required this.divided,
  });

  final List<DataItemDS> items;
  final int columns;
  final bool divided;

  @override
  Widget build(BuildContext context) {
    final rows = <List<DataItemDS>>[];
    for (int i = 0; i < items.length; i += columns) {
      rows.add(items.sublist(i, (i + columns).clamp(0, items.length)));
    }

    return Column(
      children: rows.asMap().entries.map((e) {
        final rowIndex = e.key;
        final rowItems = e.value;
        final isLast = rowIndex == rows.length - 1;

        return Container(
          decoration: divided && !isLast
              ? const BoxDecoration(
                  border: Border(bottom: BorderSide(color: ColorsDS.gray200)))
              : null,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: rowItems.asMap().entries.map((ce) {
              final colIndex = ce.key;
              final item     = ce.value;
              final isLastCol = colIndex == rowItems.length - 1;

              return Expanded(
                child: Container(
                  padding: const EdgeInsets.all(SpacingsDS.md),
                  decoration: !isLastCol
                      ? const BoxDecoration(
                          border: Border(right: BorderSide(color: ColorsDS.gray200)))
                      : null,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _Label(item: item),
                      const SizedBox(height: SpacingsDS.xs),
                      _Value(item: item),
                    ],
                  ),
                ),
              );
            }).toList(),
          ),
        );
      }).toList(),
    );
  }
}

// ─── Componentes internos ─────────────────────────────────────────────────────
class _DataRow extends StatelessWidget {
  const _DataRow({
    required this.item,
    required this.child,
    required this.showDivider,
  });

  final DataItemDS item;
  final Widget child;
  final bool showDivider;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: SpacingsDS.md,
        vertical: SpacingsDS.sm,
      ),
      decoration: showDivider
          ? const BoxDecoration(
              border: Border(bottom: BorderSide(color: ColorsDS.gray200)))
          : null,
      child: child,
    );
  }
}

class _Label extends StatelessWidget {
  const _Label({required this.item});
  final DataItemDS item;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (item.icon != null) ...[
          Icon(item.icon, size: 14, color: ColorsDS.gray500),
          const SizedBox(width: 4),
        ],
        Text(
          item.label,
          style: TypographyDS.caption.copyWith(
            color: ColorsDS.gray500,
            fontWeight: TypographyDS.weightMedium,
          ),
        ),
      ],
    );
  }
}

class _Value extends StatelessWidget {
  const _Value({required this.item});
  final DataItemDS item;

  @override
  Widget build(BuildContext context) {
    if (item.loading) {
      return CpSkeleton(width: 120, height: 14);
    }

    if (item.valueWidget != null) return item.valueWidget!;

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Flexible(
          child: Text(
            item.value ?? '—',
            style: TypographyDS.body.copyWith(
              color: item.value != null ? ColorsDS.bodyColor : ColorsDS.gray400,
            ),
          ),
        ),
        if (item.copyable && item.value != null) ...[
          const SizedBox(width: SpacingsDS.xs),
          GestureDetector(
            onTap: () {
              Clipboard.setData(ClipboardData(text: item.value!));
            },
            child: const Icon(Icons.copy_outlined, size: 14, color: ColorsDS.gray400),
          ),
        ],
        if (item.badge != null) ...[
          const SizedBox(width: SpacingsDS.xs),
          CpBadge(label: item.badge!, size: BadgeSizeDS.sm),
        ],
      ],
    );
  }
}
