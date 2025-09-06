import 'package:flutter/material.dart';

class PrettierTap extends StatefulWidget {
  const PrettierTap({
    super.key,
    required this.child,
    required this.onPressed,
    this.shrink = 3,
  }) : assert(shrink <= 8 && shrink >= 0);
  final int shrink;
  final VoidCallback? onPressed;
  final Widget child;

  @override
  State<PrettierTap> createState() => _PrettierTapState();
}

class _PrettierTapState extends State<PrettierTap>
    with SingleTickerProviderStateMixin {
  late final AnimationController controller;
  late final Animation<double> scaleAnimation;
  late final Animation<double> opacityAnimation;
  bool isToggled = false;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      duration: const Duration(milliseconds: 100),
      vsync: this,
    );

    scaleAnimation = Tween<double>(
      begin: 1,
      end: 1 - widget.shrink * 0.02,
    ).animate(CurvedAnimation(parent: controller, curve: Curves.easeInOut));
    opacityAnimation = Tween<double>(
      begin: 1,
      end: 0.9,
    ).animate(CurvedAnimation(parent: controller, curve: Curves.easeInOut));
  }

  Future<void> _handleTap() async {
    await controller.forward();
    if (widget.onPressed != null) {
      widget.onPressed!.call();
    }
    await controller.reverse();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _handleTap,
      child: FadeTransition(
        opacity: opacityAnimation,
        child: ScaleTransition(scale: scaleAnimation, child: widget.child),
      ),
    );
  }
}
