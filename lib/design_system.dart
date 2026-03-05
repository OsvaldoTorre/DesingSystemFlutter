/// Design System Flutter
/// Inspirado en Bootstrap 5 · Sin dependencias externas · Multiplataforma
///
/// Uso — importa únicamente este archivo:
/// ```dart
/// import 'package:design_system_mobile/designSystem/design_system.dart';
/// ```
library design_system;

export 'package:flutter/material.dart';

// ─── Tokens ─────────────────────────────────────────────────────────────────
export 'package:design_system_mobile/designSystem/tokens/colors.dart';
export 'package:design_system_mobile/designSystem/tokens/spacings.dart';
export 'package:design_system_mobile/designSystem/tokens/typography.dart';
export 'package:design_system_mobile/designSystem/tokens/breakpoints.dart';
export 'package:design_system_mobile/designSystem/tokens/borders.dart';
export 'package:design_system_mobile/designSystem/tokens/opacity.dart';
export 'package:design_system_mobile/designSystem/tokens/gradients.dart';
export 'package:design_system_mobile/designSystem/tokens/shadows.dart';

// ─── Theme ───────────────────────────────────────────────────────────────────
export 'config/theme/app_theme.dart';

// ─── Config / I18n ──────────────────────────────────────────────────────────
export 'config/language/language_selector.dart';

// ─── Layout ──────────────────────────────────────────────────────────────────
export 'package:design_system_mobile/designSystem/atoms/cp_grid.dart';

// ─── Components ──────────────────────────────────────────────────────────────
export 'package:design_system_mobile/designSystem/atoms/cp_text.dart';
export 'package:design_system_mobile/designSystem/atoms/cp_paragraph.dart';
export 'package:design_system_mobile/designSystem/atoms/cp_text_paragraph.dart';
export 'package:design_system_mobile/designSystem/atoms/cp_blockquote.dart';
export 'package:design_system_mobile/designSystem/atoms/cp_button.dart';
export 'package:design_system_mobile/designSystem/atoms/cp_card.dart';
export 'package:design_system_mobile/designSystem/atoms/cp_input.dart';
export 'package:design_system_mobile/designSystem/atoms/cp_badge_alert.dart';
export 'package:design_system_mobile/designSystem/atoms/cp_text-paragraph_highlight.dart';
export 'package:design_system_mobile/designSystem/atoms/cp_avatar.dart';
