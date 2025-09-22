import 'package:coffee_app/core/utils/app_router.dart';
import 'package:coffee_app/core/utils/text_styles.dart';
import 'package:coffee_app/core/widgets/prettier_tap.dart';
import 'package:coffee_app/features/checkout/presentation/views/checkout_view/widgets/action_container.dart';
import 'package:coffee_app/generated/l10n.dart';
import 'package:coffee_app/main.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class PaymentInfoCard extends StatelessWidget {
  const PaymentInfoCard({super.key});

  @override
  Widget build(BuildContext context) {
    return ActionContainer(
      title: S.current.payWith,
      action: PrettierTap(
        child: Text(
          S.current.change,
          style: TextStyles.bold14.copyWith(color: context.colors.primary),
        ),
        onPressed: () {
          GoRouter.of(context).push(AppRouter.kPaymentView);
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
    );
  }
}
