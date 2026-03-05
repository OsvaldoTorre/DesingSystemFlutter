import 'package:design_system_mobile/design_system.dart';

/// Posición del drawer
enum DrawerPositionDS { left, right }

/// CpDrawer — Panel lateral deslizante con overlay.
/// Organism para navegación móvil o paneles de configuración.
///
/// Uso via helper estático:
/// ```dart
/// CpDrawer.show(
///   context,
///   title: 'Menú',
///   child: Column(children: [...navItems]),
/// )
///
/// // O como widget en Scaffold
/// Scaffold(
///   drawer: CpDrawer(
///     title: 'Navegación',
///     child: mySidebarContent,
///   ),
/// )
/// ```
class CpDrawer extends StatelessWidget {
  const CpDrawer({
    super.key,
    this.title,
    required this.child,
    this.header,
    this.footer,
    this.position = DrawerPositionDS.left,
    this.width,
    this.backgroundColor,
    this.showCloseButton = true,
  });

  final String? title;
  final Widget child;
  final Widget? header;
  final Widget? footer;
  final DrawerPositionDS position;
  final double? width;
  final Color? backgroundColor;
  final bool showCloseButton;

  /// Abre el drawer como bottom sheet lateral usando showGeneralDialog
  static Future<void> show(
    BuildContext context, {
    String? title,
    required Widget child,
    Widget? header,
    Widget? footer,
    DrawerPositionDS position = DrawerPositionDS.left,
    double? width,
  }) {
    return showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: 'Drawer',
      barrierColor: Colors.black.withValues(alpha: 0.4),
      transitionDuration: const Duration(milliseconds: 300),
      pageBuilder: (ctx, _, __) => Align(
        alignment: position == DrawerPositionDS.left
            ? Alignment.centerLeft
            : Alignment.centerRight,
        child: CpDrawer(
          title: title,
          child: child,
          header: header,
          footer: footer,
          position: position,
          width: width,
        ),
      ),
      transitionBuilder: (ctx, anim, _, child) {
        final offset = position == DrawerPositionDS.left
            ? Offset(anim.value - 1, 0)
            : Offset(1 - anim.value, 0);
        return SlideTransition(
          position: Tween<Offset>(begin: offset, end: Offset.zero)
              .animate(CurvedAnimation(
                  parent: anim, curve: Curves.easeOut)),
          child: child,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final bg = backgroundColor ?? ColorsDS.white;
    final drawerWidth = width ?? SizesDS.sidebarExpanded;

    return Material(
      color: Colors.transparent,
      child: Container(
        width: drawerWidth,
        height: double.infinity,
        decoration: BoxDecoration(
          color: bg,
          boxShadow: ShadowsDS.xl,
        ),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // ─── Header ────────────────────────────────────────────────────
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: SpacingsDS.sm,
                  vertical: SpacingsDS.xs,
                ),
                child: Row(
                  children: [
                    if (showCloseButton)
                      IconButton(
                        icon: const Icon(Icons.close),
                        color: ColorsDS.gray600,
                        onPressed: () => Navigator.of(context).pop(),
                      ),
                    if (title != null)
                      Expanded(
                        child: Text(title!, style: TypographyDS.h5),
                      ),
                    if (header != null) header!,
                  ],
                ),
              ),

              const CpDivider(),

              // ─── Content ───────────────────────────────────────────────────
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(SpacingsDS.sm),
                  child: child,
                ),
              ),

              // ─── Footer ────────────────────────────────────────────────────
              if (footer != null) ...[
                const CpDivider(),
                Padding(
                  padding: const EdgeInsets.all(SpacingsDS.md),
                  child: footer!,
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
