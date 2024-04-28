import 'package:flutter/material.dart';

class FadeTransitionPageRoute extends PageRouteBuilder {
  final Widget route;
  FadeTransitionPageRoute({required this.route})
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
