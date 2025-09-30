import 'package:carousel_slider/carousel_slider.dart';
import 'package:coffee_app/core/model/product_model.dart';
import 'package:coffee_app/core/utils/app_router.dart';
import 'package:coffee_app/core/widgets/custom_rounded_images.dart';
import 'package:coffee_app/core/widgets/prettier_tap.dart';
import 'package:coffee_app/main.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CarouselList extends StatefulWidget {
  const CarouselList({super.key, this.topProducts = const []});
  final List<ProductModel> topProducts;

  @override
  State<CarouselList> createState() => _CarouselListState();
}

class _CarouselListState extends State<CarouselList> {
  int focusedPageIndex = 0;

  @override
  Widget build(BuildContext context) {
    void onPressed(Map<String, dynamic> extra) {
      GoRouter.of(context).push(AppRouter.kDetailsView, extra: extra);
    }

    return CarouselSlider.builder(
      itemCount: widget.topProducts.length,
      itemBuilder: (context, index, realIndex) {
        bool isFocused = index == focusedPageIndex;
        return AnimatedOpacity(
          curve: Curves.decelerate,
          duration: const Duration(milliseconds: 300),
          opacity: isFocused ? 1 : 0.15,
          child: PrettierTap(
            shrink: 1,
            onPressed: () {
              if (isFocused) {
                onPressed({
                  "product": widget.topProducts[index],
                  "tag": "${widget.topProducts[index].id}_topProduct",
                });
              }
            },
            child: Hero(
              tag: "${widget.topProducts[index].id}_topProduct",
              child: CustomRoundedImage(
                imageUrl: widget.topProducts[index].imageUrl,
                aspectRatio: 16 / 9,
                width: context.width,
              ),
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
