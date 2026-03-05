import 'package:design_system_mobile/design_system.dart';

/// Variante de shimmer según el tipo de contenido
enum ShimmerVariantDS {
  list,       // Lista con avatar + líneas
  card,       // Card con imagen + texto
  table,      // Filas de tabla
  grid,       // Grid de cards
  detail,     // Vista de detalle (DataList style)
  custom,     // Usa el builder personalizado
}

/// CpShimmerList — Esqueleto animado completo para estados de carga.
/// Combina múltiples CpSkeleton con layouts predefinidos o personalizables.
///
/// ```dart
/// // Lista de usuarios cargando
/// CpShimmerList(variant: ShimmerVariantDS.list, itemCount: 5)
///
/// // Grid de cards
/// CpShimmerList(variant: ShimmerVariantDS.grid, itemCount: 6, columns: 2)
///
/// // Tabla
/// CpShimmerList(variant: ShimmerVariantDS.table, itemCount: 8)
///
/// // Custom
/// CpShimmerList.custom(
///   itemCount: 3,
///   builder: (i) => MyCustomSkeleton(),
/// )
/// ```
class CpShimmerList extends StatefulWidget {
  const CpShimmerList({
    super.key,
    this.variant = ShimmerVariantDS.list,
    this.itemCount = 5,
    this.columns = 2,
    this.spacing = SpacingsDS.sm,
    this.padding,
    this.builder,
  });

  const CpShimmerList.custom({
    super.key,
    required this.builder,
    this.itemCount = 5,
    this.spacing = SpacingsDS.sm,
    this.padding,
  })  : variant = ShimmerVariantDS.custom,
        columns = 1;

  final ShimmerVariantDS variant;
  final int itemCount;
  final int columns;
  final double spacing;
  final EdgeInsetsGeometry? padding;
  final Widget Function(int index)? builder;

  @override
  State<CpShimmerList> createState() => _CpShimmerListState();
}

class _CpShimmerListState extends State<CpShimmerList>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1400),
    )..repeat(reverse: true);

    _animation = Tween<double>(begin: 0.4, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (_, __) => Opacity(
        opacity: _animation.value,
        child: Padding(
          padding: widget.padding ?? EdgeInsets.zero,
          child: _buildContent(),
        ),
      ),
    );
  }

  Widget _buildContent() {
    return switch (widget.variant) {
      ShimmerVariantDS.list    => _buildList(),
      ShimmerVariantDS.card    => _buildCards(),
      ShimmerVariantDS.table   => _buildTable(),
      ShimmerVariantDS.grid    => _buildGrid(),
      ShimmerVariantDS.detail  => _buildDetail(),
      ShimmerVariantDS.custom  => _buildCustom(),
    };
  }

  // ─── Lista con avatar ──────────────────────────────────────────────────────
  Widget _buildList() {
    return Column(
      children: List.generate(widget.itemCount, (i) => Padding(
        padding: EdgeInsets.only(bottom: widget.spacing),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CpSkeleton.circle(size: 44),
            const SizedBox(width: SpacingsDS.md),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CpSkeleton(width: double.infinity, height: 14),
                  const SizedBox(height: SpacingsDS.xs),
                  CpSkeleton(width: 180, height: 12),
                ],
              ),
            ),
            const SizedBox(width: SpacingsDS.md),
            CpSkeleton(width: 60, height: 24, radius: RadiusDS.pill),
          ],
        ),
      )),
    );
  }

  // ─── Cards ────────────────────────────────────────────────────────────────
  Widget _buildCards() {
    return Column(
      children: List.generate(widget.itemCount, (i) => Padding(
        padding: EdgeInsets.only(bottom: widget.spacing),
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(color: ColorsDS.gray200),
            borderRadius: RadiusDS.borderMd,
          ),
          clipBehavior: Clip.antiAlias,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CpSkeleton(width: double.infinity, height: 140, radius: 0),
              Padding(
                padding: const EdgeInsets.all(SpacingsDS.md),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CpSkeleton(width: 200, height: 16),
                    const SizedBox(height: SpacingsDS.xs),
                    CpSkeleton(width: double.infinity, height: 12),
                    const SizedBox(height: 4),
                    CpSkeleton(width: 240, height: 12),
                    const SizedBox(height: SpacingsDS.md),
                    CpSkeleton(width: 80, height: 32, radius: RadiusDS.md),
                  ],
                ),
              ),
            ],
          ),
        ),
      )),
    );
  }

  // ─── Tabla ────────────────────────────────────────────────────────────────
  Widget _buildTable() {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: ColorsDS.gray200),
        borderRadius: RadiusDS.borderMd,
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        children: [
          // Header
          Container(
            height: 48,
            color: ColorsDS.gray500,
            padding: const EdgeInsets.symmetric(horizontal: SpacingsDS.md),
            child: Row(
              children: [
                CpSkeleton(width: 100, height: 12),
                const Spacer(),
                CpSkeleton(width: 80, height: 12),
                const SizedBox(width: SpacingsDS.lg),
                CpSkeleton(width: 80, height: 12),
                const SizedBox(width: SpacingsDS.lg),
                CpSkeleton(width: 60, height: 12),
              ],
            ),
          ),
          // Rows
          ...List.generate(widget.itemCount, (i) => Container(
            height: 52,
            decoration: const BoxDecoration(
              border: Border(top: BorderSide(color: ColorsDS.gray200)),
            ),
            padding: const EdgeInsets.symmetric(horizontal: SpacingsDS.md),
            child: Row(
              children: [
                CpSkeleton(width: i.isEven ? 140 : 120, height: 14),
                const Spacer(),
                CpSkeleton(width: 80, height: 14),
                const SizedBox(width: SpacingsDS.lg),
                CpSkeleton(width: 70, height: 22, radius: RadiusDS.pill),
                const SizedBox(width: SpacingsDS.lg),
                CpSkeleton(width: 32, height: 32, radius: RadiusDS.md),
              ],
            ),
          )),
        ],
      ),
    );
  }

  // ─── Grid ────────────────────────────────────────────────────────────────
  Widget _buildGrid() {
    final rows = <Widget>[];
    for (int i = 0; i < widget.itemCount; i += widget.columns) {
      final rowItems = List.generate(
        widget.columns.clamp(0, widget.itemCount - i),
        (j) => Expanded(
          child: Container(
            margin: EdgeInsets.only(
              right: j < widget.columns - 1 ? widget.spacing : 0,
            ),
            decoration: BoxDecoration(
              border: Border.all(color: ColorsDS.gray200),
              borderRadius: RadiusDS.borderMd,
            ),
            clipBehavior: Clip.antiAlias,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CpSkeleton(width: double.infinity, height: 100, radius: 0),
                Padding(
                  padding: const EdgeInsets.all(SpacingsDS.sm),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CpSkeleton(width: double.infinity, height: 14),
                      const SizedBox(height: SpacingsDS.xs),
                      CpSkeleton(width: 80, height: 12),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      );

      // Rellena columnas vacías si la fila no está completa
      while (rowItems.length < widget.columns) {
        rowItems.add(const Expanded(child: SizedBox()));
      }

      rows.add(Padding(
        padding: EdgeInsets.only(bottom: widget.spacing),
        child: Row(children: rowItems),
      ));
    }
    return Column(children: rows);
  }

  // ─── Detail ───────────────────────────────────────────────────────────────
  Widget _buildDetail() {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: ColorsDS.gray200),
        borderRadius: RadiusDS.borderMd,
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        children: [
          // Header
          Container(
            height: 44,
            color: ColorsDS.gray500,
            padding: const EdgeInsets.symmetric(horizontal: SpacingsDS.md),
            child: Row(
              children: [
                CpSkeleton(width: 120, height: 12),
                const Spacer(),
                CpSkeleton(width: 64, height: 28, radius: RadiusDS.md),
              ],
            ),
          ),
          // Items
          ...List.generate(widget.itemCount, (i) => Container(
            height: 48,
            decoration: const BoxDecoration(
              border: Border(top: BorderSide(color: ColorsDS.gray200)),
            ),
            padding: const EdgeInsets.symmetric(
              horizontal: SpacingsDS.md,
              vertical: SpacingsDS.sm,
            ),
            child: Row(
              children: [
                SizedBox(
                  width: 140,
                  child: CpSkeleton(width: 80 + (i % 3) * 20, height: 12),
                ),
                const SizedBox(width: SpacingsDS.md),
                CpSkeleton(width: 120 + (i % 4) * 20, height: 14),
              ],
            ),
          )),
        ],
      ),
    );
  }

  // ─── Custom ────────────────────────────────────────────────────────────────
  Widget _buildCustom() {
    if (widget.builder == null) return const SizedBox();
    return Column(
      children: List.generate(widget.itemCount, (i) => Padding(
        padding: EdgeInsets.only(bottom: widget.spacing),
        child: widget.builder!(i),
      )),
    );
  }
}
