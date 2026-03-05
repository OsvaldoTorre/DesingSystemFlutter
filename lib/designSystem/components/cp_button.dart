import 'package:flutter/material.dart';
import 'package:design_system_mobile/designSystem/tokens/colors.dart';
import 'package:design_system_mobile/designSystem/tokens/spacings.dart';
import 'package:design_system_mobile/designSystem/tokens/borders.dart';
import 'package:design_system_mobile/designSystem/tokens/typography.dart';

/// Variantes de botón — equivalente btn-primary, btn-outline-*, etc.
enum ButtonVariantDS {
  primary, secondary, success, danger, warning, info, light, dark, link,
  outlinePrimary, outlineSecondary, outlineSuccess, outlineDanger,
  outlineWarning, outlineInfo, outlineLight, outlineDark,
}

/// Tamaños de botón — equivalente btn-sm, btn, btn-lg
enum ButtonSizeDS { sm, md, lg }

/// CpButton — Equivalente a <button class="btn btn-*"> de Bootstrap
///
/// Ejemplos:
/// ```dart
/// CpButton(label: 'Guardar', onPressed: () {})
/// CpButton(label: 'Eliminar', variant: ButtonVariantDS.danger, onPressed: () {})
/// CpButton(label: 'Outline', variant: ButtonVariantDS.outlinePrimary, onPressed: () {})
/// CpButton(label: 'Cargando...', loading: true, onPressed: null)
/// CpButton(label: 'Block', fullWidth: true, onPressed: () {})
/// CpButton(label: 'Agregar', prefixIcon: Icons.add, onPressed: () {})
/// ```
class CpButton extends StatelessWidget {
  const CpButton({
    super.key,
    required this.label,
    this.onPressed,
    this.variant = ButtonVariantDS.primary,
    this.size = ButtonSizeDS.md,
    this.loading = false,
    this.disabled = false,
    this.fullWidth = false,
    this.prefixIcon,
    this.suffixIcon,
  });

  final String label;
  final VoidCallback? onPressed;
  final ButtonVariantDS variant;
  final ButtonSizeDS size;
  final bool loading;
  final bool disabled;
  final bool fullWidth;
  final IconData? prefixIcon;
  final IconData? suffixIcon;

  // ─── Helpers ────────────────────────────────────────────────────────────────
  bool get _isOutline => variant.name.startsWith('outline');
  bool get _isLink    => variant == ButtonVariantDS.link;
  bool get _isEnabled => !disabled && !loading && onPressed != null;

  Color get _mainColor => switch (variant) {
    ButtonVariantDS.primary          => ColorsDS.primary,
    ButtonVariantDS.secondary        => ColorsDS.secondary,
    ButtonVariantDS.success          => ColorsDS.success,
    ButtonVariantDS.danger           => ColorsDS.danger,
    ButtonVariantDS.warning          => ColorsDS.warning,
    ButtonVariantDS.info             => ColorsDS.info,
    ButtonVariantDS.light            => ColorsDS.light,
    ButtonVariantDS.dark             => ColorsDS.dark,
    ButtonVariantDS.link             => ColorsDS.link,
    ButtonVariantDS.outlinePrimary   => ColorsDS.primary,
    ButtonVariantDS.outlineSecondary => ColorsDS.secondary,
    ButtonVariantDS.outlineSuccess   => ColorsDS.success,
    ButtonVariantDS.outlineDanger    => ColorsDS.danger,
    ButtonVariantDS.outlineWarning   => ColorsDS.warning,
    ButtonVariantDS.outlineInfo      => ColorsDS.info,
    ButtonVariantDS.outlineLight     => ColorsDS.light,
    ButtonVariantDS.outlineDark      => ColorsDS.dark,
  };

  Color get _bgColor {
    if (_isOutline || _isLink) return Colors.transparent;
    return _mainColor;
  }

  Color get _fgColor {
    if (_isOutline || _isLink) return _mainColor;
    if (variant == ButtonVariantDS.warning || variant == ButtonVariantDS.light) {
      return ColorsDS.gray900;
    }
    return ColorsDS.white;
  }

  EdgeInsets get _padding => switch (size) {
    ButtonSizeDS.sm => SpacingsDS.buttonSm,
    ButtonSizeDS.md => SpacingsDS.buttonMd,
    ButtonSizeDS.lg => SpacingsDS.buttonLg,
  };

  double get _fontSize => switch (size) {
    ButtonSizeDS.sm => TypographyDS.fontSizeSm,
    ButtonSizeDS.md => TypographyDS.fontSizeBase,
    ButtonSizeDS.lg => TypographyDS.fontSizeLg,
  };

  double get _iconSize => switch (size) {
    ButtonSizeDS.sm => 14,
    ButtonSizeDS.md => 16,
    ButtonSizeDS.lg => 20,
  };

  // ─── Build ──────────────────────────────────────────────────────────────────
  @override
  Widget build(BuildContext context) {
    final bgColor = _isEnabled ? _bgColor : ColorsDS.gray200;
    final fgColor = _isEnabled ? _fgColor : ColorsDS.gray500;
    final borderColor = _isOutline
        ? (_isEnabled ? _mainColor : ColorsDS.gray300)
        : Colors.transparent;

    Widget content = Row(
      mainAxisSize: fullWidth ? MainAxisSize.max : MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (loading) ...[
          SizedBox(
            width: _iconSize, height: _iconSize,
            child: CircularProgressIndicator(strokeWidth: 2, color: fgColor),
          ),
          const SizedBox(width: SpacingsDS.xs),
        ] else if (prefixIcon != null) ...[
          Icon(prefixIcon, size: _iconSize, color: fgColor),
          const SizedBox(width: SpacingsDS.xs),
        ],
        Text(
          label,
          style: TextStyle(
            fontSize: _fontSize,
            fontWeight: TypographyDS.weightMedium,
            color: fgColor,
            decoration: _isLink ? TextDecoration.underline : TextDecoration.none,
            letterSpacing: 0.5,
          ),
        ),
        if (suffixIcon != null && !loading) ...[
          const SizedBox(width: SpacingsDS.xs),
          Icon(suffixIcon, size: _iconSize, color: fgColor),
        ],
      ],
    );

    return Opacity(
      opacity: _isEnabled ? 1.0 : 0.65,
      child: Material(
        color: bgColor,
        borderRadius: RadiusDS.borderMd,
        child: InkWell(
          onTap: _isEnabled ? onPressed : null,
          borderRadius: RadiusDS.borderMd,
          child: Container(
            width: fullWidth ? double.infinity : null,
            padding: _padding,
            decoration: BoxDecoration(
              borderRadius: RadiusDS.borderMd,
              border: Border.all(color: borderColor),
            ),
            child: content,
          ),
        ),
      ),
    );
  }
}
