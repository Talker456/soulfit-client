import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tosspayments_widget_sdk_flutter/model/payment_info.dart';
import 'package:tosspayments_widget_sdk_flutter/model/payment_widget_options.dart';
import 'package:tosspayments_widget_sdk_flutter/payment_widget.dart';
import 'package:tosspayments_widget_sdk_flutter/widgets/agreement.dart';
import 'package:tosspayments_widget_sdk_flutter/widgets/payment_method.dart';

import '../../domain/entity/payment_result.dart';
import '../riverpod/approve_payment_riverpod.dart';
import '../riverpod/create_order_riverpod.dart';


class PaymentWidgetExamplePage2 extends ConsumerStatefulWidget {
  const PaymentWidgetExamplePage2({super.key});

  @override
  ConsumerState<PaymentWidgetExamplePage2> createState() => _PaymentWidgetExamplePageState();
}

class _PaymentWidgetExamplePageState extends ConsumerState<PaymentWidgetExamplePage2> {
  late PaymentWidget _paymentWidget;
  PaymentMethodWidgetControl? _paymentMethodWidgetControl;
  AgreementWidgetControl? _agreementWidgetControl;

  @override
  void initState() {
    super.initState();

    _paymentWidget = PaymentWidget(
      clientKey: "test_gck_docs_Ovk5rk1EwkEbP0W43n07xlzm",
      customerKey: "a1b2c3d4e5f67890",
    );

    _paymentWidget.renderPaymentMethods(
      selector: 'methods',
      amount: Amount(value: 300, currency: Currency.KRW, country: "KR"),
    ).then((control) {
      _paymentMethodWidgetControl = control;
    });

    _paymentWidget.renderAgreement(selector: 'agreement').then((control) {
      _agreementWidgetControl = control;
    });
  }

  Future<void> _handlePayment() async {
    final createOrderController = ref.watch(createOrderProvider.notifier);
    final approvePaymentController = ref.watch(approvePaymentProvider.notifier);

    // Step 1: 서버에 주문 생성 요청
    const orderName = '파란티셔츠 외 2건';
    final createResult = await createOrderController.createOrder(orderName: orderName, totalAmount: 300);



    // Step 2: 결제 요청
    final paymentResult = await _paymentWidget.requestPayment(
      paymentInfo: PaymentInfo(orderId: ref.read(createOrderProvider).value ?? '', orderName: orderName),
    );

    // Step 3: 성공 시 서버에 결제 승인 요청
    if (paymentResult.success != null) {
      final success = paymentResult.success!;

      print('[toss payments widget v2] : '+ success.toString());

      await approvePaymentController.approve(
        paymentKey: success.paymentKey,
        orderId: success.orderId,
        amount: success.amount.toInt(),
      );

      final result = ref.read(approvePaymentProvider);
      if (result.hasValue && result.value?.status == PaymentStatus.success) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('결제 성공!')),);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('결제 승인 실패')),);
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('결제 실패 또는 취소됨')),);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: ListView(
                children: [
                  PaymentMethodWidget(
                    paymentWidget: _paymentWidget,
                    selector: 'methods',
                  ),
                  AgreementWidget(
                    paymentWidget: _paymentWidget,
                    selector: 'agreement',
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: _handlePayment,
                    child: const Text('결제하기'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
