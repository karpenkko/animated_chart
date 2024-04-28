import 'dart:async';
import 'package:animated_chart/pages/charts_page.dart';
import 'package:flutter/material.dart';

import '../utils/fade_transition_page_route.dart';

class LoadingPage extends StatefulWidget {
  const LoadingPage({super.key});

  @override
  State<LoadingPage> createState() => _LoadingPageState();
}

class _LoadingPageState extends State<LoadingPage>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> animationLoading;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    )..addListener(() {
        if (controller.isCompleted) {
          Navigator.of(context).push(
            FadeTransitionPageRoute(
              route: const ChartsPage(),
            ),
          );

          Timer(const Duration(milliseconds: 500), () {
            controller.reset();
          });
        }
      });

    animationLoading = Tween(begin: 1.0, end: 10.0).animate(controller);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade800,
      body: Center(
        child: Stack(
          children: [
            ScaleTransition(
              scale: animationLoading,
              child: GestureDetector(
                onTap: () {
                  controller.forward();
                },
                child: Container(
                  width: 100,
                  height: 100,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            Positioned.fill(
              child: Icon(Icons.play_arrow, color: Colors.grey.shade800),
            ),
          ],
        ),
      ),
    );
  }
}
