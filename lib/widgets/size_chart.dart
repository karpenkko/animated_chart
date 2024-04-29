import 'package:flutter/material.dart';

class SizeChart extends StatefulWidget {
  const SizeChart({super.key});

  @override
  State<SizeChart> createState() => _ChartPageState();
}

class _ChartPageState extends State<SizeChart>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> animationSize;

  double barHeight = 50.0;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );

    animationSize = Tween<double>(begin: 50.0, end: 200.0).animate(
      CurvedAnimation(
        parent: controller,
        curve: Curves.easeOut,
      ),
    )
      ..addListener(() {
        setState(() {
          barHeight = animationSize.value;
        });
      })
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          controller.reverse();
        } else if (status == AnimationStatus.dismissed) {
          controller.forward();
        }
      });

    controller.forward();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      decoration: BoxDecoration(
        color: Colors.grey.shade300,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
            width: 40.0,
            height: barHeight,
            decoration: BoxDecoration(
              color: Colors.blue,
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ],
      ),
    );
  }
}
