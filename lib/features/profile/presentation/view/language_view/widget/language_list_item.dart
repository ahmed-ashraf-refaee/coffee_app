import 'package:coffee_app/core/utils/text_styles.dart';
import 'package:coffee_app/core/widgets/prettier_tap.dart';
import 'package:coffee_app/features/profile/presentation/manager/theme_cubit/theme_cubit.dart';
import 'package:coffee_app/main.dart';
import 'package:country_flags/country_flags.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LanguageListItem extends StatelessWidget {
  const LanguageListItem({
    super.key,
    required this.selected,
    required this.onSelected,
    required this.language,
    required this.languageCode,
    this.rtl = false,
  });

  final bool selected;
  final VoidCallback onSelected;
  final String language;
  final String languageCode;
  final bool rtl;

  @override
  Widget build(BuildContext context) {
    return PrettierTap(
      shrink: 1,
      onPressed: onSelected,
      child: Container(
        height: 86,
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
          padding: const EdgeInsets.all(8),
          child: Row(
            spacing: 16,
            textDirection: rtl ? TextDirection.rtl : TextDirection.ltr,
            children: [
              CountryFlag.fromLanguageCode(
                languageCode,
                theme: ImageTheme(
                  shape: const RoundedRectangle(8),
                  height: context.height,
                  width: 96,
                ),
              ),
              Text(
                language,
                style: TextStyles.bold16.copyWith(
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
