import 'package:design_system_mobile/design_system.dart';

/// CpModal — Diálogo modal con backdrop, header, body y footer de acciones.
///
/// Uso via helper estático:
/// ```dart
/// CpModal.show(
///   context,
///   title: 'Confirmar eliminación',
///   content: Text('¿Estás seguro? Esta acción no se puede deshacer.'),
///   actions: [
///     CpButton(label: 'Cancelar', variant: ButtonVariantDS.outlinePrimary, onPressed: () => Navigator.pop(context)),
///     CpButton(label: 'Eliminar', variant: ButtonVariantDS.danger, onPressed: () {}),
///   ],
/// )
/// ```
class CpModal extends StatelessWidget {
  const CpModal({
    super.key,
    this.title,
    required this.content,
    this.actions = const [],
    this.size = ModalSizeDS.md,
    this.dismissible = true,
    this.showCloseButton = true,
    this.padding,
  });

  final String? title;
  final Widget content;
  final List<Widget> actions;
  final ModalSizeDS size;
  final bool dismissible;
  final bool showCloseButton;
  final EdgeInsetsGeometry? padding;

  double get _maxWidth => switch (size) {
    ModalSizeDS.sm => SizesDS.modalSm,
    ModalSizeDS.md => SizesDS.modalMd,
    ModalSizeDS.lg => SizesDS.modalLg,
  };

  /// Abre el modal como dialog
  static Future<T?> show<T>(
    BuildContext context, {
    String? title,
    required Widget content,
    List<Widget> actions = const [],
    ModalSizeDS size = ModalSizeDS.md,
    bool dismissible = true,
    bool showCloseButton = true,
  }) {
    return showDialog<T>(
      context: context,
      barrierDismissible: dismissible,
      barrierColor: Colors.black.withValues(alpha: 0.5),
      builder: (_) => CpModal(
        title: title,
        content: content,
        actions: actions,
        size: size,
        dismissible: dismissible,
        showCloseButton: showCloseButton,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      elevation: 0,
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: _maxWidth),
        child: Container(
          decoration: BoxDecoration(
            color: ColorsDS.white,
            borderRadius: RadiusDS.borderLg,
            boxShadow: ShadowsDS.xl,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // ─── Header ───────────────────────────────────────────────────
              if (title != null || showCloseButton)
                Padding(
                  padding: const EdgeInsets.fromLTRB(
                    SpacingsDS.md, SpacingsDS.md, SpacingsDS.sm, SpacingsDS.sm,
                  ),
                  child: Row(
                    children: [
                      if (title != null)
                        Expanded(
                          child: Text(title!, style: TypographyDS.h5),
                        ),
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

              if (title != null || showCloseButton) const CpDivider(),

              // ─── Content ──────────────────────────────────────────────────
              Flexible(
                child: SingleChildScrollView(
                  padding: padding ??
                      const EdgeInsets.all(SpacingsDS.md),
                  child: content,
                ),
              ),

              // ─── Actions ──────────────────────────────────────────────────
              if (actions.isNotEmpty) ...[
                const CpDivider(),
                Padding(
                  padding: const EdgeInsets.all(SpacingsDS.md),
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
              ],
            ],
          ),
        ),
      ),
    );
  }
}

enum ModalSizeDS { sm, md, lg }
