import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:coffee_app/features/checkout/data/models/payment_method_model.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'card_state.dart';

class CardCubit extends Cubit<CardState> {
  CardCubit() : super(const CardState()) {
    _initDefaultCard();
  }

  Future<void> _initDefaultCard() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonCardData = prefs.getString("defaultCardData");

    if (jsonCardData != null) {
      final card = PaymentMethodModel.fromJson(jsonDecode(jsonCardData));
      emit(state.copyWith(defaultCard: card));
    } else {
      emit(const CardState());
    }
  }

  Future<void> updateDefaultCard(PaymentMethodModel card) async {
    final prefs = await SharedPreferences.getInstance();
    final jsonCardData = jsonEncode(card.toJson());
    await prefs.setString("defaultCardData", jsonCardData);

    emit(state.copyWith(defaultCard: card));
  }
}
