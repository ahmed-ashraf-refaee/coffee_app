import 'package:dio/dio.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class PaymentMethodService {
  final Dio _dio = Dio();
  final String _baseUrl = "https://api.stripe.com/v1";
  final SupabaseClient _supabase = Supabase.instance.client;

  Future<String> createCustomer(String email) async {
    final response = await _dio.post(
      "$_baseUrl/create-customer",
      data: {"email": email},
    );

    return response.data["id"];
  }

  Future<void> createAndSavePaymentMethod({
    required String customerId,
    String? holderName,
  }) async {
    try {
      final paymentMethod = await Stripe.instance.createPaymentMethod(
        params: PaymentMethodParams.card(
          paymentMethodData: PaymentMethodData(
            billingDetails: BillingDetails(name: holderName),
          ),
        ),
      );

      final card = paymentMethod.card;

      final response = await _supabase.from('payment_methods').insert({
        'user_id': _supabase.auth.currentUser?.id,
        'last4': card.last4,
        'brand': card.brand,
        'exp_month': card.expMonth,
        'exp_year': card.expYear,
        'holder_name': holderName,
        'customer_id': customerId,
        'payment_method_id': paymentMethod.id,
      });

      if (response.error != null) {
        throw Exception("Supabase insert error: ${response.error!.message}");
      }
    } catch (e) {
      throw Exception("Failed to create & save payment method: $e");
    }
  }
}
