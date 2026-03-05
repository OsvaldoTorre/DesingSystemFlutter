import 'package:design_system_mobile/design_system.dart';

/// CpListGroup — Lista estilizada con avatar, acciones y estados.
/// Organism equivalente a .list-group de Bootstrap.
///
/// ```dart
/// CpListGroup(
///   items: [
///     CpListItem(
///       title: 'Juan García',
///       subtitle: 'Administrador',
///       avatar: CpAvatar(name: 'Juan García'),
///       trailing: CpBadge(label: 'Activo', variant: VariantDS.success),
///       onTap: () {},
///     ),
///   ],
/// )
/// ```
class CpListGroup extends StatelessWidget {
  const CpListGroup({
    super.key,
    required this.items,
    this.flush = false,
    this.divided = true,
  });

  final List<CpListItem> items;

  /// true → sin bordes exteriores
  final bool flush;

  /// true → divisor entre items
  final bool divided;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: flush
          ? null
          : BoxDecoration(
              border: Border.all(color: ColorsDS.gray200),
              borderRadius: RadiusDS.borderMd,
            ),
      clipBehavior: flush ? Clip.none : Clip.antiAlias,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: items.asMap().entries.map((e) {
          final isLast = e.key == items.length - 1;
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              e.value,
              if (divided && !isLast)
                const Divider(height: 1, color: ColorsDS.gray200),
            ],
          );
        }).toList(),
      ),
    );
  }
}

/// CpListItem — Item individual de CpListGroup
class CpListItem extends StatelessWidget {
  const CpListItem({
    super.key,
    required this.title,
    this.subtitle,
    this.description,
    this.leading,
    this.avatar,
    this.trailing,
    this.onTap,
    this.isActive = false,
    this.enabled = true,
    this.padding,
  });

  final String title;
  final String? subtitle;
  final String? description;
  final Widget? leading;
  final CpAvatar? avatar;
  final Widget? trailing;
  final VoidCallback? onTap;
  final bool isActive;
  final bool enabled;
  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: enabled ? onTap : null,
      child: Container(
        padding: padding ??
            const EdgeInsets.symmetric(
              horizontal: SpacingsDS.md,
              vertical: SpacingsDS.sm,
            ),
        color: isActive
            ? ColorsDS.primarySubtle
            : (enabled ? null : ColorsDS.gray100),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // ─── Leading / Avatar ────────────────────────────────────────────
            if (leading != null) ...[
              leading!,
              const SizedBox(width: SpacingsDS.sm),
            ] else if (avatar != null) ...[
              avatar!,
              const SizedBox(width: SpacingsDS.sm),
            ],

            // ─── Contenido ───────────────────────────────────────────────────
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (subtitle != null)
                    Text(
                      subtitle!,
                      style: TypographyDS.caption.copyWith(
                        letterSpacing: 0.5,
                        color: isActive
                            ? ColorsDS.primaryEmphasis
                            : ColorsDS.gray500,
                      ),
                    ),
                  Text(
                    title,
                    style: TypographyDS.body.copyWith(
                      fontWeight: TypographyDS.weightMedium,
                      color: isActive
                          ? ColorsDS.primaryEmphasis
                          : (enabled ? ColorsDS.bodyColor : ColorsDS.gray500),
                    ),
                  ),
                  if (description != null)
                    Text(
                      description!,
                      style: TypographyDS.small,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                ],
              ),
            ),

            // ─── Trailing ────────────────────────────────────────────────────
            if (trailing != null) ...[
              const SizedBox(width: SpacingsDS.sm),
              trailing!,
            ] else if (onTap != null) ...[
              const SizedBox(width: SpacingsDS.sm),
              Icon(Icons.chevron_right, size: 18, color: ColorsDS.gray400),
            ],
          ],
        ),
      ),
    );
  }
}
