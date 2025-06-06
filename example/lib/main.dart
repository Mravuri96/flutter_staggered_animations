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
  Widget build(BuildContext context) => MaterialApp(
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
  Widget build(BuildContext context) {
    final pages = [
      ElevatedButton.icon(
        icon: const Icon(Icons.list),
        label: const Text('List Card Test'),
        onPressed: () async {
          await Navigator.push<CardListScreen>(
            context,
            MaterialPageRoute<CardListScreen>(
              builder: (context) => const CardListScreen(),
              maintainState: false,
            ),
          );
        },
      ),
      ElevatedButton.icon(
        icon: const Icon(Icons.grid_on),
        label: const Text('Grid Card Test'),
        onPressed: () async {
          await Navigator.push(
            context,
            MaterialPageRoute<CardGridScreen>(
              maintainState: false,
              builder: (context) => const CardGridScreen(),
            ),
          );
        },
      ),
      ElevatedButton.icon(
        icon: const Icon(Icons.flip),
        label: const Text('Flip Card Test'),
        onPressed: () async {
          await Navigator.push(
            context,
            MaterialPageRoute<CardFlipTest>(
              builder: (context) => const CardFlipTest(),
              maintainState: false,
            ),
          );
        },
      ),
      ElevatedButton.icon(
        icon: const Icon(Icons.zoom_in),
        label: const Text('Scale Card Test'),
        onPressed: () async {
          await Navigator.push(
            context,
            MaterialPageRoute<ScaleTest>(
              builder: (context) => const ScaleTest(),
              maintainState: false,
            ),
          );
        },
      ),
      ElevatedButton.icon(
        icon: const Icon(Icons.view_column),
        label: const Text('Column Card Test'),
        onPressed: () async {
          await Navigator.push(
            context,
            MaterialPageRoute<CardColumnScreen>(
              builder: (context) => const CardColumnScreen(),
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
            SizedBox.expand(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  ElevatedButton(
                    child: const Text('List Card Test'),
                    onPressed: () async {
                      await Navigator.push<CardListScreen>(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const CardListScreen(),
                        ),
                      );
                    },
                  ),
                  ElevatedButton(
                    child: const Text('Grid Card Test'),
                    onPressed: () async {
                      await Navigator.push<CardGridScreen>(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const CardGridScreen(),
                        ),
                      );
                    },
                  ),
                  ElevatedButton(
                    child: const Text('Column Card Test'),
                    onPressed: () async {
                      await Navigator.push(
                        context,
                        MaterialPageRoute<CardColumnScreen>(
                          builder: (context) => const CardColumnScreen(),
                        ),
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
              itemBuilder: (context, i) => Padding(
                padding: const EdgeInsets.all(8),
                child: Center(
                  child: AnimationConfiguration.staggeredList(
                    duration: const Duration(milliseconds: 750),
                    position: i,
                    child: SlideAnimation(
                      verticalOffset: i.isEven ? 88.0 : 88.0,
                      horizontalOffset: i.isEven ? 88.0 : -88.0,
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
