import 'package:flutter/material.dart';

/* 포트원 V1 결제 모듈을 불러옵니다. */
import 'package:portone_flutter/iamport_payment.dart';
/* 포트원 V1 결제 데이터 모델을 불러옵니다. */
import 'package:portone_flutter/model/payment_data.dart';
import 'package:portone_flutter/model/url_data.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class Payment extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return IamportPayment(
      appBar: new AppBar(title: new Text('포트원 V1 결제')),
      /* 웹뷰 로딩 컴포넌트 */
      initialChild: Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: EdgeInsets.fromLTRB(0.0, 30.0, 0.0, 0.0),
                child: Text('잠시만 기다려주세요...', style: TextStyle(fontSize: 20.0)),
              ),
            ],
          ),
        ),
      ),
      /* [필수입력] 가맹점 식별코드 */
      userCode: dotenv.get("IAMPORT_USERCODE"),
      /* [필수입력] 결제 데이터 */
      data: PaymentData(
        pg: 'danal', // PG사
        payMethod: 'card', // 결제수단
        name: '포트원 V1 결제데이터 분석', // 주문명
        merchantUid: 'mid_${DateTime.now().millisecondsSinceEpoch}', // 주문번호
        amount: 39000, // 결제금액
        buyerName: '홍길동', // 구매자 이름
        buyerTel: '01012345678', // 구매자 연락처
        buyerEmail: 'example@naver.com', // 구매자 이메일
        buyerAddr: '서울시 강남구 신사동 661-16', // 구매자 주소
        buyerPostcode: '06018', // 구매자 우편번호
        appScheme: 'example',
        mRedirectUrl: UrlData.redirectUrl, // 앱 URL scheme
      ),
      /* [필수입력] 콜백 함수 */
      callback: (Map<String, String> result) {
        print(' payment : OK');

        result.forEach((key, value) {
          print('$key: $value');
        });

        Navigator.pop(context, result);
      },
    );
  }
}
