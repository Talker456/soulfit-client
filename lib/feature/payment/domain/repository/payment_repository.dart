import '../entity/payment_result.dart';

abstract class PaymentRepository {
  /// 서버에 임시 주문을 생성하고 주문 ID를 반환
  Future<String> createOrder({
    required String orderName,
    required int totalAmount,
  });

  /// 서버에 결제 승인 요청을 보내고 결제 결과를 반환
  Future<PaymentResult> approvePayment({
    required String paymentKey,
    required String orderId,
    required int amount,
  });
}
