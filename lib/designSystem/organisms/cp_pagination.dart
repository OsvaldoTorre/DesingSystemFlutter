import 'package:design_system_mobile/design_system.dart';

/// CpPagination — Navegación de páginas para listas y tablas.
///
/// ```dart
/// CpPagination(
///   currentPage: _page,
///   totalPages: 12,
///   onPageChanged: (p) => setState(() => _page = p),
/// )
///
/// CpPagination(
///   currentPage: 3,
///   totalPages: 20,
///   showInfo: true,      // "Página 3 de 20"
///   maxVisible: 5,
///   onPageChanged: (p) => _loadPage(p),
/// )
/// ```
class CpPagination extends StatelessWidget {
  const CpPagination({
    super.key,
    required this.currentPage,
    required this.totalPages,
    required this.onPageChanged,
    this.maxVisible = 5,
    this.showInfo = false,
    this.showFirstLast = true,
    this.size = PaginationSizeDS.md,
  });

  final int currentPage;
  final int totalPages;
  final ValueChanged<int> onPageChanged;
  final int maxVisible;
  final bool showInfo;
  final bool showFirstLast;
  final PaginationSizeDS size;

  double get _btnSize => switch (size) {
    PaginationSizeDS.sm => 28,
    PaginationSizeDS.md => 36,
    PaginationSizeDS.lg => 44,
  };

  List<int?> get _pages {
    if (totalPages <= maxVisible) {
      return List.generate(totalPages, (i) => i + 1);
    }
    final pages = <int?>[];
    const ellipsis = null;
    final half = maxVisible ~/ 2;

    if (currentPage <= half + 1) {
      for (int i = 1; i <= maxVisible - 1; i++) pages.add(i);
      pages.add(ellipsis);
      pages.add(totalPages);
    } else if (currentPage >= totalPages - half) {
      pages.add(1);
      pages.add(ellipsis);
      for (int i = totalPages - maxVisible + 2; i <= totalPages; i++) pages.add(i);
    } else {
      pages.add(1);
      pages.add(ellipsis);
      for (int i = currentPage - half + 1; i <= currentPage + half - 1; i++) pages.add(i);
      pages.add(ellipsis);
      pages.add(totalPages);
    }
    return pages;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (showInfo) ...[
          Text(
            'Página $currentPage de $totalPages',
            style: TypographyDS.caption,
          ),
          const SizedBox(height: SpacingsDS.xs),
        ],
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            // ─── Primera página ──────────────────────────────────────────────
            if (showFirstLast)
              _PageBtn(
                icon: Icons.first_page,
                size: _btnSize,
                enabled: currentPage > 1,
                onTap: () => onPageChanged(1),
              ),

            // ─── Anterior ────────────────────────────────────────────────────
            _PageBtn(
              icon: Icons.chevron_left,
              size: _btnSize,
              enabled: currentPage > 1,
              onTap: () => onPageChanged(currentPage - 1),
            ),

            // ─── Números ─────────────────────────────────────────────────────
            ..._pages.map((p) => p == null
                ? _EllipsisBtn(size: _btnSize)
                : _PageBtn(
                    label: '$p',
                    size: _btnSize,
                    isActive: p == currentPage,
                    onTap: () => onPageChanged(p),
                  )),

            // ─── Siguiente ───────────────────────────────────────────────────
            _PageBtn(
              icon: Icons.chevron_right,
              size: _btnSize,
              enabled: currentPage < totalPages,
              onTap: () => onPageChanged(currentPage + 1),
            ),

            // ─── Última página ───────────────────────────────────────────────
            if (showFirstLast)
              _PageBtn(
                icon: Icons.last_page,
                size: _btnSize,
                enabled: currentPage < totalPages,
                onTap: () => onPageChanged(totalPages),
              ),
          ],
        ),
      ],
    );
  }
}

enum PaginationSizeDS { sm, md, lg }

class _PageBtn extends StatelessWidget {
  const _PageBtn({
    this.label,
    this.icon,
    required this.size,
    this.isActive = false,
    this.enabled = true,
    this.onTap,
  });

  final String? label;
  final IconData? icon;
  final double size;
  final bool isActive;
  final bool enabled;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final bg     = isActive ? ColorsDS.primary : Colors.transparent;
    final fg     = isActive ? ColorsDS.white
        : (enabled ? ColorsDS.gray700 : ColorsDS.gray400);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 2),
      child: InkWell(
        onTap: enabled && !isActive ? onTap : null,
        borderRadius: RadiusDS.borderSm,
        child: Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            color: bg,
            borderRadius: RadiusDS.borderSm,
            border: Border.all(
              color: isActive ? ColorsDS.primary : ColorsDS.gray300,
            ),
          ),
          alignment: Alignment.center,
          child: icon != null
              ? Icon(icon, size: size * 0.5, color: fg)
              : Text(
                  label!,
                  style: TypographyDS.label.copyWith(color: fg),
                ),
        ),
      ),
    );
  }
}

class _EllipsisBtn extends StatelessWidget {
  const _EllipsisBtn({required this.size});
  final double size;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: Center(
        child: Text('…', style: TypographyDS.body.copyWith(color: ColorsDS.gray400)),
      ),
    );
  }
}
