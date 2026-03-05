import 'package:design_system_mobile/design_system.dart';
/// Tamaños de input
enum InputSizeDS { sm, md, lg }

/// CpInput — Equivalente a <input class="form-control"> de Bootstrap
///
/// ```dart
/// CpInput(label: 'Email', hint: 'nombre@empresa.com')
/// CpInput(label: 'Contraseña', obscureText: true, errorText: 'Mínimo 8 caracteres')
/// CpInput(label: 'Buscar', prefixIcon: Icons.search, size: InputSizeDS.lg)
/// ```
class CpInput extends StatefulWidget {
  const CpInput({
    super.key,
    this.label,
    this.hint,
    this.helpText,
    this.errorText,
    this.controller,
    this.onChanged,
    this.onSubmitted,
    this.obscureText = false,
    this.enabled = true,
    this.readOnly = false,
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
  final String? errorText;
  final TextEditingController? controller;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onSubmitted;
  final bool obscureText;
  final bool enabled;
  final bool readOnly;
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
  State<CpInput> createState() => _CpInputState();
}

class _CpInputState extends State<CpInput> {
  late bool _obscure;

  @override
  void initState() {
    super.initState();
    _obscure = widget.obscureText;
  }

  _SizeConfig get _cfg => switch (widget.size) {
    InputSizeDS.sm => _SizeConfig(fontSize: TypographyDS.fontSizeSm,  height: SizesDS.inputSm, hPad: 10, vPad: 4),
    InputSizeDS.md => _SizeConfig(fontSize: TypographyDS.fontSizeBase, height: SizesDS.inputMd, hPad: 12, vPad: 6),
    InputSizeDS.lg => _SizeConfig(fontSize: TypographyDS.fontSizeLg,  height: SizesDS.inputLg, hPad: 16, vPad: 8),
  };

  bool get _hasError => widget.errorText != null && widget.errorText!.isNotEmpty;

  @override
  Widget build(BuildContext context) {
    final cfg = _cfg;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        // ─── Label ────────────────────────────────────────────────────────────
        if (widget.label != null) ...[
          Text(
            widget.label!,
            style: TypographyDS.label.copyWith(
              color: widget.enabled ? ColorsDS.gray700 : StatesDS.disabledFg,
            ),
          ),
          const SizedBox(height: SpacingsDS.xs),
        ],

        // ─── Field ────────────────────────────────────────────────────────────
        SizedBox(
          height: widget.maxLines == 1 ? cfg.height : null,
          child: TextField(
            controller: widget.controller,
            onChanged: widget.onChanged,
            onSubmitted: widget.onSubmitted,
            obscureText: _obscure,
            enabled: widget.enabled,
            readOnly: widget.readOnly,
            keyboardType: widget.keyboardType,
            maxLines: _obscure ? 1 : widget.maxLines,
            minLines: widget.minLines,
            textInputAction: widget.textInputAction,
            autofocus: widget.autofocus,
            style: TextStyle(
              fontSize: cfg.fontSize,
              color: widget.enabled ? ColorsDS.bodyColor : StatesDS.disabledFg,
            ),
            decoration: InputDecoration(
              hintText: widget.hint,
              hintStyle: TextStyle(fontSize: cfg.fontSize, color: ColorsDS.gray400),
              contentPadding: EdgeInsets.symmetric(horizontal: cfg.hPad, vertical: cfg.vPad),
              filled: true,
              fillColor: widget.enabled
                  ? (widget.readOnly ? ColorsDS.gray100 : ColorsDS.white)
                  : StatesDS.disabledBg,
              prefixIcon: widget.prefixIcon != null
                  ? Icon(widget.prefixIcon, size: cfg.fontSize + 2, color: ColorsDS.gray500)
                  : null,
              suffixIcon: _buildSuffix(cfg.fontSize),
              border: OutlineInputBorder(
                borderRadius: RadiusDS.borderMd,
                borderSide: const BorderSide(color: ColorsDS.gray400),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: RadiusDS.borderMd,
                borderSide: BorderSide(
                  color: _hasError ? StatesDS.errorBorder : ColorsDS.gray400,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: RadiusDS.borderMd,
                borderSide: BorderSide(
                  color: _hasError ? StatesDS.errorBorder : ColorsDS.primary,
                  width: 2,
                ),
              ),
              disabledBorder: OutlineInputBorder(
                borderRadius: RadiusDS.borderMd,
                borderSide: BorderSide(color: StatesDS.disabledBorder),
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: RadiusDS.borderMd,
                borderSide: BorderSide(color: StatesDS.errorBorder),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderRadius: RadiusDS.borderMd,
                borderSide: BorderSide(color: StatesDS.errorBorder, width: 2),
              ),
            ),
          ),
        ),

        // ─── Help / Error ─────────────────────────────────────────────────────
        if (_hasError) ...[
          const SizedBox(height: SpacingsDS.xs),
          Row(children: [
            Icon(Icons.error_outline, size: 12, color: StatesDS.errorFg),
            const SizedBox(width: 4),
            Text(
              widget.errorText!,
              style: TypographyDS.caption.copyWith(color: StatesDS.errorFg),
            ),
          ]),
        ] else if (widget.helpText != null) ...[
          const SizedBox(height: SpacingsDS.xs),
          Text(widget.helpText!, style: TypographyDS.caption),
        ],
      ],
    );
  }

  Widget? _buildSuffix(double fontSize) {
    if (widget.obscureText) {
      return GestureDetector(
        onTap: () => setState(() => _obscure = !_obscure),
        child: Icon(
          _obscure ? Icons.visibility_off_outlined : Icons.visibility_outlined,
          size: fontSize + 2,
          color: ColorsDS.gray500,
        ),
      );
    }
    if (widget.suffixIcon != null) {
      return GestureDetector(
        onTap: widget.onSuffixTap,
        child: Icon(widget.suffixIcon, size: fontSize + 2, color: ColorsDS.gray500),
      );
    }
    return null;
  }
}

class _SizeConfig {
  const _SizeConfig({
    required this.fontSize,
    required this.height,
    required this.hPad,
    required this.vPad,
  });
  final double fontSize;
  final double height;
  final double hPad;
  final double vPad;
}

/// CpTextArea — Equivalente a <textarea class="form-control">
class CpTextArea extends StatelessWidget {
  const CpTextArea({
    super.key,
    this.label,
    this.hint,
    this.helpText,
    this.errorText,
    this.controller,
    this.onChanged,
    this.minLines = 3,
    this.maxLines = 6,
    this.enabled = true,
  });

  final String? label;
  final String? hint;
  final String? helpText;
  final String? errorText;
  final TextEditingController? controller;
  final ValueChanged<String>? onChanged;
  final int minLines;
  final int? maxLines;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    return CpInput(
      label: label,
      hint: hint,
      helpText: helpText,
      errorText: errorText,
      controller: controller,
      onChanged: onChanged,
      minLines: minLines,
      maxLines: maxLines,
      enabled: enabled,
      keyboardType: TextInputType.multiline,
      textInputAction: TextInputAction.newline,
    );
  }
}
