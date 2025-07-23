import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../config/di/provider.dart';
import '../../domain/usecsae/create_order_usecase.dart';


final createOrderProvider = StateNotifierProvider.autoDispose<
    CreateOrderController, AsyncValue<String>>((ref) {
  final useCase = ref.watch(createOrderUseCaseProvider);
  return CreateOrderController(useCase);
});

class CreateOrderController extends StateNotifier<AsyncValue<String>> {
  final CreateOrderUseCase _useCase;

  CreateOrderController(this._useCase) : super(const AsyncValue.data(''));

  Future<void> createOrder({
    required String orderName,
    required int totalAmount,
  }) async {
    state = const AsyncValue.loading();
    try {
      final orderId = await _useCase.execute(
        orderName: orderName,
        totalAmount: totalAmount,
      );

      print('[create order usecase] : '+orderId);
      state = AsyncValue.data(orderId);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }
}
