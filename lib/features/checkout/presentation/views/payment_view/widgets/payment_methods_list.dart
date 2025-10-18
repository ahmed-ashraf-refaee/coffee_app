import 'package:coffee_app/core/utils/text_styles.dart';
import 'package:coffee_app/core/widgets/custom_elevated_button.dart';
import 'package:coffee_app/core/widgets/title_subtitle.dart';
import 'package:coffee_app/features/checkout/presentation/manager/card/card_cubit.dart';
import 'package:coffee_app/features/checkout/presentation/manager/payment/payment_cubit.dart';
import 'package:coffee_app/features/checkout/presentation/views/payment_view/widgets/add_card_overlay.dart';
import 'package:coffee_app/features/checkout/presentation/views/payment_view/widgets/payment_method_list_item.dart';
import 'package:coffee_app/features/checkout/presentation/views/payment_view/widgets/payment_method_list_item_loading.dart';
import 'package:coffee_app/generated/l10n.dart';
import 'package:coffee_app/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:ionicons/ionicons.dart';

import '../../../../data/models/payment_method_model.dart';
import 'cash_on_delivery_list_item.dart';

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
    final cardCubit = context.watch<CardCubit>();
    final tr = S.of(context);

    return Column(
      spacing: 16,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        TitleSubtitle(
          title: S.current.paymentMethods,
          subtitle: S.current.paymentMethodsSubtitle,
        ),

        BlocBuilder<PaymentCubit, PaymentState>(
          buildWhen: (previous, current) =>
              current is! PaymentCardOverlayLoading &&
              current is! CardAddedSuccess,
          builder: (context, state) {
            if (state is PaymentLoading) {
              return const Column(
                spacing: 16,
                children: [
                  PaymentMethodListItemLoading(),
                  PaymentMethodListItemLoading(),
                ],
              );
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
              return Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  if (paymentMethodsList.isEmpty)
                    const SizedBox.shrink()
                  else
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: paymentMethodsList.length,
                      itemBuilder: (context, index) {
                        final paymentMethod = paymentMethodsList[index];
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 16.0),
                          child: PaymentMethodListItem(
                            paymentMethod: paymentMethod,
                            selected:
                                cardCubit.state.defaultCard != null &&
                                paymentMethod.id ==
                                    cardCubit.state.defaultCard!.id,
                            onSelected: () {
                              cardCubit.updateDefaultCard(
                                paymentMethodsList[index],
                              );
                              GoRouter.of(context).pop();
                            },
                          ),
                        );
                      },
                    ),

                  CashOnDeliveryListItem(
                    selected:
                        cardCubit.state.defaultCard != null &&
                        cardCubit.state.defaultCard!.id == -1,
                    onSelected: () {
                      BlocProvider.of<CardCubit>(context).updateDefaultCard(
                        PaymentMethodModel(
                          id: -1,
                          createdAt: DateTime.timestamp(),
                        ),
                      );
                      GoRouter.of(context).pop();
                    },
                  ),
                ],
              );
            } else {
              return Text(
                tr.somethingWentWrong,
                style: TextStyles.medium16.copyWith(
                  color: context.colors.error,
                ),
                textAlign: TextAlign.center,
              );
            }
          },
        ),
        const SizedBox(height: 2),

        CustomElevatedButton(
          onPressed: () => addCardOverlay(context),
          backgroundColor: context.colors.secondary,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            spacing: 16,
            children: [
              Text(tr.addCard, style: TextStyles.medium20),
              const Icon(Ionicons.add),
            ],
          ),
        ),
      ],
    );
  }
}
