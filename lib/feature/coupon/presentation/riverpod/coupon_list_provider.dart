import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/models/coupon_model.dart';
import '/config/di/provider.dart'; // usecase provider 경로

final couponListProvider = FutureProvider<List<CouponModel>>((ref) async {
  final usecase = ref.watch(getAvailableCouponsUseCaseProvider);
  return await usecase();
});
