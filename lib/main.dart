import 'package:coffee_app/core/utils/app_router.dart';
import 'package:coffee_app/core/utils/dark_theme.dart';
import 'package:coffee_app/core/utils/light_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'generated/l10n.dart';

void main() {
  runApp(const CoffeeApp());
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(statusBarColor: Colors.transparent),
  );
}

class CoffeeApp extends StatelessWidget {
  const CoffeeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      locale: const Locale("en"),
      localizationsDelegates: const [
        S.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: S.delegate.supportedLocales,
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: ThemeMode.system,

      routerConfig: AppRouter.router,
    );
  }
}

extension DeviceSize on BuildContext {
  double get height => MediaQuery.of(this).size.height;
  double get width => MediaQuery.of(this).size.width;
}

extension LocaleExtension on BuildContext {
  Locale get locale => Localizations.localeOf(this);
  bool get isArabic =>
      Localizations.localeOf(this).languageCode.toLowerCase() == 'ar';
}

extension ColorSchemeExtension on BuildContext {
  ColorScheme get colors => Theme.of(this).colorScheme;
}
