import 'package:design_system_mobile/design_system.dart';

/// SpacingsDS — Escala de espaciado basada en Bootstrap 5
/// Base: 1rem = 16px
class SpacingsDS {
  SpacingsDS._();

  // ─── Escala base ────────────────────────────────────────────────────────────
  static const double s0 = 0;       // 0rem
  static const double s1 = 4.0;    // 0.25rem
  static const double s2 = 8.0;    // 0.5rem
  static const double s3 = 16.0;   // 1rem    ← base
  static const double s4 = 24.0;   // 1.5rem
  static const double s5 = 48.0;   // 3rem

  // ─── Escala extendida ───────────────────────────────────────────────────────
  static const double s6 = 64.0;   // 4rem
  static const double s7 = 80.0;   // 5rem
  static const double s8 = 96.0;   // 6rem

  static const double sAuto = double.infinity;

  // ─── Alias semánticos ───────────────────────────────────────────────────────
  static const double none = s0;
  static const double xs   = s1;   // 4px
  static const double sm   = s2;   // 8px
  static const double md   = s3;   // 16px  ← default
  static const double lg   = s4;   // 24px
  static const double xl   = s5;   // 48px
  static const double xxl  = s6;   // 64px

  // ─── EdgeInsets preconstruidos ──────────────────────────────────────────────
  static const EdgeInsets paddingXs = EdgeInsets.all(xs);
  static const EdgeInsets paddingSm = EdgeInsets.all(sm);
  static const EdgeInsets paddingMd = EdgeInsets.all(md);
  static const EdgeInsets paddingLg = EdgeInsets.all(lg);

  static const EdgeInsets paddingHSm = EdgeInsets.symmetric(horizontal: sm);
  static const EdgeInsets paddingHMd = EdgeInsets.symmetric(horizontal: md);
  static const EdgeInsets paddingHLg = EdgeInsets.symmetric(horizontal: lg);

  static const EdgeInsets paddingVSm = EdgeInsets.symmetric(vertical: sm);
  static const EdgeInsets paddingVMd = EdgeInsets.symmetric(vertical: md);

  // ─── Padding interno de botones ─────────────────────────────────────────────
  static const EdgeInsets buttonSm = EdgeInsets.symmetric(horizontal: 12, vertical: 4);
  static const EdgeInsets buttonMd = EdgeInsets.symmetric(horizontal: 12, vertical: 6);
  static const EdgeInsets buttonLg = EdgeInsets.symmetric(horizontal: 16, vertical: 8);
}
