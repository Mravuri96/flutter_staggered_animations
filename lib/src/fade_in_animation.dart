import 'package:flutter/widgets.dart';

import 'animation_configurator.dart';

/// An animation that fades its child.
class FadeInAnimation extends StatelessWidget {
  /// Creates a fade animation that fades its child.
  ///
  /// The [child] argument must not be null.
  const FadeInAnimation({
    required this.child,
    super.key,
    this.duration,
    this.delay,
    this.curve = Curves.ease,
  });

  /// The duration of the child animation.
  final Duration? duration;

  /// The delay between the beginning of two children's animations.
  final Duration? delay;

  /// The curve of the child animation. Defaults to [Curves.ease].
  final Curve curve;

  /// The child Widget to animate.
  final Widget child;

  @override
  Widget build(BuildContext context) => AnimationConfigurator(
    duration: duration,
    delay: delay,
    animatedChildBuilder: _fadeInAnimation,
  );

  Widget _fadeInAnimation(Animation<double> animation) {
    final opacityAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: animation,
        curve: Interval(0, 1, curve: curve),
      ),
    );

    return Opacity(opacity: opacityAnimation.value, child: child);
  }
}
