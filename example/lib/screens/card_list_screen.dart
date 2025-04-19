import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

import '../widgets/auto_refresh.dart';
import '../widgets/empty_card.dart';

class CardListScreen extends StatefulWidget {
  const CardListScreen({super.key});

  @override
  State<CardListScreen> createState() => _CardListScreenState();
}

class _CardListScreenState extends State<CardListScreen> {
  @override
  Widget build(BuildContext context) => AutoRefresh(
    duration: const Duration(milliseconds: 2000),
    child: Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Animated List View'),
      ),
      body: SafeArea(
        child: AnimationLimiter(
          child: ListView.builder(
            padding: const EdgeInsets.all(8),
            itemCount: 100,
            itemBuilder: (context, index) =>
                AnimationConfiguration.staggeredList(
                  position: index,
                  duration: const Duration(milliseconds: 375),
                  child: SlideAnimation(
                    verticalOffset: index.isEven ? 88.0 : 88.0,
                    horizontalOffset: index.isEven ? 88.0 : -88.0,
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
