import 'package:design_system_mobile/design_system.dart';

/// CpEmptyState — Icono + título + descripción + acción opcional.
/// Molecule que combina CpIcon, CpText y CpButton para comunicar
/// estados vacíos, errores o resultados sin datos.
///
/// ```dart
/// // Sin resultados
/// CpEmptyState(
///   icon: Icons.search_off,
///   title: 'Sin resultados',
///   description: 'Intenta con otros términos de búsqueda.',
/// )
///
/// // Con acción
/// CpEmptyState(
///   icon: Icons.folder_open,
///   title: 'No hay proyectos',
///   description: 'Crea tu primer proyecto para comenzar.',
///   actionLabel: 'Crear proyecto',
///   onAction: () => _crearProyecto(),
/// )
/// ```
class CpEmptyState extends StatelessWidget {
  const CpEmptyState({
    super.key,
    required this.title,
    this.icon,
    this.description,
    this.actionLabel,
    this.onAction,
    this.secondaryActionLabel,
    this.onSecondaryAction,
    this.iconColor,
    this.compact = false,
  });

  final String title;
  final IconData? icon;
  final String? description;
  final String? actionLabel;
  final VoidCallback? onAction;
  final String? secondaryActionLabel;
  final VoidCallback? onSecondaryAction;
  final Color? iconColor;

  /// true → versión más pequeña para usar dentro de listas o cards
  final bool compact;

  @override
  Widget build(BuildContext context) {
    final iconSize  = compact ? SizesDS.iconStandalone : SizesDS.iconHero;
    final titleStyle = compact ? TypographyDS.h6 : TypographyDS.h5;

    return Center(
      child: Padding(
        padding: EdgeInsets.all(compact ? SpacingsDS.md : SpacingsDS.xl),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (icon != null) ...[
              Icon(
                icon,
                size: iconSize,
                color: iconColor ?? ColorsDS.gray400,
              ),
              SizedBox(height: compact ? SpacingsDS.sm : SpacingsDS.md),
            ],

            Text(
              title,
              style: titleStyle,
              textAlign: TextAlign.center,
            ),

            if (description != null) ...[
              const SizedBox(height: SpacingsDS.xs),
              Text(
                description!,
                style: TypographyDS.body.copyWith(color: ColorsDS.gray500),
                textAlign: TextAlign.center,
              ),
            ],

            if (actionLabel != null && onAction != null) ...[
              SizedBox(height: compact ? SpacingsDS.md : SpacingsDS.lg),
              CpButton(
                label: actionLabel!,
                onPressed: onAction,
                size: compact ? ButtonSizeDS.sm : ButtonSizeDS.md,
              ),
            ],

            if (secondaryActionLabel != null && onSecondaryAction != null) ...[
              const SizedBox(height: SpacingsDS.sm),
              CpButton(
                label: secondaryActionLabel!,
                onPressed: onSecondaryAction,
                variant: ButtonVariantDS.outlinePrimary,
                size: compact ? ButtonSizeDS.sm : ButtonSizeDS.md,
              ),
            ],
          ],
        ),
      ),
    );
  }
}
