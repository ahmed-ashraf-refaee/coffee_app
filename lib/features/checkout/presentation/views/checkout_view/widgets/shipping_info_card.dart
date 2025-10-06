import 'package:coffee_app/core/utils/app_router.dart';
import 'package:coffee_app/core/utils/text_styles.dart';
import 'package:coffee_app/core/widgets/prettier_tap.dart';
import 'package:coffee_app/features/checkout/presentation/manager/card/card_cubit.dart';
import 'package:coffee_app/features/checkout/presentation/views/checkout_view/widgets/action_container.dart';
import 'package:coffee_app/generated/l10n.dart';
import 'package:coffee_app/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class ShippingInfoCard extends StatelessWidget {
  const ShippingInfoCard({super.key});

  @override
  Widget build(BuildContext context) {
    final defaultAddress = context.watch<CardCubit>().state.defaultAddress;
    return ActionContainer(
      title: S.current.shipTo,
      action: PrettierTap(
        child: Text(
          S.current.change,
          style: TextStyles.bold14.copyWith(color: context.colors.primary),
        ),
        onPressed: () {
          GoRouter.of(context).push(AppRouter.kAddressView);
        },
      ),
      defaultAction: PrettierTap(
        child: Text(
          S.current.add,
          style: TextStyles.bold14.copyWith(color: context.colors.primary),
        ),
        onPressed: () {
          GoRouter.of(context).push(AppRouter.kAddressView);
        },
      ),
      defaultContent: Text(
        S.current.addShippingAddress,
        style: TextStyles.regular15.copyWith(color: context.colors.onSecondary),
      ),
      content: defaultAddress == null
          ? null
          : Padding(
              padding: const EdgeInsets.only(top: 16),
              child: Column(
                spacing: 16,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        defaultAddress.title!,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        style: TextStyles.bold20.copyWith(
                          color: context.colors.onSecondary,
                        ),
                      ),
                      Text(
                        defaultAddress.phoneNumber!,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        style: TextStyles.regular16.copyWith(
                          color: context.colors.onSecondary,
                        ),
                      ),
                    ],
                  ),

                  Text(
                    defaultAddress.address,
                    style: TextStyle(color: context.colors.onSecondary),
                  ),
                ],
              ),
            ),
    );
  }
}
