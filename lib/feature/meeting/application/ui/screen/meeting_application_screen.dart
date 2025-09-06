import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:soulfit_client/core/ui/widget/shared_app_bar.dart';

import '../widget/section_label.dart';
import '../widget/readonly_green_box.dart';
import '../widget/answer_textarea.dart';
import '../widget/primary_bottom_button.dart';

class MeetingJoinQuestionScreen extends StatefulWidget {
  final String? questionText;

  const MeetingJoinQuestionScreen({super.key, this.questionText});

  @override
  State<MeetingJoinQuestionScreen> createState() =>
      _MeetingJoinQuestionScreenState();
}

class _MeetingJoinQuestionScreenState extends State<MeetingJoinQuestionScreen> {
  final _formKey = GlobalKey<FormState>();
  final _answerCtl = TextEditingController();

  @override
  void dispose() {
    _answerCtl.dispose();
    super.dispose();
  }

  void _goNext() {
    if (_formKey.currentState?.validate() != true) return;
    final answer = _answerCtl.text.trim();

    // 결제 화면으로 이동
    context.goNamed('meeting-payment', extra: {'answer': answer});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SharedAppBar(
        showBackButton: true,
        title: const Text(
          '모임 참여 신청',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
        ),
      ),
      bottomNavigationBar: PrimaryBottomButton(label: '다음', onPressed: _goNext),
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: CustomScrollView(
            slivers: [
              // 본문
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SectionLabel('참가자 필수 질문지'),
                      const SizedBox(height: 12),

                      // 읽기 전용 질문 박스
                      ReadonlyGreenBox(
                        text: widget.questionText ?? '',
                        hint: '(호스트가 설정한 질문내용)',
                        maxLines: 4,
                      ),
                      const SizedBox(height: 16),

                      // 답변 입력
                      AnswerTextarea(controller: _answerCtl),
                      const SizedBox(height: 24),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
