import 'package:design_system_mobile/design_system.dart';

/// CpCheckbox — Equivalente a <input type="checkbox"> de Bootstrap
///
/// ```dart
/// CpCheckbox(
///   label: 'Acepto los términos',
///   value: _checked,
///   onChanged: (val) => setState(() => _checked = val ?? false),
/// )
///
/// CpCheckbox(label: 'Deshabilitado', value: true, enabled: false, onChanged: null)
/// ```
class CpCheckbox extends StatelessWidget {
  const CpCheckbox({
    super.key,
    required this.value,
    required this.onChanged,
    this.label,
    this.helpText,
    this.errorText,
    this.enabled = true,
    this.tristate = false,
  });

  final bool? value;
  final ValueChanged<bool?>? onChanged;
  final String? label;
  final String? helpText;
  final String? errorText;
  final bool enabled;
  final bool tristate;

  bool get _hasError => errorText != null && errorText!.isNotEmpty;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        // ─── Checkbox + Label ──────────────────────────────────────────────────
        InkWell(
          onTap: enabled && onChanged != null
              ? () => onChanged!(value == true ? false : true)
              : null,
          borderRadius: BorderRadius.circular(4),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: SpacingsDS.xs),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  width: SizesDS.touchTarget / 2,
                  height: SizesDS.touchTarget / 2,
                  child: Checkbox(
                    value: value,
                    onChanged: enabled ? onChanged : null,
                    tristate: tristate,
                    activeColor: ColorsDS.primary,
                    checkColor: ColorsDS.white,
                    side: BorderSide(
                      color: _hasError
                          ? StatesDS.errorBorder
                          : (enabled ? ColorsDS.gray400 : StatesDS.disabledBorder),
                    ),
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    visualDensity: VisualDensity.compact,
                  ),
                ),
                if (label != null) ...[
                  const SizedBox(width: SpacingsDS.sm),
                  Flexible(
                    child: Text(
                      label!,
                      style: TypographyDS.body.copyWith(
                        color: enabled ? ColorsDS.bodyColor : StatesDS.disabledFg,
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),

        // ─── Help / Error ──────────────────────────────────────────────────────
        if (_hasError) ...[
          const SizedBox(height: SpacingsDS.xs),
          Row(children: [
            const SizedBox(width: SpacingsDS.md),
            Icon(Icons.error_outline, size: 12, color: StatesDS.errorFg),
            const SizedBox(width: 4),
            Text(errorText!, style: TypographyDS.caption.copyWith(color: StatesDS.errorFg)),
          ]),
        ] else if (helpText != null) ...[
          const SizedBox(height: SpacingsDS.xs),
          Padding(
            padding: const EdgeInsets.only(left: SpacingsDS.md),
            child: Text(helpText!, style: TypographyDS.caption),
          ),
        ],
      ],
    );
  }
}
