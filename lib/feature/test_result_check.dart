import 'package:flutter/material.dart';

// --- 1. 백엔드와 주고받을 데이터의 '약속' (데이터 모델) ---
// 각 질문과 사용자의 답변을 담는 구조입니다.

// 질문의 종류를 나타내는 enum (선택형, 서술형)
enum QuestionType { multipleChoice, descriptive }

// 하나의 질문과 답변 세트
class QuestionAnswer {
  final String question;
  final String userAnswer;
  final QuestionType type;
  final List<String>? choices; // 선택형 질문일 경우 선택지 목록

  QuestionAnswer({
    required this.question,
    required this.userAnswer,
    required this.type,
    this.choices,
  });
}

// --- 2. 프론트엔드 개발을 위한 '가짜 데이터' (Dummy Data) ---
// 백엔드 API가 완성되기 전까지 이 가짜 데이터를 사용해서 UI를 만듭니다.
final List<QuestionAnswer> dummyAnswers = [
  QuestionAnswer(
    question: 'Q1. 선택형 질문1',
    userAnswer: '선택지 1',
    type: QuestionType.multipleChoice,
    choices: ['선택지 1', '선택지 2'],
  ),
  QuestionAnswer(
    question: 'Q2. 선택형 질문2',
    userAnswer: '선택지 2',
    type: QuestionType.multipleChoice,
    choices: ['선택지 1', '선택지 2'],
  ),
  QuestionAnswer(
    question: 'Q3. 선택형 질문3',
    userAnswer: '선택지 1',
    type: QuestionType.multipleChoice,
    choices: ['선택지 1', '선택지 2'],
  ),
  QuestionAnswer(
    question: 'Q4. 서술형 질문1',
    userAnswer: '사용자가 가치관 검사 진행하면서 해당 서술형 질문에 대한 답변이 그대로 이 섹션에 나타남..',
    type: QuestionType.descriptive,
  ),
  QuestionAnswer(
    question: 'Q5. 서술형 질문2',
    userAnswer: '사용자가 가치관 검사 진행하면서 해당 서술형 질문에 대한 답변이 그대로 이 섹션에 나타남..',
    type: QuestionType.descriptive,
  ),
  // --- 주석 처리된 부분에 새로운 질문을 쉽게 추가할 수 있습니다. ---
  // QuestionAnswer(
  //   question: 'Q6. 새로운 선택형 질문',
  //   userAnswer: '선택지 1',
  //   type: QuestionType.multipleChoice,
  //   choices: ['선택지 1', '선택지 2', '선택지 3'],
  // ),
];

// --- 3. 화면을 그리는 메인 위젯 ---
class ValueTestResultScreen extends StatelessWidget {
  // 실제 앱에서는 이 데이터를 외부(백엔드)에서 받아오게 됩니다.
  final List<QuestionAnswer> answers;

  const ValueTestResultScreen({super.key, required this.answers});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      // 상단 AppBar
      appBar: AppBar(
        // 요청하신 뒤로가기 아이콘
        leading: IconButton(
          icon: const Icon(Icons.chevron_left, color: Colors.black, size: 30),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text(
          '가치관 검사지',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 1,
      ),
      // 스크롤 가능한 본문
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Card(
            elevation: 2,
            shadowColor: Colors.grey.withOpacity(0.2),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
              side: BorderSide(color: Colors.green.shade100, width: 1.5),
            ),
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'OO 가치관 검사',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  const Divider(),
                  const SizedBox(height: 16),
                  // ListView.separated를 사용해 각 질문 사이에 구분선을 자동으로 추가합니다.
                  ListView.separated(
                    // ListView가 스크롤되지 않도록 설정 (부모가 이미 스크롤됨)
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: answers.length,
                    itemBuilder: (context, index) {
                      final qa = answers[index];
                      // 질문 유형에 따라 다른 위젯을 보여줍니다.
                      if (qa.type == QuestionType.multipleChoice) {
                        return _buildMultipleChoiceResult(qa);
                      } else {
                        return _buildDescriptiveResult(qa);
                      }
                    },
                    // 각 아이템 사이에 회색 구분선을 추가합니다.
                    separatorBuilder: (context, index) => const Divider(height: 32),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  // --- UI를 작은 조각으로 나누는 private 메서드들 ---

  // 선택형 질문 결과를 보여주는 위젯
  Widget _buildMultipleChoiceResult(QuestionAnswer qa) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          qa.question,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 12),
        if (qa.choices != null && qa.choices!.isNotEmpty)
          ...qa.choices!.map((choice) {
            final isSelected = choice == qa.userAnswer;
            return Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: Row(
                children: [
                  Icon(
                    isSelected ? Icons.radio_button_checked : Icons.radio_button_unchecked,
                    color: isSelected ? const Color(0xFFFDB813) : Colors.grey, // 주황색으로 변경
                  ),
                  const SizedBox(width: 8),
                  Text(
                    choice,
                    style: TextStyle(
                      fontSize: 15,
                      color: isSelected ? Colors.black : Colors.grey[700],
                      fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                    ),
                  ),
                ],
              ),
            );
          }).toList()
        else
          const Text('선택지가 없습니다.', style: TextStyle(color: Colors.red)),
      ],
    );
  }

  // 서술형 질문 결과를 보여주는 위젯
  Widget _buildDescriptiveResult(QuestionAnswer qa) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          qa.question,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 12),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.grey[100],
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            qa.userAnswer,
            style: TextStyle(color: Colors.grey[800], height: 1.5),
          ),
        ),
      ],
    );
  }
}
