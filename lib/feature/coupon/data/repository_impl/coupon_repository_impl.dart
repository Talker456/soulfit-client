import '../../domain/repositories/coupon_repository.dart';
import '../datasources/coupon_remote_datasource.dart';
import '../models/coupon_model.dart';

class CouponRepositoryImpl implements CouponRepository {
  final CouponRemoteDatasource remoteDatasource;

  CouponRepositoryImpl({required this.remoteDatasource});

  @override
  Future<List<CouponModel>> getAvailableCoupons() {
    return remoteDatasource.getAvailableCoupons();
  }

  @override
  Future<CouponModel> registerCoupon(String code) {
    return remoteDatasource.registerCoupon(code);
  }
}
