import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:soulfit_client/core/ui/widget/shared_app_bar_dating.dart';
import 'package:soulfit_client/core/ui/widget/shared_navigation_bar.dart';
import '../riverpod/voting_provider.dart';

/// 투표 결과 화면
/// 사용자가 생성한 투표의 결과를 확인하는 화면
class VoteResultScreen extends ConsumerStatefulWidget {
  final int voteFormId;

  const VoteResultScreen({
    Key? key,
    required this.voteFormId,
  }) : super(key: key);

  @override
  ConsumerState<VoteResultScreen> createState() => _VoteResultScreenState();
}

class _VoteResultScreenState extends ConsumerState<VoteResultScreen> {
  @override
  void initState() {
    super.initState();
    // 투표 결과 로드
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(votingProvider.notifier).loadVoteResults(widget.voteFormId);
    });
  }

  @override
  Widget build(BuildContext context) {
    final votingState = ref.watch(votingProvider);
    final voteResult = votingState.voteResult;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const SharedAppBar(),
      body: votingState.isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Column(
                children: [
                  // 뒤로가기 버튼과 타이틀
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                    child: Row(
                      children: [
                        IconButton(
                          icon: const Icon(Icons.arrow_back_ios,
                              color: Colors.black),
                          onPressed: () => Navigator.of(context).pop(),
                        ),
                        const Expanded(
                          child: Text(
                            '남들이 보는 나는?',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              color: Colors.black,
                            ),
                          ),
                        ),
                        const SizedBox(width: 40),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // 프로필 이미지 영역
                        Container(
                          width: double.infinity,
                          height: 200,
                          decoration: BoxDecoration(
                            color: const Color(0xFFF8E1F5),
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: const Center(
                            child: Icon(
                              Icons.person,
                              size: 80,
                              color: Colors.black38,
                            ),
                          ),
                        ),
                        const SizedBox(height: 50),

                        // 투표 결과 타이틀
                        const Text(
                          '첫인상 투표 결과',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: Colors.black87,
                          ),
                        ),
                        const SizedBox(height: 30),

                        if (voteResult != null) ...[
                          // 하트 아이콘과 퍼센티지
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              // 싫어요 (X)
                              Column(
                                children: [
                                  Container(
                                    width: 60,
                                    height: 60,
                                    decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                    ),
                                    child: const Icon(
                                      Icons.close,
                                      size: 50,
                                      color: Colors.grey,
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                  Text(
                                    '${voteResult.dislikePercentage.toStringAsFixed(0)}%',
                                    style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.black87,
                                    ),
                                  ),
                                  Text(
                                    '(${voteResult.dislikeCount}명)',
                                    style: const TextStyle(
                                      fontSize: 14,
                                      color: Colors.black54,
                                    ),
                                  ),
                                ],
                              ),
                              // 좋아요 (하트)
                              Column(
                                children: [
                                  Container(
                                    width: 60,
                                    height: 60,
                                    decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                    ),
                                    child: const Icon(
                                      Icons.favorite,
                                      size: 50,
                                      color: Color(0xFFE91E63),
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                  Text(
                                    '${voteResult.likePercentage.toStringAsFixed(0)}%',
                                    style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.black87,
                                    ),
                                  ),
                                  Text(
                                    '(${voteResult.likeCount}명)',
                                    style: const TextStyle(
                                      fontSize: 14,
                                      color: Colors.black54,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          const SizedBox(height: 30),

                          // 진행률 바
                          Container(
                            width: double.infinity,
                            height: 12,
                            decoration: BoxDecoration(
                              color: Colors.grey[200],
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: Stack(
                              children: [
                                // 좋아요 바
                                if (voteResult.likePercentage > 0)
                                  Container(
                                    width: MediaQuery.of(context).size.width *
                                        (voteResult.likePercentage / 100) *
                                        0.9, // 0.9는 padding 고려
                                    height: 12,
                                    decoration: BoxDecoration(
                                      color: const Color(0xFFE91E63),
                                      borderRadius: BorderRadius.circular(6),
                                    ),
                                  ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 20),

                          // 총 투표 수
                          Center(
                            child: Text(
                              '총 ${voteResult.totalVotes}명이 투표했습니다',
                              style: const TextStyle(
                                fontSize: 16,
                                color: Colors.black54,
                              ),
                            ),
                          ),
                        ] else ...[
                          const Center(
                            child: Text(
                              '아직 투표 결과가 없습니다',
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.black54,
                              ),
                            ),
                          ),
                        ],

                        const SizedBox(height: 100), // 하단 네비게이션 바 공간
                      ],
                    ),
                  ),
                ],
              ),
            ),
      bottomNavigationBar: SharedNavigationBar(
        currentIndex: 0,
        onTap: (index) {},
      ),
    );
  }
}
