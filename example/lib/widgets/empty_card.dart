import 'dart:math';

import 'package:flutter/material.dart';

class EmptyCard extends StatelessWidget {
  const EmptyCard({
    super.key,
    this.width,
    this.height,
  });
  final double? width;
  final double? height;

  @override
  Widget build(final BuildContext context) {
    final color = Random.secure();
    final r = color.nextInt(255);
    final g = color.nextInt(255);
    final b = color.nextInt(255);

    final randomCol = Color.fromARGB(225, r, g, b);
    return Container(
      width: width,
      height: height,
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
      decoration: BoxDecoration(
        color: randomCol,
        borderRadius: const BorderRadius.all(Radius.circular(4)),
        boxShadow: const <BoxShadow>[
          BoxShadow(
            color: Colors.black12,
            blurRadius: 4,
            offset: Offset(0, 4),
          ),
        ],
      ),
    );
  }
}
