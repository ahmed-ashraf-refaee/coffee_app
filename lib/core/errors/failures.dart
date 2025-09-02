import 'package:dio/dio.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

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
        error: response["error"]["message"] ?? S.current.unauthorizedRequest,
      );
    } else if (statusCode == 404) {
      return Failure(error: S.current.notFound);
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
    } else {
      return Failure(error: S.current.databaseError);
    }
  }
}
