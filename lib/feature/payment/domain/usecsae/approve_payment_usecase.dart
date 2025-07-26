import '../entity/payment_result.dart';
import '../repository/payment_repository.dart';

class ApprovePaymentUseCase {
  final PaymentRepository repository;

  ApprovePaymentUseCase(this.repository);

  Future<PaymentResult> execute({
    required String paymentKey,
    required String orderId,
    required int amount,
  }) {
    return repository.approvePayment(
      paymentKey: paymentKey,
      orderId: orderId,
      amount: amount,
    );
  }
}
