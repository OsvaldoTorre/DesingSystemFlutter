import 'package:flutter/painting.dart';

/// ColorsDS — Paleta de color basada en Bootstrap 5
/// Extiende la paleta básica con escala de grises, variantes subtle/emphasis y utilidades.
///
/// Los colores primarios ya están definidos; este archivo añade la escala completa.
class ColorsDS {
  ColorsDS._();

  // ─── Semánticos principales ─────────────────────────────────────────────────
  static const Color primary = Color(0xFF0D6EFD);
  static const Color secondary = Color(0xFF6C757D);
  static const Color success = Color(0xFF198754);
  static const Color info = Color(0xFF0DCAF0);
  static const Color warning = Color(0xFFFFC107);
  static const Color danger = Color(0xFFDC3545);
  static const Color light = Color(0xFFF8F9FA);
  static const Color dark = Color(0xFF212529);

  static const Color white = Color(0xFFFFFFFF);
  static const Color black = Color(0xFF000000);

  // ─── Escala de colores semánticos (ej. con Primary) ────────────────────────
  // Se puede generar una escala similar para cada color semántico.
  static const Color primary100 = Color(0xFFCFE2FF); // primary-subtle
  static const Color primary200 = Color(0xFF9EC5FE);
  static const Color primary300 = Color(0xFF6EA8FE);
  static const Color primary400 = Color(0xFF3D8BFD);
  static const Color primary500 = Color(0xFF0D6EFD); // primary
  static const Color primary600 = Color(0xFF0A58CA);

  // ─── Variantes subtle (fondos de alertas, badges) ───────────────────────────
  static const Color primarySubtle = Color(0xFFCFE2FF);
  static const Color secondarySubtle = Color(0xFFE2E3E5);
  static const Color successSubtle = Color(0xFFD1E7DD);
  static const Color dangerSubtle = Color(0xFFF8D7DA);
  static const Color warningSubtle = Color(0xFFFFF3CD);
  static const Color infoSubtle = Color(0xFFCFF4FC);

  // ─── Variantes emphasis (texto sobre fondos subtle) ─────────────────────────
  static const Color primaryEmphasis = Color(0xFF084298);
  static const Color secondaryEmphasis = Color(0xFF41464B);
  static const Color successEmphasis = Color(0xFF0A3622);
  static const Color dangerEmphasis = Color(0xFF58151C);
  static const Color warningEmphasis = Color(0xFF664D03);
  static const Color infoEmphasis = Color(0xFF055160);

  // ─── Escala de grises ───────────────────────────────────────────────────────
  static const Color gray100 = Color(0xFFF8F9FA);
  static const Color gray200 = Color(0xFFE9ECEF);
  static const Color gray300 = Color(0xFFDEE2E6);
  static const Color gray400 = Color(0xFFCED4DA);
  static const Color gray500 = Color(0xFFADB5BD);
  static const Color gray600 = Color(0xFF6C757D);
  static const Color gray700 = Color(0xFF495057);
  static const Color gray800 = Color(0xFF343A40);
  static const Color gray900 = Color(0xFF212529);

  // ─── Surface / Backgrounds ──────────────────────────────────────────────────
  static const Color bodyBg = Color(0xFFFFFFFF);
  static const Color bodyColor = Color(0xFF212529);

  // ─── Links ──────────────────────────────────────────────────────────────────
  static const Color link = Color(0xFF0D6EFD);
  static const Color linkHover = Color(0xFF0A58CA);

  // ─── Utilidades ─────────────────────────────────────────────────────────────

  /// Retorna blanco o negro según la luminance del fondo dado.
  /// Útil para garantizar contraste sobre cualquier color semántico.
  static Color contrastOn(Color background) =>
      background.computeLuminance() > 0.4 ? gray900 : white;

  /// Retorna el color con opacidad aplicada
  static Color withOpacity(Color color, double opacity) =>
      color.withValues(alpha: opacity);
}
