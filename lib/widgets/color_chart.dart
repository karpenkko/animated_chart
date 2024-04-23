import 'package:flutter/material.dart';

class ColorChart extends StatefulWidget {
  const ColorChart({super.key});

  @override
  State<ColorChart> createState() => _ChartPageState();
}

class _ChartPageState extends State<ColorChart>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          controller.reverse();
        } else if (status == AnimationStatus.dismissed) {
          controller.forward();
        }
      })
      ..addListener(() {
        setState(() {});
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
    return SizedBox(
      height: 300,
      child: AnimatedBuilder(
        animation: controller,
        builder: (context, child) {
          return Container(
            width: 40,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
                colors: const [Colors.purple, Colors.pink, Colors.yellow],
                stops: [0, controller.value, 1],
              ),
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Colors.white),
            ),
          );
        },
      ),
    );
  }
}
