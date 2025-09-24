import 'package:coffee_app/features/authentication/data/services/auth_service.dart';
import 'package:dio/dio.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class PaymentMethodService {
  final Dio _dio = Dio();
  final String _baseUrl = "https://api.stripe.com/v1";
  final SupabaseClient _supabase = Supabase.instance.client;
<<<<<<< Updated upstream

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
=======
  final AuthService _authService = AuthService();
  //==============================================================================================================================================
  Future<void> saveCard({required String holderName}) async {
    final userId = _supabase.auth.currentUser!.id;
    String customerId = await _getOrCreateCustomerId(
      userId,
      _supabase.auth.currentUser!.email!,
    );
    String paymentMethodId = await _createPaymentMethod(holderName: holderName);
    Map<String, dynamic> cardInfo = await _attachPaymentMethod(
      customerId,
      paymentMethodId,
    );
    await _saveCardInfoToSupabase(userId: userId, cardData: cardInfo);
  }

  //========================================================================================================================================

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
>>>>>>> Stashed changes
        ),
      );

<<<<<<< Updated upstream
      final card = paymentMethod.card;
=======
  //========================================================================================================================================
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

  Future<String> _createPaymentMethod({required String holderName}) async {
    final paymentMethod = await Stripe.instance.createPaymentMethod(
      params: PaymentMethodParams.card(
        paymentMethodData: PaymentMethodData(
          billingDetails: BillingDetails(name: holderName),
        ),
      ),
    );
    return paymentMethod.id;
  }

  Future<String> _getOrCreateCustomerId(String userId, String email) async {
    final retrievedCustomerId = await _authService.fetchCustomerId();
    if (retrievedCustomerId != null) {
      return retrievedCustomerId;
    }
    final customerId = await _createCustomer(email);
    await _authService.updateUserProfile(customerId: customerId);
    return customerId;
  }

  Future<Map<String, dynamic>> _attachPaymentMethod(
    String customerId,
    String paymentMethodId,
  ) async {
    try {
      final response = await _dio.post(
        "https://api.stripe.com/v1/payment_methods/$paymentMethodId/attach",
        options: Options(
          contentType: Headers.formUrlEncodedContentType,
          headers: {"Authorization": "Bearer ${Keys.stripeSecretKey}"},
        ),
        data: {"customer": customerId},
      );

      final card = response.data["card"];
      return {
        "payment_method_id": response.data["id"],
        "last4": card["last4"],
        "brand": card["brand"],
        "exp_month": card["exp_month"],
        "exp_year": card["exp_year"],
        "holder_name": response.data["billing_details"]["name"],
      };
    } on DioException catch (e) {
      // Stripe error responses are in e.response?.data
      throw Exception(
        "Stripe attach failed: ${e.response?.data?["error"]?["message"] ?? e.message}",
      );
    }
  }

  Future<void> _saveCardInfoToSupabase({
    required String userId,
    required Map<String, dynamic> cardData,
  }) async {
    await _supabase.from("payment_methods").insert({
      "user_id": userId,
      "payment_method_id": cardData["payment_method_id"],
      "last4": cardData["last4"],
      "brand": cardData["brand"],
      "exp_month": cardData["exp_month"],
      "exp_year": cardData["exp_year"],
      "holder_name": cardData["holder_name"],
    });
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

  Future<List<Map<String, dynamic>>> fetchPaymentMethods() async {
    final userId = _supabase.auth.currentUser!.id;
    final response = await _supabase
        .from('payment_methods')
        .select()
        .eq('user_id', userId);
>>>>>>> Stashed changes

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
