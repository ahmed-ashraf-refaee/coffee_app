import 'package:dartz/dartz.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:coffee_app/core/errors/failures.dart';

Future<Either<Failure, T>> guard<T>(Future<T> Function() action) async {
  try {
    return right(await action());
  } catch (e) {
    if (e is PostgrestException) {
      return left(Failure.fromSqlException(e));
    }
    return left(Failure(error: e.toString()));
  }
}
