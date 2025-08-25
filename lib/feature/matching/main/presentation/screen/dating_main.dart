import 'package:flutter/material.dart';

class DatingMain extends StatelessWidget {
  const DatingMain({super.key});

  @override
  Widget build(BuildContext context) {
    // Scaffold는 화면의 기본 뼈대입니다.
    return Scaffold(
      // 화면 상단에 '소개팅 화면'이라는 제목을 보여줍니다.
      appBar: AppBar(
        title: const Text('소개팅 화면'),
        backgroundColor: Colors.pink[100], // 예쁜 핑크색 배경
      ),
      // 화면 중앙에 텍스트를 보여줍니다.
      body: const Center(
        child: Text(
          '소개팅 화면에 오신 것을 환영합니다!',
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DatingMain(),
    ),
  );
}