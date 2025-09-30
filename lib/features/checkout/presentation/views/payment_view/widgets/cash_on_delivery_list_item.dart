import 'package:coffee_app/core/utils/text_styles.dart';
import 'package:coffee_app/core/widgets/prettier_tap.dart';
import 'package:coffee_app/features/profile/presentation/manager/theme_cubit/theme_cubit.dart';
import 'package:coffee_app/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CashOnDeliveryListItem extends StatelessWidget {
  const CashOnDeliveryListItem({
    super.key,
    required this.selected,
    required this.onSelected,
  });

  final bool selected;
  final VoidCallback onSelected;

  @override
  Widget build(BuildContext context) {
    return PrettierTap(
      shrink: 1,
      onPressed: onSelected,
      child: Container(
        decoration: BoxDecoration(
          border: selected
              ? Border.all(
                  color: context.colors.primary,
                  strokeAlign: BorderSide.strokeAlignOutside,
                )
              : null,
          borderRadius: BorderRadius.circular(12),
          color: selected
              ? context.watch<ThemeCubit>().isDark
                    ? Color.lerp(
                        context.colors.primary,
                        context.colors.surface,
                        0.3,
                      )
                    : Color.lerp(
                        context.colors.primary,
                        context.colors.surface,
                        0.05,
                      )
              : context.colors.secondary,
        ),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 32),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          spacing: 16,
          children: [
            Text(
              "Cash on Delivery",
              style: TextStyles.bold20.copyWith(
                color: selected
                    ? context.colors.onPrimary
                    : context.colors.onSecondary,
              ),
            ),
            Icon(
              Icons.payments_outlined,
              size: 28,
              color: selected
                  ? context.colors.onPrimary
                  : context.colors.onSecondary,
            ),
          ],
        ),
      ),
    );
  }
}
