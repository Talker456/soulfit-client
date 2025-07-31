import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/models/coupon_model.dart';

final selectedCouponProvider = StateProvider<CouponModel?>((ref) => null);
