import 'package:carousel_slider/carousel_slider.dart';
import 'package:coffee_app/core/widgets/custom_rounded_images.dart';
import 'package:coffee_app/main.dart';
import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';

class CarouselListLoading extends StatelessWidget {
  const CarouselListLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
      enabled: true,
      child: CarouselSlider.builder(
        itemCount: 4,
        itemBuilder: (context, index, realIndex) {
          return CustomRoundedImage(
            imageUrl: 'https://via.placeholder.com/150',
            aspectRatio: 16 / 9,
            width: context.width,
          );
        },
        options: CarouselOptions(
          enlargeCenterPage: true,
          enlargeFactor: 0.3,
          enableInfiniteScroll: true,
          autoPlay: false,

          viewportFraction: 0.75,
          aspectRatio: 16 / 9,
        ),
      ),
    );
  }
}
