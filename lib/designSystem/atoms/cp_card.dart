import 'package:flutter/widgets.dart';
import 'package:design_system_mobile/designSystem/tokens/colors.dart';
import 'package:design_system_mobile/designSystem/tokens/spacings.dart';
import 'package:design_system_mobile/designSystem/tokens/borders.dart';
import 'package:design_system_mobile/designSystem/tokens/typography.dart';

/// CpCard — Equivalente a <div class="card"> de Bootstrap
///
/// ```dart
/// // Básica
/// CpCard(child: Text('Contenido'))
///
/// // Completa
/// CpCard(
///   header: CpCardHeader(title: 'Título'),
///   child: CpCardBody(title: 'Nombre', text: 'Descripción'),
///   footer: CpCardFooter(child: Text('Footer')),
/// )
/// ```
class CpCard extends StatelessWidget {
  const CpCard({
    super.key,
    this.child,
    this.header,
    this.footer,
    this.image,
    this.imagePlacement = CpCardImagePlacement.top,
    this.borderColor,
    this.backgroundColor,
    this.padding,
    this.width,
    this.height,
    this.shadows = const [],
  });

  final Widget? child;
  final Widget? header;
  final Widget? footer;
  final Widget? image;
  final CpCardImagePlacement imagePlacement;
  final Color? borderColor;
  final Color? backgroundColor;
  final EdgeInsetsGeometry? padding;
  final double? width;
  final double? height;
  final List<BoxShadow> shadows;

  @override
  Widget build(BuildContext context) {
    final bg     = backgroundColor ?? ColorsDS.white;
    final border = borderColor ?? ColorsDS.gray200;

    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: bg,
        borderRadius: RadiusDS.borderMd,
        border: Border.all(color: border),
        boxShadow: shadows,
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [
          if (image != null && imagePlacement == CpCardImagePlacement.top) image!,
          if (header != null) header!,
          if (child != null)
            Padding(
              padding: padding ?? const EdgeInsets.all(SpacingsDS.md),
              child: child,
            ),
          if (image != null && imagePlacement == CpCardImagePlacement.bottom) image!,
          if (footer != null) footer!,
        ],
      ),
    );
  }
}

enum CpCardImagePlacement { top, bottom }

// ─── Sub-componentes ─────────────────────────────────────────────────────────

/// CpCardHeader — .card-header
class CpCardHeader extends StatelessWidget {
  const CpCardHeader({
    super.key,
    required this.title,
    this.trailing,
    this.backgroundColor,
    this.padding,
  });

  final String title;
  final Widget? trailing;
  final Color? backgroundColor;
  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding ?? const EdgeInsets.symmetric(
        horizontal: SpacingsDS.md, vertical: SpacingsDS.sm,
      ),
      decoration: BoxDecoration(
        color: backgroundColor ?? ColorsDS.gray100,
        border: const Border(bottom: BorderSide(color: ColorsDS.gray200)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: TypographyDS.body.copyWith(fontWeight: TypographyDS.weightSemi)),
          if (trailing != null) trailing!,
        ],
      ),
    );
  }
}

/// CpCardFooter — .card-footer
class CpCardFooter extends StatelessWidget {
  const CpCardFooter({
    super.key,
    required this.child,
    this.backgroundColor,
    this.padding,
  });

  final Widget child;
  final Color? backgroundColor;
  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding ?? const EdgeInsets.symmetric(
        horizontal: SpacingsDS.md, vertical: SpacingsDS.sm,
      ),
      decoration: BoxDecoration(
        color: backgroundColor ?? ColorsDS.gray100,
        border: const Border(top: BorderSide(color: ColorsDS.gray200)),
      ),
      child: child,
    );
  }
}

/// CpCardBody — Cuerpo semántico con title, subtitle, text y actions
class CpCardBody extends StatelessWidget {
  const CpCardBody({
    super.key,
    this.title,
    this.subtitle,
    this.text,
    this.actions,
  });

  final String? title;
  final String? subtitle;
  final String? text;
  final List<Widget>? actions;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (subtitle != null) ...[
          Text(subtitle!, style: TypographyDS.caption.copyWith(letterSpacing: 1.5)),
          const SizedBox(height: SpacingsDS.xs),
        ],
        if (title != null) ...[
          Text(title!, style: TypographyDS.h5),
          const SizedBox(height: SpacingsDS.xs),
        ],
        if (text != null) Text(text!, style: TypographyDS.body),
        if (actions != null) ...[
          const SizedBox(height: SpacingsDS.md),
          Wrap(spacing: SpacingsDS.sm, children: actions!),
        ],
      ],
    );
  }
}

/// CpCardImage — .card-img-top / .card-img-bottom
class CpCardImage extends StatelessWidget {
  const CpCardImage({
    super.key,
    required this.imageWidget,
    this.height = 200,
    this.fit = BoxFit.cover,
  });

  final Widget imageWidget;
  final double height;
  final BoxFit fit;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: double.infinity,
      child: FittedBox(fit: fit, clipBehavior: Clip.antiAlias, child: imageWidget),
    );
  }
}
