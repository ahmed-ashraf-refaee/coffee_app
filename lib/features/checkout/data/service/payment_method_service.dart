import 'package:coffee_app/features/authentication/data/services/auth_service.dart';
import 'package:coffee_app/core/constants/keys.dart'; // Make sure Keys.stripeSecretKey is defined here
import 'package:dio/dio.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:supabase_flutter/supabase_flutter.dart' hide Headers;

class PaymentMethodService {
  final Dio _dio = Dio();
  final String _baseUrl = "https://api.stripe.com/v1";
  final SupabaseClient _supabase = Supabase.instance.client;
  final AuthService _authService = AuthService();

  //======================================================================
  /// Save a new card for the current user
  Future<void> saveCard({required String holderName}) async {
    final userId = _supabase.auth.currentUser!.id;
    final email = _supabase.auth.currentUser!.email!;

    // Get or create a Stripe customer for this user
    String customerId = await _getOrCreateCustomerId(userId, email);

    // Create a PaymentMethod with Stripe SDK
    String paymentMethodId = await _createPaymentMethod(holderName: holderName);

    // Attach to Stripe customer
    Map<String, dynamic> cardInfo = await _attachPaymentMethod(
      customerId,
      paymentMethodId,
    );

    // Save in Supabase
    await _saveCardInfoToSupabase(
      userId: userId,
      cardData: cardInfo,
      customerId: customerId,
    );
  }

  //======================================================================
  /// Pay using an already saved card
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

  //======================================================================
  /// Fetch saved cards from Supabase
  Future<List<Map<String, dynamic>>> fetchPaymentMethods() async {
    final userId = _supabase.auth.currentUser!.id;
    final response = await _supabase
        .from('payment_methods')
        .select()
        .eq('user_id', userId);

    return List<Map<String, dynamic>>.from(response);
  }

  //======================================================================
  /// Create Stripe customer
  Future<String> _createCustomer(String email) async {
    final response = await _dio.post(
      "$_baseUrl/customers",
      options: Options(
        contentType: Headers.formUrlEncodedContentType,
        headers: {"Authorization": "Bearer ${Keys.stripeSecretKey}"},
      ),
      data: {"email": email},
    );
    return response.data["id"];
  }

  /// Get existing customer id or create a new one
  Future<String> _getOrCreateCustomerId(String userId, String email) async {
    final retrievedCustomerId = await _authService.fetchCustomerId();
    if (retrievedCustomerId != null) {
      return retrievedCustomerId;
    }
    final customerId = await _createCustomer(email);
    await _authService.updateUserProfile(customerId: customerId);
    return customerId;
  }

  /// Create a payment method via Stripe SDK
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

  /// Attach payment method to a Stripe customer
  Future<Map<String, dynamic>> _attachPaymentMethod(
    String customerId,
    String paymentMethodId,
  ) async {
    try {
      final response = await _dio.post(
        "$_baseUrl/payment_methods/$paymentMethodId/attach",
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
      throw Exception(
        "Stripe attach failed: ${e.response?.data?["error"]?["message"] ?? e.message}",
      );
    }
  }

  /// Save card details into Supabase
  Future<void> _saveCardInfoToSupabase({
    required String userId,
    required Map<String, dynamic> cardData,
    required String customerId,
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

  /// Create Stripe PaymentIntent
  Future<String> createPaymentIntent({
    required String amount,
    required String paymentMethodId,
    required String customerId,
    required String currency,
  }) async {
    final response = await _dio.post(
      "$_baseUrl/payment_intents",
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
}
