import 'package:coffee_app/core/widgets/custom_container.dart';
import 'package:coffee_app/features/home/presentation/view/details_view/widgets/details_view_body.dart';
import 'package:flutter/material.dart';

import '../../../../../core/model/product_model.dart';

class DetailsView extends StatelessWidget {
  final ProductModel product;
  final String tag;

  const DetailsView({super.key, required this.product,required this.tag});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomContainer(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: DetailsViewBody(product: product,tag:tag),
          ),
        ),
      ),
    );
  }
}
