import 'package:coffee_app/core/utils/app_router.dart';
import 'package:coffee_app/core/utils/dark_theme.dart';
import 'package:coffee_app/core/utils/light_theme.dart';

import 'package:coffee_app/features/cart/presentation/manager/cart_cubit/cart_cubit.dart';
import 'package:coffee_app/features/profile/presentation/manager/toggle_to_dark_mode/toggle_to_dark_mode_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'core/services/app_locale.dart';
import 'features/authentication/presentation/manager/auth_bloc/auth_bloc.dart';
import 'features/wishlist/presentation/manager/wishlist/wishlist_cubit.dart';
import 'generated/l10n.dart';

final String url = "https://fxwpkhftzlintbdkujze.supabase.co";
final String anonKey =
    "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImZ4d3BraGZ0emxpbnRiZGt1anplIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NTYzNzY0ODQsImV4cCI6MjA3MTk1MjQ4NH0.oAgu9Jlsdem3A6Rk9AmCf76IkYux_fTj21qDU_kml2U";

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Supabase.initialize(url: url, anonKey: anonKey);
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(statusBarColor: Colors.transparent),
  );
  runApp(const CoffeeApp());
  // await AuthService().resetPassword("sameh.hazem504@gmail.com");
  // print(await AuthService().verify("567279", "sameh.hazem504@gmail.com"));
}

class CoffeeApp extends StatelessWidget {
  const CoffeeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => ThemeCubit()),
        BlocProvider(create: (context) => AuthBloc()),
        BlocProvider(create: (context) => WishlistCubit()..getWishlist()),
        BlocProvider(create: (context) => CartCubit()..loadCart()),
      ],
      child: BlocBuilder<ThemeCubit, ThemeMode>(
        builder: (context, themeMode) {
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
            themeMode: themeMode,
            routerConfig: AppRouter.router,
            builder: (context, router) {
              AppLocale.update(Localizations.localeOf(context));
              return router ?? const SizedBox.shrink();
            },
          );
        },
      ),
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
