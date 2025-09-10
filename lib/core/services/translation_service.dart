import 'package:flutter/material.dart';
import 'package:translator/translator.dart';

class TranslationService {
  final _translator = GoogleTranslator();

  Future<String> translateText(String text, Locale locale) async {
    try {
      final targetLang = locale.languageCode;
      final translation = await _translator.translate(text, to: targetLang);
      return translation.text;
    } catch (e) {
      return text;
    }
  }
}
