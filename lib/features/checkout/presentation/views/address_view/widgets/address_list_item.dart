import 'package:coffee_app/core/utils/text_styles.dart';
import 'package:coffee_app/core/widgets/prettier_tap.dart';
import 'package:coffee_app/features/checkout/data/models/address_model.dart';
import 'package:coffee_app/features/profile/presentation/manager/theme_cubit/theme_cubit.dart';
import 'package:coffee_app/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddressListItem extends StatelessWidget {
  const AddressListItem({
    super.key,
    required this.selected,
    required this.onSelected,
    required this.address,
  });

  final bool selected;
  final VoidCallback onSelected;
  final AddressModel address;

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
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            spacing: 16,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    address.title!,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    style: TextStyles.bold20.copyWith(
                      color: selected
                          ? context.colors.onPrimary
                          : context.colors.onSecondary,
                    ),
                  ),
                  Text(
                    address.phoneNumber!,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    style: TextStyles.regular16.copyWith(
                      color: selected
                          ? context.colors.onPrimary
                          : context.colors.onSecondary,
                    ),
                  ),
                ],
              ),

              Text(
                address.address,
                style: TextStyle(
                  color: selected
                      ? context.colors.onPrimary
                      : context.colors.onSecondary,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
