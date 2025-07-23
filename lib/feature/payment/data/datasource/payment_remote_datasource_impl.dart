import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:soulfit_client/feature/authentication/data/datasource/auth_local_datasource.dart';
import 'package:soulfit_client/feature/payment/data/datasource/payment_remote_datasource.dart';

import '../../domain/entity/payment_result.dart';
import '../model/approve_payment_response_model.dart';
import '../model/creat_order_response_model.dart';

class PaymentRemoteDataSourceImpl implements PaymentRemoteDataSource {
  final http.Client client;
  final String baseUrl;
  final AuthLocalDataSource source;

  PaymentRemoteDataSourceImpl({
    required this.client,
    required this.baseUrl,
    required this.source,
  });

  //String accessToken = await source.getAccessToken() as String;
  //
  //     final response = await client.post(
  //       Uri.parse('https://$base:8443/api/auth/logout'),
  //       headers: <String,String>{
  //         'Content-Type' : 'application/json; charset=UTF-8',
  //         'Authorization': 'Bearer '+accessToken,
  //       },
  //     );

  @override
  Future<String> createOrder({
    required String orderName,
    required int totalAmount,
  }) async {
    String accessToken = await source.getAccessToken() as String;

    final uri = Uri.parse('http://$baseUrl:8080/api/payments/order');

    final response = await client.post(
      uri,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer '+accessToken,
      },
      body: jsonEncode({
        'totalAmount': totalAmount,
      }),
    );

    if (response.statusCode == 200) {
      print('[payment remote data source impl] : order created');


      final Map<String, dynamic> json = jsonDecode(response.body);
      final model = CreateOrderResponseModel.fromJson(json);
      return model.orderId;
    } else {
      print('[payment remote data source impl] : create order FAIL' + response.body);
      throw Exception('Failed to create order: ${response.body}');
    }
  }

  @override
  Future<PaymentResult> approvePayment({
    required String paymentKey,
    required String orderId,
    required int amount,
  }) async {
    String accessToken = await source.getAccessToken() as String;

    final uri = Uri.parse('http://$baseUrl:8080/api/payments/approve');

    final response = await client.post(
      uri,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer '+accessToken,
      },
      body: jsonEncode({
        'paymentKey': paymentKey,
        'orderId': orderId,
        'amount': amount,
      }),
    );

    if (response.statusCode == 200) {
      print('[payment remote data source impl] : payment approved');


      final Map<String, dynamic> json = jsonDecode(response.body);
      final model = ApprovePaymentResponseModel.fromJson(json);
      return model.toDomain();
    } else {
      print('[payment remote data source impl] : payment approval FAIL' + response.body);
      throw Exception('Failed to approve payment: ${response.body}');
    }
  }
}
