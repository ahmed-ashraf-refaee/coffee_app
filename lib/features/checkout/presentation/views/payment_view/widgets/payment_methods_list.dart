import 'package:coffee_app/core/utils/text_styles.dart';
import 'package:coffee_app/core/widgets/custom_elevated_button.dart';
import 'package:coffee_app/features/checkout/presentation/manager/payment/payment_cubit.dart';
import 'package:coffee_app/features/checkout/presentation/views/payment_view/widgets/add_card_overlay.dart';
import 'package:coffee_app/features/checkout/presentation/views/payment_view/widgets/payment_method_list_item.dart';
import 'package:coffee_app/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ionicons/ionicons.dart';

import '../../../../data/models/payment_method_model.dart';

class PaymentMethodsList extends StatefulWidget {
  const PaymentMethodsList({super.key});

  @override
  State<PaymentMethodsList> createState() => _PaymentMethodsListState();
}

class _PaymentMethodsListState extends State<PaymentMethodsList> {
  @override
  void initState() {
    super.initState();
    context.read<PaymentCubit>().fetchCards();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SingleChildScrollView(
        child: Column(
          spacing: 16,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text("bank cards", style: TextStyles.bold20),

            BlocBuilder<PaymentCubit, PaymentState>(
              builder: (context, state) {
                if (state is PaymentLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is PaymentFailure) {
                  return Center(
                    child: Text(
                      state.error,
                      style: TextStyles.medium16.copyWith(
                        color: context.colors.error,
                      ),
                    ),
                  );
                } else if (state is CardsLoadedSuccess) {
                  final paymentMethodsList = state.cards;
                  if (paymentMethodsList.isEmpty) {
                    return Text(
                      "No cards available. Please add a card.",
                      style: TextStyles.medium16.copyWith(
                        color: context.colors.surface,
                      ),
                      textAlign: TextAlign.center,
                    );
                  }
                  return ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: paymentMethodsList.length,
                    itemBuilder: (context, index) {
                      final PaymentMethodModel cardDetails =
                          paymentMethodsList[index];
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 16.0),
                        child: PaymentMethodListItem(
                          paymentMethod: cardDetails,
                          selected: index == 0,
                          onSelected: () {},
                        ),
                      );
                    },
                  );
                } else {
                  return Text(
                    "Something went wrong. Please try again.",
                    style: TextStyles.medium16.copyWith(
                      color: context.colors.error,
                    ),
                    textAlign: TextAlign.center,
                  );
                }
              },
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
