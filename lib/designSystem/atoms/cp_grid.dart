import 'package:design_system_mobile/designSystem/tokens/spacings.dart';
import 'package:flutter/widgets.dart';
import 'package:design_system_mobile/designSystem/tokens/breakpoints.dart';

/// CpContainer — Equivalente a .container de Bootstrap
/// Centra el contenido y aplica max-width según el breakpoint activo.
///
/// ```dart
/// CpContainer(child: myContent)                  // .container
/// CpContainer(fluid: true, child: myContent)     // .container-fluid
/// ```
class CpContainer extends StatelessWidget {
  const CpContainer({
    super.key,
    required this.child,
    this.fluid = false,
    this.padding,
  });

  final Widget child;

  /// true → ocupa 100% del ancho (.container-fluid)
  final bool fluid;

  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) {
    final bp = BreakpointsDS.of(context);
    final maxWidth = fluid
        ? double.infinity
        : (BreakpointsDS.containerMaxWidths[bp] ?? double.infinity);

    return Center(
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: maxWidth),
        child: Padding(
          padding:
              padding ?? const EdgeInsets.symmetric(horizontal: SpacingsDS.md),
          child: child,
        ),
      ),
    );
  }
}

/// CpRow — Equivalente a .row de Bootstrap
/// Organiza columnas [CpCol] en filas con gutter configurable.
///
/// ```dart
/// CpRow(
///   gutterH: SpacingsDS.md,  // gx-3
///   gutterV: SpacingsDS.md,  // gy-3
///   children: [
///     CpCol(xs: 12, md: 6, child: MyWidget()),
///     CpCol(xs: 12, md: 6, child: MyWidget()),
///   ],
/// )
/// ```
class CpRow extends StatelessWidget {
  const CpRow({
    super.key,
    required this.children,
    this.gutterH = SpacingsDS.md,
    this.gutterV = SpacingsDS.md,
  });

  final List<Widget> children;

  /// Gutter horizontal entre columnas (equivalente gx-*)
  final double gutterH;

  /// Gutter vertical entre filas (equivalente gy-*)
  final double gutterV;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Wrap(
          spacing: gutterH,
          runSpacing: gutterV,
          children: children
              .map(
                (child) => child is CpCol
                    ? _SizedCol(
                        col: child,
                        parentWidth: constraints.maxWidth,
                        gutterH: gutterH,
                      )
                    : child,
              )
              .toList(),
        );
      },
    );
  }
}

class _SizedCol extends StatelessWidget {
  const _SizedCol({
    required this.col,
    required this.parentWidth,
    required this.gutterH,
  });

  final CpCol col;
  final double parentWidth;
  final double gutterH;

  @override
  Widget build(BuildContext context) {
    final span = col._resolveSpan(context);
    if (span == 0) return const SizedBox.shrink();

    final colsInRow = 12 / span;
    final totalGutter = (colsInRow - 1) * gutterH / colsInRow;
    final colWidth = (parentWidth * span / 12) - totalGutter;

    return SizedBox(width: colWidth.clamp(0, parentWidth), child: col);
  }
}

/// CpCol — Equivalente a .col-{n} de Bootstrap (sistema de 12 columnas)
///
/// Solo `xs` es obligatorio. El resto hereda hacia arriba igual que Bootstrap.
///
/// ```dart
/// CpCol(xs: 12, md: 6, lg: 4, child: MyCard())   // col-12 col-md-6 col-lg-4
/// CpCol(xs: 12, child: MyWidget())                 // col-12 (full width)
/// ```
class CpCol extends StatelessWidget {
  const CpCol({
    super.key,
    required this.child,
    this.xs = 12,
    this.sm,
    this.md,
    this.lg,
    this.xl,
    this.xxl,
  }) : assert(xs >= 0 && xs <= 12, 'xs debe ser entre 0 y 12');

  final Widget child;

  /// Columnas en xs (0–575px) — obligatorio
  final int xs;
  final int? sm;
  final int? md;
  final int? lg;
  final int? xl;
  final int? xxl;

  int _resolveSpan(BuildContext context) => BreakpointsDS.resolve<int>(
    context,
    xs: xs,
    sm: sm,
    md: md,
    lg: lg,
    xl: xl,
    xxl: xxl,
  );

  @override
  Widget build(BuildContext context) => child;
}
