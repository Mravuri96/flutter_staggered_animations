import 'dart:math';

import 'package:flutter/widgets.dart';

import 'animation_configurator.dart';

/// An enum representing a flip axis.
enum FlipAxis {
  /// The x axis (vertical flip)
  x,

  /// The y axis (horizontal flip)
  y,
}

/// An animation that flips its child either vertically or horizontally.
class FlipAnimation extends StatelessWidget {
  /// Creates a flip animation that flips its child.
  ///
  /// Default value for [flipAxis] is [FlipAxis.x].
  ///
  /// The [child] argument must not be null.
  const FlipAnimation({
    required this.child,
    super.key,
    this.duration,
    this.delay,
    this.curve = Curves.ease,
    this.flipAxis = FlipAxis.x,
  });

  /// The duration of the child animation.
  final Duration? duration;

  /// The delay between the beginning of two children's animations.
  final Duration? delay;

  /// The curve of the child animation. Defaults to [Curves.ease].
  final Curve curve;

  /// The [FlipAxis] in which the child widget will be flipped.
  final FlipAxis flipAxis;

  /// The child Widget to animate.
  final Widget child;

  @override
  Widget build(BuildContext context) => AnimationConfigurator(
    duration: duration,
    delay: delay,
    animatedChildBuilder: _flipAnimation,
  );

  Widget _flipAnimation(Animation<double> animation) {
    final flipAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: animation,
        curve: Interval(0, 1, curve: curve),
      ),
    );

    Matrix4 computeTransformationMatrix() {
      final radians = (1 - flipAnimation.value) * pi / 2;

      switch (flipAxis) {
        case FlipAxis.y:
          return Matrix4.rotationY(radians);
        case FlipAxis.x:
          return Matrix4.rotationX(radians);
      }
    }

    return Transform(
      transform: computeTransformationMatrix(),
      alignment: Alignment.center,
      child: child,
    );
  }
}
