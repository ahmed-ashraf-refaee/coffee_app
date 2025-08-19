import 'package:coffee_app/core/widgets/gradient_container.dart';
import 'package:coffee_app/features/home/presentation/view/details_view/widgets/details_view_body.dart';
import 'package:flutter/material.dart';

class DetailsView extends StatelessWidget {
  const DetailsView({super.key, required this.tag});
  final String tag;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GradientContainer(
        child: SafeArea(child: DetailsViewBody(tag: tag)),
      ),
    );
  }
}
