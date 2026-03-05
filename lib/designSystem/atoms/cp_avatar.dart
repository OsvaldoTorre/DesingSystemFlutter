import 'package:design_system_mobile/design_system.dart';

/// Tamaños de avatar
enum AvatarSizeDS { xs, sm, md, lg, xl }

/// CpAvatar — Muestra imagen de perfil o iniciales como fallback.
///
/// ```dart
/// CpAvatar(name: 'Juan García')
/// CpAvatar(imageUrl: 'https://...', size: AvatarSizeDS.lg)
/// CpAvatar(name: 'Ana López', size: AvatarSizeDS.sm, showBorder: true)
/// ```
class CpAvatar extends StatelessWidget {
  const CpAvatar({
    super.key,
    this.imageUrl,
    this.name,
    this.size = AvatarSizeDS.md,
    this.showBorder = false,
    this.borderColor,
    this.backgroundColor,
  });

  final String? imageUrl;
  final String? name;
  final AvatarSizeDS size;
  final bool showBorder;
  final Color? borderColor;
  final Color? backgroundColor;

  double get _diameter => switch (size) {
    AvatarSizeDS.xs => SizesDS.avatarXs,
    AvatarSizeDS.sm => SizesDS.avatarSm,
    AvatarSizeDS.md => SizesDS.avatarMd,
    AvatarSizeDS.lg => SizesDS.avatarLg,
    AvatarSizeDS.xl => SizesDS.avatarXl,
  };

  TextStyle get _textStyle => switch (size) {
    AvatarSizeDS.xs => TypographyDS.caption.copyWith(fontWeight: TypographyDS.weightMedium),
    AvatarSizeDS.sm => TypographyDS.caption.copyWith(fontWeight: TypographyDS.weightMedium),
    AvatarSizeDS.md => TypographyDS.body.copyWith(fontSize: 18, fontWeight: TypographyDS.weightMedium),
    AvatarSizeDS.lg => TypographyDS.h5.copyWith(fontWeight: TypographyDS.weightMedium),
    AvatarSizeDS.xl => TypographyDS.h3.copyWith(fontWeight: TypographyDS.weightMedium),
  };

  String get _initials {
    if (name == null || name!.trim().isEmpty) return '';
    final parts = name!.trim().split(' ').where((p) => p.isNotEmpty).toList();
    if (parts.isEmpty) return '';
    if (parts.length == 1) return parts.first[0].toUpperCase();
    return (parts.first[0] + parts.last[0]).toUpperCase();
  }

  @override
  Widget build(BuildContext context) {
    final hasImage  = imageUrl != null && imageUrl!.isNotEmpty;
    final initials  = _initials;
    final bg        = backgroundColor ?? ColorsDS.secondarySubtle;
    final radius    = _diameter / 2;

    Widget avatar = CircleAvatar(
      radius: radius,
      backgroundImage: hasImage ? NetworkImage(imageUrl!) : null,
      backgroundColor: bg,
      child: !hasImage && initials.isNotEmpty
          ? Text(
              initials,
              style: _textStyle.copyWith(color: ColorsDS.secondaryEmphasis),
            )
          : (!hasImage
              ? Icon(Icons.person, size: _diameter * 0.5, color: ColorsDS.gray500)
              : null),
    );

    if (showBorder) {
      avatar = Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(
            color: borderColor ?? ColorsDS.gray300,
            width: BorderDS.widthMd,
          ),
        ),
        child: avatar,
      );
    }

    return avatar;
  }
}
