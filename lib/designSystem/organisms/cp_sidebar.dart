import 'package:design_system_mobile/design_system.dart';

/// Modelo de sección del sidebar
class SidebarSectionDS {
  const SidebarSectionDS({
    required this.items,
    this.title,
  });

  final String? title;
  final List<SidebarItemDS> items;
}

/// Modelo de item del sidebar
class SidebarItemDS {
  const SidebarItemDS({
    required this.label,
    required this.icon,
    this.badge,
    this.onTap,
    this.isActive = false,
    this.children = const [],
  });

  final String label;
  final IconData icon;
  final String? badge;
  final VoidCallback? onTap;
  final bool isActive;

  /// Sub-items para navegación anidada
  final List<SidebarItemDS> children;
}

/// CpSidebar — Panel de navegación lateral con secciones y collapse.
/// Organism que combina CpNavItems en grupos con títulos opcionales.
///
/// ```dart
/// CpSidebar(
///   header: FlutterLogo(size: 32),
///   sections: [
///     SidebarSectionDS(title: 'PRINCIPAL', items: [
///       SidebarItemDS(label: 'Dashboard', icon: Icons.dashboard, isActive: true, onTap: () {}),
///       SidebarItemDS(label: 'Usuarios', icon: Icons.people, badge: '5', onTap: () {}),
///     ]),
///     SidebarSectionDS(title: 'CONFIGURACIÓN', items: [
///       SidebarItemDS(label: 'Ajustes', icon: Icons.settings, onTap: () {}),
///     ]),
///   ],
///   collapsed: false,
///   onToggle: () => setState(() => _collapsed = !_collapsed),
/// )
/// ```
class CpSidebar extends StatelessWidget {
  const CpSidebar({
    super.key,
    required this.sections,
    this.header,
    this.footer,
    this.collapsed = false,
    this.onToggle,
    this.backgroundColor,
    this.width,
  });

  final List<SidebarSectionDS> sections;
  final Widget? header;
  final Widget? footer;
  final bool collapsed;
  final VoidCallback? onToggle;
  final Color? backgroundColor;
  final double? width;

  double get _width => collapsed
      ? SizesDS.sidebarCollapsed
      : (width ?? SizesDS.sidebarExpanded);

  @override
  Widget build(BuildContext context) {
    final bg = backgroundColor ?? ColorsDS.white;

    return AnimatedContainer(
      duration: TransitionsDS.drawer.duration,
      curve: TransitionsDS.drawer.curve,
      width: _width,
      decoration: BoxDecoration(
        color: bg,
        border: Border(right: BorderSide(color: ColorsDS.gray200)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ─── Header ────────────────────────────────────────────────────────
          if (header != null || onToggle != null)
            Container(
              height: SizesDS.navbarMd,
              padding: const EdgeInsets.symmetric(horizontal: SpacingsDS.sm),
              child: Row(
                children: [
                  if (header != null && !collapsed) ...[
                    Expanded(child: header!),
                  ],
                  if (onToggle != null)
                    IconButton(
                      icon: Icon(
                        collapsed
                            ? Icons.chevron_right
                            : Icons.chevron_left,
                        color: ColorsDS.gray600,
                      ),
                      onPressed: onToggle,
                    ),
                ],
              ),
            ),

          const CpDivider(),

          // ─── Secciones ────────────────────────────────────────────────────
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(vertical: SpacingsDS.sm),
              children: sections.map((section) =>
                _SidebarSection(section: section, collapsed: collapsed),
              ).toList(),
            ),
          ),

          // ─── Footer ──────────────────────────────────────────────────────
          if (footer != null) ...[
            const CpDivider(),
            Padding(
              padding: const EdgeInsets.all(SpacingsDS.sm),
              child: collapsed ? const SizedBox() : footer!,
            ),
          ],
        ],
      ),
    );
  }
}

class _SidebarSection extends StatelessWidget {
  const _SidebarSection({required this.section, required this.collapsed});
  final SidebarSectionDS section;
  final bool collapsed;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (section.title != null && !collapsed) ...[
          Padding(
            padding: const EdgeInsets.fromLTRB(
              SpacingsDS.md, SpacingsDS.sm, SpacingsDS.md, SpacingsDS.xs,
            ),
            child: Text(
              section.title!,
              style: TypographyDS.caption.copyWith(
                letterSpacing: 1.2,
                fontWeight: TypographyDS.weightSemi,
              ),
            ),
          ),
        ],
        ...section.items.map((item) =>
          _SidebarItem(item: item, collapsed: collapsed),
        ),
        const SizedBox(height: SpacingsDS.sm),
      ],
    );
  }
}

class _SidebarItem extends StatelessWidget {
  const _SidebarItem({required this.item, required this.collapsed});
  final SidebarItemDS item;
  final bool collapsed;

  @override
  Widget build(BuildContext context) {
    final isActive = item.isActive;
    final color = isActive ? ColorsDS.primary : ColorsDS.gray600;

    final tile = InkWell(
      onTap: item.onTap,
      borderRadius: RadiusDS.borderMd,
      child: Container(
        margin: const EdgeInsets.symmetric(
          horizontal: SpacingsDS.xs,
          vertical: 2,
        ),
        padding: EdgeInsets.symmetric(
          horizontal: collapsed ? SpacingsDS.sm : SpacingsDS.sm,
          vertical: SpacingsDS.sm,
        ),
        decoration: BoxDecoration(
          color: isActive
              ? ColorsDS.primary.withValues(alpha: 0.08)
              : Colors.transparent,
          borderRadius: RadiusDS.borderMd,
        ),
        child: Row(
          mainAxisAlignment: collapsed
              ? MainAxisAlignment.center
              : MainAxisAlignment.start,
          children: [
            Icon(item.icon, size: 20, color: color),
            if (!collapsed) ...[
              const SizedBox(width: SpacingsDS.sm),
              Expanded(
                child: Text(
                  item.label,
                  style: TypographyDS.body.copyWith(
                    color: isActive ? ColorsDS.primary : ColorsDS.gray700,
                    fontWeight: isActive
                        ? TypographyDS.weightSemi
                        : TypographyDS.weightNormal,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              if (item.badge != null)
                CpBadge(
                  label: item.badge!,
                  variant: VariantDS.danger,
                  pill: true,
                  size: BadgeSizeDS.sm,
                ),
            ],
          ],
        ),
      ),
    );

    if (collapsed && item.label.isNotEmpty) {
      return Tooltip(message: item.label, child: tile);
    }
    return tile;
  }
}
