import 'package:coffee_app/core/helper/ui_helpers.dart';
import 'package:coffee_app/features/checkout/data/models/payment_method_model.dart';
import 'package:coffee_app/features/checkout/presentation/views/payment_view/widgets/payment_method_list_item.dart';
import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';

class PaymentMethodListItemLoading extends StatelessWidget {
  const PaymentMethodListItemLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
      effect: UiHelpers.customShimmer(context),
      child: PaymentMethodListItem(
        paymentMethod: PaymentMethodModel(
          id: 1,
          createdAt: DateTime.timestamp(),
          brand: "visa",
          expMonth: 2,
          expYear: 2048,
          last4: 2222,
          holderName: "ashraf",
        ),
        selected: false,
        onSelected: () {},
      ),
    );
  }
}
