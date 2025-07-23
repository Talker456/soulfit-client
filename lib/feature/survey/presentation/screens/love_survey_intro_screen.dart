import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class LoveSurveyIntroScreen extends StatelessWidget {
  const LoveSurveyIntroScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFF0F5),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 닫기 버튼
              GestureDetector(
                onTap: () => context.go('/'), // 홈으로 이동
                child: const Icon(Icons.close, color: Colors.pink, size: 28),
              ),
              const SizedBox(height: 32),

              // 텍스트
              const Text(
                '우리,',
                style: TextStyle(
                  color: Colors.pink,
                  fontSize: 28,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 4),
              const Text(
                '진짜 잘 맞는 사람 만나려면?',
                style: TextStyle(
                  color: Colors.pink,
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                '먼저 당신의 연애 가치관부터 알아볼게요 😉\n\n간단한 검사로 당신과 맞는 인연을\nAI가 찾아드립니다💘',
                style: TextStyle(
                  color: Colors.pinkAccent,
                  fontSize: 16,
                  height: 1.4,
                ),
              ),
              const Spacer(),
              // 테스트 하러가기 버튼
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => context.go('/love-survey'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.pink,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(24),
                    ),
                  ),
                  child: const Text('테스트 하러가기', style: TextStyle(fontSize: 16)),
                ),
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}
