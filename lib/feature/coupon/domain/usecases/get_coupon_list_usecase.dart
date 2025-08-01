import '../../data/models/coupon_model.dart';
import '../repositories/coupon_repository.dart';

class GetAvailableCouponsUseCase {
  final CouponRepository repository;

  GetAvailableCouponsUseCase(this.repository);

  Future<List<CouponModel>> call() {
    return repository.getAvailableCoupons();
  }
}
