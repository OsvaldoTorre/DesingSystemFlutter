import 'package:design_system_mobile/design_system.dart';

/// CpSkeleton — Placeholder animado para estados de carga.
///
/// ```dart
/// // Línea de texto
/// CpSkeleton(width: 200, height: 16)
///
/// // Bloque (card, imagen)
/// CpSkeleton(width: double.infinity, height: 120, radius: RadiusDS.md)
///
/// // Círculo (avatar)
/// CpSkeleton.circle(size: 48)
///
/// // Párrafo completo
/// CpSkeleton.paragraph(lines: 3)
/// ```
class CpSkeleton extends StatefulWidget {
  const CpSkeleton({
    super.key,
    this.width,
    this.height = 16,
    this.radius,
  });

  const CpSkeleton.circle({
    super.key,
    required double size,
  })  : width = size,
        height = size,
        radius = 999;

  static Widget paragraph({int lines = 3, double lineHeight = 14}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: List.generate(lines, (i) {
        final isLast = i == lines - 1;
        return Padding(
          padding: EdgeInsets.only(bottom: i < lines - 1 ? SpacingsDS.sm : 0),
          child: CpSkeleton(
            width: isLast ? 160 : double.infinity,
            height: lineHeight,
          ),
        );
      }),
    );
  }

  final double? width;
  final double height;
  final double? radius;

  @override
  State<CpSkeleton> createState() => _CpSkeletonState();
}

class _CpSkeletonState extends State<CpSkeleton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    )..repeat(reverse: true);

    _animation = Tween<double>(begin: 0.4, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: TransitionsDS.fade.curve),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (_, __) => Opacity(
        opacity: _animation.value,
        child: Container(
          width: widget.width,
          height: widget.height,
          decoration: BoxDecoration(
            color: ColorsDS.gray200,
            borderRadius: BorderRadius.circular(
              widget.radius ?? RadiusDS.sm,
            ),
          ),
        ),
      ),
    );
  }
}
