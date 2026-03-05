import 'package:design_system_mobile/design_system.dart';

/// CpRadio — Equivalente a <input type="radio"> de Bootstrap.
/// Usar dentro de CpRadioGroup para manejar la selección.
///
/// ```dart
/// CpRadioGroup<String>(
///   value: _selected,
///   onChanged: (val) => setState(() => _selected = val),
///   items: [
///     CpRadioItem(value: 'a', label: 'Opción A'),
///     CpRadioItem(value: 'b', label: 'Opción B'),
///     CpRadioItem(value: 'c', label: 'Opción C', enabled: false),
///   ],
/// )
/// ```
class CpRadioGroup<T> extends StatelessWidget {
  const CpRadioGroup({
    super.key,
    required this.value,
    required this.onChanged,
    required this.items,
    this.direction = Axis.vertical,
  });

  final T? value;
  final ValueChanged<T?> onChanged;
  final List<CpRadioItem<T>> items;
  final Axis direction;

  @override
  Widget build(BuildContext context) {
    final children = items.map((item) =>
      _CpRadioTile<T>(
        item: item,
        groupValue: value,
        onChanged: onChanged,
      ),
    ).toList();

    if (direction == Axis.horizontal) {
      return Wrap(spacing: SpacingsDS.md, children: children);
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: children,
    );
  }
}

/// Modelo de item para CpRadioGroup
class CpRadioItem<T> {
  const CpRadioItem({
    required this.value,
    required this.label,
    this.helpText,
    this.enabled = true,
  });

  final T value;
  final String label;
  final String? helpText;
  final bool enabled;
}

class _CpRadioTile<T> extends StatelessWidget {
  const _CpRadioTile({
    required this.item,
    required this.groupValue,
    required this.onChanged,
  });

  final CpRadioItem<T> item;
  final T? groupValue;
  final ValueChanged<T?> onChanged;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: item.enabled ? () => onChanged(item.value) : null,
      borderRadius: BorderRadius.circular(4),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: SpacingsDS.xs),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              width: SizesDS.touchTarget / 2,
              height: SizesDS.touchTarget / 2,
              child: Radio<T>(
                value: item.value,
                groupValue: groupValue,
                onChanged: item.enabled ? onChanged : null,
                activeColor: ColorsDS.primary,
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                visualDensity: VisualDensity.compact,
              ),
            ),
            const SizedBox(width: SpacingsDS.sm),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  item.label,
                  style: TypographyDS.body.copyWith(
                    color: item.enabled ? ColorsDS.bodyColor : StatesDS.disabledFg,
                  ),
                ),
                if (item.helpText != null)
                  Text(item.helpText!, style: TypographyDS.caption),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
