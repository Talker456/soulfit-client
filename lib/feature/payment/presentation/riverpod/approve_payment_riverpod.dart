import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../config/di/provider.dart';
import '../../domain/entity/payment_result.dart';
import '../../domain/usecsae/approve_payment_usecase.dart';

final approvePaymentProvider = StateNotifierProvider.autoDispose<
    ApprovePaymentController, AsyncValue<PaymentResult>>((ref) {
  final useCase = ref.watch(approvePaymentUseCaseProvider);
  return ApprovePaymentController(useCase);
});

class ApprovePaymentController
    extends StateNotifier<AsyncValue<PaymentResult>> {
  final ApprovePaymentUseCase _useCase;

  ApprovePaymentController(this._useCase) : super(const AsyncValue.loading());

  Future<void> approve({
    required String paymentKey,
    required String orderId,
    required int amount,
  }) async {
    state = const AsyncValue.loading();
    try {
      final result = await _useCase.execute(
        paymentKey: paymentKey,
        orderId: orderId,
        amount: amount,
      );
      state = AsyncValue.data(result);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }
}
