import 'package:coffee_app/core/constants/language_constants.dart';
import 'package:coffee_app/core/services/app_locale.dart';
import 'package:coffee_app/core/utils/text_styles.dart';
import 'package:coffee_app/core/widgets/custom_app_bar.dart';
import 'package:coffee_app/core/widgets/custom_container.dart';
import 'package:coffee_app/core/widgets/custom_elevated_button.dart';
import 'package:coffee_app/core/widgets/custom_icon_button.dart';
import 'package:coffee_app/features/home/presentation/manager/home_filter_cubit/home_filter_cubit.dart';
import 'package:coffee_app/features/profile/presentation/manager/locale_cubit/locale_cubit.dart';
import 'package:coffee_app/generated/l10n.dart';
import 'package:coffee_app/main.dart';
import 'package:country_flags/country_flags.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:ionicons/ionicons.dart';

class Language {
  final String languageName;
  final String languageCode;
  final bool rtl;

  Language({
    required this.languageName,
    required this.languageCode,
    this.rtl = false,
  });
}

List<Language> languagesList = [
  Language(languageName: 'العربية', languageCode: 'ar', rtl: true),
  Language(languageName: 'English', languageCode: 'en'),
  Language(languageName: 'Español', languageCode: 'es'),
  Language(languageName: 'Français', languageCode: 'fr'),
  Language(languageName: 'Italiano', languageCode: 'it'),
];

class LanguageSelectView extends StatefulWidget {
  const LanguageSelectView({super.key});

  @override
  State<LanguageSelectView> createState() => _LanguageSelectViewState();
}

class _LanguageSelectViewState extends State<LanguageSelectView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomContainer(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                CustomAppBar(
                  leading: CustomIconButton(
                    padding: 8,
                    onPressed: () {
                      GoRouter.of(context).pop();
                    },
                    child: Icon(
                      Ionicons.chevron_back,
                      color: context.colors.onSecondary,
                    ),
                  ),
                ),

                ListView(
                  shrinkWrap: true,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  children: [
                    Center(
                      child: Text(
                        S.current.selectLanguage,
                        style: TextStyles.bold32.copyWith(fontSize: 24),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    const SizedBox(height: 16),
                    ...languagesList.map(
                      (language) => Padding(
                        padding: const EdgeInsets.only(bottom: 16),
                        child: LanguageListItem(
                          selected:
                              AppLocale.current.languageCode ==
                              language.languageCode,
                          onSelected: () {
                            setState(() {
                              BlocProvider.of<LocaleCubit>(
                                context,
                              ).changeLocale(
                                LanguageConstants.supportedLocals[language
                                    .languageCode]!,
                              );

                              context.read<HomeFilterCubit>().resetAll();
                            });
                          },
                          language: language.languageName,
                          languageCode: language.languageCode,
                          rtl: language.rtl,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

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
    return CustomElevatedButton(
      shrink: 1,
      height: 86,
      contentPadding: const EdgeInsets.all(8),
      backgroundColor: selected
          ? context.colors.primary
          : context.colors.secondary,
      onPressed: onSelected,
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
    );
  }
}
