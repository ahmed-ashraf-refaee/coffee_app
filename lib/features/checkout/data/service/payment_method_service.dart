import 'package:dio/dio.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:supabase_flutter/supabase_flutter.dart' hide Headers;

import '../../../../core/constants/keys.dart';

class PaymentMethodService {
  final Dio _dio = Dio();
  final String _baseUrl = "https://api.stripe.com/v1";
  final SupabaseClient _supabase = Supabase.instance.client;

  Future<String> creCustomer(String email) async {
    final response = await _dio.post(
      "v1/payment_methods/pm_1SAcHuD3PqUYeRcnhkxNjoKH/attach",
      data: {"amount": (100 * 100).round().toString(), "currency": "EGP"},
    );
    return response.data["id"];
  }

  Future<String> createPaymentIntent({
    required double amount,
    required PaymentMethod paymentMethod,
    String currency = 'EGP',
  }) async {
    Dio dio = Dio();
    final response = await dio.post(
      "https://api.stripe.com/v1/payment_intents",
      data: {
        "amount": (amount * 100).round().toString(),
        "currency": currency,
        "payment_method": paymentMethod.id,
        // "confirm": "true",
      },
      options: Options(
        contentType: Headers.formUrlEncodedContentType,
        headers: {"Authorization": "Bearer ${Keys.stripeSecretKey}"},
      ),
    );
    return response.data["client_secret"];
  }

  Future<void> payWithCardField(double amount, String currency) async {
    final paymentMethod = await Stripe.instance.createPaymentMethod(
      params: const PaymentMethodParams.card(
        paymentMethodData: PaymentMethodData(),
      ),
    );
    String clientSecret = await createPaymentIntent(
      amount: amount * 100,
      currency: currency,
      paymentMethod: paymentMethod,
    );
    await Stripe.instance.confirmPayment(
      paymentIntentClientSecret: clientSecret,
      data: const PaymentMethodParams.card(
        paymentMethodData: PaymentMethodData(),
      ),
    );
  }

  Future<PaymentMethod> createAndSavePaymentMethod({String? holderName}) async {
    final paymentMethod = await Stripe.instance.createPaymentMethod(
      params: PaymentMethodParams.card(
        paymentMethodData: PaymentMethodData(
          billingDetails: BillingDetails(name: holderName),
        ),
      ),
    );

    // final card = paymentMethod.card;

    // await _supabase.from('payment_methods').insert({
    //   'user_id': _supabase.auth.currentUser?.id,
    //   'last4': card.last4,
    //   'brand': card.brand,
    //   'exp_month': card.expMonth,
    //   'exp_year': card.expYear,
    //   'holder_name': holderName,
    //   'payment_method_id': paymentMethod.id,
    // });
    return paymentMethod;
  }

  Future<List<Map<String, dynamic>>> fetchPaymentMethods() async {
    final userId = _supabase.auth.currentUser!.id;
    final response = await _supabase
        .from('payment_methods')
        .select()
        .eq('user_id', userId);

    return List<Map<String, dynamic>>.from(response);
  }
}
