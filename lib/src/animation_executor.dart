import 'dart:async';

import 'package:flutter/widgets.dart';

import 'animation_limiter.dart';

typedef Builder = Widget Function(
  BuildContext context,
  AnimationController? animationController,
);

class AnimationExecutor extends StatefulWidget {
  const AnimationExecutor({
    super.key,
    required this.duration,
    this.delay = Duration.zero,
    required this.builder,
  });
  final Duration duration;
  final Duration delay;
  final Builder builder;

  @override
  _AnimationExecutorState createState() => _AnimationExecutorState();
}

class _AnimationExecutorState extends State<AnimationExecutor>
    with SingleTickerProviderStateMixin {
  late final AnimationController? _animationController;
  Timer? _timer;

  @override
  void initState() {
    super.initState();

    _animationController =
        AnimationController(duration: widget.duration, vsync: this);

    if (AnimationLimiter.shouldRunAnimation(context) ?? true) {
      _timer = Timer(widget.delay, _animationController!.forward);
    } else {
      _animationController?.value = 1.0;
    }
  }

  @override
  Widget build(final BuildContext context) => AnimatedBuilder(
        builder: _buildAnimation,
        animation: _animationController!,
      );

  @override
  void dispose() {
    _timer?.cancel();
    _animationController?.dispose();
    super.dispose();
  }

  Widget _buildAnimation(final BuildContext context, final Widget? child) =>
      widget.builder(context, _animationController);
}
