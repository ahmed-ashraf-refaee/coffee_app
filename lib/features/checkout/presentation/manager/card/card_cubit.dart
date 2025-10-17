import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:coffee_app/features/checkout/data/models/payment_method_model.dart';
import 'package:coffee_app/features/checkout/data/models/address_model.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'card_state.dart';

class CardCubit extends Cubit<CardState> {
  CardCubit() : super(const CardState()) {
    _initDefaultCard();
    _initDefaultAddress();
  }

  Future<void> _initDefaultCard() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonCardData = prefs.getString("defaultCardData");

    if (jsonCardData != null) {
      final card = PaymentMethodModel.fromJson(jsonDecode(jsonCardData));

      emit(state.copyWith(defaultCard: card));
    }
  }

  Future<void> updateDefaultCard(PaymentMethodModel card) async {
    final prefs = await SharedPreferences.getInstance();
    final jsonCardData = jsonEncode(card.toJson());
    await prefs.setString("defaultCardData", jsonCardData);

    emit(state.copyWith(defaultCard: card));
  }

  Future<void> _initDefaultAddress() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonAddressData = prefs.getString("defaultAddressData");

    if (jsonAddressData != null) {
      final address = AddressModel.fromJson(jsonDecode(jsonAddressData));
      emit(state.copyWith(defaultAddress: address));
    }
  }

  Future<void> updateDefaultAddress(AddressModel address) async {
    final prefs = await SharedPreferences.getInstance();
    final jsonAddressData = jsonEncode(address.toJson());
    await prefs.setString("defaultAddressData", jsonAddressData);

    emit(state.copyWith(defaultAddress: address));
  }
}
