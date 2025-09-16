import 'dart:ui';

import 'package:flutter_bloc/flutter_bloc.dart';

class LocaleCubit extends Cubit<Locale> {
  LocaleCubit() : super(const Locale('ar'));

  void changeLocale(Locale locale) {
    emit(locale);
  }
}
