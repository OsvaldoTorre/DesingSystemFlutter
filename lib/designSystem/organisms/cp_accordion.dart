import 'package:design_system_mobile/design_system.dart';

/// Modelo de panel del accordion
class AccordionItemDS {
  const AccordionItemDS({
    required this.title,
    required this.content,
    this.subtitle,
    this.icon,
    this.initiallyExpanded = false,
  });

  final String title;
  final Widget content;
  final String? subtitle;
  final IconData? icon;
  final bool initiallyExpanded;
}

/// CpAccordion — Secciones colapsables animadas (FAQ, configuración).
/// Organism que gestiona el estado de expansión de múltiples paneles.
///
/// ```dart
/// CpAccordion(
///   items: [
///     AccordionItemDS(
///       title: '¿Cómo puedo cancelar?',
///       content: Text('Puedes cancelar en cualquier momento desde Ajustes.'),
///     ),
///     AccordionItemDS(
///       title: '¿Hay periodo de prueba?',
///       content: Text('Sí, 14 días gratis sin tarjeta.'),
///       initiallyExpanded: true,
///     ),
///   ],
/// )
/// ```
class CpAccordion extends StatefulWidget {
  const CpAccordion({
    super.key,
    required this.items,
    this.allowMultiple = false,
    this.flush = false,
  });

  final List<AccordionItemDS> items;

  /// true → permite múltiples paneles abiertos a la vez
  final bool allowMultiple;

  /// true → sin bordes laterales (estilo flush de Bootstrap)
  final bool flush;

  @override
  State<CpAccordion> createState() => _CpAccordionState();
}

class _CpAccordionState extends State<CpAccordion> {
  late List<bool> _expanded;

  @override
  void initState() {
    super.initState();
    _expanded = widget.items.map((i) => i.initiallyExpanded).toList();
  }

  void _toggle(int index) {
    setState(() {
      if (!widget.allowMultiple) {
        for (int i = 0; i < _expanded.length; i++) {
          _expanded[i] = i == index ? !_expanded[i] : false;
        }
      } else {
        _expanded[index] = !_expanded[index];
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: widget.items.asMap().entries.map((e) {
        final i    = e.key;
        final item = e.value;
        final isExpanded = _expanded[i];
        final isLast = i == widget.items.length - 1;

        return Container(
          decoration: BoxDecoration(
            border: widget.flush
                ? Border(
                    top: BorderSide(color: ColorsDS.gray200),
                    bottom: isLast ? BorderSide(color: ColorsDS.gray200) : BorderSide.none,
                  )
                : Border.all(color: ColorsDS.gray200),
            borderRadius: widget.flush ? null : RadiusDS.borderMd,
            color: ColorsDS.white,
          ),
          margin: widget.flush
              ? EdgeInsets.zero
              : const EdgeInsets.only(bottom: SpacingsDS.sm),
          child: Column(
            children: [
              // ─── Header ────────────────────────────────────────────────────
              InkWell(
                onTap: () => _toggle(i),
                borderRadius: widget.flush ? null : RadiusDS.borderMd,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: SpacingsDS.md,
                    vertical: SpacingsDS.sm,
                  ),
                  child: Row(
                    children: [
                      if (item.icon != null) ...[
                        Icon(item.icon, size: 18, color: ColorsDS.gray600),
                        const SizedBox(width: SpacingsDS.sm),
                      ],
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              item.title,
                              style: TypographyDS.body.copyWith(
                                fontWeight: TypographyDS.weightSemi,
                                color: isExpanded
                                    ? ColorsDS.primary
                                    : ColorsDS.bodyColor,
                              ),
                            ),
                            if (item.subtitle != null && !isExpanded)
                              Text(item.subtitle!, style: TypographyDS.caption),
                          ],
                        ),
                      ),
                      AnimatedRotation(
                        turns: isExpanded ? 0.5 : 0,
                        duration: TransitionsDS.collapse.duration,
                        curve: TransitionsDS.collapse.curve,
                        child: Icon(
                          Icons.keyboard_arrow_down,
                          color: isExpanded
                              ? ColorsDS.primary
                              : ColorsDS.gray500,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // ─── Content animado ────────────────────────────────────────────
              AnimatedCrossFade(
                firstChild: const SizedBox(width: double.infinity),
                secondChild: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.fromLTRB(
                    SpacingsDS.md, 0, SpacingsDS.md, SpacingsDS.md,
                  ),
                  decoration: const BoxDecoration(
                    border: Border(top: BorderSide(color: ColorsDS.gray200)),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(top: SpacingsDS.sm),
                    child: item.content,
                  ),
                ),
                crossFadeState: isExpanded
                    ? CrossFadeState.showSecond
                    : CrossFadeState.showFirst,
                duration: TransitionsDS.collapse.duration,
              ),
            ],
          ),
        );
      }).toList(),
    );
  }
}
