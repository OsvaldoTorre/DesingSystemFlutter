import 'package:design_system_mobile/design_system.dart';

/// CpSwitch — Equivalente a toggle switch / .form-check .form-switch de Bootstrap
///
/// ```dart
/// CpSwitch(
///   label: 'Notificaciones',
///   value: _enabled,
///   onChanged: (val) => setState(() => _enabled = val),
/// )
///
/// CpSwitch(label: 'Modo oscuro', value: true, enabled: false, onChanged: null)
/// ```
class CpSwitch extends StatelessWidget {
  const CpSwitch({
    super.key,
    required this.value,
    required this.onChanged,
    this.label,
    this.helpText,
    this.enabled = true,
    this.labelPosition = SwitchLabelPosition.right,
  });

  final bool value;
  final ValueChanged<bool>? onChanged;
  final String? label;
  final String? helpText;
  final bool enabled;
  final SwitchLabelPosition labelPosition;

  @override
  Widget build(BuildContext context) {
    final switchWidget = Switch(
      value: value,
      onChanged: enabled ? onChanged : null,
      activeColor: ColorsDS.white,
      activeTrackColor: ColorsDS.primary,
      inactiveThumbColor: ColorsDS.white,
      inactiveTrackColor: ColorsDS.gray400,
      trackOutlineColor: const MaterialStatePropertyAll(Colors.transparent),
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
    );

    final labelWidget = label != null
        ? Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                label!,
                style: TypographyDS.body.copyWith(
                  color: enabled ? ColorsDS.bodyColor : StatesDS.disabledFg,
                ),
              ),
              if (helpText != null)
                Text(helpText!, style: TypographyDS.caption),
            ],
          )
        : null;

    return InkWell(
      onTap: enabled && onChanged != null ? () => onChanged!(!value) : null,
      borderRadius: BorderRadius.circular(4),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: SpacingsDS.xs),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (labelPosition == SwitchLabelPosition.left && labelWidget != null) ...[
              labelWidget,
              const SizedBox(width: SpacingsDS.sm),
            ],
            switchWidget,
            if (labelPosition == SwitchLabelPosition.right && labelWidget != null) ...[
              const SizedBox(width: SpacingsDS.sm),
              labelWidget,
            ],
          ],
        ),
      ),
    );
  }
}

enum SwitchLabelPosition { left, right }
