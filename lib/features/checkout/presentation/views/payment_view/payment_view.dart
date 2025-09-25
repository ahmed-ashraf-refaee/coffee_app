import 'package:coffee_app/core/widgets/custom_app_bar.dart';
import 'package:coffee_app/core/widgets/custom_icon_button.dart';
import 'package:coffee_app/features/checkout/presentation/views/payment_view/widgets/payment_methods_list.dart';
import 'package:coffee_app/main.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ionicons/ionicons.dart';

class PaymentView extends StatelessWidget {
  const PaymentView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Expanded(
            child: SingleChildScrollView(
              child: Column(
                spacing: 16,
                children: [
                  CustomAppBar(
                    leading: CustomIconButton(
                      padding: 8,
                      onPressed: () {
                        GoRouter.of(context).pop();
                      },
                      child: Icon(
                        Ionicons.chevron_back,
                        color: context.colors.onSecondary,
                      ),
                    ),
                  ),
                  const PaymentMethodsList(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
