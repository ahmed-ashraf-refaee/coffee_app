import 'package:coffee_app/core/utils/app_router.dart';
import 'package:coffee_app/core/utils/text_styles.dart';
import 'package:coffee_app/core/widgets/prettier_tap.dart';
import 'package:coffee_app/features/checkout/data/models/payment_method_model.dart';
import 'package:coffee_app/features/checkout/presentation/manager/card/card_cubit.dart';
import 'package:coffee_app/features/checkout/presentation/views/checkout_view/widgets/action_container.dart';
import 'package:coffee_app/features/checkout/presentation/views/payment_view/widgets/card_brand_icon.dart';
import 'package:coffee_app/generated/l10n.dart';
import 'package:coffee_app/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class PaymentInfoCard extends StatelessWidget {
  const PaymentInfoCard({
    super.key,
    required this.cvvController,
    required this.formKey,
  });
  final TextEditingController cvvController;
  final GlobalKey formKey;
  @override
  Widget build(BuildContext context) {
    final defaultCard = context.watch<CardCubit>().state.defaultCard;
    return ActionContainer(
      title: S.current.payWith,
      action: PrettierTap(
        child: Text(
          S.current.change,
          style: TextStyles.bold14.copyWith(color: context.colors.primary),
        ),

        onPressed: () {
          GoRouter.of(context).push(AppRouter.kPaymentView);
          cvvController.clear();
        },
      ),
      defaultAction: PrettierTap(
        child: Text(
          S.current.add,
          style: TextStyles.bold14.copyWith(color: context.colors.primary),
        ),
        onPressed: () {
          GoRouter.of(context).push(AppRouter.kPaymentView);
        },
      ),
      defaultContent: Text(
        S.current.addPaymentMethod,
        style: TextStyles.regular15.copyWith(color: context.colors.onSecondary),
      ),
      content: defaultCard == null
          ? null
          : defaultCard.id == -1
          ? Padding(
              padding: const EdgeInsets.only(top: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                spacing: 16,
                children: [
                  Icon(
                    Icons.payments_outlined,
                    size: 32,
                    color: context.colors.onSecondary,
                  ),
                  Text(
                    "Cash on Delivery",
                    style: TextStyles.medium16.copyWith(
                      color: context.colors.onSecondary,
                    ),
                  ),
                ],
              ),
            )
          : CardPayment(
              defaultCard: defaultCard,
              cvvController: cvvController,
              formKey: formKey,
            ),
    );
  }
}

class CardPayment extends StatelessWidget {
  const CardPayment({
    super.key,
    required this.defaultCard,
    required this.cvvController,
    required this.formKey,
  });

  final PaymentMethodModel defaultCard;
  final TextEditingController cvvController;
  final GlobalKey formKey;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 16),
      child: Row(
        spacing: 16,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,

        children: [
          cardBrandIcon(
            context: context,
            brand: defaultCard.brand,
            size: 32,
            selected: false,
          ),
          Text(
            "**** **** **** ${defaultCard.last4}",
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
            textDirection: TextDirection.ltr,
            style: TextStyles.medium16.copyWith(
              color: context.colors.onSecondary,
            ),
          ),
          const Spacer(),
          Form(
            key: formKey,
            child: TextFormField(
              controller: cvvController,
              keyboardType: TextInputType.number,
              style: TextStyles.regular15,
              textAlign: TextAlign.center,
              maxLength: 3,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              decoration: InputDecoration(
                isDense: true,
                constraints: const BoxConstraints(maxHeight: 64, maxWidth: 64),
                counterText: '',
                contentPadding: const EdgeInsets.symmetric(vertical: 8),
                hintText: "cvv",
                fillColor: context.colors.surface,
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Enter CVV";
                } else if (value.length != 3) {
                  return "Invalid CVV";
                }
                return null;
              },
            ),
          ),
        ],
      ),
    );
  }
}
