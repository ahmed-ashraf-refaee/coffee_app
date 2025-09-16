import 'dart:ui';
import 'package:coffee_app/core/services/app_locale.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LocaleCubit extends Cubit<Locale> {
  LocaleCubit() : super(const Locale('ar'));
  void changeLocale(Locale locale) {
    AppLocale.update(locale);

    emit(locale);
  }
}
