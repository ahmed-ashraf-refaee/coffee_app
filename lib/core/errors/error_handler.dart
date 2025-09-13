import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:coffee_app/core/errors/failures.dart';

Future<Either<Failure, T>> guard<T>(Future<T> Function() action) async {
  try {
    return right(await action());
  } on PostgrestException catch (e) {
    return left(Failure.fromSqlException(e));
  } on AuthApiException catch (e) {
    return left(Failure.fromAuthException(e));
  } on DioException catch (e) {
    return left(Failure.fromDioError(e));
  } catch (e) {
    return left(Failure(error: e.toString()));
  }
}
