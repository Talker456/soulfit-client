import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/coupon_model.dart';
import 'coupon_remote_datasource.dart';

class CouponRemoteDatasourceImpl implements CouponRemoteDatasource {
  final http.Client client;

  CouponRemoteDatasourceImpl({required this.client});

  @override
  Future<List<CouponModel>> getAvailableCoupons() async {
    final response = await client.get(
      Uri.parse('https://api.soulfit.com/coupons/available'),
    );

    if (response.statusCode == 200) {
      final List<dynamic> jsonList = jsonDecode(response.body);
      return jsonList.map((e) => CouponModel.fromJson(e)).toList();
    } else {
      throw Exception('Failed to load coupons');
    }
  }

  @override
  Future<CouponModel> registerCoupon(String code) async {
    final response = await client.post(
      Uri.parse('https://api.soulfit.com/coupons/register'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'code': code}),
    );

    if (response.statusCode == 200) {
      return CouponModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to register coupon');
    }
  }
}
