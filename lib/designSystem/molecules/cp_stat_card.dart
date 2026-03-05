import 'package:design_system_mobile/design_system.dart';

/// Dirección de tendencia
enum TrendDS { up, down, neutral }

/// CpStatCard — Tarjeta de estadística con valor, label y tendencia.
/// Es una molecule porque combina icono + valor + label + badge de tendencia.
///
/// ```dart
/// CpStatCard(
///   label: 'Ventas del mes',
///   value: '\$12,400',
///   trend: TrendDS.up,
///   trendLabel: '+8.2%',
///   icon: Icons.attach_money,
/// )
/// ```
class CpStatCard extends StatelessWidget {
  const CpStatCard({
    super.key,
    required this.label,
    required this.value,
    this.trend = TrendDS.neutral,
    this.trendLabel,
    this.icon,
    this.iconColor,
    this.backgroundColor,
    this.onTap,
  });

  final String label;
  final String value;
  final TrendDS trend;
  final String? trendLabel;
  final IconData? icon;
  final Color? iconColor;
  final Color? backgroundColor;
  final VoidCallback? onTap;

  Color get _trendColor => switch (trend) {
    TrendDS.up      => ColorsDS.success,
    TrendDS.down    => ColorsDS.danger,
    TrendDS.neutral => ColorsDS.gray500,
  };

  IconData get _trendIcon => switch (trend) {
    TrendDS.up      => Icons.trending_up,
    TrendDS.down    => Icons.trending_down,
    TrendDS.neutral => Icons.trending_flat,
  };

  @override
  Widget build(BuildContext context) {
    final bg = backgroundColor ?? ColorsDS.white;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(SpacingsDS.md),
        decoration: BoxDecoration(
          color: bg,
          borderRadius: RadiusDS.borderMd,
          border: Border.all(color: ColorsDS.gray200),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            // ─── Label + Icono ───────────────────────────────────────────────
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    label,
                    style: TypographyDS.caption.copyWith(
                      letterSpacing: 0.5,
                      color: ColorsDS.gray600,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                if (icon != null) ...[
                  const SizedBox(width: SpacingsDS.sm),
                  Container(
                    padding: const EdgeInsets.all(SpacingsDS.sm),
                    decoration: BoxDecoration(
                      color: (iconColor ?? ColorsDS.primary).withValues(alpha: 0.1),
                      borderRadius: RadiusDS.borderSm,
                    ),
                    child: Icon(
                      icon,
                      size: 18,
                      color: iconColor ?? ColorsDS.primary,
                    ),
                  ),
                ],
              ],
            ),

            const SizedBox(height: SpacingsDS.sm),

            // ─── Valor principal ─────────────────────────────────────────────
            Text(
              value,
              style: TypographyDS.h4.copyWith(fontWeight: TypographyDS.weightBold),
            ),

            // ─── Tendencia ───────────────────────────────────────────────────
            if (trendLabel != null) ...[
              const SizedBox(height: SpacingsDS.xs),
              Row(
                children: [
                  Icon(_trendIcon, size: 14, color: _trendColor),
                  const SizedBox(width: 2),
                  Text(
                    trendLabel!,
                    style: TypographyDS.caption.copyWith(
                      color: _trendColor,
                      fontWeight: TypographyDS.weightMedium,
                    ),
                  ),
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }
}
