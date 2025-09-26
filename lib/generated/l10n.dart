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
    final name = (locale.countryCode?.isEmpty ?? false)
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

  /// `Enter email`
  String get enterEmail {
    return Intl.message('Enter email', name: 'enterEmail', desc: '', args: []);
  }

  /// `Invalid email`
  String get invalidEmail {
    return Intl.message(
      'Invalid email',
      name: 'invalidEmail',
      desc: '',
      args: [],
    );
  }

  /// `Enter password`
  String get enterPassword {
    return Intl.message(
      'Enter password',
      name: 'enterPassword',
      desc: '',
      args: [],
    );
  }

  /// `At least 8 characters`
  String get minPassword {
    return Intl.message(
      'At least 8 characters',
      name: 'minPassword',
      desc: '',
      args: [],
    );
  }

  /// `Use upper, lower & number`
  String get passwordRequirement {
    return Intl.message(
      'Use upper, lower & number',
      name: 'passwordRequirement',
      desc: '',
      args: [],
    );
  }

  /// `Confirm password`
  String get confirmPassword {
    return Intl.message(
      'Confirm password',
      name: 'confirmPassword',
      desc: '',
      args: [],
    );
  }

  /// `Passwords don't match`
  String get passwordsDontMatch {
    return Intl.message(
      'Passwords don\'t match',
      name: 'passwordsDontMatch',
      desc: '',
      args: [],
    );
  }

  /// `Enter first name`
  String get enterFirstName {
    return Intl.message(
      'Enter first name',
      name: 'enterFirstName',
      desc: '',
      args: [],
    );
  }

  /// `Enter last name`
  String get enterLastName {
    return Intl.message(
      'Enter last name',
      name: 'enterLastName',
      desc: '',
      args: [],
    );
  }

  /// `Name too short`
  String get nameTooShort {
    return Intl.message(
      'Name too short',
      name: 'nameTooShort',
      desc: '',
      args: [],
    );
  }

  /// `Name too long`
  String get nameTooLong {
    return Intl.message(
      'Name too long',
      name: 'nameTooLong',
      desc: '',
      args: [],
    );
  }

  /// `Invalid characters`
  String get invalidCharacters {
    return Intl.message(
      'Invalid characters',
      name: 'invalidCharacters',
      desc: '',
      args: [],
    );
  }

  /// `Enter username`
  String get enterUsername {
    return Intl.message(
      'Enter username',
      name: 'enterUsername',
      desc: '',
      args: [],
    );
  }

  /// `Too short`
  String get tooShort {
    return Intl.message('Too short', name: 'tooShort', desc: '', args: []);
  }

  /// `Too long`
  String get tooLong {
    return Intl.message('Too long', name: 'tooLong', desc: '', args: []);
  }

  /// `Connection timeout with server.`
  String get connectionTimeout {
    return Intl.message(
      'Connection timeout with server.',
      name: 'connectionTimeout',
      desc: '',
      args: [],
    );
  }

  /// `Send timeout with server.`
  String get sendTimeout {
    return Intl.message(
      'Send timeout with server.',
      name: 'sendTimeout',
      desc: '',
      args: [],
    );
  }

  /// `Receive timeout with server.`
  String get receiveTimeout {
    return Intl.message(
      'Receive timeout with server.',
      name: 'receiveTimeout',
      desc: '',
      args: [],
    );
  }

  /// `Bad certificate (incorrect certificate).`
  String get badCertificate {
    return Intl.message(
      'Bad certificate (incorrect certificate).',
      name: 'badCertificate',
      desc: '',
      args: [],
    );
  }

  /// `Request was canceled.`
  String get requestCanceled {
    return Intl.message(
      'Request was canceled.',
      name: 'requestCanceled',
      desc: '',
      args: [],
    );
  }

  /// `No internet connection.`
  String get noInternetConnection {
    return Intl.message(
      'No internet connection.',
      name: 'noInternetConnection',
      desc: '',
      args: [],
    );
  }

  /// `Unexpected error. Please try again.`
  String get unexpectedError {
    return Intl.message(
      'Unexpected error. Please try again.',
      name: 'unexpectedError',
      desc: '',
      args: [],
    );
  }

  /// `Unexpected server error.`
  String get unexpectedServerError {
    return Intl.message(
      'Unexpected server error.',
      name: 'unexpectedServerError',
      desc: '',
      args: [],
    );
  }

  /// `Unauthorized request.`
  String get unauthorizedRequest {
    return Intl.message(
      'Unauthorized request.',
      name: 'unauthorizedRequest',
      desc: '',
      args: [],
    );
  }

  /// `Your request was not found.`
  String get notFound {
    return Intl.message(
      'Your request was not found.',
      name: 'notFound',
      desc: '',
      args: [],
    );
  }

  /// `Internal server error. Please try again.`
  String get internalServerError {
    return Intl.message(
      'Internal server error. Please try again.',
      name: 'internalServerError',
      desc: '',
      args: [],
    );
  }

  /// `Oops, something went wrong. Please try again.`
  String get genericError {
    return Intl.message(
      'Oops, something went wrong. Please try again.',
      name: 'genericError',
      desc: '',
      args: [],
    );
  }

  /// `Invalid email or password.`
  String get invalidCredentials {
    return Intl.message(
      'Invalid email or password.',
      name: 'invalidCredentials',
      desc: '',
      args: [],
    );
  }

  /// `Please confirm your email before logging in.`
  String get emailNotConfirmed {
    return Intl.message(
      'Please confirm your email before logging in.',
      name: 'emailNotConfirmed',
      desc: '',
      args: [],
    );
  }

  /// `This email is already registered.`
  String get emailAlreadyRegistered {
    return Intl.message(
      'This email is already registered.',
      name: 'emailAlreadyRegistered',
      desc: '',
      args: [],
    );
  }

  /// `Your password is too weak or incorrect.`
  String get weakOrWrongPassword {
    return Intl.message(
      'Your password is too weak or incorrect.',
      name: 'weakOrWrongPassword',
      desc: '',
      args: [],
    );
  }

  /// `Authentication failed. Please try again.`
  String get authFailed {
    return Intl.message(
      'Authentication failed. Please try again.',
      name: 'authFailed',
      desc: '',
      args: [],
    );
  }

  /// `This record already exists.`
  String get duplicateRecord {
    return Intl.message(
      'This record already exists.',
      name: 'duplicateRecord',
      desc: '',
      args: [],
    );
  }

  /// `This record is linked and cannot be removed.`
  String get foreignKeyError {
    return Intl.message(
      'This record is linked and cannot be removed.',
      name: 'foreignKeyError',
      desc: '',
      args: [],
    );
  }

  /// `A required field was left empty.`
  String get nullValueError {
    return Intl.message(
      'A required field was left empty.',
      name: 'nullValueError',
      desc: '',
      args: [],
    );
  }

  /// `There is a problem with the database query.`
  String get syntaxError {
    return Intl.message(
      'There is a problem with the database query.',
      name: 'syntaxError',
      desc: '',
      args: [],
    );
  }

  /// `A database error occurred. Please try again.`
  String get databaseError {
    return Intl.message(
      'A database error occurred. Please try again.',
      name: 'databaseError',
      desc: '',
      args: [],
    );
  }

  /// `That username isn't available. Choose a different one.`
  String get usernameTaken {
    return Intl.message(
      'That username isn\'t available. Choose a different one.',
      name: 'usernameTaken',
      desc: '',
      args: [],
    );
  }

  /// `Your account has been created successfully.`
  String get registrationSuccess {
    return Intl.message(
      'Your account has been created successfully.',
      name: 'registrationSuccess',
      desc: '',
      args: [],
    );
  }

  /// `We've sent a password reset link to your email.`
  String get resetPasswordEmailSent {
    return Intl.message(
      'We\'ve sent a password reset link to your email.',
      name: 'resetPasswordEmailSent',
      desc: '',
      args: [],
    );
  }

  /// `New password must be different from the old password.`
  String get samePasswordError {
    return Intl.message(
      'New password must be different from the old password.',
      name: 'samePasswordError',
      desc: '',
      args: [],
    );
  }

  /// `Your password has been reset successfully.`
  String get resetPasswordSuccess {
    return Intl.message(
      'Your password has been reset successfully.',
      name: 'resetPasswordSuccess',
      desc: '',
      args: [],
    );
  }

  /// `Something went wrong. Please try again.`
  String get resetPasswordError {
    return Intl.message(
      'Something went wrong. Please try again.',
      name: 'resetPasswordError',
      desc: '',
      args: [],
    );
  }

  /// `This reset link has expired. Please request a new one.`
  String get linkExpired {
    return Intl.message(
      'This reset link has expired. Please request a new one.',
      name: 'linkExpired',
      desc: '',
      args: [],
    );
  }

  /// `The provided value is too long.`
  String get valueTooLong {
    return Intl.message(
      'The provided value is too long.',
      name: 'valueTooLong',
      desc: '',
      args: [],
    );
  }

  /// `Invalid input format.`
  String get invalidInputSyntax {
    return Intl.message(
      'Invalid input format.',
      name: 'invalidInputSyntax',
      desc: '',
      args: [],
    );
  }

  /// `There is a conflict with the current data.`
  String get conflictError {
    return Intl.message(
      'There is a conflict with the current data.',
      name: 'conflictError',
      desc: '',
      args: [],
    );
  }

  /// `Enter Verification Code`
  String get enterVerificationCode {
    return Intl.message(
      'Enter Verification Code',
      name: 'enterVerificationCode',
      desc: '',
      args: [],
    );
  }

  /// `Enter the 6-digit verification code we sent to your email.`
  String get enterVerificationCodeSubtitle {
    return Intl.message(
      'Enter the 6-digit verification code we sent to your email.',
      name: 'enterVerificationCodeSubtitle',
      desc: '',
      args: [],
    );
  }

  /// `Please enter the code`
  String get pleaseEnterCode {
    return Intl.message(
      'Please enter the code',
      name: 'pleaseEnterCode',
      desc: '',
      args: [],
    );
  }

  /// `Code must be 6 digits`
  String get codeMustBeSixDigits {
    return Intl.message(
      'Code must be 6 digits',
      name: 'codeMustBeSixDigits',
      desc: '',
      args: [],
    );
  }

  /// `Not received yet?`
  String get notReceivedYet {
    return Intl.message(
      'Not received yet?',
      name: 'notReceivedYet',
      desc: '',
      args: [],
    );
  }

  /// `Resend after {seconds} seconds`
  String resendAfterSeconds(int seconds) {
    return Intl.message(
      'Resend after $seconds seconds',
      name: 'resendAfterSeconds',
      desc: '',
      args: [seconds],
    );
  }

  /// `Resend Code`
  String get resendCode {
    return Intl.message('Resend Code', name: 'resendCode', desc: '', args: []);
  }

  /// `Verification successful. You can now set a new password.`
  String get verificationSuccessful {
    return Intl.message(
      'Verification successful. You can now set a new password.',
      name: 'verificationSuccessful',
      desc: '',
      args: [],
    );
  }

  /// `New code sent. Please check your inbox.`
  String get newCodeSent {
    return Intl.message(
      'New code sent. Please check your inbox.',
      name: 'newCodeSent',
      desc: '',
      args: [],
    );
  }

  /// `Set Password`
  String get setPassword {
    return Intl.message(
      'Set Password',
      name: 'setPassword',
      desc: '',
      args: [],
    );
  }

  /// `Create a new password for your account.`
  String get setPasswordSubtitle {
    return Intl.message(
      'Create a new password for your account.',
      name: 'setPasswordSubtitle',
      desc: '',
      args: [],
    );
  }

  /// `Your password has been successfully updated.`
  String get passwordUpdatedSuccessfully {
    return Intl.message(
      'Your password has been successfully updated.',
      name: 'passwordUpdatedSuccessfully',
      desc: '',
      args: [],
    );
  }

  /// `Send Verification Code`
  String get sendEmail {
    return Intl.message(
      'Send Verification Code',
      name: 'sendEmail',
      desc: '',
      args: [],
    );
  }

  /// `Verify`
  String get verify {
    return Intl.message('Verify', name: 'verify', desc: '', args: []);
  }

  /// `Set Password`
  String get setPasswordButton {
    return Intl.message(
      'Set Password',
      name: 'setPasswordButton',
      desc: '',
      args: [],
    );
  }

  /// `Reset password`
  String get resetPassword {
    return Intl.message(
      'Reset password',
      name: 'resetPassword',
      desc: '',
      args: [],
    );
  }

  /// `Enter your email to reset your password.`
  String get resetPasswordSubtitle {
    return Intl.message(
      'Enter your email to reset your password.',
      name: 'resetPasswordSubtitle',
      desc: '',
      args: [],
    );
  }

  /// `Verification email sent. Please check your inbox.`
  String get verificationEmailSent {
    return Intl.message(
      'Verification email sent. Please check your inbox.',
      name: 'verificationEmailSent',
      desc: '',
      args: [],
    );
  }

  /// `User with provided email does not exist.`
  String get userEmailNotFound {
    return Intl.message(
      'User with provided email does not exist.',
      name: 'userEmailNotFound',
      desc: '',
      args: [],
    );
  }

  /// `This reset link has expired`
  String get otpExpired {
    return Intl.message(
      'This reset link has expired',
      name: 'otpExpired',
      desc: '',
      args: [],
    );
  }

  /// `Invalid OTP code. Please check and try again.`
  String get invalidOTP {
    return Intl.message(
      'Invalid OTP code. Please check and try again.',
      name: 'invalidOTP',
      desc: '',
      args: [],
    );
  }

  /// `Select Language`
  String get selectLanguage {
    return Intl.message(
      'Select Language',
      name: 'selectLanguage',
      desc: '',
      args: [],
    );
  }

  /// `Save`
  String get save {
    return Intl.message('Save', name: 'save', desc: '', args: []);
  }

  /// `Top Rated`
  String get sort_topRated {
    return Intl.message('Top Rated', name: 'sort_topRated', desc: '', args: []);
  }

  /// `Oldest`
  String get sort_oldest {
    return Intl.message('Oldest', name: 'sort_oldest', desc: '', args: []);
  }

  /// `Newest`
  String get sort_newest {
    return Intl.message('Newest', name: 'sort_newest', desc: '', args: []);
  }

  /// `Discount`
  String get sort_discount {
    return Intl.message('Discount', name: 'sort_discount', desc: '', args: []);
  }

  /// `Lowest Price`
  String get sort_lowestPrice {
    return Intl.message(
      'Lowest Price',
      name: 'sort_lowestPrice',
      desc: '',
      args: [],
    );
  }

  /// `Highest Price`
  String get sort_highestPrice {
    return Intl.message(
      'Highest Price',
      name: 'sort_highestPrice',
      desc: '',
      args: [],
    );
  }

  /// `5 Stars`
  String get rating_5 {
    return Intl.message('5 Stars', name: 'rating_5', desc: '', args: []);
  }

  /// `4 Stars & Up`
  String get rating_4up {
    return Intl.message('4 Stars & Up', name: 'rating_4up', desc: '', args: []);
  }

  /// `3 Stars & Up`
  String get rating_3up {
    return Intl.message('3 Stars & Up', name: 'rating_3up', desc: '', args: []);
  }

  /// `2 Stars & Up`
  String get rating_2up {
    return Intl.message('2 Stars & Up', name: 'rating_2up', desc: '', args: []);
  }

  /// `1 Star & Up`
  String get rating_1up {
    return Intl.message('1 Star & Up', name: 'rating_1up', desc: '', args: []);
  }

  /// `Filters`
  String get filters {
    return Intl.message('Filters', name: 'filters', desc: '', args: []);
  }

  /// `Reset`
  String get reset {
    return Intl.message('Reset', name: 'reset', desc: '', args: []);
  }

  /// `Apply`
  String get apply {
    return Intl.message('Apply', name: 'apply', desc: '', args: []);
  }

  /// `Sort by`
  String get sortBy {
    return Intl.message('Sort by', name: 'sortBy', desc: '', args: []);
  }

  /// `Price range`
  String get priceRange {
    return Intl.message('Price range', name: 'priceRange', desc: '', args: []);
  }

  /// `Rating`
  String get rating {
    return Intl.message('Rating', name: 'rating', desc: '', args: []);
  }

  /// `All`
  String get all {
    return Intl.message('All', name: 'all', desc: '', args: []);
  }

  /// `Order Summary`
  String get order_summary {
    return Intl.message(
      'Order Summary',
      name: 'order_summary',
      desc: '',
      args: [],
    );
  }

  /// `Pay with`
  String get payWith {
    return Intl.message('Pay with', name: 'payWith', desc: '', args: []);
  }

  /// `Ship to`
  String get shipTo {
    return Intl.message('Ship to', name: 'shipTo', desc: '', args: []);
  }

  /// `change`
  String get change {
    return Intl.message('change', name: 'change', desc: '', args: []);
  }

  /// `Checkout`
  String get checkout {
    return Intl.message('Checkout', name: 'checkout', desc: '', args: []);
  }

  /// `Add`
  String get add {
    return Intl.message('Add', name: 'add', desc: '', args: []);
  }

  /// `Add payment method`
  String get addPaymentMethod {
    return Intl.message(
      'Add payment method',
      name: 'addPaymentMethod',
      desc: '',
      args: [],
    );
  }

  /// `Add shipping address`
  String get addShippingAddress {
    return Intl.message(
      'Add shipping address',
      name: 'addShippingAddress',
      desc: '',
      args: [],
    );
  }

  /// `Card Holder Name`
  String get holderName {
    return Intl.message(
      'Card Holder Name',
      name: 'holderName',
      desc: '',
      args: [],
    );
  }

  /// `CVV`
  String get cvv {
    return Intl.message('CVV', name: 'cvv', desc: '', args: []);
  }

  /// `MM/YY`
  String get expiryDate {
    return Intl.message('MM/YY', name: 'expiryDate', desc: '', args: []);
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
