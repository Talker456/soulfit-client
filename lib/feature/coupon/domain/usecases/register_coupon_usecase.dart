import '../../data/models/coupon_model.dart';
import '../repositories/coupon_repository.dart';

class RegisterCouponUseCase {
  final CouponRepository repository;

  RegisterCouponUseCase(this.repository);

  Future<CouponModel> call(String code) {
    return repository.registerCoupon(code);
  }
}
