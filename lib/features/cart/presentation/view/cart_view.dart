import 'package:coffee_app/features/cart/presentation/view/widgets/cart_view_body.dart';
import 'package:coffee_app/features/payment/presentation/manager/payment/stripe_payment_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartView extends StatelessWidget {
  const CartView({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.only(top: 16, left: 16, right: 16),
        child: BlocProvider(
          create: (context) => StripePaymentCubit(),
          child: const CartViewBody(),
        ),
      ),
    );
  }
}
