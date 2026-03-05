import 'package:design_system_mobile/design_system.dart';

/// Modelo de paso
class StepItemDS {
  const StepItemDS({
    required this.title,
    required this.content,
    this.subtitle,
    this.icon,
    this.optional = false,
  });

  final String title;
  final Widget content;
  final String? subtitle;
  final IconData? icon;
  final bool optional;
}

/// Estado de un paso
enum StepStateDS { pending, active, completed, error }

/// Orientación del stepper
enum StepperOrientationDS { horizontal, vertical }

/// CpStepper — Flujo de pasos secuenciales para onboarding, checkout, formularios multi-paso.
///
/// ```dart
/// CpStepper(
///   steps: [
///     StepItemDS(title: 'Cuenta', subtitle: 'Datos de acceso', content: StepCuenta()),
///     StepItemDS(title: 'Perfil', content: StepPerfil()),
///     StepItemDS(title: 'Confirmar', content: StepConfirm()),
///   ],
///   onFinish: () => _completarRegistro(),
/// )
/// ```
class CpStepper extends StatefulWidget {
  const CpStepper({
    super.key,
    required this.steps,
    this.orientation = StepperOrientationDS.horizontal,
    this.initialStep = 0,
    this.onStepChanged,
    this.onFinish,
    this.finishLabel = 'Finalizar',
    this.nextLabel = 'Siguiente',
    this.backLabel = 'Atrás',
    this.canSkip = false,
    this.stepStates = const {},
  });

  final List<StepItemDS> steps;
  final StepperOrientationDS orientation;
  final int initialStep;
  final ValueChanged<int>? onStepChanged;
  final VoidCallback? onFinish;
  final String finishLabel;
  final String nextLabel;
  final String backLabel;
  final bool canSkip;

  /// Override del estado visual de pasos específicos: {0: StepStateDS.error}
  final Map<int, StepStateDS> stepStates;

  @override
  State<CpStepper> createState() => _CpStepperState();
}

class _CpStepperState extends State<CpStepper> {
  late int _current;

  @override
  void initState() {
    super.initState();
    _current = widget.initialStep;
  }

  bool get _isLast => _current == widget.steps.length - 1;
  bool get _isFirst => _current == 0;

  void _next() {
    if (!_isLast) {
      setState(() => _current++);
      widget.onStepChanged?.call(_current);
    } else {
      widget.onFinish?.call();
    }
  }

  void _back() {
    if (!_isFirst) {
      setState(() => _current--);
      widget.onStepChanged?.call(_current);
    }
  }

  StepStateDS _stateOf(int i) {
    if (widget.stepStates.containsKey(i)) return widget.stepStates[i]!;
    if (i < _current) return StepStateDS.completed;
    if (i == _current) return StepStateDS.active;
    return StepStateDS.pending;
  }

  @override
  Widget build(BuildContext context) {
    return widget.orientation == StepperOrientationDS.horizontal
        ? _HorizontalStepper(
            steps: widget.steps,
            current: _current,
            stateOf: _stateOf,
            onNext: _next,
            onBack: _back,
            isFirst: _isFirst,
            isLast: _isLast,
            nextLabel: widget.nextLabel,
            backLabel: widget.backLabel,
            finishLabel: widget.finishLabel,
          )
        : _VerticalStepper(
            steps: widget.steps,
            current: _current,
            stateOf: _stateOf,
            onNext: _next,
            onBack: _back,
            isFirst: _isFirst,
            isLast: _isLast,
            nextLabel: widget.nextLabel,
            backLabel: widget.backLabel,
            finishLabel: widget.finishLabel,
          );
  }
}

// ─── Horizontal ───────────────────────────────────────────────────────────────
class _HorizontalStepper extends StatelessWidget {
  const _HorizontalStepper({
    required this.steps,
    required this.current,
    required this.stateOf,
    required this.onNext,
    required this.onBack,
    required this.isFirst,
    required this.isLast,
    required this.nextLabel,
    required this.backLabel,
    required this.finishLabel,
  });

  final List<StepItemDS> steps;
  final int current;
  final StepStateDS Function(int) stateOf;
  final VoidCallback onNext;
  final VoidCallback onBack;
  final bool isFirst;
  final bool isLast;
  final String nextLabel;
  final String backLabel;
  final String finishLabel;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // ─── Indicadores ────────────────────────────────────────────────────
        Row(
          children: steps.asMap().entries.expand((e) {
            final i     = e.key;
            final step  = e.value;
            final state = stateOf(i);
            final isLast = i == steps.length - 1;

            return [
              Expanded(
                child: _StepIndicator(
                  index: i,
                  step: step,
                  state: state,
                  horizontal: true,
                ),
              ),
              if (!isLast)
                Expanded(
                  child: _StepConnector(
                    completed: stateOf(i) == StepStateDS.completed,
                    horizontal: true,
                  ),
                ),
            ];
          }).toList(),
        ),

        const SizedBox(height: SpacingsDS.lg),

        // ─── Contenido del paso actual ───────────────────────────────────────
        AnimatedSwitcher(
          duration: TransitionsDS.tab.duration,
          child: KeyedSubtree(
            key: ValueKey(current),
            child: steps[current].content,
          ),
        ),

        const SizedBox(height: SpacingsDS.lg),
        const CpDivider(),
        const SizedBox(height: SpacingsDS.md),

        // ─── Controles ───────────────────────────────────────────────────────
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            isFirst
                ? const SizedBox()
                : CpButton(
                    label: backLabel,
                    variant: ButtonVariantDS.outlinePrimary,
                    prefixIcon: Icons.arrow_back,
                    onPressed: onBack,
                  ),
            CpButton(
              label: isLast ? finishLabel : nextLabel,
              suffixIcon: isLast ? Icons.check : Icons.arrow_forward,
              onPressed: onNext,
            ),
          ],
        ),
      ],
    );
  }
}

// ─── Vertical ─────────────────────────────────────────────────────────────────
class _VerticalStepper extends StatelessWidget {
  const _VerticalStepper({
    required this.steps,
    required this.current,
    required this.stateOf,
    required this.onNext,
    required this.onBack,
    required this.isFirst,
    required this.isLast,
    required this.nextLabel,
    required this.backLabel,
    required this.finishLabel,
  });

  final List<StepItemDS> steps;
  final int current;
  final StepStateDS Function(int) stateOf;
  final VoidCallback onNext;
  final VoidCallback onBack;
  final bool isFirst;
  final bool isLast;
  final String nextLabel;
  final String backLabel;
  final String finishLabel;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: steps.asMap().entries.map((e) {
        final i     = e.key;
        final step  = e.value;
        final state = stateOf(i);
        final isActive = i == current;
        final isLastStep = i == steps.length - 1;

        return Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ─── Indicador + línea ──────────────────────────────────────────
            Column(
              children: [
                _StepIndicator(index: i, step: step, state: state, horizontal: false),
                if (!isLastStep)
                  _StepConnector(
                    completed: state == StepStateDS.completed,
                    horizontal: false,
                    height: isActive ? null : 40,
                  ),
              ],
            ),

            const SizedBox(width: SpacingsDS.md),

            // ─── Contenido ──────────────────────────────────────────────────
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 6),
                  Text(
                    step.title,
                    style: TypographyDS.body.copyWith(
                      fontWeight: isActive
                          ? TypographyDS.weightSemi
                          : TypographyDS.weightNormal,
                      color: isActive ? ColorsDS.primary : ColorsDS.gray700,
                    ),
                  ),
                  if (step.subtitle != null)
                    Text(step.subtitle!, style: TypographyDS.caption),

                  if (isActive) ...[
                    const SizedBox(height: SpacingsDS.md),
                    step.content,
                    const SizedBox(height: SpacingsDS.md),
                    Row(
                      children: [
                        if (!isFirst)
                          CpButton(
                            label: backLabel,
                            variant: ButtonVariantDS.outlinePrimary,
                            size: ButtonSizeDS.sm,
                            onPressed: onBack,
                          ),
                        const SizedBox(width: SpacingsDS.sm),
                        CpButton(
                          label: isLast ? finishLabel : nextLabel,
                          size: ButtonSizeDS.sm,
                          onPressed: onNext,
                        ),
                      ],
                    ),
                    const SizedBox(height: SpacingsDS.md),
                  ],
                ],
              ),
            ),
          ],
        );
      }).toList(),
    );
  }
}

// ─── Indicador de paso ────────────────────────────────────────────────────────
class _StepIndicator extends StatelessWidget {
  const _StepIndicator({
    required this.index,
    required this.step,
    required this.state,
    required this.horizontal,
  });

  final int index;
  final StepItemDS step;
  final StepStateDS state;
  final bool horizontal;

  Color get _bg => switch (state) {
    StepStateDS.active    => ColorsDS.primary,
    StepStateDS.completed => ColorsDS.success,
    StepStateDS.error     => ColorsDS.danger,
    StepStateDS.pending   => ColorsDS.gray200,
  };

  Color get _fg => switch (state) {
    StepStateDS.pending => ColorsDS.gray500,
    _                   => ColorsDS.white,
  };

  @override
  Widget build(BuildContext context) {
    final circle = AnimatedContainer(
      duration: TransitionsDS.tab.duration,
      width: 32,
      height: 32,
      decoration: BoxDecoration(shape: BoxShape.circle, color: _bg),
      child: Center(
        child: state == StepStateDS.completed
            ? Icon(Icons.check, size: 16, color: _fg)
            : state == StepStateDS.error
                ? Icon(Icons.close, size: 16, color: _fg)
                : step.icon != null
                    ? Icon(step.icon, size: 16, color: _fg)
                    : Text(
                        '${index + 1}',
                        style: TypographyDS.label.copyWith(
                          color: _fg,
                          fontWeight: TypographyDS.weightBold,
                        ),
                      ),
      ),
    );

    if (!horizontal) return circle;

    return Column(
      children: [
        circle,
        const SizedBox(height: SpacingsDS.xs),
        Text(
          step.title,
          style: TypographyDS.caption.copyWith(
            color: state == StepStateDS.active
                ? ColorsDS.primary
                : ColorsDS.gray500,
            fontWeight: state == StepStateDS.active
                ? TypographyDS.weightSemi
                : TypographyDS.weightNormal,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}

// ─── Conector entre pasos ─────────────────────────────────────────────────────
class _StepConnector extends StatelessWidget {
  const _StepConnector({
    required this.completed,
    required this.horizontal,
    this.height,
  });

  final bool completed;
  final bool horizontal;
  final double? height;

  @override
  Widget build(BuildContext context) {
    final color = completed ? ColorsDS.success : ColorsDS.gray200;

    if (horizontal) {
      return Container(height: 2, color: color, margin: const EdgeInsets.only(top: 15));
    }
    return Container(
      width: 2,
      height: height ?? 40,
      margin: const EdgeInsets.only(left: 15),
      color: color,
    );
  }
}
