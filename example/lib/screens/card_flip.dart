import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

import '../widgets/auto_refresh.dart';
import '../widgets/empty_card.dart';

class CardFlipTest extends StatefulWidget {
  const CardFlipTest({super.key});

  @override
  _CardFlipTestState createState() => _CardFlipTestState();
}

class _CardFlipTestState extends State<CardFlipTest>
    with SingleTickerProviderStateMixin {
  late FlipAxis axis;
  @override
  void initState() {
    axis = FlipAxis.x;

    super.initState();
  }

  @override
  Widget build(final BuildContext context) => Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(56),
          child: Builder(
            builder: (final context) => AppBar(
              centerTitle: true,
              title: const Text('Card Flip example'),
              actions: <Widget>[
                IconButton(
                  icon: const Icon(Icons.flip),
                  onPressed: () => setState(
                    () {
                      axis == FlipAxis.x
                          ? axis = FlipAxis.y
                          : axis = FlipAxis.x;
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          duration: const Duration(seconds: 1),
                          backgroundColor: Colors.blueAccent.shade700,
                          content: Text(
                            'Flip axis is set to the " ${axis.toString().substring(9).toUpperCase()} " axis',
                          ),
                        ),
                      );
                    },
                  ),
                )
              ],
            ),
          ),
        ),
        body: AutoRefresh(
          duration: const Duration(milliseconds: 2000),
          child: SafeArea(
            child: AnimationLimiter(
              child: ListView.builder(
                padding: const EdgeInsets.all(8),
                itemCount: 100,
                itemBuilder: (final context, final index) =>
                    AnimationConfiguration.staggeredList(
                  position: index,
                  duration: const Duration(milliseconds: 375),
                  child: FlipAnimation(
                    flipAxis: axis,
                    child: FadeInAnimation(
                      child: EmptyCard(
                        width: MediaQuery.of(context).size.width,
                        height: 88,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      );
}
