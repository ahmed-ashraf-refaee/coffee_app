import 'package:coffee_app/core/constants/keys.dart';
import 'package:dio/dio.dart';
import 'package:flutter_stripe/flutter_stripe.dart';

class StripePaymentService {
  StripePaymentService._internal();

  static final StripePaymentService instance = StripePaymentService._internal();

  static Future<void> makePayment({
    required double amount,
    required String currency,
  }) async {
    String clientSecret = await _getClientSecret(amount, currency);
    await _initializePaymentCard(clientSecret);
    await Stripe.instance.presentPaymentSheet();
  }

  static Future<void> _initializePaymentCard(String clientSecret) async {
    await Stripe.instance.initPaymentSheet(
      paymentSheetParameters: SetupPaymentSheetParameters(
        paymentIntentClientSecret: clientSecret,
        merchantDisplayName: 'Coffee App',
      ),
    );
  }

  static Future<String> _getClientSecret(double amount, String currency) async {
    Dio dio = Dio();
    Response response = await dio.post(
      "https://api.stripe.com/v1/payment_intents",
      data: {"amount": (amount * 100).round().toString(), "currency": currency},

      options: Options(
        contentType: Headers.formUrlEncodedContentType,
        headers: {"Authorization": "Bearer ${Keys.stripeSecretKey}"},
      ),
    );
    return response.data['client_secret'];
  }
}
