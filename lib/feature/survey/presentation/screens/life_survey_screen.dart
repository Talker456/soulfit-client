// lib/feature/survey/presentation/screens/life_survey_screen.dart

import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import '../riverpod/life_survey_provider.dart';

class LifeSurveyScreen extends StatefulWidget {
  const LifeSurveyScreen({super.key});

  @override
  State<LifeSurveyScreen> createState() => _LifeSurveyScreenState();
}

class _LifeSurveyScreenState extends State<LifeSurveyScreen> {
  int currentQuestionIndex = 0;

  final List<Map<String, dynamic>> questions = [
    {
      'question': '주말에 갑자기 시간이 생겼다면?',
      'options': [
        '하고 싶은 거 떠오르는 대로 움직인다',
        '그동안 못 했던 일부터 처리한다',
        '그냥 푹 쉬면서 재충전한다',
      ],
    },
    {
      'question': '새로운 사람을 만날 때 나는?',
      'options': [
        '편하게 말 걸고 금방 친해진다',
        '어느 정도 분위기 보고 천천히 다가간다',
        '조용히 관찰하며 상대를 파악한다',
      ],
    },
    {
      'question': '갈등이 생겼을 때 나는?',
      'options': [
        '바로 이야기하고 풀고 싶다',
        '감정이 가라앉은 후에 조용히 말한다',
        '상대가 먼저 말 꺼내줄 때까지 기다린다',
      ],
    },
    {
      'question': '큰 결정을 앞뒀을 때 나는?',
      'options': ['직감이 끌리는 쪽을 따른다', '리스트 정리하고 신중히 고민한다', '주변 의견도 많이 참고해서 결정한다'],
    },
    {
      'question': '나에게 성공이란?',
      'options': [
        '내가 하고 싶은 일을 하면서 사는 것',
        '사회적으로 인정받고 안정된 삶',
        '가족이나 가까운 사람들과 함께 행복한 삶',
      ],
    },
    {
      'question': '친구와 약속이 잡혔을 때 나는?',
      'options': ['하고 싶은 걸 먼저 택한다', '상대를 배려해 조율해본다', '그냥 상대가 원하는 쪽으로 맞춘다'],
    },
    {
      'question': '모임에서 나는 보통?',
      'options': [
        '분위기 메이커! 이끌어가는 편',
        '적당히 어울리면서 중심은 피하는 편',
        '조용히 듣고 있다가 필요할 때만 말하는 편',
      ],
    },
    {
      'question': '여행을 계획할 때 나는?',
      'options': [
        '일단 떠나고 보자!',
        '동선, 예산 전부 계획하고 떠난다',
        '큰 틀만 정해두고 현지 분위기에 따라 유동적으로 움직인다',
      ],
    },
    {
      'question': '시간이 생기면 주로 하는 생각은?',
      'options': ['내가 뭘 하고 싶을까?', '지금 나는 잘 사고 있나?', '주변 사람들은 어떻게 지내고 있을까?'],
    },
    {
      'question': '나를 가장 잘 설명하는 말은?',
      'options': ['자유로운 영혼', '계획형 꼼꼼러', '배려 깊은 사람'],
    },
    {
      'question': '돈을 쓰는 스타일은?',
      'options': ['지금이 중요하니까, 아끼지 않는다', '필요한 건 쓰고 나머지는 모은다', '가능한 한 절약한다'],
    },
    {
      'question': '나는 감정을...',
      'options': ['바로 표현해야 속이 편하다', '상황에 따라 조절하여 표현한다', '혼자서 조용히 정리하는 편이다'],
    },
    {
      'question': '\'행복\'이란 나에게...',
      'options': ['나답게 사는 것', '내가 세운 목표에 도달하는 것', '누군가와 진심으로 연결되어 있는 것'],
    },
    {
      'question': '누군가 힘들다고 할 때 나는?',
      'options': ['일단 공감해주고 들어준다', '조언을 줄지 말지 먼저 고민한다', '상황부터 객관적으로 파악한다'],
    },
    {
      'question': '나중에 나이 들어서 가장 중요할 것 같은 건?',
      'options': [
        '내가 좋아하는 삶을 살았다는 만족감',
        '남들이 인정해주는 결과',
        '곁에 믿을 수 있는 사람이 있다는 안정감',
      ],
    },
  ];

  final List<String> answers = [];

  void _selectOption(String option) {
    answers.add(option);

    if (currentQuestionIndex < questions.length - 1) {
      setState(() {
        currentQuestionIndex++;
      });
    } else {
      // 검사 완료
      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: const Text('검사 완료!'),
          content: const Text('인생 가치관 검사가 완료되었습니다.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context); // 다이얼로그 닫기
                Navigator.pop(context); // 홈으로 돌아가기
              },
              child: const Text('홈으로'),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final question = questions[currentQuestionIndex];

    return Scaffold(
      appBar: AppBar(
        title: const Text('인생 가치관 검사'),
        backgroundColor: Colors.grey.shade200,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // 질문
                  Text(
                    'Q${currentQuestionIndex + 1}. ${question['question']}',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 24),
                  // 선택지
                  ...(question['options'] as List<String>).map((option) {
                    return Container(
                      width: double.infinity,
                      margin: const EdgeInsets.only(bottom: 12),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.grey.shade200,
                        ),
                        onPressed: () => _selectOption(option),
                        child: Text(option),
                      ),
                    );
                  }),
                  // 이전 질문 보기
                  if (currentQuestionIndex > 0)
                    TextButton(
                      onPressed: () {
                        setState(() {
                          currentQuestionIndex--;
                          answers.removeLast();
                        });
                      },
                      child: const Text('← 이전으로'),
                    ),
                ],
              ),
            ),
            const SizedBox(height: 12),
            // 하단 진행 바
            LinearProgressIndicator(
              value: (currentQuestionIndex + 1) / questions.length,
              backgroundColor: Colors.grey.shade300,
              color: const Color(0xFF66A825),
              minHeight: 6,
            ),
          ],
        ),
      ),
    );
  }
}
