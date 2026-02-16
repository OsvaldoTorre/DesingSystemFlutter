import 'package:design_system_mobile/desigSystem/tokens/spacings.dart';
import 'package:flutter/material.dart';
import '../../desigSystem/tokens/colors.dart';
import '../../desigSystem/tokens/typography.dart';

class AppTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,

      // 1. Configuración de Colores (ColorScheme)
      colorScheme: const ColorScheme(
        brightness: Brightness.light,
        primary: ColorsDS.primary,
        onPrimary: ColorsDS.white,
        secondary: ColorsDS.secondary,
        onSecondary: ColorsDS.white,
        error: ColorsDS.danger,
        onError: ColorsDS.white,
        surface: ColorsDS.white,
        onSurface: ColorsDS.dark,

        // Mapeamos 'info' a tertiary para tenerlo disponible en el esquema
        tertiary: ColorsDS.info,
        onTertiary: ColorsDS.black,
      ),

      // Fondo por defecto de las pantallas (blanco como en la web)
      scaffoldBackgroundColor: ColorsDS.white,

      // 2. Configuración de Tipografía
      // Mapeamos tus tokens 'h' y 'body' a los slots semánticos de Material
      textTheme: const TextTheme(
        displayLarge: TypographyDS.h1,
        displayMedium: TypographyDS.h2,
        displaySmall: TypographyDS.h3,
        headlineLarge: TypographyDS.h4,
        headlineMedium: TypographyDS.h5,
        headlineSmall: TypographyDS.h6,

        bodyLarge: TypographyDS.bodyLead,
        bodyMedium: TypographyDS.body,
        bodySmall: TypographyDS.small,
      ),

      // 3. Estilos globales de componentes (Ejemplo: Botones estilo Bootstrap)
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: ColorsDS.primary,
          foregroundColor: ColorsDS.white,
          textStyle: TypographyDS.body.copyWith(fontWeight: FontWeight.w500),
          padding: const EdgeInsets.symmetric(
            horizontal: SpacingsDS.s2,
            vertical: SpacingsDS.s2,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(
              4,
            ), // Bordes ligeramente redondeados estilo Bootstrap
          ),
        ),
      ),
    );
  }
}
