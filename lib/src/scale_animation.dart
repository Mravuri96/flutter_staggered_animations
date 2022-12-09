import 'package:flutter/widgets.dart';

import 'animation_configurator.dart';

/// An animation that scales its child.
class ScaleAnimation extends StatelessWidget {
  /// Creates a scale animation that scales its child for its center.
  ///
  /// Default value for [scale] is 0.0.
  ///
  /// The [child] argument must not be null.
  const ScaleAnimation({
    super.key,
    this.duration,
    this.delay,
    this.curve = Curves.ease,
    this.scale = 0.0,
    required this.child,
  }) : assert(scale >= 0.0);

  /// The duration of the child animation.
  final Duration? duration;

  /// The delay between the beginning of two children's animations.
  final Duration? delay;

  /// The curve of the child animation. Defaults to [Curves.ease].
  final Curve curve;

  /// Scaling factor to apply at the start of the animation.
  final double scale;

  /// The child Widget to animate.
  final Widget child;

  @override
  Widget build(final BuildContext context) => AnimationConfigurator(
        duration: duration,
        delay: delay,
        animatedChildBuilder: _landingAnimation,
      );

  Widget _landingAnimation(final Animation<double> animation) {
    final landingAnimation = Tween<double>(begin: scale, end: 1).animate(
      CurvedAnimation(
        parent: animation,
        curve: Interval(0, 1, curve: curve),
      ),
    );

    return Transform.scale(
      scale: landingAnimation.value,
      child: child,
    );
  }
}
