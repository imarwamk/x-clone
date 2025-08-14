import 'package:flutter/material.dart';

class GradientBackground extends StatelessWidget {
  const GradientBackground({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color.fromARGB(255, 42, 12, 77),
            Color.fromARGB(255, 7, 1, 36),
            Color.fromARGB(242, 7, 1, 36),
            Color.fromARGB(252, 0, 0, 0),
          ],
          stops: [0.0, 0.4, 0.7, 1.0],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
    );
  }
}
