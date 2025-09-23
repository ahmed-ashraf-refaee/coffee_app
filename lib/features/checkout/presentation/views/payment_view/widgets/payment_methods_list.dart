import 'package:coffee_app/core/utils/text_styles.dart';
import 'package:coffee_app/core/widgets/custom_elevated_button.dart';
import 'package:coffee_app/features/checkout/data/models/payment_method_model.dart';
import 'package:coffee_app/features/checkout/presentation/views/payment_view/widgets/add_card_overlay.dart';
import 'package:coffee_app/features/checkout/presentation/views/payment_view/widgets/cash_on_delivery_list_item.dart';
import 'package:coffee_app/features/checkout/presentation/views/payment_view/widgets/payment_method_list_item.dart';
import 'package:coffee_app/features/payment/presentation/manager/payment/stripe_payment_cubit.dart';
import 'package:coffee_app/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ionicons/ionicons.dart';

class PaymentMethodsList extends StatelessWidget {
  const PaymentMethodsList({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SingleChildScrollView(
        child: Column(
          spacing: 16,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text("bank cards", style: TextStyles.bold20),

            PaymentMethodListItem(
              onSelected: () {},
              selected: false,
              paymentMethod: PaymentMethodModel(
                holderName: 'Ahmed Ashraf',
                expMonth: 12,
                expYear: 2028,
                last4: 4242,
                id: 1,
                brand: 'mastercard',
                createdAt: DateTime.now(),
              ),
            ),

            CustomElevatedButton(
              onPressed: () {

                addCardOverlay(context);
              },
              backgroundColor: context.colors.secondary,
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                spacing: 16,
                children: [
                  Text('Add card', style: TextStyles.medium20),
                  Icon(Ionicons.add),
                ],
              ),
            ),

            const Text("Other Methods", style: TextStyles.bold20),
            CashOnDeliveryListItem(selected: true, onSelected: () {}),
          ],
        ),
      ),
    );
  }
}
