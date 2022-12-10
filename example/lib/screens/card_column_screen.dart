import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

import '../widgets/auto_refresh.dart';
import '../widgets/empty_card.dart';

class CardColumnScreen extends StatefulWidget {
  const CardColumnScreen({super.key});

  @override
  _CardColumnScreenState createState() => _CardColumnScreenState();
}

class _CardColumnScreenState extends State<CardColumnScreen> {
  @override
  Widget build(final BuildContext context) => AutoRefresh(
        duration: const Duration(milliseconds: 2000),
        child: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: const Text('Animated Column View'),
          ),
          body: SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: AnimationLimiter(
                child: Column(
                  children: AnimationConfiguration.toStaggeredList(
                    duration: const Duration(milliseconds: 375),
                    childAnimationBuilder: (final widget) => SlideAnimation(
                      horizontalOffset: MediaQuery.of(context).size.width / 2,
                      child: FadeInAnimation(child: widget),
                    ),
                    children: [
                      EmptyCard(
                        width: MediaQuery.of(context).size.width,
                        height: 166,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: const [
                            EmptyCard(height: 50, width: 50),
                            EmptyCard(height: 50, width: 50),
                            EmptyCard(height: 50, width: 50),
                          ],
                        ),
                      ),
                      Row(
                        children: const [
                          Flexible(child: EmptyCard(height: 150)),
                          Flexible(child: EmptyCard(height: 150)),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        child: Row(
                          children: const [
                            Flexible(child: EmptyCard(height: 50)),
                            Flexible(child: EmptyCard(height: 50)),
                            Flexible(child: EmptyCard(height: 50)),
                          ],
                        ),
                      ),
                      EmptyCard(
                        width: MediaQuery.of(context).size.width,
                        height: 166,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      );
}
