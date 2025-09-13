import 'package:flutter/material.dart';

class FadeScaleSwitcher extends StatelessWidget {
  final Widget child;
  final Duration duration;
  final Curve switchInCurve;
  final Curve switchOutCurve;
  final bool reverse;

  const FadeScaleSwitcher({
    super.key,
    required this.child,
    this.duration = const Duration(milliseconds: 200),
    this.switchInCurve = Curves.easeOut,
    this.switchOutCurve = Curves.easeIn,
    this.reverse = false, // <--- NEW
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: duration,
      switchInCurve: switchInCurve,
      switchOutCurve: switchOutCurve,
      transitionBuilder: (child, animation) {
        final curved = CurvedAnimation(
          parent: animation,
          curve: Curves.easeInOut,
        );

        // pick tween based on reverse flag
        final scaleTween = reverse
            ? Tween<double>(begin: 1.0, end: 0.90)
            : Tween<double>(begin: 0.90, end: 1.0);

        return FadeTransition(
          opacity: curved,
          child: ScaleTransition(
            scale: scaleTween.animate(curved),
            child: child,
          ),
        );
      },
      child: child,
    );
  }
}
