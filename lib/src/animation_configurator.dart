import 'package:flutter/widgets.dart';

import 'animation_configuration.dart';
import 'animation_executor.dart';

class AnimationConfigurator extends StatelessWidget {
  const AnimationConfigurator({
    required this.animatedChildBuilder,
    super.key,
    this.duration,
    this.delay,
  });
  final Duration? duration;
  final Duration? delay;
  final Widget Function(Animation<double>) animatedChildBuilder;

  @override
  Widget build(BuildContext context) {
    final animationConfiguration = AnimationConfiguration.of(context);

    if (animationConfiguration == null) {
      throw FlutterError.fromParts(<DiagnosticsNode>[
        ErrorSummary('Animation not wrapped in an AnimationConfiguration.'),
        ErrorDescription(
          'This error happens if you use an Animation that is not wrapped in an '
          'AnimationConfiguration.',
        ),
        ErrorHint(
          'The solution is to wrap your Animation(s) with an AnimationConfiguration. '
          'Reminder: an AnimationConfiguration provides the configuration '
          'used as a base for every children Animation. Configuration made in AnimationConfiguration '
          'can be overridden in Animation children if needed.',
        ),
      ]);
    }

    final position = animationConfiguration.position;
    final duration = this.duration ?? animationConfiguration.duration;
    final delay = this.delay ?? animationConfiguration.delay;
    final columnCount = animationConfiguration.columnCount;

    return AnimationExecutor(
      duration: duration,
      delay: stagger(position, duration, delay, columnCount),
      builder: (context, animationController) {
        return animatedChildBuilder(animationController);
      },
    );
  }

  Duration stagger(
    int position,
    Duration duration,
    Duration? delay,
    int columnCount,
  ) {
    final delayInMilliseconds = delay == null
        ? duration.inMilliseconds ~/ 6
        : delay.inMilliseconds;

    int computeStaggeredGridDuration() =>
        (position ~/ columnCount + position % columnCount) *
        delayInMilliseconds;

    int computeStaggeredListDuration() => position * delayInMilliseconds;

    return Duration(
      milliseconds: columnCount > 1
          ? computeStaggeredGridDuration()
          : computeStaggeredListDuration(),
    );
  }
}
