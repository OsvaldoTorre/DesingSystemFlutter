import 'package:design_system_mobile/design_system.dart';

/// CpFormField — Label + CpInput + helpText + errorText en un bloque semántico.
/// Es una molecule porque combina un label, un atom (CpInput) y textos de apoyo
/// con lógica de validación integrada.
///
/// ```dart
/// CpFormField(
///   label: 'Correo electrónico',
///   hint: 'nombre@empresa.com',
///   required: true,
///   prefixIcon: Icons.email_outlined,
///   keyboardType: TextInputType.emailAddress,
///   validator: (val) => val!.contains('@') ? null : 'Email inválido',
///   onChanged: (val) => _email = val,
/// )
/// ```
class CpFormField extends StatefulWidget {
  const CpFormField({
    super.key,
    this.label,
    this.hint,
    this.helpText,
    this.controller,
    this.onChanged,
    this.onSubmitted,
    this.validator,
    this.obscureText = false,
    this.enabled = true,
    this.readOnly = false,
    this.required = false,
    this.size = InputSizeDS.md,
    this.prefixIcon,
    this.suffixIcon,
    this.onSuffixTap,
    this.keyboardType,
    this.maxLines = 1,
    this.minLines,
    this.textInputAction,
    this.autofocus = false,
  });

  final String? label;
  final String? hint;
  final String? helpText;
  final TextEditingController? controller;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onSubmitted;

  /// Función de validación — retorna mensaje de error o null si es válido
  final String? Function(String?)? validator;

  final bool obscureText;
  final bool enabled;
  final bool readOnly;

  /// true → muestra asterisco rojo junto al label
  final bool required;

  final InputSizeDS size;
  final IconData? prefixIcon;
  final IconData? suffixIcon;
  final VoidCallback? onSuffixTap;
  final TextInputType? keyboardType;
  final int? maxLines;
  final int? minLines;
  final TextInputAction? textInputAction;
  final bool autofocus;

  @override
  State<CpFormField> createState() => _CpFormFieldState();
}

class _CpFormFieldState extends State<CpFormField> {
  late TextEditingController _controller;
  String? _errorText;
  bool _isDirty = false;

  @override
  void initState() {
    super.initState();
    _controller = widget.controller ?? TextEditingController();
  }

  @override
  void dispose() {
    if (widget.controller == null) _controller.dispose();
    super.dispose();
  }

  void _validate(String value) {
    if (!_isDirty) setState(() => _isDirty = true);
    if (widget.validator != null) {
      setState(() => _errorText = widget.validator!(value));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        // ─── Label con indicador de requerido ─────────────────────────────────
        if (widget.label != null) ...[
          Row(
            children: [
              Text(
                widget.label!,
                style: TypographyDS.label.copyWith(
                  color: widget.enabled ? ColorsDS.gray700 : StatesDS.disabledFg,
                ),
              ),
              if (widget.required) ...[
                const SizedBox(width: 2),
                Text(
                  '*',
                  style: TypographyDS.label.copyWith(color: ColorsDS.danger),
                ),
              ],
            ],
          ),
          const SizedBox(height: SpacingsDS.xs),
        ],

        // ─── Input ────────────────────────────────────────────────────────────
        CpInput(
          hint: widget.hint,
          controller: _controller,
          onChanged: (val) {
            _validate(val);
            widget.onChanged?.call(val);
          },
          onSubmitted: widget.onSubmitted,
          obscureText: widget.obscureText,
          enabled: widget.enabled,
          readOnly: widget.readOnly,
          size: widget.size,
          prefixIcon: widget.prefixIcon,
          suffixIcon: widget.suffixIcon,
          onSuffixTap: widget.onSuffixTap,
          keyboardType: widget.keyboardType,
          maxLines: widget.maxLines,
          minLines: widget.minLines,
          textInputAction: widget.textInputAction,
          autofocus: widget.autofocus,
          errorText: _isDirty ? _errorText : null,
        ),

        // ─── Help text (solo si no hay error) ────────────────────────────────
        if ((_errorText == null || !_isDirty) && widget.helpText != null) ...[
          const SizedBox(height: SpacingsDS.xs),
          Text(widget.helpText!, style: TypographyDS.caption),
        ],
      ],
    );
  }
}
