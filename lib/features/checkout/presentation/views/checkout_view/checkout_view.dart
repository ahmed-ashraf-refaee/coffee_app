import 'package:coffee_app/core/utils/text_styles.dart';
import 'package:coffee_app/core/widgets/custom_app_bar.dart';
import 'package:coffee_app/core/widgets/custom_elevated_button.dart';
import 'package:coffee_app/core/widgets/custom_icon_button.dart';
import 'package:coffee_app/features/checkout/presentation/views/checkout_view/widgets/order_summary.dart';
import 'package:coffee_app/features/checkout/presentation/views/checkout_view/widgets/payment_info_card.dart';
import 'package:coffee_app/features/checkout/presentation/views/checkout_view/widgets/shipping_info_card.dart';
import 'package:coffee_app/generated/l10n.dart';
import 'package:coffee_app/main.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ionicons/ionicons.dart';

class CheckoutView extends StatelessWidget {
  const CheckoutView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            spacing: 16,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              CustomAppBar(
                leading: CustomIconButton(
                  padding: 8,
                  onPressed: () {},
                  child: Icon(
                    Ionicons.chevron_back,
                    color: context.colors.onSecondary,
                  ),
                ),
              ),
              const OrderSummary(),
              const PaymentInfoCard(),
              const ShippingInfoCard(),
              const Spacer(),
              CustomElevatedButton(
                disabled: true,
                onPressed: () {},
                child: Text(S.current.checkout, style: TextStyles.medium20),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
