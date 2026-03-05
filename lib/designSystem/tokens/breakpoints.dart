import 'package:flutter/widgets.dart';

/// BreakpointsDS — Sistema de breakpoints responsivos al estilo Bootstrap 5
///
/// Equivalencias:
/// xs  →  0 – 575px   (móviles pequeños, default)
/// sm  →  ≥ 576px     (móviles grandes)
/// md  →  ≥ 768px     (tablets)
/// lg  →  ≥ 992px     (tablets grandes / laptops)
/// xl  →  ≥ 1200px    (desktops)
/// xxl →  ≥ 1400px    (desktops grandes)
enum DSBreakpoint { xs, sm, md, lg, xl, xxl }

class BreakpointsDS {
  BreakpointsDS._();

  // ─── Valores numéricos ──────────────────────────────────────────────────────
  static const double sm  =  576;
  static const double md  =  768;
  static const double lg  =  992;
  static const double xl  = 1200;
  static const double xxl = 1400;

  // Max-widths de .container por breakpoint
  static const Map<DSBreakpoint, double> containerMaxWidths = {
    DSBreakpoint.sm:  540,
    DSBreakpoint.md:  720,
    DSBreakpoint.lg:  960,
    DSBreakpoint.xl:  1140,
    DSBreakpoint.xxl: 1320,
  };

  // ─── Helpers de contexto ────────────────────────────────────────────────────

  /// Retorna el breakpoint activo según el ancho actual de pantalla
  static DSBreakpoint of(BuildContext context) {
    return fromWidth(MediaQuery.sizeOf(context).width);
  }

  /// Retorna el breakpoint correspondiente a un ancho dado
  static DSBreakpoint fromWidth(double width) {
    if (width >= xxl) return DSBreakpoint.xxl;
    if (width >= xl)  return DSBreakpoint.xl;
    if (width >= lg)  return DSBreakpoint.lg;
    if (width >= md)  return DSBreakpoint.md;
    if (width >= sm)  return DSBreakpoint.sm;
    return DSBreakpoint.xs;
  }

  /// true si el breakpoint actual es >= al breakpoint dado
  static bool isAtLeast(BuildContext context, DSBreakpoint bp) =>
      of(context).index >= bp.index;

  /// true si el breakpoint actual es < al breakpoint dado
  static bool isBelow(BuildContext context, DSBreakpoint bp) =>
      !isAtLeast(context, bp);

  /// true si es móvil (xs o sm)
  static bool isMobile(BuildContext context) =>
      isBelow(context, DSBreakpoint.md);

  /// true si es tablet (md o lg)
  static bool isTablet(BuildContext context) {
    final bp = of(context);
    return bp == DSBreakpoint.md || bp == DSBreakpoint.lg;
  }

  /// true si es desktop (xl o xxl)
  static bool isDesktop(BuildContext context) =>
      isAtLeast(context, DSBreakpoint.xl);

  // ─── Valor responsivo ───────────────────────────────────────────────────────

  /// Retorna el valor más específico disponible para el breakpoint activo.
  /// Los breakpoints sin valor heredan del anterior (como Bootstrap).
  ///
  /// Ejemplo:
  /// ```dart
  /// // col-12 col-md-6 col-lg-4
  /// final cols = BreakpointsDS.resolve<int>(context, xs: 12, md: 6, lg: 4);
  /// ```
  static T resolve<T>(
    BuildContext context, {
    required T xs,
    T? sm,
    T? md,
    T? lg,
    T? xl,
    T? xxl,
  }) {
    final bp = of(context);
    return _pick(bp, xs: xs, sm: sm, md: md, lg: lg, xl: xl, xxl: xxl);
  }

  static T _pick<T>(
    DSBreakpoint bp, {
    required T xs,
    T? sm,
    T? md,
    T? lg,
    T? xl,
    T? xxl,
  }) {
    final values = <T?>[xs, sm, md, lg, xl, xxl];
    T last = xs;
    for (int i = 0; i <= bp.index; i++) {
      if (values[i] != null) last = values[i] as T;
    }
    return last;
  }
}
