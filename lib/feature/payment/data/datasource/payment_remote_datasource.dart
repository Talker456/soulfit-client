import '../../domain/entity/payment_result.dart';

abstract class PaymentRemoteDataSource {
  Future<String> createOrder({
    required String orderName,
    required int totalAmount,
    required String orderType,
    required int itemId,
  });

  Future<PaymentResult> approvePayment({
    required String paymentKey,
    required String orderId,
    required int amount,
  });
}
