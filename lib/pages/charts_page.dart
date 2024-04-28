import 'package:flutter/material.dart';

import '../widgets/color_chart.dart';
import '../widgets/size_chart.dart';

class ChartsPage extends StatefulWidget {
  const ChartsPage({super.key});

  @override
  State<ChartsPage> createState() => _ChartsPageState();
}

class _ChartsPageState extends State<ChartsPage>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late List<Animation<Offset>> slideAnimations = [];
  late List<Animation<double>> fadeAnimations = [];
  final int itemCount = 2;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );

    slideAnimations = List.generate(
      itemCount,
      (index) => Tween(
        begin: const Offset(-0.3, 0),
        end: Offset.zero,
      ).animate(
        CurvedAnimation(
          parent: controller,
          curve: Interval(
            index * (1 / itemCount),
            1,
          ),
        ),
      ),
    );

    fadeAnimations = List.generate(
      itemCount,
      (index) => Tween(
        begin: 0.0,
        end: 1.0,
      ).animate(
        CurvedAnimation(
          parent: controller,
          curve: Interval(
            index * (1 / itemCount),
            1,
          ),
        ),
      ),
    );

    controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Chart',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: Colors.grey.shade800,
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.only(left: 40.0, right: 40.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              itemCount,
              (index) => Expanded(
                child: AnimatedBuilder(
                  animation: controller,
                  builder: (context, child) {
                    return SlideTransition(
                      position: slideAnimations[index],
                      child: FadeTransition(
                        opacity: fadeAnimations[index],
                        child: child,
                      ),
                    );
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      index == 0 ? const SizeChart() : const ColorChart(),
                      const SizedBox(height: 20),
                      Text(
                        index == 0 ? 'Hydration' : 'Happiness',
                        style: const TextStyle(
                          fontSize: 16,
                        ),
                      ),
                    ],
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
