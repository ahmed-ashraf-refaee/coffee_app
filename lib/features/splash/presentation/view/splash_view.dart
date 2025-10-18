import 'package:coffee_app/generated/l10n.dart';
import 'package:coffee_app/main.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

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

  late Animation<double> _descriptionAnimation;
  late AnimationController _descriptionAnimationController;

  late Animation<double> _rotationAnimation;
  late AnimationController _rotationAnimationController;

  @override
  void initState() {
    super.initState();
    titleAnimation();
    rotationAnimation();
    secondTitleAnimation();
    Future.delayed(const Duration(milliseconds: 5000), () async {
      final prefs = await SharedPreferences.getInstance();
      final remember = prefs.getBool("remember_me") ?? true;
      final seenOnboarding = prefs.getBool('seen_onboarding') ?? false;
      if (!seenOnboarding) {
        await prefs.setBool('seen_onboarding', true);
        if (mounted) {
          GoRouter.of(context).pushReplacement(AppRouter.kOnboardingView);
        }
        return;
      }
      if (remember) {
        final user = Supabase.instance.client.auth.currentSession?.user;
        if (user != null) {
          if (mounted) {
            GoRouter.of(context).pushReplacement(AppRouter.kNavigationView);
          }
        } else {
          if (mounted) {
            GoRouter.of(context).pushReplacement(AppRouter.kAuthView);
          }
        }
      } else {
        if (mounted) {
          GoRouter.of(context).pushReplacement(AppRouter.kAuthView);
        }
      }
    });
  }

  void rotationAnimation() {
    _rotationAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    _rotationAnimation = Tween<double>(
      begin: 0,
      end: 0.025,
    ).animate(_rotationAnimationController);
    Future.delayed(const Duration(milliseconds: 3500), () {
      if (mounted) {
        _rotationAnimationController.forward();
      }
    });
  }

  void titleAnimation() {
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    );
    _animation = Tween<double>(
      begin: 0.04,
      end: 1,
    ).animate(_animationController);
    _animationController.forward();
  }

  void secondTitleAnimation() {
    _descriptionAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2500),
    );
    _descriptionAnimation = Tween<double>(
      begin: 0.00,
      end: 0.5,
    ).animate(_descriptionAnimationController);
    Future.delayed(const Duration(milliseconds: 1500), () {
      if (mounted) {
        _descriptionAnimationController.forward();
      }
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    _descriptionAnimationController.dispose();
    _rotationAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const Spacer(),
          SizedBox(
            width: context.width,
            height: 250,
            child: Lottie.asset('assets/icons/coffee_icon.json', repeat: false),
          ),
          Row(
            spacing: 16,
            textDirection: TextDirection.ltr,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FadeTransition(
                opacity: _animation,
                child: Text(S.current.coffee, style: TextStyles.bold48),
              ),
              RotationTransition(
                alignment: Alignment.centerLeft,
                turns: _rotationAnimation,
                child: FadeTransition(
                  opacity: _animation,
                  child: Text(S.current.drop, style: TextStyles.bold48),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: FadeTransition(
              opacity: _descriptionAnimation,
              child: Text(S.current.splashSubtitle, style: TextStyles.bold14),
            ),
          ),
          const Spacer(flex: 3),
        ],
      ),
    );
  }
}
