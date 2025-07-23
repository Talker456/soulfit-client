// lib/feature/survey/presentation/screens/love_survey_screen.dart

import 'package:flutter/material.dart';

class LoveSurveyScreen extends StatefulWidget {
  const LoveSurveyScreen({super.key});

  @override
  State<LoveSurveyScreen> createState() => _LoveSurveyScreenState();
}

class _LoveSurveyScreenState extends State<LoveSurveyScreen> {
  int currentQuestionIndex = 0;

  final List<Map<String, dynamic>> questions = [
    {
      'question': '상대방이 바쁜 날, 연락이 늦어지면 나는...?',
      'options': [
        '“바쁘겠지~” 하고 기다린다',
        '‘나도 바쁘게 지내자’ 하며 별 생각 안 한다',
        '왜 답장 없지? 서운해서 먼저 연락한다',
      ],
    },
    {
      'question': '연인이 갑자기 ‘혼자만의 시간이 필요해’라고 말하면?',
      'options': [
        '그래, 나도 그럴 때 있으니까 이해한다',
        '이해는 되지만 좀 서운하다 ',
        '나 때문에 그런 건가 걱정된다',
      ],
    },
    {
      'question': '중요한 날에 연인이 약속을 잊었다면?',
      'options': [
        '깜빡할 수도 있지, 이해하려고 한다',
        '속상하지만 티는 안 낸다',
        '바로 말한다, “그날 얼마나 기대했는데…”',
      ],
    },
    {
      'question': '나의 연락 스타일은?',
      'options': [
        '하루 몇 번이면 충분해, 너무 자주 안 해도 돼',
        '딱히 정해진 건 없고, 상황에 따라 다르다',
        '자주 연락하고 소통 자주 하는 게 좋다',
      ],
    },
    {
      'question': '나는 애정 표현을…',
      'options': [
        '말보단 행동으로 보여주는 편이다',
        '말이든 행동이든 상황에 따라 다르게 한다',
        '“좋아해”, “보고 싶어” 자주 표현하는 게 좋다',
      ],
    },
    {
      'question': '다툰 뒤에 나는 보통…',
      'options': [
        '혼자 생각 정리한 다음에 말하는 편',
        '감정이 가라앉으면 먼저 대화 시도하는 편',
        '빨리 풀고 싶어서 바로 얘기하는 편',
      ],
    },
    {
      'question': '연인의 SNS에 이성 친구 댓글이 달렸다면?',
      'options': [
        '별 신경 안 쓴다, 사생활은 서로 존중한다',
        '좀 신경 쓰이긴 하지만 말은 안 한다',
        '괜히 마음 쓰이고, 속 얘기 꺼내고 싶어진다',
      ],
    },
    {
      'question': '연애할 때 우선순위는?',
      'options': ['내 생활도 지키는 게 중요하다', '서로 존중하는 균형 잡힌 관계', '연애할 땐 서로가 1순위여야 한다'],
    },
    {
      'question': '연인이 힘들어 보일 때 나는?',
      'options': [
        '그냥 들어주는 게 제일이라고 생각한다',
        '조언을 줄까 말까 고민하게 된다',
        '해결 방법부터 알려주고 싶다',
      ],
    },
    {
      'question': '생일이나 기념일이 다가오면?',
      'options': [
        '마음만 전하면 충분하다고 생각한다',
        '최소한의 챙김은 필요하다',
        '정성껏 특별하게 준비해야 한다고 느낀다',
      ],
    },
    {
      'question': '\'사랑해\' 같은 말은?',
      'options': [
        '자주 안 해도 진심이면 괜찮다',
        '상황에 따라 자연스럽게 표현하는 게 좋다',
        '자주 해줘야 관계가 더 단단해진다',
      ],
    },
    {
      'question': '연애할 때 내 모습은?',
      'options': ['조율 잘하고 균형 맞추는 타입', '상대에 따라 나도 달라짐', '감정 표현도 리드도 적극적인 편'],
    },
    {
      'question': '연인이 이성 친구랑 단둘이 여행 간다고 하면?',
      'options': ['믿고 보내줄 수 있다', '조금 불편하긴 하다', '솔직히 이해 안 된다, 안 갔으면 좋겠다'],
    },
    {
      'question': '나는 연애할 때…',
      'options': [
        '각자만의 시간도 중요하다고 생각한다',
        '가끔은 기대고, 가끔은 혼자 있고 싶다',
        '서로 붙어 있는 시간이 많을수록 좋다',
      ],
    },
    {
      'question': '연인이 \'요즘 좀 달라진 것 같아\'라고 하면?',
      'options': [
        '그 말 꺼낸 이유부터 솔직히 얘기해본다',
        '어떤 점이 그런지 먼저 물어본다',
        '나도 그렇게 느꼈는지 돌아보게 된다',
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
          content: const Text('연애 가치관 검사가 완료되었습니다.'),
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
        title: const Text('연애 가치관 검사'),
        backgroundColor: Colors.pinkAccent.shade100,
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
                          backgroundColor: Colors.pink.shade100,
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
              color: Color(0xFFFF7DAE),
              minHeight: 6,
            ),
          ],
        ),
      ),
    );
  }
}
