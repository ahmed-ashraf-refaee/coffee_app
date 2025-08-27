import 'package:coffee_app/core/utils/text_styles.dart';
import 'package:coffee_app/core/widgets/custom_icon_button.dart';
import 'package:coffee_app/main.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';

import '../../../../core/utils/color_palette.dart';

class OnboardingView extends StatefulWidget {
  const OnboardingView({super.key});

  @override
  State<OnboardingView> createState() => _OnboardingViewState();
}

class _OnboardingViewState extends State<OnboardingView> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<Map<String, String>> onboardingData = [
    {
      'image': 'assets/images/onboarding_images/1.png',
      'title': 'Welcome to',
      'subtitle':
          'Discover the best coffee around you and enjoy the experience.',
    },
    {
      'image': 'assets/images/onboarding_images/2.jpg',
      'title': 'Fast Delivery',
      'subtitle':
          'Get your coffee delivered to your doorstep quickly and safely.',
    },
    {
      'image': 'assets/images/onboarding_images/4.png',
      'title': 'Order Your Coffee',
      'subtitle': 'Easily order your favorite coffee from anywhere, anytime.',
    },
  ];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView.builder(
            controller: _pageController,
            itemCount: onboardingData.length,
            onPageChanged: (value) => setState(() => _currentPage = value),
            itemBuilder: (context, index) {
              return _buildBlurredImagePage(index);
            },
          ),
          Positioned(
            top: 48,
            right: 24,
            child: CustomIconButton(
              onPressed: () {
                if (_currentPage < onboardingData.length - 1) {
                  _pageController.nextPage(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                  );
                } else {
                  // Navigate to the next screen or perform any action
                }
              },
              backgroundColor: ColorPalette.raisinBlack,
              borderRadius: BorderRadius.circular(16),
              child: Icon(
                _currentPage < onboardingData.length - 1
                    ? Ionicons.chevron_forward_outline
                    : Ionicons.checkmark_outline,
                color: context.colors.onPrimary,
              ),
            ),
          ),
          Positioned(
            bottom: 48,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                onboardingData.length,
                (index) => AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  margin: const EdgeInsets.symmetric(horizontal: 5),
                  width: _currentPage == index ? 48 : 24,
                  height: 4,
                  decoration: BoxDecoration(
                    color: _currentPage == index
                        ? context.colors.primary
                        : context.colors.onSecondary,
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBlurredImagePage(int index) {
    return Stack(
      children: [
        // Base image
        SizedBox(
          width: double.infinity,
          height: double.infinity,
          child: Image.asset(
            onboardingData[index]["image"]!,
            fit: BoxFit.cover,
          ),
        ),

        index == 0
            ? Positioned(
                top: context.height * 0.08,
                left: 24,
                right: 24,
                child: Column(
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        onboardingData[index]['title']!,

                        style: TextStyles.bold32.copyWith(
                          color: context.colors.onPrimary,
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Coffee Shot',
                        style: TextStyles.bold48.copyWith(
                          color: context.colors.primary,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(6.0),
                      child: Text(
                        onboardingData[index]['subtitle']!,
                        textAlign: TextAlign.center,
                        style: TextStyles.bold20.copyWith(
                          color: context.colors.onPrimary.withAlpha(200),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            : Positioned(
                top: index == 1 ? context.height * 0.73 : context.height * 0.15,
                left: 24,
                right: 24,
                child: Column(
                  children: [
                    Text(
                      onboardingData[index]['title']!,
                      textAlign: TextAlign.center,
                      style: TextStyles.bold32.copyWith(
                        color: context.colors.onPrimary,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      onboardingData[index]['subtitle']!,
                      textAlign: TextAlign.center,
                      style: TextStyles.bold20.copyWith(
                        color: context.colors.onPrimary.withAlpha(200),
                      ),
                    ),
                  ],
                ),
              ),
        // Left edge blur gradient
        Positioned(
          left: 0,
          top: 0,
          bottom: 0,
          width: 70,
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: [Colors.black.withAlpha(170), Colors.transparent],
              ),
            ),
          ),
        ),

        // Right edge blur gradient
        Positioned(
          right: 0,
          top: 0,
          bottom: 0,
          width: 70,
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.centerRight,
                end: Alignment.centerLeft,
                colors: [Colors.black.withAlpha(170), Colors.transparent],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
