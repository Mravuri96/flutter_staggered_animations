import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

import '../widgets/auto_refresh.dart';
import '../widgets/empty_card.dart';

class CardGridScreen extends StatefulWidget {
  const CardGridScreen({super.key});

  @override
  State<CardGridScreen> createState() => _CardGridScreenState();
}

class _CardGridScreenState extends State<CardGridScreen> {
  @override
  Widget build(BuildContext context) {
    const columnCount = 3;

    return AutoRefresh(
      duration: const Duration(milliseconds: 2000),
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text('Animated Grid View'),
        ),
        body: SafeArea(
          child: AnimationLimiter(
            child: GridView.count(
              padding: const EdgeInsets.all(8),
              crossAxisCount: columnCount,
              children: List.generate(
                100,
                (index) => AnimationConfiguration.staggeredGrid(
                  columnCount: columnCount,
                  position: index,
                  duration: const Duration(milliseconds: 375),
                  child: ScaleAnimation(
                    scale: 0.5,
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
      ),
    );
  }
}
