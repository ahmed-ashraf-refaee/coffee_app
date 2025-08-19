import 'package:carousel_slider/carousel_slider.dart';
import 'package:coffee_app/core/widgets/custom_rounded_images.dart';
import 'package:coffee_app/core/widgets/prettier_tap.dart';
import 'package:coffee_app/main.dart';
import 'package:flutter/material.dart';

class CarouselList extends StatefulWidget {
  const CarouselList({super.key});

  @override
  State<CarouselList> createState() => _CarouselListState();
}

class _CarouselListState extends State<CarouselList> {
  int focusedPageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return CarouselSlider.builder(
      itemCount: 4,
      itemBuilder: (context, index, realIndex) {
        bool isFocused = index == focusedPageIndex;
        return AnimatedOpacity(
          curve: Curves.decelerate,
          duration: const Duration(milliseconds: 300),
          opacity: isFocused ? 1 : 0.15,
          child: PrettierTap(
            shrink: 1,
            onPressed: () {},
            child: CustomRoundedImage(
              imageUrl:
                  'https://www.americanolounge.com/wp-content/uploads/2024/08/What-is-American-style-coffee_270222935.webp',
              aspectRatio: 16 / 9,
              width: context.width,
            ),
          ),
        );
      },
      options: CarouselOptions(
        enlargeCenterPage: true,
        enlargeFactor: 0.3,
        enableInfiniteScroll: true,
        autoPlay: true,
        autoPlayAnimationDuration: const Duration(milliseconds: 300),
        autoPlayCurve: Curves.decelerate,
        autoPlayInterval: const Duration(seconds: 5),
        viewportFraction: 0.75,
        aspectRatio: 16 / 9,
        onPageChanged: (index, _) {
          setState(() {
            focusedPageIndex = index;
          });
        },
      ),
    );
  }
}
