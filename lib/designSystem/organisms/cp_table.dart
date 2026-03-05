import 'package:design_system_mobile/design_system.dart';

/// Definición de columna
class TableColumnDS<T> {
  const TableColumnDS({
    required this.label,
    required this.cell,
    this.width,
    this.minWidth,
    this.sortable = false,
    this.align = TextAlign.left,
  });

  final String label;
  final Widget Function(T row) cell;
  final double? width;
  final double? minWidth;
  final bool sortable;
  final TextAlign align;
}

/// CpTable — Tabla de datos con ordenamiento, selección y paginación.
///
/// ```dart
/// CpTable<Usuario>(
///   columns: [
///     TableColumnDS(label: 'Nombre', cell: (u) => Text(u.nombre), sortable: true),
///     TableColumnDS(label: 'Email',  cell: (u) => Text(u.email)),
///     TableColumnDS(label: 'Rol',    cell: (u) => CpBadge(label: u.rol), width: 100),
///   ],
///   rows: usuarios,
///   loading: _cargando,
///   onRowTap: (u) => _verDetalle(u),
///   totalPages: _totalPaginas,
///   currentPage: _pagina,
///   onPageChanged: (p) => _cargarPagina(p),
/// )
/// ```
class CpTable<T> extends StatefulWidget {
  const CpTable({
    super.key,
    required this.columns,
    required this.rows,
    this.loading = false,
    this.selectable = false,
    this.onRowTap,
    this.onSelectionChanged,
    this.emptyTitle = 'Sin resultados',
    this.emptyDescription,
    this.emptyIcon = Icons.table_rows_outlined,
    this.currentPage,
    this.totalPages,
    this.onPageChanged,
    this.stickyHeader = true,
    this.striped = false,
    this.compact = false,
    this.rowKey,
  });

  final List<TableColumnDS<T>> columns;
  final List<T> rows;
  final bool loading;
  final bool selectable;
  final void Function(T row)? onRowTap;
  final void Function(List<T> selected)? onSelectionChanged;
  final String emptyTitle;
  final String? emptyDescription;
  final IconData emptyIcon;
  final int? currentPage;
  final int? totalPages;
  final ValueChanged<int>? onPageChanged;
  final bool stickyHeader;
  final bool striped;
  final bool compact;

  /// Key única por row para selección (ej: (u) => u.id)
  final Object Function(T row)? rowKey;

  @override
  State<CpTable<T>> createState() => _CpTableState<T>();
}

class _CpTableState<T> extends State<CpTable<T>> {
  final Set<Object> _selected = {};
  int? _sortColumn;
  bool _sortAsc = true;

  double get _rowHeight => widget.compact ? 40 : 52;
  EdgeInsets get _cellPadding => widget.compact
      ? const EdgeInsets.symmetric(horizontal: SpacingsDS.sm, vertical: SpacingsDS.xs)
      : const EdgeInsets.symmetric(horizontal: SpacingsDS.md, vertical: SpacingsDS.sm);

  bool _isSelected(T row) {
    if (widget.rowKey == null) return false;
    return _selected.contains(widget.rowKey!(row));
  }

  void _toggleRow(T row) {
    if (widget.rowKey == null) return;
    final key = widget.rowKey!(row);
    setState(() {
      if (_selected.contains(key)) {
        _selected.remove(key);
      } else {
        _selected.add(key);
      }
    });
    widget.onSelectionChanged
        ?.call(widget.rows.where((r) => _selected.contains(widget.rowKey!(r))).toList());
  }

  void _toggleAll() {
    setState(() {
      if (_selected.length == widget.rows.length) {
        _selected.clear();
      } else {
        _selected.clear();
        for (final r in widget.rows) {
          if (widget.rowKey != null) _selected.add(widget.rowKey!(r));
        }
      }
    });
    widget.onSelectionChanged
        ?.call(widget.rows.where((r) => _selected.contains(widget.rowKey!(r))).toList());
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: ColorsDS.gray200),
        borderRadius: RadiusDS.borderMd,
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // ─── Tabla ────────────────────────────────────────────────────────
          Expanded(
            child: _buildTable(),
          ),

          // ─── Paginación ───────────────────────────────────────────────────
          if (widget.totalPages != null && widget.totalPages! > 1) ...[
            const Divider(height: 1, color: ColorsDS.gray200),
            Padding(
              padding: const EdgeInsets.all(SpacingsDS.sm),
              child: CpPagination(
                currentPage: widget.currentPage ?? 1,
                totalPages: widget.totalPages!,
                onPageChanged: widget.onPageChanged ?? (_) {},
                showInfo: true,
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildTable() {
    if (widget.loading) {
      return const Center(child: CpSpinner(size: SpinnerSizeDS.lg));
    }

    if (widget.rows.isEmpty) {
      return CpEmptyState(
        icon: widget.emptyIcon,
        title: widget.emptyTitle,
        description: widget.emptyDescription,
        compact: true,
      );
    }

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ─── Header ────────────────────────────────────────────────────
            _TableHeader(
              columns: widget.columns,
              selectable: widget.selectable,
              allSelected: _selected.length == widget.rows.length && widget.rows.isNotEmpty,
              sortColumn: _sortColumn,
              sortAsc: _sortAsc,
              cellPadding: _cellPadding,
              rowHeight: _rowHeight,
              onSelectAll: widget.selectable ? _toggleAll : null,
              onSort: (i) => setState(() {
                if (_sortColumn == i) {
                  _sortAsc = !_sortAsc;
                } else {
                  _sortColumn = i;
                  _sortAsc = true;
                }
              }),
            ),

            // ─── Rows ───────────────────────────────────────────────────────
            ...widget.rows.asMap().entries.map((e) {
              final row       = e.value;
              final isOdd     = e.key.isOdd;
              final isSelected = _isSelected(row);

              return _TableRow<T>(
                row: row,
                columns: widget.columns,
                selectable: widget.selectable,
                selected: isSelected,
                striped: widget.striped && isOdd,
                cellPadding: _cellPadding,
                rowHeight: _rowHeight,
                onTap: widget.onRowTap != null
                    ? () => widget.onRowTap!(row)
                    : (widget.selectable ? () => _toggleRow(row) : null),
                onSelect: widget.selectable ? () => _toggleRow(row) : null,
              );
            }),
          ],
        ),
      ),
    );
  }
}

// ─── Header ────────────────────────────────────────────────────────────────────
class _TableHeader<T> extends StatelessWidget {
  const _TableHeader({
    required this.columns,
    required this.selectable,
    required this.allSelected,
    required this.sortColumn,
    required this.sortAsc,
    required this.cellPadding,
    required this.rowHeight,
    this.onSelectAll,
    this.onSort,
  });

  final List<TableColumnDS<T>> columns;
  final bool selectable;
  final bool allSelected;
  final int? sortColumn;
  final bool sortAsc;
  final EdgeInsets cellPadding;
  final double rowHeight;
  final VoidCallback? onSelectAll;
  final void Function(int)? onSort;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: rowHeight,
      color: ColorsDS.gray500,
      child: Row(
        children: [
          if (selectable)
            SizedBox(
              width: 48,
              child: Checkbox(
                value: allSelected,
                onChanged: (_) => onSelectAll?.call(),
                activeColor: ColorsDS.primary,
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                visualDensity: VisualDensity.compact,
              ),
            ),
          ...columns.asMap().entries.map((e) {
            final i   = e.key;
            final col = e.value;
            final isSorted = sortColumn == i;

            return GestureDetector(
              onTap: col.sortable ? () => onSort?.call(i) : null,
              child: Container(
                width: col.width,
                constraints: BoxConstraints(minWidth: col.minWidth ?? 80),
                padding: cellPadding,
                decoration: const BoxDecoration(
                  border: Border(right: BorderSide(color: ColorsDS.gray200)),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        col.label,
                        textAlign: col.align,
                        style: TypographyDS.label.copyWith(
                          fontWeight: TypographyDS.weightSemi,
                          color: isSorted ? ColorsDS.primary : ColorsDS.gray600,
                          letterSpacing: 0.5,
                        ),
                      ),
                    ),
                    if (col.sortable) ...[
                      const SizedBox(width: 4),
                      Icon(
                        isSorted
                            ? (sortAsc ? Icons.arrow_upward : Icons.arrow_downward)
                            : Icons.unfold_more,
                        size: 14,
                        color: isSorted ? ColorsDS.primary : ColorsDS.gray400,
                      ),
                    ],
                  ],
                ),
              ),
            );
          }),
        ],
      ),
    );
  }
}

// ─── Row ──────────────────────────────────────────────────────────────────────
class _TableRow<T> extends StatelessWidget {
  const _TableRow({
    required this.row,
    required this.columns,
    required this.selectable,
    required this.selected,
    required this.striped,
    required this.cellPadding,
    required this.rowHeight,
    this.onTap,
    this.onSelect,
  });

  final T row;
  final List<TableColumnDS<T>> columns;
  final bool selectable;
  final bool selected;
  final bool striped;
  final EdgeInsets cellPadding;
  final double rowHeight;
  final VoidCallback? onTap;
  final VoidCallback? onSelect;

  @override
  Widget build(BuildContext context) {
    Color bg = Colors.transparent;
    if (selected) bg = ColorsDS.primarySubtle;
    else if (striped) bg = ColorsDS.gray500;

    return InkWell(
      onTap: onTap,
      child: Container(
        height: rowHeight,
        color: bg,
        decoration: const BoxDecoration(
          border: Border(top: BorderSide(color: ColorsDS.gray200)),
        ),
        child: Row(
          children: [
            if (selectable)
              SizedBox(
                width: 48,
                child: Checkbox(
                  value: selected,
                  onChanged: (_) => onSelect?.call(),
                  activeColor: ColorsDS.primary,
                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  visualDensity: VisualDensity.compact,
                ),
              ),
            ...columns.map((col) => Container(
              width: col.width,
              constraints: BoxConstraints(minWidth: col.minWidth ?? 80),
              padding: cellPadding,
              decoration: const BoxDecoration(
                border: Border(right: BorderSide(color: ColorsDS.gray200)),
              ),
              alignment: col.align == TextAlign.center
                  ? Alignment.center
                  : col.align == TextAlign.right
                      ? Alignment.centerRight
                      : Alignment.centerLeft,
              child: col.cell(row),
            )),
          ],
        ),
      ),
    );
  }
}
