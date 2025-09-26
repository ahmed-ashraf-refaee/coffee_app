import 'package:coffee_app/core/helper/ui_helpers.dart';
import 'package:coffee_app/core/utils/text_styles.dart';
import 'package:coffee_app/core/widgets/custom_app_bar.dart';
import 'package:coffee_app/core/widgets/custom_elevated_button.dart';
import 'package:coffee_app/core/widgets/custom_icon_button.dart';
import 'package:coffee_app/features/authentication/presentation/manager/auth_bloc/auth_bloc.dart';
import 'package:coffee_app/features/checkout/presentation/manager/card/card_cubit.dart';
import 'package:coffee_app/features/checkout/presentation/manager/payment/payment_cubit.dart';
import 'package:coffee_app/features/checkout/presentation/views/checkout_view/widgets/order_summary.dart';
import 'package:coffee_app/features/checkout/presentation/views/checkout_view/widgets/payment_info_card.dart';
import 'package:coffee_app/features/checkout/presentation/views/checkout_view/widgets/shipping_info_card.dart';
import 'package:coffee_app/generated/l10n.dart';
import 'package:coffee_app/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:ionicons/ionicons.dart';

class CheckoutView extends StatefulWidget {
  CheckoutView({super.key, required this.summeryCheckout});
  final Map<String, double> summeryCheckout;

  @override
  State<CheckoutView> createState() => _CheckoutViewState();
}

class _CheckoutViewState extends State<CheckoutView> {
  final TextEditingController cvvController = TextEditingController();
  final GlobalKey formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    cvvController.dispose();
    super.dispose();
  }

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
                  onPressed: () {
                    GoRouter.of(context).pop();
                  },
                  child: Icon(
                    Ionicons.chevron_back,
                    color: context.colors.onSecondary,
                  ),
                ),
              ),
              OrderSummary(
                subTotal: widget.summeryCheckout['subTotal']!,
                shipping: widget.summeryCheckout['shipping']!,
              ),

              PaymentInfoCard(cvvController: cvvController, formKey: formKey),

              const ShippingInfoCard(),
              const Spacer(),
              BlocConsumer<PaymentCubit, PaymentState>(
                listener: (context, state) {
                  if (state is PaymentCompletedSuccess) {
                    UiHelpers.showSnackBar(
                      context: context,
                      message: "Successfully paid",
                    );
                    // context.read<CartCubit>().clearCart();
                  } else if (state is PaymentFailure) {
                    UiHelpers.showSnackBar(
                      context: context,
                      message: state.error,
                    );
                  }
                },
                builder: (context, state) {
                  return CustomElevatedButton(
                    isLoading: state is PaymentLoading,
                    disabled:
                        context.watch<CardCubit>().state.defaultCard == null,
                    onPressed: () {
                      if ((formKey.currentState as FormState).validate()) {
                        context.read<PaymentCubit>().payWithCard(
                          amount:
                              (widget.summeryCheckout['subTotal']! +
                              widget.summeryCheckout['shipping']!),
                          paymentMethodId: context
                              .read<CardCubit>()
                              .state
                              .defaultCard!
                              .paymentMethodId!,
                          cvc: cvvController.text,
                        );
                        cvvController.clear();
                      }
                    },
                    child: Text(S.current.checkout, style: TextStyles.medium20),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
