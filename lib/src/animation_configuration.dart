import 'package:flutter/widgets.dart';

/// [AnimationConfiguration] provides the configuration used as a base for every children Animation.
/// Configuration made in [AnimationConfiguration] can be overridden in Animation children if needed.
///
/// Depending on the scenario in which you will present your animations,
/// you should use one of [AnimationConfiguration]'s named constructors.
///
/// [AnimationConfiguration.synchronized] if you want to launch all the children's animations at the same time.
///
/// [AnimationConfiguration.staggeredList] if you want to delay the animation of each child
/// to produce a single-axis staggered animations (from top to bottom or from left to right).
///
/// [AnimationConfiguration.staggeredGrid] if you want to delay the animation of each child
/// to produce a dual-axis staggered animations (from left to right and top to bottom).
class AnimationConfiguration extends InheritedWidget {
  /// Configure the children's animation to be synchronized (all the children's animation start at the same time).
  ///
  /// Default value for [duration] is 225ms.
  ///
  /// The [child] argument must not be null.
  const AnimationConfiguration.synchronized({
    required super.child,
    super.key,
    this.duration = const Duration(milliseconds: 225),
  }) : position = 0,
       delay = Duration.zero,
       columnCount = 1;

  /// Configure the children's animation to be staggered.
  ///
  /// A staggered animation consists of sequential or overlapping animations.
  ///
  /// Each child animation will start with a delay based on its position comparing to previous children.
  ///
  /// The staggering effect will be based on a single axis (from top to bottom or from left to right).
  ///
  /// Use this named constructor to display a staggered animation on a single-axis list of widgets
  /// ([ListView], [ScrollView], [Column], [Row]...).
  ///
  /// The [position] argument must not be null.
  ///
  /// Default value for [duration] is 225ms.
  ///
  /// Default value for [delay] is the [duration] divided by 6
  /// (appropriate factor to keep coherence during the animation).
  ///
  /// The [child] argument must not be null.
  const AnimationConfiguration.staggeredList({
    required this.position,
    required super.child,
    super.key,
    this.duration = const Duration(milliseconds: 225),
    this.delay,
  }) : columnCount = 1;

  /// Configure the children's animation to be staggered.
  ///
  /// A staggered animation consists of sequential or overlapping animations.
  ///
  /// Each child animation will start with a delay based on its position comparing to previous children.
  ///
  /// The staggering effect will be based on a dual-axis (from left to right and top to bottom).
  ///
  /// Use this named constructor to display a staggered animation on a dual-axis list of widgets
  /// ([GridView]...).
  ///
  /// The [position] argument must not be null.
  ///
  /// Default value for [duration] is 225ms.
  ///
  /// Default value for [delay] is the [duration] divided by 6
  /// (appropriate factor to keep coherence during the animation).
  ///
  /// The [columnCount] argument must not be null and must be greater than 0.
  ///
  /// The [child] argument must not be null.
  const AnimationConfiguration.staggeredGrid({
    required this.position,
    required this.columnCount,
    required super.child,
    super.key,
    this.duration = const Duration(milliseconds: 225),
    this.delay,
  });

  /// Index used as a factor to calculate the delay of each child's animation.
  final int position;

  /// The duration of each child's animation.
  final Duration duration;

  /// The delay between the beginning of two children's animations.
  final Duration? delay;

  /// The column count of the grid
  final int columnCount;

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => false;

  /// Helper method to apply a staggered animation to the children of a [Column] or [Row].
  ///
  /// It maps every child with an index and calls
  /// [AnimationConfiguration.staggeredList] constructor under the hood.
  ///
  /// Default value for [duration] is 225ms.
  ///
  /// Default value for [delay] is the [duration] divided by 6
  /// (appropriate factor to keep coherence during the animation).
  ///
  /// The [childAnimationBuilder] is a function that will be applied to each child you provide in [children]
  ///
  /// The following is an example of a [childAnimationBuilder] you could provide:
  ///
  /// ```dart
  /// (widget) => SlideAnimation(
  ///   horizontalOffset: 50.0,
  ///   child: FadeInAnimation(
  ///     child: widget,
  ///   ),
  /// )
  /// ```
  ///
  /// The [children] argument must not be null.
  /// It corresponds to the children you would normally have passed to the [Column] or [Row].
  static List<Widget> toStaggeredList({
    required Widget Function(Widget) childAnimationBuilder,
    required List<Widget> children,
    Duration? duration,
    Duration? delay,
  }) => [
    ...children
        .asMap()
        .map(
          (index, widget) => MapEntry(
            index,
            AnimationConfiguration.staggeredList(
              position: index,
              duration: duration ?? const Duration(milliseconds: 225),
              delay: delay,
              child: childAnimationBuilder(widget),
            ),
          ),
        )
        .values,
  ];

  static AnimationConfiguration? of(BuildContext context) =>
      context.findAncestorWidgetOfExactType<AnimationConfiguration>();
}
