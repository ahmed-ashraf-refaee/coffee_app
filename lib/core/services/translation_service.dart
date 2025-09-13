import 'package:coffee_app/core/services/app_locale.dart';

import 'package:translator/translator.dart';

class TranslationService {
  final _translator = GoogleTranslator();

  Future<String> translateText(String text) async {
    try {
      final targetLang = AppLocale.current.languageCode;
      final translation = await _translator.translate(text, to: targetLang);
      return translation.text;
    } catch (e) {
      return text;
    }
  }
}
