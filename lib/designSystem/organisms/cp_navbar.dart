import 'package:design_system_mobile/design_system.dart';

/// Modelo de item de navegación
class NavItemDS {
  const NavItemDS({
    required this.label,
    this.icon,
    this.badge,
    this.onTap,
    this.isActive = false,
  });

  final String label;
  final IconData? icon;
  final String? badge;
  final VoidCallback? onTap;
  final bool isActive;
}

/// CpNavbar — Barra de navegación superior.
/// Organism que combina logo, links de navegación, acciones y menú hamburguesa.
///
/// ```dart
/// CpNavbar(
///   brand: Text('MiApp', style: TypographyDS.h5),
///   items: [
///     NavItemDS(label: 'Inicio', icon: Icons.home, isActive: true, onTap: () {}),
///     NavItemDS(label: 'Productos', onTap: () {}),
///     NavItemDS(label: 'Contacto', onTap: () {}),
///   ],
///   actions: [
///     CpButton(label: 'Login', variant: ButtonVariantDS.outlinePrimary, onPressed: () {}),
///   ],
/// )
/// ```
class CpNavbar extends StatefulWidget implements PreferredSizeWidget {
  const CpNavbar({
    super.key,
    this.brand,
    this.items = const [],
    this.actions = const [],
    this.backgroundColor,
    this.elevation = true,
    this.height,
  });

  final Widget? brand;
  final List<NavItemDS> items;
  final List<Widget> actions;
  final Color? backgroundColor;
  final bool elevation;
  final double? height;

  @override
  Size get preferredSize => Size.fromHeight(height ?? SizesDS.navbarMd);

  @override
  State<CpNavbar> createState() => _CpNavbarState();
}

class _CpNavbarState extends State<CpNavbar> {
  bool _menuOpen = false;

  @override
  Widget build(BuildContext context) {
    final bg = widget.backgroundColor ?? ColorsDS.white;
    final isMobile = MediaQuery.sizeOf(context).width < 768;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // ─── Barra principal ────────────────────────────────────────────────
        Container(
          height: widget.height ?? SizesDS.navbarMd,
          padding: const EdgeInsets.symmetric(horizontal: SpacingsDS.md),
          decoration: BoxDecoration(
            color: bg,
            boxShadow: widget.elevation ? ShadowsDS.sm : [],
            border: Border(
              bottom: BorderSide(color: ColorsDS.gray200),
            ),
          ),
          child: Row(
            children: [
              // Brand
              if (widget.brand != null) ...[
                widget.brand!,
                const SizedBox(width: SpacingsDS.md),
              ],

              // Links desktop
              if (!isMobile) ...[
                Expanded(
                  child: Row(
                    children: widget.items.map((item) =>
                      _NavLink(item: item),
                    ).toList(),
                  ),
                ),
              ] else
                const Spacer(),

              // Actions
              ...widget.actions,

              // Hamburguesa en mobile
              if (isMobile && widget.items.isNotEmpty) ...[
                const SizedBox(width: SpacingsDS.sm),
                IconButton(
                  icon: Icon(
                    _menuOpen ? Icons.close : Icons.menu,
                    color: ColorsDS.gray700,
                  ),
                  onPressed: () => setState(() => _menuOpen = !_menuOpen),
                ),
              ],
            ],
          ),
        ),

        // ─── Menú mobile desplegable ────────────────────────────────────────
        if (isMobile && _menuOpen)
          Container(
            color: bg,
            child: Column(
              children: widget.items.map((item) =>
                ListTile(
                  leading: item.icon != null
                      ? Icon(item.icon,
                          color: item.isActive ? ColorsDS.primary : ColorsDS.gray600)
                      : null,
                  title: Text(
                    item.label,
                    style: TypographyDS.body.copyWith(
                      color: item.isActive ? ColorsDS.primary : ColorsDS.bodyColor,
                      fontWeight: item.isActive
                          ? TypographyDS.weightSemi
                          : TypographyDS.weightNormal,
                    ),
                  ),
                  trailing: item.badge != null
                      ? CpBadge(label: item.badge!, variant: VariantDS.danger, pill: true)
                      : null,
                  onTap: () {
                    setState(() => _menuOpen = false);
                    item.onTap?.call();
                  },
                ),
              ).toList(),
            ),
          ),
      ],
    );
  }
}

class _NavLink extends StatelessWidget {
  const _NavLink({required this.item});
  final NavItemDS item;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: item.onTap,
      borderRadius: RadiusDS.borderSm,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: SpacingsDS.sm,
          vertical: SpacingsDS.xs,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (item.icon != null) ...[
              Icon(item.icon,
                  size: 16,
                  color: item.isActive ? ColorsDS.primary : ColorsDS.gray600),
              const SizedBox(width: 4),
            ],
            Text(
              item.label,
              style: TypographyDS.body.copyWith(
                color: item.isActive ? ColorsDS.primary : ColorsDS.gray700,
                fontWeight: item.isActive
                    ? TypographyDS.weightSemi
                    : TypographyDS.weightNormal,
              ),
            ),
            if (item.badge != null) ...[
              const SizedBox(width: 4),
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
  }
}
