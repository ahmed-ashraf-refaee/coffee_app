import 'package:dio/dio.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../generated/l10n.dart';

class Failure {
  final String error;

  Failure({required this.error});

  factory Failure.fromDioError(DioException dioException) {
    switch (dioException.type) {
      case DioExceptionType.connectionTimeout:
        return Failure(error: S.current.connectionTimeout);
      case DioExceptionType.sendTimeout:
        return Failure(error: S.current.sendTimeout);
      case DioExceptionType.receiveTimeout:
        return Failure(error: S.current.receiveTimeout);
      case DioExceptionType.badCertificate:
        return Failure(error: S.current.badCertificate);
      case DioExceptionType.badResponse:
        return Failure._fromBadResponse(
          statusCode: dioException.response?.statusCode,
          response: dioException.response?.data,
        );
      case DioExceptionType.cancel:
        return Failure(error: S.current.requestCanceled);
      case DioExceptionType.connectionError:
        return Failure(error: S.current.noInternetConnection);
      case DioExceptionType.unknown:
        if (dioException.message?.contains("SocketException") ?? false) {
          return Failure(error: S.current.noInternetConnection);
        }
        return Failure(error: S.current.unexpectedError);
    }
  }

  factory Failure._fromBadResponse({
    required int? statusCode,
    dynamic response,
  }) {
    if (statusCode == null) {
      return Failure(error: S.current.unexpectedServerError);
    }
    if (statusCode == 400 || statusCode == 401 || statusCode == 403) {
      return Failure(
        error: response?["error"]["message"] ?? S.current.unauthorizedRequest,
      );
    } else if (statusCode == 404) {
      return Failure(error: S.current.notFound);
    } else if (statusCode == 409) {
      return Failure(error: S.current.conflictError);
    } else if (statusCode == 500) {
      return Failure(error: S.current.internalServerError);
    } else {
      return Failure(error: S.current.genericError);
    }
  }

  factory Failure.fromAuthException(AuthApiException exception) {
    final message = exception.message.toLowerCase();

    if (message.contains("invalid login credentials")) {
      return Failure(error: S.current.invalidCredentials);
    } else if (message.contains("email not confirmed")) {
      return Failure(error: S.current.emailNotConfirmed);
    } else if (message.contains("user already registered")) {
      return Failure(error: S.current.emailAlreadyRegistered);
    } else if (message.contains("expired action link") ||
        message.contains("token has expired")) {
      return Failure(error: S.current.linkExpired);
    } else if (message.contains("password")) {
      return Failure(error: S.current.weakOrWrongPassword);
    } else {
      return Failure(error: S.current.authFailed);
    }
  }

  factory Failure.fromSqlException(PostgrestException exception) {
    final code = exception.code;
    final message = exception.message.toLowerCase();

    if (code == "23505" || message.contains("duplicate key")) {
      return Failure(error: S.current.duplicateRecord);
    } else if (code == "23503" || message.contains("foreign key")) {
      return Failure(error: S.current.foreignKeyError);
    } else if (code == "23502" || message.contains("null value")) {
      return Failure(error: S.current.nullValueError);
    } else if (code == "42601" || message.contains("syntax")) {
      return Failure(error: S.current.syntaxError);
    } else if (code == "22001" || message.contains("value too long")) {
      return Failure(error: S.current.valueTooLong);
    } else if (code == "22P02" || message.contains("invalid input syntax")) {
      return Failure(error: S.current.invalidInputSyntax);
    } else {
      return Failure(error: S.current.databaseError);
    }
  }
  factory Failure.fromAuthExceptionOTP(AuthException exception) {
    final errorMessage = exception.message.toLowerCase();
    if (errorMessage.contains('expired') ||
        errorMessage.contains('token has expired') ||
        errorMessage.contains('otp expired')) {
      return Failure(error: S.current.otpExpired);
    } else {
      return Failure(error: S.current.invalidOTP);
    }
  }
  factory Failure.fromStringException(String errorMessage) {
    final message = errorMessage.toLowerCase();

    if (message.contains("user with provided email does not exist")) {
      return Failure(error: S.current.userEmailNotFound);
    }

    return Failure(error: S.current.unexpectedError);
  }

  factory Failure.fromException(dynamic exception) {
    if (exception is AuthApiException) {
      return Failure.fromAuthException(exception);
    } else if (exception is AuthException) {
      return Failure.fromAuthExceptionOTP(exception);
    } else if (exception is PostgrestException) {
      return Failure.fromSqlException(exception);
    } else if (exception is DioException) {
      return Failure.fromDioError(exception);
    } else if (exception is String) {
      return Failure.fromStringException(exception);
    } else {
      return Failure(error: S.current.unexpectedError);
    }
  }
}
