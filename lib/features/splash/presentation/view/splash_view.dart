import 'package:coffee_app/main.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';

import '../../../../core/utils/app_router.dart';
import '../../../../core/utils/text_styles.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> with TickerProviderStateMixin {
  late Animation<double> _animation;
  late AnimationController _animationController;

  late Animation<double> _descriptionanimation;
  late AnimationController _descriptionanimationController;

  late Animation<double> _rotatiomanimation;
  late AnimationController _rotationanimationController;

  @override
  void initState() {
    super.initState();
    titleAnimation();
    rotationAnimation();
    secondTitleAnimation();
    Future.delayed(Duration(milliseconds: 5000), () {
      GoRouter.of(context).pushReplacement(AppRouter.kNavigationView);
    });
  }

  void rotationAnimation() {
    _rotationanimationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 500),
    );
    _rotatiomanimation = Tween<double>(
      begin: 0,
      end: 0.025,
    ).animate(_rotationanimationController);
    Future.delayed(Duration(milliseconds: 3500), () {
      _rotationanimationController.forward();
    });
  }

  void titleAnimation() {
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 3),
    );
    _animation = Tween<double>(
      begin: 0.04,
      end: 1,
    ).animate(_animationController);
    _animationController.forward();
  }

  void secondTitleAnimation() {
    _descriptionanimationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 2500),
    );
    _descriptionanimation = Tween<double>(
      begin: 0.00,
      end: 0.5,
    ).animate(_descriptionanimationController);
    Future.delayed(Duration(milliseconds: 1500), () {
      _descriptionanimationController.forward();
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    _descriptionanimationController.dispose();
    _rotationanimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Spacer(),
          SizedBox(
            width: context.width,
            height: 250,
            child: Lottie.asset('assets/icons/coffe_icon.json', repeat: false),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FadeTransition(
                opacity: _animation,

                child: Text("Coffee ", style: TextStyles.bold48),
              ),
              RotationTransition(
                alignment: Alignment.centerLeft,
                turns: _rotatiomanimation,
                child: FadeTransition(
                  opacity: _animation,

                  child: Text("Drop", style: TextStyles.bold48),
                ),
              ),
            ],
          ),

          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: FadeTransition(
              opacity: _descriptionanimation,
              child: Text(
                "your perfect pour at your door",
                style: TextStyles.bold14,
              ),
            ),
          ),
          Spacer(flex: 3),
        ],
      ),
    );
  }
}
