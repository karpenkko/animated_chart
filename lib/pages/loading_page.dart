import 'dart:async';

import 'package:animated_chart/pages/charts_page.dart';
import 'package:flutter/material.dart';

class LoadingPage extends StatefulWidget {
  const LoadingPage({super.key});

  @override
  State<LoadingPage> createState() => _LoadingPageState();
}

class _LoadingPageState extends State<LoadingPage>
    with TickerProviderStateMixin {
  late AnimationController controller;
  late AnimationController controllerRout;
  late Animation<double> animationLoading;
  late Animation<double> animationOpacity;
  late Animation<double> animationScale;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    )..addListener(() {
      if (controller.isCompleted) {
        Navigator.of(context).push(
          MyCustomRouteTransition(
            route: const ChartsPage(),
          ),
        );

        Timer(const Duration(milliseconds: 500), () {
          controller.reset();
        });
      }
    });

    // controllerRout = AnimationController(
    //   vsync: this,
    //   duration: const Duration(milliseconds: 1000),
    // )..addListener(() {
    //     if (controllerRout.isCompleted) {
    //       Navigator.of(context).push(
    //         MyCustomRouteTransition(
    //           route: const ChartsPage(),
    //         ),
    //       );
    //
    //       Timer(const Duration(milliseconds: 500), () {
    //         controllerRout.reset();
    //       });
    //     }
    //   });

    animationLoading = Tween(begin: 0.0, end: 1.0).animate(controller);
    // animationOpacity = Tween(begin: 0.0, end: 1.0).animate(controller);
    // animationScale = Tween(begin: 1.0, end: 10.0).animate(controllerRout);

    controller.forward();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        // child: ScaleTransition(
        //   scale: animationScale,
        //   child: GestureDetector(
        //     onTap: () {
        //       controllerRout.forward();
        //     },
        //     child: Container(
        //       width: 100,
        //       height: 100,
        //       decoration: const BoxDecoration(
        //         shape: BoxShape.circle,
        //         color: Colors.blue,
        //       ),
        //       child:
        //       const Icon(Icons.play_arrow, color: Colors.white),
        //     ),
        //   ),
        // ),
        child: AnimatedBuilder(
          animation: animationLoading,
          builder: (context, child) {
            return Stack(
              alignment: Alignment.center,
              children: [
                SizedBox(
                  width: 100,
                  height: 100,
                  child: CircularProgressIndicator(
                    value: animationLoading.value,
                    strokeWidth: 8,
                    backgroundColor: Colors.grey.shade100,
                    color: Colors.blue,
                  ),
                ),
                Text(
                  '${(animationLoading.value * 100).toInt()}%',
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                // if (animationLoading.value == 1.0)
                //   ScaleTransition(
                //     scale: animationScale,
                //     child: GestureDetector(
                //       onTap: () {
                //         controllerRout.forward();
                //       },
                //       child: Container(
                //         width: 100,
                //         height: 100,
                //         decoration: const BoxDecoration(
                //           shape: BoxShape.circle,
                //           color: Colors.blue,
                //         ),
                //         child:
                //             const Icon(Icons.play_arrow, color: Colors.white),
                //       ),
                //     ),
                //   ),
              ],
            );
          },
        ),
      ),
    );
  }
}

class MyCustomRouteTransition extends PageRouteBuilder {
  final Widget route;
  MyCustomRouteTransition({required this.route})
      : super(
          pageBuilder: (context, animation, secondaryAnimation) {
            return route;
          },
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return FadeTransition(
              opacity: animation,
              child: child,
            );
          },
        );
}
