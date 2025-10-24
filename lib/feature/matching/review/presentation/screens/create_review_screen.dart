
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:soulfit_client/feature/matching/review/presentation/provider/review_provider.dart';

import '../state/create_review_state.dart';

class CreateReviewScreen extends ConsumerStatefulWidget {
  // Assuming these are passed via routing
  final int revieweeId;
  final int conversationRequestId;

  const CreateReviewScreen({
    super.key,
    required this.revieweeId,
    required this.conversationRequestId,
  });

  @override
  ConsumerState<CreateReviewScreen> createState() => _CreateReviewScreenState();
}

class _CreateReviewScreenState extends ConsumerState<CreateReviewScreen> {
  final _commentController = TextEditingController();
  final List<String> _selectedKeywords = [];

  @override
  void initState() {
    super.initState();
    // Fetch keywords when the screen is initialized
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(createReviewNotifierProvider.notifier).fetchKeywords();
    });
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(createReviewNotifierProvider);

    ref.listen<CreateReviewState>(createReviewNotifierProvider, (previous, next) {
      if (next.status == CreateReviewStatus.success) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('리뷰가 성공적으로 제출되었습니다.')));
        // Optionally pop the screen
        // Navigator.of(context).pop();
      } else if (next.status == CreateReviewStatus.error) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(next.error ?? '알 수 없는 오류')));
      }
    });

    return Scaffold(
      appBar: AppBar(title: const Text('리뷰 작성')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: _buildBody(state),
      ),
    );
  }

  Widget _buildBody(CreateReviewState state) {
    if (state.status == CreateReviewStatus.keywordsLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('어떤 점이 좋았나요?', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8.0,
            children: state.keywords.map((keyword) {
              return ChoiceChip(
                label: Text(keyword),
                selected: _selectedKeywords.contains(keyword),
                onSelected: (selected) {
                  setState(() {
                    if (selected) {
                      _selectedKeywords.add(keyword);
                    } else {
                      _selectedKeywords.remove(keyword);
                    }
                  });
                },
              );
            }).toList(),
          ),
          const SizedBox(height: 24),
          const Text('한마디', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          TextField(
            controller: _commentController,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              hintText: '대화 상대에 대한 리뷰를 남겨주세요.',
            ),
            maxLines: 4,
          ),
          const SizedBox(height: 24),
          ElevatedButton(
            onPressed: state.status == CreateReviewStatus.loading
                ? null
                : () {
                    ref.read(createReviewNotifierProvider.notifier).submitReview(
                          revieweeId: widget.revieweeId,
                          conversationRequestId: widget.conversationRequestId,
                          comment: _commentController.text,
                          keywords: _selectedKeywords,
                        );
                  },
            child: state.status == CreateReviewStatus.loading
                ? const CircularProgressIndicator(color: Colors.white)
                : const Text('제출하기'),
          ),
        ],
      ),
    );
  }
}
