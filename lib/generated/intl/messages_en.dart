// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a en locale. All the
// messages from the main program should be duplicated here with the same
// function name.

// Ignore issues from commonly used lints in this file.
// ignore_for_file:unnecessary_brace_in_string_interps, unnecessary_new
// ignore_for_file:prefer_single_quotes,comment_references, directives_ordering
// ignore_for_file:annotate_overrides,prefer_generic_function_type_aliases
// ignore_for_file:unused_import, file_names, avoid_escaping_inner_quotes
// ignore_for_file:unnecessary_string_interpolations, unnecessary_string_escapes

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = new MessageLookup();

typedef String MessageIfAbsent(String messageStr, List<dynamic> args);

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'en';

  static String m0(seconds) => "Resend after ${seconds} seconds";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
    "all": MessageLookupByLibrary.simpleMessage("All"),
    "already_have_account": MessageLookupByLibrary.simpleMessage(
      "Already have an account?",
    ),
    "app_name_first": MessageLookupByLibrary.simpleMessage("Coffee"),
    "app_name_second": MessageLookupByLibrary.simpleMessage("Drop"),
    "apply": MessageLookupByLibrary.simpleMessage("Apply"),
    "authFailed": MessageLookupByLibrary.simpleMessage(
      "Authentication failed. Please try again.",
    ),
    "badCertificate": MessageLookupByLibrary.simpleMessage(
      "Bad certificate (incorrect certificate).",
    ),
    "codeMustBeSixDigits": MessageLookupByLibrary.simpleMessage(
      "Code must be 6 digits",
    ),
    "confirmPassword": MessageLookupByLibrary.simpleMessage("Confirm password"),
    "confirm_password": MessageLookupByLibrary.simpleMessage(
      "Confirm Password",
    ),
    "conflictError": MessageLookupByLibrary.simpleMessage(
      "There is a conflict with the current data.",
    ),
    "connectionTimeout": MessageLookupByLibrary.simpleMessage(
      "Connection timeout with server.",
    ),
    "continue_with_payment": MessageLookupByLibrary.simpleMessage(
      "Continue with payment",
    ),
    "create_account": MessageLookupByLibrary.simpleMessage("Create an Account"),
    "databaseError": MessageLookupByLibrary.simpleMessage(
      "A database error occurred. Please try again.",
    ),
    "dont_have_account": MessageLookupByLibrary.simpleMessage(
      "Don\'t have an account?",
    ),
    "duplicateRecord": MessageLookupByLibrary.simpleMessage(
      "This record already exists.",
    ),
    "email": MessageLookupByLibrary.simpleMessage("Email"),
    "emailAlreadyRegistered": MessageLookupByLibrary.simpleMessage(
      "This email is already registered.",
    ),
    "emailNotConfirmed": MessageLookupByLibrary.simpleMessage(
      "Please confirm your email before logging in.",
    ),
    "enterEmail": MessageLookupByLibrary.simpleMessage("Enter email"),
    "enterFirstName": MessageLookupByLibrary.simpleMessage("Enter first name"),
    "enterLastName": MessageLookupByLibrary.simpleMessage("Enter last name"),
    "enterPassword": MessageLookupByLibrary.simpleMessage("Enter password"),
    "enterUsername": MessageLookupByLibrary.simpleMessage("Enter username"),
    "enterVerificationCode": MessageLookupByLibrary.simpleMessage(
      "Enter Verification Code",
    ),
    "enterVerificationCodeSubtitle": MessageLookupByLibrary.simpleMessage(
      "Enter the 6-digit verification code we sent to your email.",
    ),
    "facebook": MessageLookupByLibrary.simpleMessage("Facebook"),
    "filters": MessageLookupByLibrary.simpleMessage("Filters"),
    "first_name": MessageLookupByLibrary.simpleMessage("First Name"),
    "foreignKeyError": MessageLookupByLibrary.simpleMessage(
      "This record is linked and cannot be removed.",
    ),
    "forgot_password": MessageLookupByLibrary.simpleMessage("Forgot Password?"),
    "genericError": MessageLookupByLibrary.simpleMessage(
      "Oops, something went wrong. Please try again.",
    ),
    "get_started_subtitle": MessageLookupByLibrary.simpleMessage(
      "Sign up to discover a world full of coffee",
    ),
    "get_started_title": MessageLookupByLibrary.simpleMessage(
      "Get Started Now!",
    ),
    "google": MessageLookupByLibrary.simpleMessage("Google"),
    "internalServerError": MessageLookupByLibrary.simpleMessage(
      "Internal server error. Please try again.",
    ),
    "invalidCharacters": MessageLookupByLibrary.simpleMessage(
      "Invalid characters",
    ),
    "invalidCredentials": MessageLookupByLibrary.simpleMessage(
      "Invalid email or password.",
    ),
    "invalidEmail": MessageLookupByLibrary.simpleMessage("Invalid email"),
    "invalidInputSyntax": MessageLookupByLibrary.simpleMessage(
      "Invalid input format.",
    ),
    "invalidOTP": MessageLookupByLibrary.simpleMessage(
      "Invalid OTP code. Please check and try again.",
    ),
    "last_name": MessageLookupByLibrary.simpleMessage("Last Name"),
    "linkExpired": MessageLookupByLibrary.simpleMessage(
      "This reset link has expired. Please request a new one.",
    ),
    "log_in": MessageLookupByLibrary.simpleMessage("Log In"),
    "minPassword": MessageLookupByLibrary.simpleMessage(
      "At least 8 characters",
    ),
    "nameTooLong": MessageLookupByLibrary.simpleMessage("Name too long"),
    "nameTooShort": MessageLookupByLibrary.simpleMessage("Name too short"),
    "newCodeSent": MessageLookupByLibrary.simpleMessage(
      "New code sent. Please check your inbox.",
    ),
    "noInternetConnection": MessageLookupByLibrary.simpleMessage(
      "No internet connection.",
    ),
    "notFound": MessageLookupByLibrary.simpleMessage(
      "Your request was not found.",
    ),
    "notReceivedYet": MessageLookupByLibrary.simpleMessage("Not received yet?"),
    "nullValueError": MessageLookupByLibrary.simpleMessage(
      "A required field was left empty.",
    ),
    "or": MessageLookupByLibrary.simpleMessage("or"),
    "otpExpired": MessageLookupByLibrary.simpleMessage(
      "This reset link has expired",
    ),
    "password": MessageLookupByLibrary.simpleMessage("Password"),
    "passwordRequirement": MessageLookupByLibrary.simpleMessage(
      "Use upper, lower & number",
    ),
    "passwordUpdatedSuccessfully": MessageLookupByLibrary.simpleMessage(
      "Your password has been successfully updated.",
    ),
    "passwordsDontMatch": MessageLookupByLibrary.simpleMessage(
      "Passwords don\'t match",
    ),
    "pleaseEnterCode": MessageLookupByLibrary.simpleMessage(
      "Please enter the code",
    ),
    "priceRange": MessageLookupByLibrary.simpleMessage("Price range"),
    "profile_dark_mode": MessageLookupByLibrary.simpleMessage("Dark Mode"),
    "profile_edit_profile": MessageLookupByLibrary.simpleMessage(
      "Edit Profile",
    ),
    "profile_languages": MessageLookupByLibrary.simpleMessage("Languages"),
    "profile_logout": MessageLookupByLibrary.simpleMessage("Logout"),
    "profile_notification": MessageLookupByLibrary.simpleMessage(
      "Notification",
    ),
    "profile_payment_details": MessageLookupByLibrary.simpleMessage(
      "Payment Details",
    ),
    "profile_support": MessageLookupByLibrary.simpleMessage("Support"),
    "rating": MessageLookupByLibrary.simpleMessage("Rating"),
    "rating_1up": MessageLookupByLibrary.simpleMessage("1 Star & Up"),
    "rating_2up": MessageLookupByLibrary.simpleMessage("2 Stars & Up"),
    "rating_3up": MessageLookupByLibrary.simpleMessage("3 Stars & Up"),
    "rating_4up": MessageLookupByLibrary.simpleMessage("4 Stars & Up"),
    "rating_5": MessageLookupByLibrary.simpleMessage("5 Stars"),
    "receiveTimeout": MessageLookupByLibrary.simpleMessage(
      "Receive timeout with server.",
    ),
    "registrationSuccess": MessageLookupByLibrary.simpleMessage(
      "Your account has been created successfully.",
    ),
    "remember_me": MessageLookupByLibrary.simpleMessage("Remember me"),
    "requestCanceled": MessageLookupByLibrary.simpleMessage(
      "Request was canceled.",
    ),
    "resendAfterSeconds": m0,
    "resendCode": MessageLookupByLibrary.simpleMessage("Resend Code"),
    "reset": MessageLookupByLibrary.simpleMessage("Reset"),
    "resetPassword": MessageLookupByLibrary.simpleMessage("Reset password"),
    "resetPasswordEmailSent": MessageLookupByLibrary.simpleMessage(
      "We\'ve sent a password reset link to your email.",
    ),
    "resetPasswordError": MessageLookupByLibrary.simpleMessage(
      "Something went wrong. Please try again.",
    ),
    "resetPasswordSubtitle": MessageLookupByLibrary.simpleMessage(
      "Enter your email to reset your password.",
    ),
    "resetPasswordSuccess": MessageLookupByLibrary.simpleMessage(
      "Your password has been reset successfully.",
    ),
    "samePasswordError": MessageLookupByLibrary.simpleMessage(
      "New password must be different from the old password.",
    ),
    "save": MessageLookupByLibrary.simpleMessage("Save"),
    "search": MessageLookupByLibrary.simpleMessage("Find your favorite coffee"),
    "selectLanguage": MessageLookupByLibrary.simpleMessage("Select Language"),
    "sendEmail": MessageLookupByLibrary.simpleMessage("Send Verification Code"),
    "sendTimeout": MessageLookupByLibrary.simpleMessage(
      "Send timeout with server.",
    ),
    "setPassword": MessageLookupByLibrary.simpleMessage("Set Password"),
    "setPasswordButton": MessageLookupByLibrary.simpleMessage("Set Password"),
    "setPasswordSubtitle": MessageLookupByLibrary.simpleMessage(
      "Create a new password for your account.",
    ),
    "shipping": MessageLookupByLibrary.simpleMessage("Shipping:"),
    "sign_up": MessageLookupByLibrary.simpleMessage("Sign Up"),
    "sortBy": MessageLookupByLibrary.simpleMessage("Sort by"),
    "sort_discount": MessageLookupByLibrary.simpleMessage("Discount"),
    "sort_highestPrice": MessageLookupByLibrary.simpleMessage("Highest Price"),
    "sort_lowestPrice": MessageLookupByLibrary.simpleMessage("Lowest Price"),
    "sort_newest": MessageLookupByLibrary.simpleMessage("Newest"),
    "sort_oldest": MessageLookupByLibrary.simpleMessage("Oldest"),
    "sort_topRated": MessageLookupByLibrary.simpleMessage("Top Rated"),
    "sub_total": MessageLookupByLibrary.simpleMessage("Sub Total:"),
    "syntaxError": MessageLookupByLibrary.simpleMessage(
      "There is a problem with the database query.",
    ),
    "tooLong": MessageLookupByLibrary.simpleMessage("Too long"),
    "tooShort": MessageLookupByLibrary.simpleMessage("Too short"),
    "total_price": MessageLookupByLibrary.simpleMessage("Total Price:"),
    "unauthorizedRequest": MessageLookupByLibrary.simpleMessage(
      "Unauthorized request.",
    ),
    "unexpectedError": MessageLookupByLibrary.simpleMessage(
      "Unexpected error. Please try again.",
    ),
    "unexpectedServerError": MessageLookupByLibrary.simpleMessage(
      "Unexpected server error.",
    ),
    "userEmailNotFound": MessageLookupByLibrary.simpleMessage(
      "User with provided email does not exist.",
    ),
    "username": MessageLookupByLibrary.simpleMessage("Username"),
    "usernameTaken": MessageLookupByLibrary.simpleMessage(
      "That username isn\'t available. Choose a different one.",
    ),
    "valueTooLong": MessageLookupByLibrary.simpleMessage(
      "The provided value is too long.",
    ),
    "verificationEmailSent": MessageLookupByLibrary.simpleMessage(
      "Verification email sent. Please check your inbox.",
    ),
    "verificationSuccessful": MessageLookupByLibrary.simpleMessage(
      "Verification successful. You can now set a new password.",
    ),
    "verify": MessageLookupByLibrary.simpleMessage("Verify"),
    "weakOrWrongPassword": MessageLookupByLibrary.simpleMessage(
      "Your password is too weak or incorrect.",
    ),
    "welcome_back": MessageLookupByLibrary.simpleMessage("Welcome Back"),
    "welcome_back_subtitle": MessageLookupByLibrary.simpleMessage(
      "Log in to access your account",
    ),
    "welcome_back_title": MessageLookupByLibrary.simpleMessage("Welcome Back!"),
  };
}
