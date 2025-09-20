import 'package:coffee_app/core/constants/keys.dart';
import 'package:dio/dio.dart';

class StripePaymentService {
  StripePaymentService._internal();

  static final StripePaymentService instance = StripePaymentService._internal();

  static Future<void> makePayment(
    String amount, {
    String currency = 'EGP',
  }) async {
    String clientSecret = await _getClientSecret(amount, currency);
  }

  static Future<String> _getClientSecret(String amount, String currency) async {
    Dio dio = Dio();
    Response response = await dio.post(
      "https://api.stripe.com/v1/payment_intents",
      data: {"amount": '${amount}00', "currency": currency},

      options: Options(
        contentType: Headers.contentEncodingHeader,
        headers: {
          "Authorization": "Bearer ${Keys.stripeSecretKey}",
          "Content-Type": 'application/x-www-form-urlencoded',
        },
      ),
    );
    return response.data['client_secret'];
  }
}
