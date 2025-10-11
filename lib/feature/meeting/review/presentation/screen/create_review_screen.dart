import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:soulfit_client/core/ui/widget/shared_app_bar.dart';
import '../provider/review_providers.dart';

/// 리뷰 작성 화면
class CreateReviewScreen extends ConsumerStatefulWidget {
  final String meetingId;

  const CreateReviewScreen({
    super.key,
    required this.meetingId,
  });

  @override
  ConsumerState<CreateReviewScreen> createState() => _CreateReviewScreenState();
}

class _CreateReviewScreenState extends ConsumerState<CreateReviewScreen> {
  final _contentController = TextEditingController();
  double _rating = 5.0;
  final List<String> _selectedKeywords = [];

  // 키워드 옵션 (호스트 리뷰용)
  final List<String> _keywordOptions = [
    '친절함',
    '시간 준수',
    '재미있음',
    '소통 잘함',
    '배려심',
    '전문적임',
    '분위기 좋음',
    '설명 명확함',
  ];

  @override
  void dispose() {
    _contentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final createReviewState = ref.watch(createReviewProvider);

    // 성공 시 화면 닫기
    ref.listen(createReviewProvider, (previous, next) {
      if (next.success) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('리뷰가 작성되었습니다')),
        );
        Navigator.of(context).pop(true); // true를 반환하여 새로고침 트리거
      }
    });

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const SharedAppBar(),
      body: Column(
        children: [
          // 헤더 AppBar
          AppBar(
            backgroundColor: Colors.white,
            elevation: 0,
            automaticallyImplyLeading: false,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
              onPressed: () => Navigator.of(context).pop(),
            ),
            title: const Text(
              '리뷰 작성',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            centerTitle: true,
          ),
          // 컨텐츠
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // 평점 선택
                  const Text(
                    '평점',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Expanded(
                        child: Slider(
                          value: _rating,
                          min: 0.5,
                          max: 5.0,
                          divisions: 9, // 0.5 단위
                          label: _rating.toStringAsFixed(1),
                          onChanged: (value) {
                            setState(() {
                              _rating = value;
                            });
                          },
                        ),
                      ),
                      const SizedBox(width: 16),
                      Text(
                        _rating.toStringAsFixed(1),
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),

                  // 키워드 선택
                  const Text(
                    '키워드 선택 (선택사항)',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: _keywordOptions.map((keyword) {
                      final isSelected = _selectedKeywords.contains(keyword);
                      return FilterChip(
                        label: Text(keyword),
                        selected: isSelected,
                        onSelected: (selected) {
                          setState(() {
                            if (selected) {
                              _selectedKeywords.add(keyword);
                            } else {
                              _selectedKeywords.remove(keyword);
                            }
                          });
                        },
                        selectedColor: Colors.blue.shade100,
                        checkmarkColor: Colors.blue.shade700,
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 24),

                  // 리뷰 내용
                  const Text(
                    '리뷰 내용',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 12),
                  TextField(
                    controller: _contentController,
                    maxLines: 8,
                    decoration: InputDecoration(
                      hintText: '리뷰 내용을 작성해주세요 (최소 10자 이상)',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      counterText: '',
                    ),
                    maxLength: 500,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '${_contentController.text.length}/500',
                    style: const TextStyle(color: Colors.grey, fontSize: 12),
                  ),

                  // 에러 메시지
                  if (createReviewState.error != null) ...[
                    const SizedBox(height: 16),
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.red.shade50,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        createReviewState.error!,
                        style: TextStyle(color: Colors.red.shade700),
                      ),
                    ),
                  ],

                  const SizedBox(height: 24),

                  // 제출 버튼
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: createReviewState.submitting
                          ? null
                          : () {
                              _submitReview();
                            },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: createReviewState.submitting
                          ? const SizedBox(
                              width: 20,
                              height: 20,
                              child: CircularProgressIndicator(
                                color: Colors.white,
                                strokeWidth: 2,
                              ),
                            )
                          : const Text(
                              '리뷰 작성',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _submitReview() {
    final content = _contentController.text.trim();

    if (content.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('리뷰 내용을 입력해 주세요')),
      );
      return;
    }

    if (content.length < 10) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('리뷰 내용은 최소 10자 이상 입력해 주세요')),
      );
      return;
    }

    ref.read(createReviewProvider.notifier).createReview(
          meetingId: widget.meetingId,
          rating: _rating,
          content: content,
          keywords: _selectedKeywords,
        );
  }
}
