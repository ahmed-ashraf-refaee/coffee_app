import 'package:coffee_app/core/helper/ui_helpers.dart';
import 'package:coffee_app/core/utils/text_styles.dart';
import 'package:coffee_app/core/widgets/custom_app_bar.dart';
import 'package:coffee_app/core/widgets/custom_elevated_button.dart';
import 'package:coffee_app/core/widgets/custom_icon_button.dart';
import 'package:coffee_app/features/checkout/data/models/order_model.dart';
import 'package:coffee_app/features/checkout/presentation/manager/card/card_cubit.dart';
import 'package:coffee_app/features/checkout/presentation/manager/order/order_cubit.dart';
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
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../../../cart/presentation/manager/cart_cubit/cart_cubit.dart';

class CheckoutView extends StatefulWidget {
  const CheckoutView({super.key, required this.checkoutSummery});
  final Map<String, double> checkoutSummery;

  @override
  State<CheckoutView> createState() => _CheckoutViewState();
}

class _CheckoutViewState extends State<CheckoutView> {
  final TextEditingController cvvController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    cvvController.dispose();
    super.dispose();
  }

  Future<void> _handleCheckout(BuildContext context) async {
    final cardCubit = context.read<CardCubit>();
    final orderCubit = context.read<OrderCubit>();
    final paymentCubit = context.read<PaymentCubit>();
    final cartCubit = context.read<CartCubit>();

    final defaultCard = cardCubit.state.defaultCard;
    final defaultAddress = cardCubit.state.defaultAddress;

    if (defaultCard == null || defaultAddress == null) {
      return;
    }

    final order = OrderModel(
      shippingAddressId: defaultAddress.id,
      paymentId: defaultCard.id,
      userId: Supabase.instance.client.auth.currentUser!.id,
      totalPrice: widget.checkoutSummery['subTotal']!,

      shippingPrice: widget.checkoutSummery['shipping']!,
      status: "pending",
    );

    // Cash on Delivery
    if (defaultCard.id == -1) {
      await orderCubit.createOrder(
        order,
        cartCubit.getOrderItemsFromCachedCart(),
      );
      return;
    }

    // Card payment
    if (formKey.currentState!.validate()) {
      paymentCubit.payWithCard(
        amount:
            widget.checkoutSummery['subTotal']! -
            widget.checkoutSummery['discount']! +
            widget.checkoutSummery['shipping']!,
        paymentMethodId: defaultCard.paymentMethodId!,
        cvc: cvvController.text,
      );
      await orderCubit.createOrder(
        order,
        cartCubit.getOrderItemsFromCachedCart(),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: MultiBlocListener(
            listeners: [
              BlocListener<PaymentCubit, PaymentState>(
                listener: (context, state) {
                  if (state is PaymentCompletedSuccess) {
                    UiHelpers.showSnackBar(
                      context: context,
                      message: "Successfully paid",
                    );
                  } else if (state is PaymentFailure) {
                    UiHelpers.showSnackBar(
                      context: context,
                      message: state.error,
                    );
                  }
                },
              ),
              BlocListener<OrderCubit, OrderState>(
                listener: (context, state) {
                  if (state is OrderCreated) {
                    UiHelpers.showSnackBar(
                      context: context,
                      message: "تم الأخذ",
                    );
                    cvvController.clear();
                    context.read<CartCubit>().clearCart();
                    GoRouter.of(context).pop();
                  } else if (state is OrderError) {
                    UiHelpers.showSnackBar(
                      context: context,
                      message: state.message,
                    );
                  }
                },
              ),
            ],
            child: _CheckoutBody(
              formKey: formKey,
              cvvController: cvvController,
              checkoutSummery: widget.checkoutSummery,
              onCheckoutPressed: () => _handleCheckout(context),
            ),
          ),
        ),
      ),
    );
  }
}

class _CheckoutBody extends StatelessWidget {
  const _CheckoutBody({
    required this.formKey,
    required this.cvvController,
    required this.checkoutSummery,
    required this.onCheckoutPressed,
  });

  final GlobalKey<FormState> formKey;
  final TextEditingController cvvController;
  final Map<String, double> checkoutSummery;
  final VoidCallback onCheckoutPressed;

  @override
  Widget build(BuildContext context) {
    final cardCubit = context.watch<CardCubit>();
    final state = context.watch<PaymentCubit>().state;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      spacing: 16,
      children: [
        CustomAppBar(
          leading: CustomIconButton(
            padding: 8,
            onPressed: () => GoRouter.of(context).pop(),
            child: Icon(
              Ionicons.chevron_back,
              color: context.colors.onSecondary,
            ),
          ),
        ),
        OrderSummary(
          subTotal: checkoutSummery['subTotal']!,
          shipping: checkoutSummery['shipping']!,
          discount: checkoutSummery['discount']!,
        ),
        PaymentInfoCard(cvvController: cvvController, formKey: formKey),
        const ShippingInfoCard(),
        const Spacer(),
        CustomElevatedButton(
          isLoading: state is PaymentLoading,
          disabled:
              cardCubit.state.defaultCard == null ||
              cardCubit.state.defaultAddress == null,
          onPressed: onCheckoutPressed,
          child: Text(S.current.checkout, style: TextStyles.medium20),
        ),
      ],
    );
  }
}
