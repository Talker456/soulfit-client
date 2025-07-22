import 'package:flutter/material.dart';

// --- 중요! ---
// 1. 아래 import 문에서 'prac.dart' 파일의 실제 경로를 확인해주세요.
//    만약 lib 폴더 바로 아래에 있다면 지금 경로가 맞습니다.
import 'package:soulfit_client/prac.dart'; 

// 2. prac.dart 안에 있는 위젯의 클래스 이름을 확인하고,
//    아래 home 부분의 'PracScreen'을 실제 클래스 이름으로 바꿔주세요.
//    (예: PracScreen -> MyPracticeWidget)

void main() {
  // 이 main 함수는 오직 prac.dart를 테스트하기 위해 존재합니다.
  runApp(const PracPreviewApp());
}

class PracPreviewApp extends StatelessWidget {
  const PracPreviewApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // 디버그 배너 제거
      debugShowCheckedModeBanner: false,
      // prac.dart에 있는 위젯을 첫 화면으로 지정
      // 클래스 이름이 PracScreen이 아니라면 꼭 수정해주세요!
      home: const MainScreen(), 
    );
  }
}
