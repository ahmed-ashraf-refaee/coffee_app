import 'package:coffee_app/core/widgets/custom_elevated_button.dart';
import 'package:coffee_app/features/cart/presentation/view/widgets/cart_list_item.dart';
import 'package:coffee_app/features/cart/presentation/view/widgets/summary_line.dart';
import 'package:coffee_app/main.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ionicons/ionicons.dart';

import '../../../../../core/utils/text_styles.dart';
import '../../../../../core/widgets/custom_icon_button.dart';
import '../../../../../generated/l10n.dart';

class CartViewBody extends StatelessWidget {
  const CartViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // This Expanded widget makes the CustomScrollView fill the available space
        Expanded(
          child: CustomScrollView(
            slivers: [
              SliverAppBar(
                collapsedHeight: 48 + 16,
                toolbarHeight: 48,
                backgroundColor: context.colors.surface,
                leadingWidth: 48,
                leading: CustomIconButton(
                  padding: 8,
                  onPressed: GoRouter.of(context).pop,
                  child: Icon(
                    Ionicons.chevron_back,
                    color: context.colors.onSecondary,
                  ),
                ),
                actions: [
                  CustomIconButton(
                    padding: 8,
                    onPressed: () {},
                    child: Icon(
                      Ionicons.bag_remove_outline,
                      color: context.colors.primary,
                    ),
                  ),
                ],
              ),
              SliverList.builder(
                itemBuilder: (context, index) => const Padding(
                  padding: EdgeInsets.only(bottom: 16),
                  child: CartListItem(),
                ),
                itemCount: 20,
              ),
            ],
          ),
        ),

        // This is the fixed summary section at the bottom
        Container(
          padding: const EdgeInsets.only(top: 16),
          color: context.colors.surface,
          width: context.width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            spacing: 8,
            children: [
              SummaryLine(
                label: S.current.sub_total,
                value: '15',
                style: TextStyles.regular16,
              ),
              SummaryLine(
                label: S.current.shipping,
                value: '15',
                style: TextStyles.regular16,
              ),
              Divider(color: context.colors.onSecondary, thickness: 1),
              SummaryLine(
                label: S.current.total_price,
                value: '30',
                style: TextStyles.regular16,
              ),
              CustomElevatedButton(
                onPressed: () {},
                child: Text(
                  S.current.continue_with_payment,
                  style: TextStyles.medium20.copyWith(
                    color: context.colors.onPrimary,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
