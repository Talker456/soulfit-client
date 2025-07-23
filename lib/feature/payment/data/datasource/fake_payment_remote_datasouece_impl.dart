import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:soulfit_client/feature/payment/data/datasource/payment_remote_datasource.dart';

import '../../domain/entity/payment_result.dart';

class FakePaymentRemoteDataSourceImpl implements PaymentRemoteDataSource {
  int _orderCounter = 1000;
  final http.Client client;

  FakePaymentRemoteDataSourceImpl({
    required this.client,
  });



  @override
  Future<String> createOrder({
    required String orderName,
    required int totalAmount,
  }) async {
    await Future.delayed(const Duration(milliseconds: 300)); // simulate latency
    return 'FAKE-ORDER-ID-${_orderCounter++}';
  }

  @override
  Future<PaymentResult> approvePayment({
    required String paymentKey,
    required String orderId,
    required int amount,
  }) async {
    // await Future.delayed(const Duration(milliseconds: 300)); // simulate latency


    //const response = await fetch(
    //     'https://api.tosspayments.com/v1/payments/confirm',
    //     {
    //       method: 'POST',
    //       body: JSON.stringify({ orderId, amount, paymentKey }),
    //       headers: {
    //         Authorization: encryptedSecretKey,
    //         'Content-Type': 'application/json',
    //       },
    //     },
    //   );
    //   const data = await response.json();
    //   console.log(data);
    String secretKey = "test_gsk_docs_OaPz8L5KdmQXkzRz3y47BMw6";

    final String encryptedSecretKey =
        'Basic ' + base64Encode(utf8.encode('$secretKey:'));

    final uri = Uri.parse('https://api.tosspayments.com/v1/payments/confirm');

    final response = await client.post(
      uri,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': encryptedSecretKey,
      },
      body: jsonEncode({
        'paymentKey': paymentKey,
        'orderId': orderId,
        'amount': amount,
      }),
    );

    if(response.statusCode==200){
      print('[fake payment remote data source impl] : confirmation OK !!');
      print(response.body);
    }else{
      print('[fake payment remote data source impl] : confirmation NOT OK');
      print(response.body);
    }


    if (amount <= 0) {
      return const PaymentResult(
        status: PaymentStatus.failed,
        message: 'Invalid amount for test payment.',
      );
    }

    return const PaymentResult(
      status: PaymentStatus.success,
      message: 'Test payment approved.',
    );
  }
}
