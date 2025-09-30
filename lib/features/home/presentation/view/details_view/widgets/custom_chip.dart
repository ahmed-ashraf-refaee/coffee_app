import 'package:coffee_app/core/utils/text_styles.dart';
import 'package:coffee_app/core/widgets/prettier_tap.dart';
import 'package:coffee_app/features/profile/presentation/manager/theme_cubit/theme_cubit.dart';
import 'package:coffee_app/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CustomChip extends StatelessWidget {
  const CustomChip({
    super.key,
    required this.label,
    required this.selected,
    required this.onSelected,
    this.contentPadding = const EdgeInsets.all(12),
  });

  final String label;
  final bool selected;
  final VoidCallback onSelected;
  final EdgeInsets contentPadding;

  @override
  Widget build(BuildContext context) {
    final Widget body = Container(
      height: 48,
      alignment: Alignment.center,
      padding: contentPadding,
      decoration: BoxDecoration(
        border: selected
            ? Border.all(
                color: context.colors.primary,
                strokeAlign: BorderSide.strokeAlignInside,
              )
            : null,
        borderRadius: BorderRadius.circular(12),
        color: selected
            ? context.watch<ThemeCubit>().isDark
                  ? Color.lerp(
                      context.colors.primary,
                      context.colors.surface,
                      0.4,
                    )
                  : Color.lerp(
                      context.colors.primary,
                      context.colors.surface,
                      0.05,
                    )
            : context.colors.secondary,
      ),
      child: Text(
        label,
        style: TextStyles.regular15.copyWith(
          color: selected
              ? context.colors.onPrimary
              : context.colors.onSecondary,
        ),
      ),
    );

    return IntrinsicWidth(
      child: PrettierTap(shrink: 3, onPressed: onSelected, child: body),
    );
  }
}
