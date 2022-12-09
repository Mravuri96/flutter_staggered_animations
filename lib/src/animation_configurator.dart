import 'package:flutter/widgets.dart';

import 'animation_configuration.dart';
import 'animation_executor.dart';

class AnimationConfigurator extends StatelessWidget {
  const AnimationConfigurator({
    super.key,
    this.duration,
    this.delay,
    required this.animatedChildBuilder,
  });
  final Duration? duration;
  final Duration? delay;
  final Widget Function(Animation<double>) animatedChildBuilder;

  @override
  Widget build(final BuildContext context) {
    final animationConfiguration = AnimationConfiguration.of(context);

    if (animationConfiguration == null) {
      throw FlutterError.fromParts(
        <DiagnosticsNode>[
          ErrorSummary('Animation not wrapped in an AnimationConfiguration.'),
          ErrorDescription(
              'This error happens if you use an Animation that is not wrapped in an '
              'AnimationConfiguration.'),
          ErrorHint(
              'The solution is to wrap your Animation(s) with an AnimationConfiguration. '
              'Reminder: an AnimationConfiguration provides the configuration '
              'used as a base for every children Animation. Configuration made in AnimationConfiguration '
              'can be overridden in Animation children if needed.'),
        ],
      );
    }

    final position = animationConfiguration.position;
    final duration = this.duration ?? animationConfiguration.duration;
    final delay = this.delay ?? animationConfiguration.delay;
    final columnCount = animationConfiguration.columnCount;

    return AnimationExecutor(
      duration: duration,
      delay: stagger(position, duration, delay, columnCount),
      builder: (final context, final animationController) =>
          animatedChildBuilder(animationController!),
    );
  }

  Duration stagger(
    final int position,
    final Duration duration,
    final Duration? delay,
    final int columnCount,
  ) {
    final delayInMilliseconds =
        delay == null ? duration.inMilliseconds ~/ 6 : delay.inMilliseconds;

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
