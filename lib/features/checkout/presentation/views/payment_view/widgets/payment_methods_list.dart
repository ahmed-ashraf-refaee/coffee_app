import 'package:coffee_app/core/utils/text_styles.dart';
import 'package:coffee_app/features/checkout/presentation/views/payment_view/widgets/payment_method_list_item.dart';
import 'package:flutter/material.dart';

class PaymentMethodsList extends StatelessWidget {
  const PaymentMethodsList({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 16,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const Text("bank cards", style: TextStyles.bold20),
        ListView.builder(
          shrinkWrap: true,
          itemCount: 5,
          itemBuilder: (context, index) => const Padding(
            padding: EdgeInsets.only(bottom: 16),
            child: PaymentMethodListItem(cardHolderName: 'Ahmed',),
          ),
        ),
        const Text("other methods", style: TextStyles.bold20),
        ListView.builder(
          shrinkWrap: true,
          itemCount: 1,
          itemBuilder: (context, index) => const Padding(
            padding: EdgeInsets.only(bottom: 16),
            child: PaymentMethodListItem(),
          ),
        ),
      ],
    );
  }
}
