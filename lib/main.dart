import 'package:design_system_mobile/design_system.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<String>(
      valueListenable: LanguageS.currentLang,
      builder: (context, lang, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          // ─── Integra los temas del Design System ──────────────────────────
          theme: AppThemeDS.light(),
          darkTheme: AppThemeDS.dark(),
          themeMode: ThemeMode.light,
          home: const _ShowcasePage(),
        );
      },
    );
  }
}

class _ShowcasePage extends StatefulWidget {
  const _ShowcasePage();

  @override
  State<_ShowcasePage> createState() => _ShowcasePageState();
}

class _ShowcasePageState extends State<_ShowcasePage> {
  bool _showAlert = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Design System'),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: SpacingsDS.md),
            child: CpBadge(
              label: 'v0.1',
              variant: VariantDS.primary,
              pill: false,
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(SpacingsDS.s3),
          children: [
            // ─── Selector de idioma ──────────────────────────────────────────
            Wrap(
              spacing: SpacingsDS.sm,
              children: ['es', 'en', 'pt', 'de']
                  .map(
                    (lang) => CpButton(
                      label: lang.toUpperCase(),
                      size: ButtonSizeDS.sm,
                      variant: LanguageS.currentLang.value == lang
                          ? ButtonVariantDS.primary
                          : ButtonVariantDS.outlinePrimary,
                      onPressed: () => LanguageS.currentLang.value = lang,
                    ),
                  )
                  .toList(),
            ),

            const SizedBox(height: SpacingsDS.s4),

            // ─── Tipografía ──────────────────────────────────────────────────
            CpText('Typography', style: TypographyDS.h2),
            const SizedBox(height: SpacingsDS.s2),
            CpText('Display Large', style: TypographyDS.displaySm),
            CpText('H1 Heading', style: TypographyDS.h1),
            CpText('H2 Heading', style: TypographyDS.h2),
            CpText('H3 Heading', style: TypographyDS.h3),
            CpText('H4 Heading', style: TypographyDS.h4),
            CpText('H5 Heading', style: TypographyDS.h5),
            CpText('H6 Heading', style: TypographyDS.h6),
            const SizedBox(height: SpacingsDS.s2),
            CpText('Lead — Paragraph introductivo', style: TypographyDS.lead),
            CpText(
              'Body — Texto de cuerpo estándar de 16px.',
              style: TypographyDS.body,
            ),
            CpText(
              'Small — Texto de apoyo en 14px.',
              style: TypographyDS.small,
            ),
            CpText('LABEL · UPPERCASE', style: TypographyDS.label),
            CpText('Caption — 10px auxiliar', style: TypographyDS.caption),

            const Divider(height: SpacingsDS.xl),

            // ─── Colores ─────────────────────────────────────────────────────
            CpText(LanguageS.get(TextApp.colors), style: TypographyDS.h2),
            const SizedBox(height: SpacingsDS.s2),
            Wrap(
              spacing: SpacingsDS.sm,
              runSpacing: SpacingsDS.sm,
              children: [
                _ColorChip('primary', ColorsDS.primary),
                _ColorChip('secondary', ColorsDS.secondary),
                _ColorChip('success', ColorsDS.success),
                _ColorChip('danger', ColorsDS.danger),
                _ColorChip('warning', ColorsDS.warning),
                _ColorChip('info', ColorsDS.info),
                _ColorChip('light', ColorsDS.light),
                _ColorChip('dark', ColorsDS.dark),
              ],
            ),

            const Divider(height: SpacingsDS.xl),

            // ─── Botones ─────────────────────────────────────────────────────
            CpText(LanguageS.get(TextApp.buttons), style: TypographyDS.h2),
            const SizedBox(height: SpacingsDS.s2),
            Wrap(
              spacing: SpacingsDS.sm,
              runSpacing: SpacingsDS.sm,
              children: [
                CpButton(label: 'Primary', onPressed: () {}),
                CpButton(
                  label: 'Secondary',
                  variant: ButtonVariantDS.secondary,
                  onPressed: () {},
                ),
                CpButton(
                  label: 'Success',
                  variant: ButtonVariantDS.success,
                  onPressed: () {},
                ),
                CpButton(
                  label: 'Danger',
                  variant: ButtonVariantDS.danger,
                  onPressed: () {},
                ),
                CpButton(
                  label: 'Warning',
                  variant: ButtonVariantDS.warning,
                  onPressed: () {},
                ),
                CpButton(
                  label: 'Info',
                  variant: ButtonVariantDS.info,
                  onPressed: () {},
                ),
              ],
            ),
            const SizedBox(height: SpacingsDS.sm),
            Wrap(
              spacing: SpacingsDS.sm,
              runSpacing: SpacingsDS.sm,
              children: [
                CpButton(
                  label: 'Outline',
                  variant: ButtonVariantDS.outlinePrimary,
                  onPressed: () {},
                ),
                CpButton(
                  label: 'Small',
                  size: ButtonSizeDS.sm,
                  onPressed: () {},
                ),
                CpButton(
                  label: 'Large',
                  size: ButtonSizeDS.lg,
                  onPressed: () {},
                ),
                CpButton(label: 'Loading', loading: true, onPressed: null),
                CpButton(label: 'Disabled', disabled: true, onPressed: () {}),
                CpButton(
                  label: 'Link',
                  variant: ButtonVariantDS.link,
                  onPressed: () {},
                ),
              ],
            ),
            const SizedBox(height: SpacingsDS.sm),
            CpButton(
              label: 'Full Width',
              fullWidth: true,
              prefixIcon: Icons.save,
              onPressed: () {},
            ),

            const Divider(height: SpacingsDS.xl),

            // ─── Alertas ─────────────────────────────────────────────────────
            Text('Alerts', style: TypographyDS.h2),
            const SizedBox(height: SpacingsDS.s2),
            if (_showAlert)
              CpAlert(
                title: 'Operación exitosa',
                message: 'Los cambios se guardaron correctamente.',
                variant: VariantDS.success,
                dismissible: true,
                onDismiss: () => setState(() => _showAlert = false),
              ),
            const SizedBox(height: SpacingsDS.sm),
            CpAlert(
              message: 'Esta es una alerta de información.',
              variant: VariantDS.info,
            ),
            const SizedBox(height: SpacingsDS.sm),
            CpAlert(
              title: 'Advertencia',
              message: 'Revisa los campos antes de continuar.',
              variant: VariantDS.warning,
            ),
            const SizedBox(height: SpacingsDS.sm),
            CpAlert(
              title: 'Error',
              message: 'No se pudo conectar al servidor.',
              variant: VariantDS.danger,
            ),

            const Divider(height: SpacingsDS.xl),

            // ─── Cards + Grid ─────────────────────────────────────────────────
            Text('Cards + Grid', style: TypographyDS.h2),
            const SizedBox(height: SpacingsDS.s2),
            CpContainer(
              child: CpRow(
                children: [
                  CpCol(
                    xs: 12,
                    md: 6,
                    child: CpCard(
                      header: CpCardHeader(
                        title: 'Usuarios',
                        trailing: CpBadge(
                          label: '12',
                          variant: VariantDS.success,
                          pill: true,
                        ),
                      ),
                      footer: CpCardFooter(
                        child: Text(
                          'Actualizado hace 5 min',
                          style: TypographyDS.caption,
                        ),
                      ),
                      child: CpCardBody(
                        title: 'Gestión de acceso',
                        text: 'Administra los permisos del sistema.',
                        actions: [
                          CpButton(
                            label: 'Ver todos',
                            size: ButtonSizeDS.sm,
                            onPressed: () {},
                          ),
                        ],
                      ),
                    ),
                  ),
                  CpCol(
                    xs: 12,
                    md: 6,
                    child: CpCard(
                      header: const CpCardHeader(title: 'Estadísticas'),
                      child: CpCardBody(
                        subtitle: 'ESTE MES',
                        title: '2,540 visitas',
                        text: 'Un incremento del 12% respecto al mes anterior.',
                        actions: [
                          CpButton(
                            label: 'Ver reporte',
                            size: ButtonSizeDS.sm,
                            variant: ButtonVariantDS.outlinePrimary,
                            onPressed: () {},
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const Divider(height: SpacingsDS.xl),

            // ─── Inputs ──────────────────────────────────────────────────────
            Text('Inputs', style: TypographyDS.h2),
            const SizedBox(height: SpacingsDS.s2),
            CpInput(
              label: 'Nombre completo',
              hint: 'Ej: Juan García',
              helpText: 'Tal como aparece en tu identificación.',
            ),
            const SizedBox(height: SpacingsDS.s3),
            CpInput(
              label: 'Email',
              hint: 'nombre@empresa.com',
              prefixIcon: Icons.email_outlined,
              keyboardType: TextInputType.emailAddress,
            ),
            const SizedBox(height: SpacingsDS.s3),
            const CpInput(
              label: 'Con error',
              hint: 'Escribe algo...',
              errorText: 'Este campo es obligatorio',
            ),
            const SizedBox(height: SpacingsDS.s3),
            const CpInput(
              label: 'Contraseña',
              obscureText: true,
              helpText: 'Mínimo 8 caracteres.',
            ),
            const SizedBox(height: SpacingsDS.s3),
            CpTextArea(
              label: 'Descripción',
              hint: 'Escribe aquí...',
              minLines: 3,
              maxLines: 6,
            ),

            const Divider(height: SpacingsDS.xl),

            // ─── Avatars ─────────────────────────────────────────────────────
            Text('Avatars', style: TypographyDS.h2),
            const SizedBox(height: SpacingsDS.s2),
            Wrap(
              spacing: SpacingsDS.md,
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                CpAvatar(size: AvatarSizeDS.sm, name: 'Bruce Wayne'),
                CpAvatar(size: AvatarSizeDS.md, name: 'Clark Kent'),
                CpAvatar(size: AvatarSizeDS.lg, name: 'Diana Prince'),
                CpAvatar(
                  size: AvatarSizeDS.lg,
                  imageUrl: 'https://i.pravatar.cc/150?u=wonderwoman',
                  name: 'Diana Prince',
                ),
              ],
            ),

            const Divider(height: SpacingsDS.xl),

            // ─── Spacings ────────────────────────────────────────────────────
            Text(LanguageS.get(TextApp.spacings), style: TypographyDS.h2),
            const SizedBox(height: SpacingsDS.s2),
            ...[
              's1 (4px)',
              's2 (8px)',
              's3 (16px)',
              's4 (24px)',
              's5 (48px)',
            ].asMap().entries.map(
              (e) => Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(e.value, style: TypographyDS.caption),
                  const SizedBox(height: 2),
                  Container(
                    height: [
                      SpacingsDS.s1,
                      SpacingsDS.s2,
                      SpacingsDS.s3,
                      SpacingsDS.s4,
                      SpacingsDS.s5,
                    ][e.key],
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: ColorsDS.primarySubtle,
                      borderRadius: RadiusDS.borderSm,
                      border: Border.all(
                        color: ColorsDS.primary.withOpacity(0.3),
                      ),
                    ),
                  ),
                  const SizedBox(height: SpacingsDS.sm),
                ],
              ),
            ),

            const SizedBox(height: SpacingsDS.xl),
          ],
        ),
      ),
    );
  }
}

/// Widget auxiliar para mostrar los color tokens
class _ColorChip extends StatelessWidget {
  const _ColorChip(this.name, this.color);
  final String name;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 56,
          height: 40,
          decoration: BoxDecoration(
            color: color,
            borderRadius: RadiusDS.borderSm,
            border: Border.all(color: ColorsDS.gray200),
          ),
        ),
        const SizedBox(height: 2),
        Text(name, style: TypographyDS.caption),
      ],
    );
  }
}
