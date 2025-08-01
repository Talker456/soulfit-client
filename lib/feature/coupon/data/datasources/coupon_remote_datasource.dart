import '../models/coupon_model.dart';

abstract class CouponRemoteDatasource {
  Future<List<CouponModel>> getAvailableCoupons();
  Future<CouponModel> registerCoupon(String code);
}
