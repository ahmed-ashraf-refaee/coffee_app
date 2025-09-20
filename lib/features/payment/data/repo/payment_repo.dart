abstract class PaymentRepo {
  Future<void> makePayment({required double amount, required String currency});
}
