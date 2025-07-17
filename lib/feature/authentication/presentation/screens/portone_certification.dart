import 'package:flutter/material.dart';

/* 포트원 V1 휴대폰 본인인증 모듈을 불러옵니다. */
import 'package:portone_flutter/iamport_certification.dart';
/* 포트원 V1 휴대폰 본인인증 데이터 모델을 불러옵니다. */
import 'package:portone_flutter/model/certification_data.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:portone_flutter/model/url_data.dart';

class Certification extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return IamportCertification(
      appBar: new AppBar(
        title: new Text('포트원 V1 본인인증'),
      ),
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
      userCode: dotenv.get("IAMPORT_USERCODE"), //IAMPORT_USERCODE
      /* [필수입력] 본인인증 데이터 */
      data: CertificationData(
        merchantUid: 'mid_${DateTime.now().millisecondsSinceEpoch}',
        company: '포트원 V1',
        carrier: 'SKT',
        name: '홍길동',
        phone: '01012341234',
        mRedirectUrl: UrlData.redirectUrl,
      ),
      /* [필수입력] 콜백 함수 */
      callback: (Map<String, String> result) {
        print(' certificatoin : OK' );
        // Navigator.pushReplacementNamed(
        //   context,
        //   '/certification-result',
        //   arguments: result,
        // );
        Navigator.pop(context, result);
      },
    );
  }
}