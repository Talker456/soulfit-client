import 'package:flutter/material.dart';

class Step6Done extends StatelessWidget {
  const Step6Done({super.key});
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: const [
          Icon(Icons.check_circle, size: 96),
          SizedBox(height: 12),
          Text(
            '개설 완료!',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
          ),
          SizedBox(height: 6),
          Text('모임이 정상적으로 개설되었습니다.'),
        ],
      ),
    );
  }
}
