import 'package:design_system_mobile/design_system.dart';

/// CpForm — Formulario completo con validación, secciones y acciones.
/// Organism que agrupa CpFormFields con lógica de submit y estado de carga.
///
/// ```dart
/// CpForm(
///   title: 'Crear cuenta',
///   onSubmit: () async {
///     await _register();
///   },
///   submitLabel: 'Registrarse',
///   children: [
///     CpFormField(label: 'Nombre', required: true, validator: (v) => v!.isEmpty ? 'Requerido' : null),
///     CpFormField(label: 'Email', required: true, keyboardType: TextInputType.emailAddress),
///     CpFormField(label: 'Contraseña', obscureText: true),
///   ],
/// )
/// ```
class CpForm extends StatefulWidget {
  const CpForm({
    super.key,
    required this.children,
    this.title,
    this.subtitle,
    this.onSubmit,
    this.onCancel,
    this.submitLabel = 'Guardar',
    this.cancelLabel = 'Cancelar',
    this.loading = false,
    this.spacing = SpacingsDS.md,
    this.showDivider = false,
    this.submitVariant = ButtonVariantDS.primary,
  });

  final List<Widget> children;
  final String? title;
  final String? subtitle;
  final Future<void> Function()? onSubmit;
  final VoidCallback? onCancel;
  final String submitLabel;
  final String cancelLabel;
  final bool loading;
  final double spacing;
  final bool showDivider;
  final ButtonVariantDS submitVariant;

  @override
  State<CpForm> createState() => _CpFormState();
}

class _CpFormState extends State<CpForm> {
  final _formKey = GlobalKey<FormState>();
  bool _submitting = false;

  Future<void> _handleSubmit() async {
    if (_formKey.currentState?.validate() ?? true) {
      setState(() => _submitting = true);
      try {
        await widget.onSubmit?.call();
      } finally {
        if (mounted) setState(() => _submitting = false);
      }
    }
  }

  bool get _isLoading => widget.loading || _submitting;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [
          // ─── Título ─────────────────────────────────────────────────────────
          if (widget.title != null) ...[
            Text(widget.title!, style: TypographyDS.h5),
            if (widget.subtitle != null) ...[
              const SizedBox(height: SpacingsDS.xs),
              Text(
                widget.subtitle!,
                style: TypographyDS.body.copyWith(color: ColorsDS.gray500),
              ),
            ],
            SizedBox(height: widget.spacing),
          ],

          // ─── Campos ────────────────────────────────────────────────────────
          ...widget.children.expand((child) => [
            child,
            SizedBox(height: widget.spacing),
          ]),

          // ─── Divider opcional ──────────────────────────────────────────────
          if (widget.showDivider) ...[
            const CpDivider(),
            const SizedBox(height: SpacingsDS.md),
          ],

          // ─── Acciones ──────────────────────────────────────────────────────
          if (widget.onSubmit != null || widget.onCancel != null)
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                if (widget.onCancel != null) ...[
                  CpButton(
                    label: widget.cancelLabel,
                    variant: ButtonVariantDS.outlinePrimary,
                    onPressed: _isLoading ? null : widget.onCancel,
                  ),
                  const SizedBox(width: SpacingsDS.sm),
                ],
                if (widget.onSubmit != null)
                  _isLoading
                      ? const CpSpinner(size: SpinnerSizeDS.md)
                      : CpButton(
                          label: widget.submitLabel,
                          variant: widget.submitVariant,
                          onPressed: _handleSubmit,
                        ),
              ],
            ),
        ],
      ),
    );
  }
}

/// CpFormSection — Agrupa campos relacionados con título y descripción.
///
/// ```dart
/// CpFormSection(
///   title: 'Información personal',
///   description: 'Datos básicos de tu perfil',
///   children: [
///     CpFormField(label: 'Nombre'),
///     CpFormField(label: 'Apellido'),
///   ],
/// )
/// ```
class CpFormSection extends StatelessWidget {
  const CpFormSection({
    super.key,
    required this.children,
    this.title,
    this.description,
    this.spacing = SpacingsDS.md,
  });

  final List<Widget> children;
  final String? title;
  final String? description;
  final double spacing;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (title != null) ...[
          Text(title!, style: TypographyDS.h6),
          if (description != null) ...[
            const SizedBox(height: SpacingsDS.xs),
            Text(
              description!,
              style: TypographyDS.small,
            ),
          ],
          SizedBox(height: spacing),
        ],
        ...children.expand((c) => [c, SizedBox(height: spacing)]),
      ],
    );
  }
}
