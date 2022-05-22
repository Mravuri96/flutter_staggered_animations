import 'dart:math';

import 'package:flutter/material.dart';

class EmptyCard extends StatelessWidget {
  final double? width;
  final double? height;

  const EmptyCard({
    super.key,
    this.width,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    final color = Random.secure();
    final r = color.nextInt(255);
    final g = color.nextInt(255);
    final b = color.nextInt(255);

    final randomCol = Color.fromARGB(225, r, g, b);
    return Container(
      width: width,
      height: height,
      margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
      decoration: BoxDecoration(
        color: randomCol,
        borderRadius: const BorderRadius.all(Radius.circular(4.0)),
        boxShadow: const <BoxShadow>[
          BoxShadow(
            color: Colors.black12,
            blurRadius: 4.0,
            offset: Offset(0.0, 4.0),
          ),
        ],
      ),
    );
  }
}
