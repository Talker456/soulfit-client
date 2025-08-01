import 'dart:async';
import 'coupon_remote_datasource.dart';
import '../models/coupon_model.dart';

class FakeCouponRemoteDatasource implements CouponRemoteDatasource {
  @override
  Future<List<CouponModel>> getAvailableCoupons() async {
    await Future.delayed(const Duration(seconds: 1)); // 로딩
    return [
      CouponModel(
        id: 1,
        code: 'WELCOME10',
        discountAmount: 10000,
        isUsed: false,
      ),
      CouponModel(id: 2, code: 'SUMMER5', discountAmount: 5000, isUsed: false),
    ];
  }

  @override
  Future<CouponModel> registerCoupon(String code) async {
    await Future.delayed(const Duration(milliseconds: 500)); // 등록 지연
    return CouponModel(id: 99, code: code, discountAmount: 3000, isUsed: false);
  }
}
