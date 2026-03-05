import 'package:design_system_mobile/design_system.dart';

/// AppThemeDS — Genera ThemeData para MaterialApp usando los tokens del Design System.
///
/// Uso en main.dart:
/// ```dart
/// MaterialApp(
///   theme:     AppThemeDS.light(),
///   darkTheme: AppThemeDS.dark(),
///   themeMode: ThemeMode.system,
/// )
/// ```
class AppThemeDS {
  AppThemeDS._();

  // ─── Tema claro ─────────────────────────────────────────────────────────────
  static ThemeData light() {
    return ThemeData.light(useMaterial3: true).copyWith(
      colorScheme: _lightScheme,
      scaffoldBackgroundColor: ColorsDS.gray100,
      textTheme: _textTheme(ColorsDS.bodyColor),
      elevatedButtonTheme: _elevatedButton(),
      outlinedButtonTheme: _outlinedButton(),
      textButtonTheme: _textButton(),
      inputDecorationTheme: _inputDecoration(),
      cardTheme: _cardTheme(),
      dividerTheme: const DividerThemeData(
        color: ColorsDS.gray300,
        thickness: 1,
        space: 0,
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: ColorsDS.white,
        foregroundColor: ColorsDS.bodyColor,
        elevation: 0,
        scrolledUnderElevation: 1,
        shadowColor: ColorsDS.gray200,
        titleTextStyle: TypographyDS.h5.copyWith(fontWeight: FontWeight.w600),
      ),
    );
  }

  // ─── Tema oscuro ─────────────────────────────────────────────────────────────
  static ThemeData dark() {
    return ThemeData.dark(useMaterial3: true).copyWith(
      colorScheme: _darkScheme,
      scaffoldBackgroundColor: ColorsDS.gray900,
      textTheme: _textTheme(ColorsDS.white),
      elevatedButtonTheme: _elevatedButton(),
      outlinedButtonTheme: _outlinedButton(),
      textButtonTheme: _textButton(),
      inputDecorationTheme: _inputDecoration(dark: true),
      cardTheme: _cardTheme(dark: true),
      dividerTheme: const DividerThemeData(
        color: ColorsDS.gray700,
        thickness: 1,
        space: 0,
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: ColorsDS.gray900,
        foregroundColor: ColorsDS.gray100,
        elevation: 0,
        titleTextStyle: TypographyDS.h5.copyWith(
          fontWeight: FontWeight.w600,
          color: ColorsDS.gray100,
        ),
      ),
    );
  }

  // ─── Color schemes ───────────────────────────────────────────────────────────
  static const ColorScheme _lightScheme = ColorScheme.light(
    primary: ColorsDS.primary,
    onPrimary: ColorsDS.white,
    secondary: ColorsDS.secondary,
    onSecondary: ColorsDS.white,
    error: ColorsDS.danger,
    onError: ColorsDS.white,
    surface: ColorsDS.white,
    onSurface: ColorsDS.bodyColor,
    outline: ColorsDS.gray300,
  );

  static const ColorScheme _darkScheme = ColorScheme.dark(
    primary: ColorsDS.primary,
    onPrimary: ColorsDS.white,
    secondary: ColorsDS.secondary,
    onSecondary: ColorsDS.white,
    error: ColorsDS.danger,
    onError: ColorsDS.white,
    surface: ColorsDS.gray800,
    onSurface: ColorsDS.gray100,
    outline: ColorsDS.gray600,
  );

  // ─── TextTheme ───────────────────────────────────────────────────────────────
  static TextTheme _textTheme(Color base) => TextTheme(
    displayLarge: TypographyDS.displayLg.copyWith(color: base),
    displayMedium: TypographyDS.displayMd.copyWith(color: base),
    displaySmall: TypographyDS.displaySm.copyWith(color: base),
    headlineLarge: TypographyDS.h1.copyWith(color: base),
    headlineMedium: TypographyDS.h2.copyWith(color: base),
    headlineSmall: TypographyDS.h3.copyWith(color: base),
    titleLarge: TypographyDS.h4.copyWith(color: base),
    titleMedium: TypographyDS.h5.copyWith(color: base),
    titleSmall: TypographyDS.h6.copyWith(color: base),
    bodyLarge: TypographyDS.lead.copyWith(color: base),
    bodyMedium: TypographyDS.body.copyWith(color: base),
    bodySmall: TypographyDS.small.copyWith(color: base),
    labelLarge: TypographyDS.label.copyWith(color: base),
    labelSmall: TypographyDS.caption,
  );

  // ─── Component themes ────────────────────────────────────────────────────────
  static ElevatedButtonThemeData _elevatedButton() => ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: ColorsDS.primary,
      foregroundColor: ColorsDS.white,
      padding: SpacingsDS.buttonMd,
      textStyle: TypographyDS.label,
      shape: RoundedRectangleBorder(borderRadius: RadiusDS.borderMd),
      elevation: 0,
    ),
  );

  static OutlinedButtonThemeData _outlinedButton() => OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      foregroundColor: ColorsDS.primary,
      padding: SpacingsDS.buttonMd,
      textStyle: TypographyDS.label,
      side: const BorderSide(color: ColorsDS.primary),
      shape: RoundedRectangleBorder(borderRadius: RadiusDS.borderMd),
    ),
  );

  static TextButtonThemeData _textButton() => TextButtonThemeData(
    style: TextButton.styleFrom(
      foregroundColor: ColorsDS.primary,
      padding: SpacingsDS.buttonMd,
      textStyle: TypographyDS.label,
      shape: RoundedRectangleBorder(borderRadius: RadiusDS.borderMd),
    ),
  );

  static InputDecorationTheme _inputDecoration({
    bool dark = false,
  }) => InputDecorationTheme(
    filled: true,
    fillColor: dark ? ColorsDS.gray800 : ColorsDS.white,
    contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
    border: OutlineInputBorder(
      borderRadius: RadiusDS.borderMd,
      borderSide: BorderSide(color: dark ? ColorsDS.gray600 : ColorsDS.gray400),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: RadiusDS.borderMd,
      borderSide: BorderSide(color: dark ? ColorsDS.gray600 : ColorsDS.gray400),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: RadiusDS.borderMd,
      borderSide: const BorderSide(color: ColorsDS.primary, width: 2),
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: RadiusDS.borderMd,
      borderSide: const BorderSide(color: ColorsDS.danger),
    ),
    hintStyle: TypographyDS.body.copyWith(color: ColorsDS.gray500),
    labelStyle: TypographyDS.label,
  );

  static CardThemeData _cardTheme({bool dark = false}) => CardThemeData(
    elevation: 0,
    color: dark ? ColorsDS.gray800 : ColorsDS.white,
    shape: RoundedRectangleBorder(borderRadius: RadiusDS.borderMd),
    margin: EdgeInsets.zero, // El espaciado lo controla el Grid (CpCol)
    clipBehavior: Clip.antiAlias,
    shadowColor: dark ? Colors.black : ColorsDS.gray200,
  );
}
