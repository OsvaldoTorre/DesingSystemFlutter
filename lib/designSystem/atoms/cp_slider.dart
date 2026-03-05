import 'package:design_system_mobile/design_system.dart';

/// CpSlider — Control deslizante para valores numéricos.
///
/// ```dart
/// CpSlider(
///   value: _volume,
///   onChanged: (val) => setState(() => _volume = val),
/// )
///
/// CpSlider(
///   label: 'Brillo',
///   value: _brightness,
///   min: 0, max: 100, divisions: 10,
///   showValue: true,
///   onChanged: (val) => setState(() => _brightness = val),
/// )
/// ```
class CpSlider extends StatelessWidget {
  const CpSlider({
    super.key,
    required this.value,
    required this.onChanged,
    this.label,
    this.min = 0.0,
    this.max = 1.0,
    this.divisions,
    this.showValue = false,
    this.enabled = true,
    this.color,
  });

  final double value;
  final ValueChanged<double>? onChanged;
  final String? label;
  final double min;
  final double max;
  final int? divisions;
  final bool showValue;
  final bool enabled;
  final Color? color;

  String get _displayValue {
    if (divisions != null) return value.toInt().toString();
    return value.toStringAsFixed(1);
  }

  @override
  Widget build(BuildContext context) {
    final activeColor = color ?? ColorsDS.primary;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (label != null || showValue) ...[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              if (label != null)
                Text(
                  label!,
                  style: TypographyDS.label.copyWith(
                    color: enabled ? ColorsDS.gray700 : StatesDS.disabledFg,
                  ),
                ),
              if (showValue)
                Text(_displayValue, style: TypographyDS.label),
            ],
          ),
          const SizedBox(height: SpacingsDS.xs),
        ],
        SliderTheme(
          data: SliderTheme.of(context).copyWith(
            activeTrackColor: enabled ? activeColor : StatesDS.disabledBg,
            inactiveTrackColor: enabled ? ColorsDS.gray300 : StatesDS.disabledBg,
            thumbColor: enabled ? activeColor : StatesDS.disabledFg,
            overlayColor: activeColor.withValues(alpha: 0.12),
            trackHeight: 4,
          ),
          child: Slider(
            value: value.clamp(min, max),
            min: min,
            max: max,
            divisions: divisions,
            onChanged: enabled ? onChanged : null,
          ),
        ),
      ],
    );
  }
}
