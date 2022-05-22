import 'package:example/widgets/auto_refresh.dart';
import 'package:example/widgets/empty_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

class ScaleTest extends StatefulWidget {
  const ScaleTest({super.key});
  @override
  _ScaleTestState createState() => _ScaleTestState();
}

class _ScaleTestState extends State<ScaleTest> {
  late bool rev;
  @override
  void initState() {
    rev = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(56),
        child: Builder(
          builder: (context) {
            return AppBar(
              centerTitle: true,
              title: const Text('Card Flip example'),
              actions: <Widget>[
                Container(
                  child: IconButton(
                    icon: const Icon(Icons.sort),
                    onPressed: () => setState(
                      () {
                        rev ? rev = false : rev = true;
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            duration: const Duration(seconds: 1),
                            backgroundColor: Colors.blueAccent.shade700,
                            content: Text(
                              rev ? 'List Reversed' : 'Normal List',
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                )
              ],
            );
          },
        ),
      ),
      body: AutoRefresh(
        duration: const Duration(milliseconds: 2000),
        child: SafeArea(
          child: AnimationLimiter(
            child: ListView.builder(
              padding: const EdgeInsets.all(8.0),
              itemCount: 100,
              reverse: rev,
              itemBuilder: (BuildContext context, int index) {
                return AnimationConfiguration.staggeredList(
                  position: index,
                  duration: const Duration(milliseconds: 375),
                  child: ScaleAnimation(
                    scale: 2,
                    child: FadeInAnimation(
                      child: EmptyCard(
                        width: MediaQuery.of(context).size.width,
                        height: 88.0,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
