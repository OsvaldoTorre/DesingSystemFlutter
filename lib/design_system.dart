/// Design System Flutter
/// Inspirado en Bootstrap 5 · Sin dependencias externas · Multiplataforma
///
/// Uso — importa únicamente este archivo en cualquier parte del proyecto:
/// ```dart
/// import 'package:design_system_mobile/design_system.dart';
/// ```
library design_system;

export 'package:flutter/material.dart';
export 'package:flutter/services.dart';

// ─── Tokens ──────────────────────────────────────────────────────────────────
export 'package:design_system_mobile/designSystem/tokens/colors.dart';
export 'package:design_system_mobile/designSystem/tokens/spacings.dart';
export 'package:design_system_mobile/designSystem/tokens/typography.dart';
export 'package:design_system_mobile/designSystem/tokens/breakpoints.dart';
export 'package:design_system_mobile/designSystem/tokens/borders.dart';
export 'package:design_system_mobile/designSystem/tokens/opacity.dart';
export 'package:design_system_mobile/designSystem/tokens/gradients.dart';
export 'package:design_system_mobile/designSystem/tokens/icon_sizes.dart';
export 'package:design_system_mobile/designSystem/tokens/z_indices.dart';
export 'package:design_system_mobile/designSystem/tokens/sizes.dart';
export 'package:design_system_mobile/designSystem/tokens/states.dart';
export 'package:design_system_mobile/designSystem/tokens/transitions.dart';
export 'package:design_system_mobile/designSystem/tokens/shadows.dart';

// ─── Theme ───────────────────────────────────────────────────────────────────
export 'config/theme/app_theme.dart';

// ─── Config / I18n ───────────────────────────────────────────────────────────
export 'config/language/language_selector.dart';

// ─── Layout ──────────────────────────────────────────────────────────────────
export 'package:design_system_mobile/designSystem/layout/cp_grid.dart';

// ─── Atoms ───────────────────────────────────────────────────────────────────
export 'package:design_system_mobile/designSystem/atoms/cp_text.dart';
export 'package:design_system_mobile/designSystem/atoms/cp_button.dart';
export 'package:design_system_mobile/designSystem/atoms/cp_input.dart';
export 'package:design_system_mobile/designSystem/atoms/cp_badge.dart';
export 'package:design_system_mobile/designSystem/atoms/cp_avatar.dart';
export 'package:design_system_mobile/designSystem/atoms/cp_icon.dart';
export 'package:design_system_mobile/designSystem/atoms/cp_divider.dart';
export 'package:design_system_mobile/designSystem/atoms/cp_spinner.dart';
export 'package:design_system_mobile/designSystem/atoms/cp_checkbox.dart';
export 'package:design_system_mobile/designSystem/atoms/cp_radio.dart';
export 'package:design_system_mobile/designSystem/atoms/cp_switch.dart';
export 'package:design_system_mobile/designSystem/atoms/cp_slider.dart';
export 'package:design_system_mobile/designSystem/atoms/cp_skeleton.dart';

// ─── Molecules ───────────────────────────────────────────────────────────────
export 'package:design_system_mobile/designSystem/molecules/cp_paragraph.dart';
export 'package:design_system_mobile/designSystem/molecules/cp_text_paragraph.dart';
export 'package:design_system_mobile/designSystem/molecules/cp_text_paragraph_highlight.dart';
export 'package:design_system_mobile/designSystem/molecules/cp_blockquote.dart';
export 'package:design_system_mobile/designSystem/molecules/cp_alert.dart';
export 'package:design_system_mobile/designSystem/molecules/cp_form_field.dart';
export 'package:design_system_mobile/designSystem/molecules/cp_search_bar.dart';
export 'package:design_system_mobile/designSystem/molecules/cp_stat_card.dart';
export 'package:design_system_mobile/designSystem/molecules/cp_empty_state.dart';
export 'package:design_system_mobile/designSystem/molecules/cp_breadcrumb.dart';
export 'package:design_system_mobile/designSystem/molecules/cp_toast.dart';
export 'package:design_system_mobile/designSystem/molecules/cp_tooltip.dart';
export 'package:design_system_mobile/designSystem/molecules/cp_progress.dart';

// ─── Organisms ───────────────────────────────────────────────────────────────
export 'package:design_system_mobile/designSystem/organisms/cp_card.dart';
export 'package:design_system_mobile/designSystem/organisms/cp_navbar.dart';
export 'package:design_system_mobile/designSystem/organisms/cp_sidebar.dart';
export 'package:design_system_mobile/designSystem/organisms/cp_modal.dart';
export 'package:design_system_mobile/designSystem/organisms/cp_drawer.dart';
export 'package:design_system_mobile/designSystem/organisms/cp_form.dart';
export 'package:design_system_mobile/designSystem/organisms/cp_tabs.dart';
export 'package:design_system_mobile/designSystem/organisms/cp_accordion.dart';
export 'package:design_system_mobile/designSystem/organisms/cp_pagination.dart';
export 'package:design_system_mobile/designSystem/organisms/cp_list_group.dart';
export 'package:design_system_mobile/designSystem/organisms/cp_bottom_sheet.dart';
export 'package:design_system_mobile/designSystem/organisms/cp_table.dart';
export 'package:design_system_mobile/designSystem/organisms/cp_stepper.dart';
export 'package:design_system_mobile/designSystem/organisms/cp_data_list.dart';
