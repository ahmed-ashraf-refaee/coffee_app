// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(
      _current != null,
      'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.',
    );
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name =
        (locale.countryCode?.isEmpty ?? false)
            ? locale.languageCode
            : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(
      instance != null,
      'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?',
    );
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Coffee`
  String get app_name_first {
    return Intl.message('Coffee', name: 'app_name_first', desc: '', args: []);
  }

  /// `Drop`
  String get app_name_second {
    return Intl.message('Drop', name: 'app_name_second', desc: '', args: []);
  }

  /// `First Name`
  String get first_name {
    return Intl.message('First Name', name: 'first_name', desc: '', args: []);
  }

  /// `Last Name`
  String get last_name {
    return Intl.message('Last Name', name: 'last_name', desc: '', args: []);
  }

  /// `Username`
  String get username {
    return Intl.message('Username', name: 'username', desc: '', args: []);
  }

  /// `Email`
  String get email {
    return Intl.message('Email', name: 'email', desc: '', args: []);
  }

  /// `Password`
  String get password {
    return Intl.message('Password', name: 'password', desc: '', args: []);
  }

  /// `Confirm Password`
  String get confirm_password {
    return Intl.message(
      'Confirm Password',
      name: 'confirm_password',
      desc: '',
      args: [],
    );
  }

  /// `Sign Up`
  String get sign_up {
    return Intl.message('Sign Up', name: 'sign_up', desc: '', args: []);
  }

  /// `Log In`
  String get log_in {
    return Intl.message('Log In', name: 'log_in', desc: '', args: []);
  }

  /// `Forgot Password?`
  String get forgot_password {
    return Intl.message(
      'Forgot Password?',
      name: 'forgot_password',
      desc: '',
      args: [],
    );
  }

  /// `Already have an account?`
  String get already_have_account {
    return Intl.message(
      'Already have an account?',
      name: 'already_have_account',
      desc: '',
      args: [],
    );
  }

  /// `Don't have an account?`
  String get dont_have_account {
    return Intl.message(
      'Don\'t have an account?',
      name: 'dont_have_account',
      desc: '',
      args: [],
    );
  }

  /// `Welcome Back`
  String get welcome_back {
    return Intl.message(
      'Welcome Back',
      name: 'welcome_back',
      desc: '',
      args: [],
    );
  }

  /// `Create an Account`
  String get create_account {
    return Intl.message(
      'Create an Account',
      name: 'create_account',
      desc: '',
      args: [],
    );
  }

  /// `Remember me`
  String get remember_me {
    return Intl.message('Remember me', name: 'remember_me', desc: '', args: []);
  }

  /// `or`
  String get or {
    return Intl.message('or', name: 'or', desc: '', args: []);
  }

  /// `Welcome Back!`
  String get welcome_back_title {
    return Intl.message(
      'Welcome Back!',
      name: 'welcome_back_title',
      desc: '',
      args: [],
    );
  }

  /// `Log in to access your account`
  String get welcome_back_subtitle {
    return Intl.message(
      'Log in to access your account',
      name: 'welcome_back_subtitle',
      desc: '',
      args: [],
    );
  }

  /// `Get Started Now!`
  String get get_started_title {
    return Intl.message(
      'Get Started Now!',
      name: 'get_started_title',
      desc: '',
      args: [],
    );
  }

  /// `Sign up to discover a world full of coffee`
  String get get_started_subtitle {
    return Intl.message(
      'Sign up to discover a world full of coffee',
      name: 'get_started_subtitle',
      desc: '',
      args: [],
    );
  }

  /// `Facebook`
  String get facebook {
    return Intl.message('Facebook', name: 'facebook', desc: '', args: []);
  }

  /// `Google`
  String get google {
    return Intl.message('Google', name: 'google', desc: '', args: []);
  }

  /// `Find your favorite coffee`
  String get search {
    return Intl.message(
      'Find your favorite coffee',
      name: 'search',
      desc: '',
      args: [],
    );
  }

  /// `Edit Profile`
  String get profile_edit_profile {
    return Intl.message(
      'Edit Profile',
      name: 'profile_edit_profile',
      desc: '',
      args: [],
    );
  }

  /// `Payment Details`
  String get profile_payment_details {
    return Intl.message(
      'Payment Details',
      name: 'profile_payment_details',
      desc: '',
      args: [],
    );
  }

  /// `Languages`
  String get profile_languages {
    return Intl.message(
      'Languages',
      name: 'profile_languages',
      desc: '',
      args: [],
    );
  }

  /// `Notification`
  String get profile_notification {
    return Intl.message(
      'Notification',
      name: 'profile_notification',
      desc: '',
      args: [],
    );
  }

  /// `Dark Mode`
  String get profile_dark_mode {
    return Intl.message(
      'Dark Mode',
      name: 'profile_dark_mode',
      desc: '',
      args: [],
    );
  }

  /// `Support`
  String get profile_support {
    return Intl.message('Support', name: 'profile_support', desc: '', args: []);
  }

  /// `Logout`
  String get profile_logout {
    return Intl.message('Logout', name: 'profile_logout', desc: '', args: []);
  }

  /// `Total Price:`
  String get total_price {
    return Intl.message(
      'Total Price:',
      name: 'total_price',
      desc: '',
      args: [],
    );
  }

  /// `Sub Total:`
  String get sub_total {
    return Intl.message('Sub Total:', name: 'sub_total', desc: '', args: []);
  }

  /// `Shipping:`
  String get shipping {
    return Intl.message('Shipping:', name: 'shipping', desc: '', args: []);
  }

  /// `Continue with payment`
  String get continue_with_payment {
    return Intl.message(
      'Continue with payment',
      name: 'continue_with_payment',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'ar'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
