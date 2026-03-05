import 'package:design_system_mobile/design_system.dart';

/// CpSearchBar — CpInput + botón de búsqueda con estado de carga.
/// Es una molecule porque combina un campo de texto, un icono y un botón
/// con lógica de interacción propia.
///
/// ```dart
/// // Simple
/// CpSearchBar(onSearch: (q) => _buscar(q))
///
/// // Con botón y cargando
/// CpSearchBar(
///   hint: 'Buscar productos...',
///   showButton: true,
///   loading: _searching,
///   onSearch: (q) => _buscar(q),
///   onClear: () => _limpiar(),
/// )
/// ```
class CpSearchBar extends StatefulWidget {
  const CpSearchBar({
    super.key,
    this.hint = 'Buscar...',
    this.controller,
    this.onSearch,
    this.onChanged,
    this.onClear,
    this.showButton = false,
    this.buttonLabel = 'Buscar',
    this.loading = false,
    this.enabled = true,
    this.autofocus = false,
  });

  final String hint;
  final TextEditingController? controller;
  final ValueChanged<String>? onSearch;
  final ValueChanged<String>? onChanged;
  final VoidCallback? onClear;
  final bool showButton;
  final String buttonLabel;
  final bool loading;
  final bool enabled;
  final bool autofocus;

  @override
  State<CpSearchBar> createState() => _CpSearchBarState();
}

class _CpSearchBarState extends State<CpSearchBar> {
  late TextEditingController _ctrl;
  bool _hasText = false;

  @override
  void initState() {
    super.initState();
    _ctrl = widget.controller ?? TextEditingController();
    _ctrl.addListener(() {
      final has = _ctrl.text.isNotEmpty;
      if (has != _hasText) setState(() => _hasText = has);
    });
  }

  @override
  void dispose() {
    if (widget.controller == null) _ctrl.dispose();
    super.dispose();
  }

  void _handleSearch() {
    if (widget.onSearch != null) widget.onSearch!(_ctrl.text);
  }

  void _handleClear() {
    _ctrl.clear();
    widget.onClear?.call();
    widget.onChanged?.call('');
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: SizedBox(
            height: SizesDS.inputMd,
            child: TextField(
              controller: _ctrl,
              enabled: widget.enabled,
              autofocus: widget.autofocus,
              textInputAction: TextInputAction.search,
              onSubmitted: widget.onSearch,
              onChanged: widget.onChanged,
              style: TypographyDS.body,
              decoration: InputDecoration(
                hintText: widget.hint,
                hintStyle: TypographyDS.body.copyWith(color: ColorsDS.gray400),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: SpacingsDS.sm,
                  vertical: SpacingsDS.xs,
                ),
                filled: true,
                fillColor: widget.enabled ? ColorsDS.white : ColorsDS.gray100,
                prefixIcon: widget.loading
                    ? Padding(
                        padding: const EdgeInsets.all(SpacingsDS.sm),
                        child: CpSpinner(size: SpinnerSizeDS.sm),
                      )
                    : const Icon(Icons.search, size: 20, color: ColorsDS.gray500),
                suffixIcon: AnimatedOpacity(
                  opacity: _hasText ? 1.0 : 0.0,
                  duration: TransitionsDS.fade.duration,
                  child: GestureDetector(
                    onTap: _handleClear,
                    child: const Icon(Icons.close, size: 18, color: ColorsDS.gray500),
                  ),
                ),
                border: OutlineInputBorder(
                  borderRadius: widget.showButton
                      ? const BorderRadius.horizontal(left: Radius.circular(RadiusDS.md))
                      : RadiusDS.borderMd,
                  borderSide: const BorderSide(color: ColorsDS.gray400),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: widget.showButton
                      ? const BorderRadius.horizontal(left: Radius.circular(RadiusDS.md))
                      : RadiusDS.borderMd,
                  borderSide: const BorderSide(color: ColorsDS.gray400),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: widget.showButton
                      ? const BorderRadius.horizontal(left: Radius.circular(RadiusDS.md))
                      : RadiusDS.borderMd,
                  borderSide: const BorderSide(color: ColorsDS.primary, width: 2),
                ),
              ),
            ),
          ),
        ),

        // ─── Botón de búsqueda ─────────────────────────────────────────────
        if (widget.showButton) ...[
          const SizedBox(width: 1),
          SizedBox(
            height: SizesDS.inputMd,
            child: CpButton(
              label: widget.buttonLabel,
              onPressed: widget.enabled && !widget.loading ? _handleSearch : null,
              loading: widget.loading,
            ),
          ),
        ],
      ],
    );
  }
}
