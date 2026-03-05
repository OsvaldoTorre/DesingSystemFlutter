import 'package:design_system_mobile/design_system.dart';
import 'package:flutter/material.dart';

/// Tamaños para el componente [CpAvatar]
enum AvatarSizeDS { sm, md, lg }

/// CpAvatar — Muestra una imagen de perfil o las iniciales de un nombre.
///
/// Se adapta a diferentes tamaños y muestra iniciales como fallback si no
/// se provee una URL de imagen.
class CpAvatar extends StatelessWidget {
  const CpAvatar({
    super.key,
    this.imageUrl,
    this.name,
    this.size = AvatarSizeDS.md,
  });

  /// URL de la imagen a mostrar.
  final String? imageUrl;

  /// Nombre para generar las iniciales si no hay imagen.
  final String? name;

  /// Tamaño del avatar, usando los tokens de `SizesDS`.
  final AvatarSizeDS size;

  double get _diameter => switch (size) {
    AvatarSizeDS.sm => 32.0,
    AvatarSizeDS.md => 48.0,
    AvatarSizeDS.lg => 64.0,
  };

  TextStyle get _textStyle => switch (size) {
    AvatarSizeDS.sm => TypographyDS.caption.copyWith(
      fontWeight: TypographyDS.weightMedium,
    ),
    AvatarSizeDS.md => TypographyDS.body.copyWith(
      fontSize: 18,
      fontWeight: TypographyDS.weightMedium,
    ),
    AvatarSizeDS.lg => TypographyDS.h5.copyWith(
      fontWeight: TypographyDS.weightMedium,
    ),
  };

  String get _initials {
    if (name == null || name!.trim().isEmpty) return '';
    final parts = name!.trim().split(' ').where((p) => p.isNotEmpty);
    if (parts.isEmpty) return '';
    if (parts.length == 1) return parts.first[0].toUpperCase();
    return (parts.first[0] + parts.last[0]).toUpperCase();
  }

  @override
  Widget build(BuildContext context) {
    final hasImage = imageUrl != null && imageUrl!.isNotEmpty;
    final initials = _initials;

    return CircleAvatar(
      radius: _diameter / 2,
      backgroundImage: hasImage ? NetworkImage(imageUrl!) : null,
      backgroundColor: ColorsDS.secondarySubtle,
      child: !hasImage && initials.isNotEmpty
          ? Text(
              initials,
              style: _textStyle.copyWith(color: ColorsDS.secondaryEmphasis),
            )
          : null,
    );
  }
}
