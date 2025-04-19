import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

import 'screens/card_column_screen.dart';
import 'screens/card_flip.dart';
import 'screens/card_grid_screen.dart';
import 'screens/card_list_screen.dart';
import 'screens/card_scale.dart';

void main() => runApp(const App());

class App extends StatelessWidget {
  const App({super.key});
  @override
  Widget build(final BuildContext context) => MaterialApp(
        theme: ThemeData(
          brightness: Brightness.light,
          scaffoldBackgroundColor: const Color.fromRGBO(239, 238, 239, 1),
        ),
        home: const HomeScreen(),
        debugShowCheckedModeBanner: false,
      );
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(final BuildContext context) {
    final pages = [
      ElevatedButton.icon(
        icon: const Icon(Icons.list),
        label: const Text('List Card Test'),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute<CardListScreen>(
              builder: (final context) => const CardListScreen(),
              maintainState: false,
            ),
          );
        },
      ),
      ElevatedButton.icon(
        icon: const Icon(Icons.grid_on),
        label: const Text('Grid Card Test'),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute<CardGridScreen>(
              maintainState: false,
              builder: (final context) => const CardGridScreen(),
            ),
          );
        },
      ),
      ElevatedButton.icon(
        icon: const Icon(Icons.flip),
        label: const Text('Flip Card Test'),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute<CardFlipTest>(
              builder: (final context) => const CardFlipTest(),
              maintainState: false,
            ),
          );
        },
      ),
      ElevatedButton.icon(
        icon: const Icon(Icons.zoom_in),
        label: const Text('Scale Card Test'),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute<ScaleTest>(
              builder: (final context) => const ScaleTest(),
              maintainState: false,
            ),
          );
        },
      ),
      ElevatedButton.icon(
        icon: const Icon(Icons.view_column),
        label: const Text('Column Card Test'),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute<CardColumnScreen>(
              builder: (final context) => const CardColumnScreen(),
              maintainState: false,
            ),
          );
        },
      ),
    ];
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Staggered Animations'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          children: [
            SizedBox(
              height: double.infinity,
              width: double.infinity,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  ElevatedButton(
                    child: const Text('List Card Test'),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const CardListScreen()),
                      );
                    },
                  ),
                  ElevatedButton(
                    child: const Text('Grid Card Test'),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const CardGridScreen()),
                      );
                    },
                  ),
                  ElevatedButton(
                    child: const Text('Column Card Test'),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const CardColumnScreen()),
                      );
                    },
                  ),
                ],
              ),
            ),
            ListView.builder(
              itemCount: pages.length,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (final context, final i) => Padding(
                padding: const EdgeInsets.all(8),
                child: Center(
                  child: AnimationConfiguration.staggeredList(
                    duration: const Duration(milliseconds: 750),
                    position: i,
                    child: SlideAnimation(
                      verticalOffset: i % 2 == 0 ? 88.0 : 88.0,
                      horizontalOffset: i % 2 == 0 ? 88.0 : -88.0,
                      child: FadeInAnimation(
                        duration: const Duration(seconds: 1),
                        child: pages[i],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
