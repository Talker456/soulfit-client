import '../../data/models/coupon_model.dart';

abstract class CouponRepository {
  Future<List<CouponModel>> getAvailableCoupons();
  Future<CouponModel> registerCoupon(String code);
}
