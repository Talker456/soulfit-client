import 'package:flutter/material.dart';

class IntroHeader extends StatelessWidget{


  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        Text(
          'soulfit',
          style: TextStyle(
            fontSize: 54,
            fontWeight: FontWeight.w600,
            color: Color(0xFF8FBC8F),
            letterSpacing: 2,
          ),
        ),
        SizedBox(height: 12),
        Text(
          '나의 소울메이트를 찾는 여정의 시작',
          style: TextStyle(
            fontSize: 16,
            color: Color(0xFF666666),
            fontWeight: FontWeight.w400,
          ),
        ),
      ],
    );
  }
}


