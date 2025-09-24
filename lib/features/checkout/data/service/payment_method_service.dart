import 'package:dio/dio.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:supabase_flutter/supabase_flutter.dart' hide Headers;

import '../../../../core/constants/keys.dart';

class PaymentMethodService {
  final Dio _dio = Dio();
  final SupabaseClient _supabase = Supabase.instance.client;

  Future<String> _createCustomer(String email) async {
    final response = await _dio.post(
      "https://api.stripe.com/v1/customers",
      options: Options(
        contentType: Headers.formUrlEncodedContentType,
        headers: {"Authorization": "Bearer ${Keys.stripeSecretKey}"},
      ),
      data: {"email": email},
    );
    return response.data["id"];
  }

  Future<String> _createPaymentMethod() async {
    final paymentMethod = await Stripe.instance.createPaymentMethod(
      params: const PaymentMethodParams.card(
        paymentMethodData: PaymentMethodData(),
      ),
    );
    return paymentMethod.id;
  }

  Future<String> attachPaymentMethod(
    String customerId,
    String paymentMethodId,
  ) async {
    final response = await _dio.post(
      "https://api.stripe.com/v1/payment_methods/$paymentMethodId/attach",
      options: Options(
        contentType: Headers.formUrlEncodedContentType,
        headers: {"Authorization": "Bearer ${Keys.stripeSecretKey}"},
      ),
      data: {"customer": customerId},
    );
    return response.data['id'];
  }

  Future<void> saveCard({required String email}) async {
    String customerId = await _createCustomer(email);
    String paymentMethodId = await _createPaymentMethod();
    await attachPaymentMethod(customerId, paymentMethodId);
  }

  Future<String> createPaymentIntent({
    required String amount,
    required String paymentMethodId,
    required String customerId,

    required String currency,
  }) async {
    final response = await _dio.post(
      "https://api.stripe.com/v1/payment_intents",
      options: Options(
        contentType: Headers.formUrlEncodedContentType,
        headers: {"Authorization": "Bearer ${Keys.stripeSecretKey}"},
      ),
      data: {
        "amount": amount,
        "currency": currency,
        "payment_method": paymentMethodId,
        "customer": customerId,
        "automatic_payment_methods[enabled]": "true",
      },
    );
    return response.data["client_secret"];
  }

  Future<void> payWithSavedCard({
    required double amount,
    String currency = "EGP",
    required String paymentMethodId,
    required String customerId,
    required String cvc,
  }) async {
    String processedAmount = (amount * 100).round().toString();
    String clientSecret = await createPaymentIntent(
      amount: processedAmount,
      currency: currency,
      paymentMethodId: paymentMethodId,
      customerId: customerId,
    );
    await Stripe.instance.confirmPayment(
      paymentIntentClientSecret: clientSecret,
      data: PaymentMethodParams.cardFromMethodId(
        paymentMethodData: PaymentMethodDataCardFromMethod(
          paymentMethodId: paymentMethodId,
          cvc: cvc,
        ),
      ),
    );
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
