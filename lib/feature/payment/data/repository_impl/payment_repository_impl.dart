import '../../domain/entity/payment_result.dart';
import '../../domain/repository/payment_repository.dart';
import '../datasource/payment_remote_datasource.dart';

class PaymentRepositoryImpl implements PaymentRepository {
  final PaymentRemoteDataSource remote;

  PaymentRepositoryImpl(this.remote);

  @override
  Future<String> createOrder({
    required String orderName,
    required int totalAmount,
    required String orderType,
    required int itemId,
  }) {
    return remote.createOrder(
      orderName: orderName,
      totalAmount: totalAmount,
      orderType: orderType,
      itemId : itemId,
    );
  }

  @override
  Future<PaymentResult> approvePayment({
    required String paymentKey,
    required String orderId,
    required int amount,
  }) {
    return remote.approvePayment(
      paymentKey: paymentKey,
      orderId: orderId,
      amount: amount,
    );
  }
}
