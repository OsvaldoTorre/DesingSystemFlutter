import 'package:design_system_mobile/config/language/language_selector.dart';
import 'package:design_system_mobile/desigSystem/componets/cp_text.dart';
import 'package:design_system_mobile/desigSystem/tokens/colors.dart';
import 'package:design_system_mobile/desigSystem/tokens/spacings.dart';
import 'package:design_system_mobile/desigSystem/tokens/typography.dart';
import 'package:design_system_mobile/gallery/typography_gallery.dart';
import 'package:flutter/material.dart';
import 'config/theme/theme_data.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Escuchamos los cambios en el idioma globalmente
    return ValueListenableBuilder<String>(
      valueListenable: LanguageS.currentLang,
      builder: (context, lang, child) {
        return MaterialApp(
          home: Scaffold(
            body: SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(SpacingsDS.s3),
                child: ListView(
                  
                  children: [
                    // Botones para cambiar idioma
                    Wrap(
                      alignment: WrapAlignment.center,
                      spacing: 10,
                      children: [
                        ElevatedButton(
                          onPressed: () => LanguageS.currentLang.value = 'es',
                          child: const Text("ES"),
                        ),
                        ElevatedButton(
                          onPressed: () => LanguageS.currentLang.value = 'en',
                          child: const Text("EN"),
                        ),
                        ElevatedButton(
                          onPressed: () => LanguageS.currentLang.value = 'pt',
                          child: const Text("PT"),
                        ),
                        ElevatedButton(
                          onPressed: () => LanguageS.currentLang.value = 'de',
                          child: const Text("DE"),
                        ),
                      ],
                    ),
                    const SizedBox(height: 50),
                    TypographyGallery(),

                    CpText(
                      LanguageS.get(TextApp.buttons),
                      color: ColorsDS.primary,
                      style: TypographyDS.h2,
                      padding: const EdgeInsetsGeometry.all(SpacingsDS.s1),
                    ),
                    ElevatedButton(
                      onPressed: () {},
                      child: CpText(
                        LanguageS.get(TextApp.name),
                        color: ColorsDS.info,
                        style: TypographyDS.h2,
                      ),
                    ),
                    Text(
                      'H1',
                      style: Theme.of(context).textTheme.displayLarge,
                      textAlign: TextAlign.start,
                    ),
                    Text(
                      'H2',
                      style: Theme.of(context).textTheme.displayMedium,
                      textAlign: TextAlign.start,
                    ),
                    Text(
                      'H3',
                      style: Theme.of(context).textTheme.displaySmall,
                      textAlign: TextAlign.start,
                    ),
                    Text(
                      'H4',
                      style: Theme.of(context).textTheme.headlineLarge,
                      textAlign: TextAlign.start,
                    ),
                    Text(
                      'H5',
                      style: Theme.of(context).textTheme.headlineMedium,
                      textAlign: TextAlign.start,
                    ),
                    Text(
                      'H6',
                      style: Theme.of(context).textTheme.headlineSmall,
                      textAlign: TextAlign.start,
                    ),
                    Text(
                      'Body Lead',
                      style: Theme.of(context).textTheme.bodyLarge,
                      textAlign: TextAlign.start,
                    ),
                    Text(
                      'Body',
                      style: Theme.of(context).textTheme.bodyMedium,
                      textAlign: TextAlign.start,
                    ),
                    Text(
                      'Body Small',
                      style: Theme.of(context).textTheme.bodySmall,
                      textAlign: TextAlign.start,
                    ),

                    Center(
                      child: Text(
                        LanguageS.get(TextApp.colors),
                        style: TypographyDS.h2,
                      ),
                    ),
                    SizedBox(
                      height: 20,
                      width: 10,
                      child: Container(color: ColorsDS.primary),
                    ),
                    SizedBox(
                      height: 20,
                      width: 10,
                      child: Container(color: ColorsDS.secondary),
                    ),
                    SizedBox(
                      height: 20,
                      width: 10,
                      child: Container(color: ColorsDS.success),
                    ),
                    SizedBox(
                      height: 20,
                      width: 10,
                      child: Container(color: ColorsDS.info),
                    ),
                    SizedBox(
                      height: 20,
                      width: 10,
                      child: Container(color: ColorsDS.warning),
                    ),
                    SizedBox(
                      height: 20,
                      width: 10,
                      child: Container(color: ColorsDS.danger),
                    ),
                    SizedBox(
                      height: 20,
                      width: 10,
                      child: Container(color: ColorsDS.light),
                    ),
                    SizedBox(
                      height: 20,
                      width: 10,
                      child: Container(color: ColorsDS.dark),
                    ),
                    SizedBox(
                      height: 20,
                      width: 10,
                      child: Container(color: ColorsDS.white),
                    ),
                    SizedBox(
                      height: 20,
                      width: 10,
                      child: Container(color: ColorsDS.black),
                    ),
                    Center(
                      child: CpText(
                        LanguageS.get(TextApp.spacings),
                        color: ColorsDS.dark,
                        style: TypographyDS.h3,
                      ),
                    ),
                    Text("Spacings s0"),
                    SizedBox(
                      height: SpacingsDS.s0,
                      child: Container(color: ColorsDS.danger),
                    ),
                    Text("Spacings s1"),
                    SizedBox(
                      height: SpacingsDS.s1,
                      child: Container(color: ColorsDS.danger),
                    ),
                    Text("Spacings s2"),
                    SizedBox(
                      height: SpacingsDS.s2,
                      child: Container(color: ColorsDS.danger),
                    ),
                    Text("Spacings s3"),
                    SizedBox(
                      height: SpacingsDS.s3,
                      child: Container(color: ColorsDS.danger),
                    ),
                    Text("Spacings s4"),
                    SizedBox(
                      height: SpacingsDS.s4,
                      child: Container(color: ColorsDS.danger),
                    ),
                    Text("Spacings s5"),
                    SizedBox(
                      height: SpacingsDS.s5,
                      child: Container(color: ColorsDS.danger),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
