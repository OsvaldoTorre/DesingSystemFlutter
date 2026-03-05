import 'package:design_system_mobile/design_system.dart';

/// CpBottomSheet — Panel deslizante desde la parte inferior.
/// Organism para acciones contextuales, filtros o formularios en móvil.
///
/// Uso via helper estático:
/// ```dart
/// CpBottomSheet.show(
///   context,
///   title: 'Filtros',
///   child: FilterForm(),
/// )
///
/// // Modal (no se cierra al tocar fuera)
/// CpBottomSheet.show(
///   context,
///   title: 'Confirmar',
///   isModal: true,
///   child: ConfirmContent(),
///   actions: [
///     CpButton(label: 'Aceptar', onPressed: () => Navigator.pop(context)),
///   ],
/// )
/// ```
class CpBottomSheet extends StatelessWidget {
  const CpBottomSheet({
    super.key,
    this.title,
    required this.child,
    this.actions = const [],
    this.showHandle = true,
    this.showCloseButton = true,
    this.maxHeightFactor = 0.9,
    this.initialHeightFactor,
  });

  final String? title;
  final Widget child;
  final List<Widget> actions;
  final bool showHandle;
  final bool showCloseButton;

  /// Fracción máxima de la pantalla que puede ocupar (0.0 - 1.0)
  final double maxHeightFactor;

  /// Fracción inicial de altura (null = wrap content)
  final double? initialHeightFactor;

  /// Abre el BottomSheet
  static Future<T?> show<T>(
    BuildContext context, {
    String? title,
    required Widget child,
    List<Widget> actions = const [],
    bool isModal = false,
    bool showHandle = true,
    bool showCloseButton = true,
    double maxHeightFactor = 0.9,
    double? initialHeightFactor,
  }) {
    return showModalBottomSheet<T>(
      context: context,
      isDismissible: !isModal,
      enableDrag: !isModal,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => CpBottomSheet(
        title: title,
        child: child,
        actions: actions,
        showHandle: showHandle,
        showCloseButton: showCloseButton && isModal,
        maxHeightFactor: maxHeightFactor,
        initialHeightFactor: initialHeightFactor,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.sizeOf(context).height;

    return Container(
      constraints: BoxConstraints(
        maxHeight: screenHeight * maxHeightFactor,
      ),
      decoration: BoxDecoration(
        color: ColorsDS.white,
        borderRadius: const BorderRadius.vertical(
          top: Radius.circular(RadiusDS.lg),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // ─── Handle ──────────────────────────────────────────────────────
          if (showHandle)
            Center(
              child: Container(
                margin: const EdgeInsets.only(top: SpacingsDS.sm),
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: ColorsDS.gray300,
                  borderRadius: RadiusDS.borderPill,
                ),
              ),
            ),

          // ─── Header ──────────────────────────────────────────────────────
          if (title != null || showCloseButton) ...[
            Padding(
              padding: const EdgeInsets.fromLTRB(
                SpacingsDS.md, SpacingsDS.sm, SpacingsDS.sm, SpacingsDS.sm,
              ),
              child: Row(
                children: [
                  if (title != null)
                    Expanded(child: Text(title!, style: TypographyDS.h5)),
                  if (showCloseButton)
                    IconButton(
                      icon: const Icon(Icons.close, size: 20),
                      color: ColorsDS.gray500,
                      onPressed: () => Navigator.of(context).pop(),
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(),
                    ),
                ],
              ),
            ),
            const CpDivider(),
          ],

          // ─── Content ──────────────────────────────────────────────────────
          Flexible(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(SpacingsDS.md),
              child: child,
            ),
          ),

          // ─── Actions ──────────────────────────────────────────────────────
          if (actions.isNotEmpty) ...[
            const CpDivider(),
            Padding(
              padding: EdgeInsets.fromLTRB(
                SpacingsDS.md,
                SpacingsDS.sm,
                SpacingsDS.md,
                SpacingsDS.md + MediaQuery.of(context).padding.bottom,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: actions
                    .map((a) => Padding(
                          padding: const EdgeInsets.only(left: SpacingsDS.sm),
                          child: a,
                        ))
                    .toList(),
              ),
            ),
          ] else
            SizedBox(height: MediaQuery.of(context).padding.bottom),
        ],
      ),
    );
  }
}
