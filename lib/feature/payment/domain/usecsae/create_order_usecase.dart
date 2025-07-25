import '../repository/payment_repository.dart';

class CreateOrderUseCase {
  final PaymentRepository repository;

  CreateOrderUseCase(this.repository);

  Future<String> execute({
    required String orderName,
    required int totalAmount,
    required String orderType,
    required int itemId,
  }) {
    return repository.createOrder(
      orderName: orderName,
      totalAmount: totalAmount,
      orderType : orderType,
      itemId: itemId,
    );
  }
}
