import 'package:coffee_app/core/constants/keys.dart';
import 'package:coffee_app/core/constants/language_constants.dart';
import 'package:coffee_app/core/utils/app_router.dart';
import 'package:coffee_app/core/utils/dark_theme.dart';
import 'package:coffee_app/core/utils/light_theme.dart';
import 'package:coffee_app/features/admin/presentation/manager/admin_product_manager/admin_product_manager_cubit.dart';
import 'package:coffee_app/features/cart/presentation/manager/cart_cubit/cart_cubit.dart';
import 'package:coffee_app/features/checkout/presentation/manager/address/address_cubit.dart';
import 'package:coffee_app/features/checkout/presentation/manager/card/card_cubit.dart';
import 'package:coffee_app/features/home/presentation/manager/review_cubit/review_cubit.dart';
import 'package:coffee_app/features/profile/presentation/manager/locale_cubit/locale_cubit.dart';
import 'package:coffee_app/features/profile/presentation/manager/theme_cubit/theme_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'core/services/app_locale.dart';
import 'features/admin/presentation/manager/admin_role_cubit/admin_role_cubit.dart';
import 'features/authentication/presentation/manager/auth_bloc/auth_bloc.dart';
import 'features/checkout/presentation/manager/payment/payment_cubit.dart';
import 'features/home/presentation/manager/home_filter_cubit/home_filter_cubit.dart';
import 'features/home/presentation/manager/home_products_cubit/home_product_cubit.dart';
import 'features/navigation/presentation/manager/navigator_cubit/navigator_cubit.dart';
import 'features/profile/presentation/manager/edit_profile/edit_profile_cubit.dart';
import 'features/wishlist/presentation/manager/wishlist/wishlist_cubit.dart';
import 'generated/l10n.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Supabase.initialize(
    url: Keys.supabaseUrl,
    anonKey: Keys.supabaseAnonKey,
  );
  Stripe.publishableKey = Keys.stripePublishableKey;
  await Stripe.instance.applySettings();

  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(statusBarColor: Colors.transparent),
  );

  runApp(const CoffeeApp());
}

class CoffeeApp extends StatelessWidget {
  const CoffeeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => ThemeCubit()),
        BlocProvider(create: (context) => AuthBloc()),
        BlocProvider(create: (context) => WishlistCubit()),
        BlocProvider(create: (context) => CartCubit()),
        BlocProvider(create: (context) => LocaleCubit()),
        BlocProvider(create: (context) => HomeFilterCubit()),
        BlocProvider(create: (context) => AddressCubit()..fetchAddresses()),
        BlocProvider(create: (context) => PaymentCubit()),
        BlocProvider(create: (context) => CardCubit()),
        BlocProvider(create: (context) => AdminProductManagerCubit()),
        BlocProvider(create: (context) => AdminRoleCubit()..loadRole()),
        BlocProvider(create: (context) => EditProfileCubit()..fetchUserData()),
        BlocProvider(create: (context) => AppNavigatorCubit()),
        BlocProvider(create: (context) => ReviewCubit()),
        BlocProvider(
          create: (context) =>
              HomeProductCubit(context.read<HomeFilterCubit>())..getProducts(),
        ),
      ],
      child: Builder(
        builder: (context) {
          final themeMode = context.select((ThemeCubit c) => c.state);
          final locale = context.select((LocaleCubit c) => c.state);
          print(locale.languageCode);
          return MaterialApp.router(
            debugShowCheckedModeBanner: false,
            locale: locale,
            localizationsDelegates: const [
              S.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: LanguageConstants.supportedLocals.values,
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
