import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:soulfit_client/core/ui/widget/shared_app_bar_dating.dart';
import 'package:soulfit_client/core/ui/widget/shared_navigation_bar.dart';
import '../../domain/entities/vote_response.dart';
import '../riverpod/voting_provider.dart';

/// 투표 참여 화면
/// 다른 유저에게 좋아요/싫어요 투표를 하는 화면
class VoteParticipateScreen extends ConsumerStatefulWidget {
  final int voteFormId;

  const VoteParticipateScreen({
    Key? key,
    required this.voteFormId,
  }) : super(key: key);

  @override
  ConsumerState<VoteParticipateScreen> createState() =>
      _VoteParticipateScreenState();
}

class _VoteParticipateScreenState extends ConsumerState<VoteParticipateScreen> {
  int currentImageIndex = 0;

  @override
  void initState() {
    super.initState();
    // 투표 대상 목록 로드
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(votingProvider.notifier).loadVoteTargets(widget.voteFormId);
    });
  }

  void nextImage() {
    final target = ref.read(votingProvider.notifier).currentTarget;
    if (target != null &&
        currentImageIndex < target.additionalImages.length - 1) {
      setState(() {
        currentImageIndex++;
      });
    }
  }

  void previousImage() {
    if (currentImageIndex > 0) {
      setState(() {
        currentImageIndex--;
      });
    }
  }

  Future<void> onVote(VoteChoice choice) async {
    final target = ref.read(votingProvider.notifier).currentTarget;
    if (target == null) return;

    await ref.read(votingProvider.notifier).submitVote(
          voteFormId: widget.voteFormId,
          targetUserId: target.userId,
          choice: choice,
        );

    // 다음 유저로 넘어가면 이미지 인덱스 초기화
    setState(() {
      currentImageIndex = 0;
    });

    // 모든 투표 완료 시
    final votingState = ref.read(votingProvider);
    if (votingState.voteTargets.isEmpty && mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('모든 투표가 완료되었습니다!')),
      );
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    final votingState = ref.watch(votingProvider);
    final currentTarget = ref.read(votingProvider.notifier).currentTarget;

    if (votingState.isLoading) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    if (currentTarget == null) {
      return Scaffold(
        appBar: const SharedAppBar(),
        body: const Center(
          child: Text('투표 가능한 유저가 없습니다'),
        ),
        bottomNavigationBar: SharedNavigationBar(
          currentIndex: 1,
          onTap: (index) {},
        ),
      );
    }

    final images = [
      if (currentTarget.profileImageUrl != null)
        currentTarget.profileImageUrl!,
      ...currentTarget.additionalImages,
    ];

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const SharedAppBar(),
      body: Column(
        children: [
          // 헤더
          Container(
            height: 56,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border(
                bottom: BorderSide(
                  color: Colors.grey.shade200,
                  width: 1,
                ),
              ),
            ),
            child: Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
                  onPressed: () => Navigator.of(context).pop(),
                ),
                const Expanded(
                  child: Text(
                    '첫인상 투표',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                    ),
                  ),
                ),
                const SizedBox(width: 48),
              ],
            ),
          ),
          // 본문
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  // 프로필 카드
                  Expanded(
                    child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 10,
                            offset: const Offset(0, 5),
                          ),
                        ],
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Stack(
                          children: [
                            // 프로필 이미지
                            GestureDetector(
                              onTapUp: (details) {
                                final screenWidth =
                                    MediaQuery.of(context).size.width;
                                if (details.globalPosition.dx <
                                    screenWidth / 2) {
                                  previousImage();
                                } else {
                                  nextImage();
                                }
                              },
                              child: Container(
                                width: double.infinity,
                                height: double.infinity,
                                decoration: BoxDecoration(
                                  image: images.isNotEmpty
                                      ? DecorationImage(
                                          image: NetworkImage(
                                            images[currentImageIndex],
                                          ),
                                          fit: BoxFit.cover,
                                        )
                                      : null,
                                  color: Colors.grey.shade200,
                                ),
                                child: images.isEmpty
                                    ? const Center(
                                        child: Icon(Icons.person, size: 100),
                                      )
                                    : null,
                              ),
                            ),

                            // 상단 이미지 인디케이터
                            if (images.isNotEmpty)
                              Positioned(
                                top: 16,
                                left: 16,
                                right: 16,
                                child: Row(
                                  children: List.generate(
                                    images.length,
                                    (index) => Expanded(
                                      child: Container(
                                        height: 3,
                                        margin: EdgeInsets.only(
                                          right: index < images.length - 1
                                              ? 4
                                              : 0,
                                        ),
                                        decoration: BoxDecoration(
                                          color: index <= currentImageIndex
                                              ? Colors.white
                                              : Colors.white.withOpacity(0.3),
                                          borderRadius:
                                              BorderRadius.circular(2),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),

                            // 하단 프로필 정보
                            Positioned(
                              bottom: 0,
                              left: 0,
                              right: 0,
                              child: Container(
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
                                    colors: [
                                      Colors.transparent,
                                      Colors.black.withOpacity(0.7),
                                    ],
                                  ),
                                ),
                                padding: const EdgeInsets.all(20),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      '${currentTarget.username}, ${currentTarget.age}',
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 28,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    if (currentTarget.distance != null) ...[
                                      const SizedBox(height: 4),
                                      Row(
                                        children: [
                                          const Icon(
                                            Icons.location_on,
                                            color: Colors.white70,
                                            size: 16,
                                          ),
                                          const SizedBox(width: 4),
                                          Text(
                                            '${currentTarget.distance!.toStringAsFixed(1)}km away',
                                            style: const TextStyle(
                                              color: Colors.white70,
                                              fontSize: 16,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 30),

                  // 액션 버튼들
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      // 싫어요 버튼
                      GestureDetector(
                        onTap: () => onVote(VoteChoice.dislike),
                        child: Container(
                          width: 60,
                          height: 60,
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black12,
                                blurRadius: 8,
                                offset: Offset(0, 2),
                              ),
                            ],
                          ),
                          child: const Icon(
                            Icons.close,
                            color: Colors.grey,
                            size: 30,
                          ),
                        ),
                      ),

                      // 좋아요 버튼
                      GestureDetector(
                        onTap: () => onVote(VoteChoice.like),
                        child: Container(
                          width: 60,
                          height: 60,
                          decoration: const BoxDecoration(
                            color: Color(0xFFFF4458),
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black12,
                                blurRadius: 8,
                                offset: Offset(0, 2),
                              ),
                            ],
                          ),
                          child: const Icon(
                            Icons.favorite,
                            color: Colors.white,
                            size: 30,
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 30),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: SharedNavigationBar(
        currentIndex: 1,
        onTap: (index) {},
      ),
    );
  }
}
