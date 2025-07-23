import '../repository/payment_repository.dart';

class CreateOrderUseCase {
  final PaymentRepository repository;

  CreateOrderUseCase(this.repository);

  Future<String> execute({
    required String orderName,
    required int totalAmount,
  }) {
    return repository.createOrder(
      orderName: orderName,
      totalAmount: totalAmount,
    );
  }
}
