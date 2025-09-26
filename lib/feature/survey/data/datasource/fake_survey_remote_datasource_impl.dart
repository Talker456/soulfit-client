
import 'dart:math';

import '../../domain/entity/question.dart';
import '../models/choice_model.dart';
import '../models/question_model.dart';
import '../models/survey_model.dart';
import '../models/survey_submission_model.dart';
import 'survey_remote_data_source.dart';

class FakeSurveyRemoteDataSourceImpl implements SurveyRemoteDataSource {
  final _lifeSurvey = SurveyModel(
    sessionId: 999,
    questions: [
      QuestionModel(
        id: 1,
        content: '주말에 갑자기 시간이 생겼다면?',
        type: QuestionType.multiple,
        choices: [
          ChoiceModel(id: 1, text: '하고 싶은 거 떠오르는 대로 움직인다'),
          ChoiceModel(id: 2, text: '그동안 못 했던 일부터 처리한다'),
          ChoiceModel(id: 3, text: '그냥 푹 쉬면서 재충전한다'),
        ],
      ),
      QuestionModel(
        id: 2,
        content: '새로운 사람을 만날 때 나는?',
        type: QuestionType.multiple,
        choices: [
          ChoiceModel(id: 1, text: '편하게 말 걸고 금방 친해진다'),
          ChoiceModel(id: 2, text: '어느 정도 분위기 보고 천천히 다가간다'),
          ChoiceModel(id: 3, text: '조용히 관찰하며 상대를 파악한다'),
        ],
      ),
      QuestionModel(
        id: 3,
        content: '자기소개를 해주세요.',
        type: QuestionType.text,
        choices: [],
      ),
    ],
  );

  final _loveSurvey = SurveyModel(
    sessionId: 998,
    questions: [
      QuestionModel(
        id: 1,
        content: '상대방이 바쁜 날, 연락이 늦어지면 나는...?',
        type: QuestionType.multiple,
        choices: [
          ChoiceModel(id: 1, text: '“바쁘겠지~” 하고 기다린다'),
          ChoiceModel(id: 2, text: '‘나도 바쁘게 지내자’ 하며 별 생각 안 한다'),
          ChoiceModel(id: 3, text: '왜 답장 없지? 서운해서 먼저 연락한다'),
        ],
      ),
      QuestionModel(
        id: 2,
        content: '연인이 갑자기 ‘혼자만의 시간이 필요해’라고 말하면?',
        type: QuestionType.multiple,
        choices: [
          ChoiceModel(id: 1, text: '그래, 나도 그럴 때 있으니까 이해한다'),
          ChoiceModel(id: 2, text: '이해는 되지만 좀 서운하다 '),
          ChoiceModel(id: 3, text: '나 때문에 그런 건가 걱정된다'),
        ],
      ),
    ],
  );

  @override
  Future<SurveyModel> startSurvey(String testType) async {
    print('[FakeSurveyRemoteDataSource] startSurvey for $testType');
    await Future.delayed(const Duration(milliseconds: 300)); // Simulate network delay

    if (testType == 'TYPE_A') {
      return _lifeSurvey;
    } else if (testType == 'TYPE_B') {
      return _loveSurvey;
    } else {
      throw Exception('Unknown testType: $testType');
    }
  }

  @override
  Future<void> submitSurvey(SurveySubmissionModel submission) async {
    print('[FakeSurveyRemoteDataSource] submitSurvey received:');
    print('  Session ID: ${submission.sessionId}');
    for (var answer in submission.answers) {
      print('    - Q_ID: ${answer.questionId}, Choice_ID: ${answer.selectedChoiceId}, Text: ${answer.answerText}');
    }
    await Future.delayed(const Duration(milliseconds: 300)); // Simulate network delay
    return;
  }
}
