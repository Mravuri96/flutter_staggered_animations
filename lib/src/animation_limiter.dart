import 'package:flutter/widgets.dart';

/// In the context of a scrollable view, your children's animations are only built
/// as the user scrolls and they appear on the screen.
///
/// This create a situation
/// where your animations will be run as you scroll through the content.
///
/// If this is not a behaviour you want in your app, you can use AnimationLimiter.
///
/// AnimationLimiter is an InheritedWidget that prevents the children widgets to be
/// animated if they don't appear in the first frame where AnimationLimiter is built.
///
/// To be effective, AnimationLimiter musts be a direct parent of your scrollable list of widgets.
class AnimationLimiter extends StatefulWidget {
  /// Creates an [AnimationLimiter] that will prevents the children widgets to be
  /// animated if they don't appear in the first frame where AnimationLimiter is built.
  ///
  /// The [child] argument must not be null.
  const AnimationLimiter({required this.child, super.key});

  /// The child Widget to animate.
  final Widget child;

  @override
  State<AnimationLimiter> createState() => _AnimationLimiterState();

  static bool? shouldRunAnimation(BuildContext context) =>
      _AnimationLimiterProvider.of(context)?.shouldRunAnimation;
}

class _AnimationLimiterState extends State<AnimationLimiter> {
  var _shouldRunAnimation = true;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback(( value) {
      if (!mounted) {
        return;
      }
      setState(() {
        _shouldRunAnimation = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) => _AnimationLimiterProvider(
    shouldRunAnimation: _shouldRunAnimation,
    child: widget.child,
  );
}

class _AnimationLimiterProvider extends InheritedWidget {
  const _AnimationLimiterProvider({
    required super.child,
    this.shouldRunAnimation,
  });
  final bool? shouldRunAnimation;

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => false;

  static _AnimationLimiterProvider? of(BuildContext context) =>
      context.findAncestorWidgetOfExactType<_AnimationLimiterProvider>();
}
