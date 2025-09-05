import 'package:flutter/material.dart';
import 'package:soulfit_client/core/ui/widget/shared_app_bar_dating.dart';
import 'package:soulfit_client/core/ui/widget/shared_navigation_bar.dart';

class FirstImpressionVote extends StatefulWidget {
  const FirstImpressionVote({Key? key}) : super(key: key);

  @override
  State<FirstImpressionVote> createState() => _FirstImpressionVoteState();
}

class _FirstImpressionVoteState extends State<FirstImpressionVote> {
  int currentImageIndex = 0;
  int currentProfileIndex = 0;
  
  // 샘플 프로필 데이터 (간단하게)
  final List<String> profileImages = [
    'https://images.unsplash.com/photo-1494790108755-2616b612b830?w=400&h=600&fit=crop',
    'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=400&h=600&fit=crop',
    'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?w=400&h=600&fit=crop',
  ];

  final List<String> names = ["Britney", "Jessica", "Emma"];
  final List<int> ages = [24, 26, 22];
  final List<String> distances = ["1km away", "2km away", "3km away"];

  void nextImage() {
    if (currentImageIndex < profileImages.length - 1) {
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

  void onDislike() {
    // 싫어요 (0) - 백엔드에서 처리할 부분
    print("Dislike: ${names[currentProfileIndex]} - choice: 0");
    moveToNextProfile();
  }

  void onLike() {
    // 좋아요 (1) - 백엔드에서 처리할 부분  
    print("Like: ${names[currentProfileIndex]} - choice: 1");
    moveToNextProfile();
  }

  void moveToNextProfile() {
    if (currentProfileIndex < names.length - 1) {
      setState(() {
        currentProfileIndex++;
        currentImageIndex = 0;
      });
    } else {
      // 마지막 프로필
      setState(() {
        currentProfileIndex = 0; // 처음으로 돌아가기
        currentImageIndex = 0;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const SharedAppBar(),
      body: Padding(
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
                          final screenWidth = MediaQuery.of(context).size.width;
                          if (details.globalPosition.dx < screenWidth / 2) {
                            previousImage();
                          } else {
                            nextImage();
                          }
                        },
                        child: Container(
                          width: double.infinity,
                          height: double.infinity,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: NetworkImage(profileImages[currentImageIndex]),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),

                      // 상단 이미지 인디케이터
                      Positioned(
                        top: 16,
                        left: 16,
                        right: 16,
                        child: Row(
                          children: List.generate(
                            profileImages.length,
                            (index) => Expanded(
                              child: Container(
                                height: 3,
                                margin: EdgeInsets.only(
                                  right: index < profileImages.length - 1 ? 4 : 0,
                                ),
                                decoration: BoxDecoration(
                                  color: index <= currentImageIndex
                                      ? Colors.white
                                      : Colors.white.withOpacity(0.3),
                                  borderRadius: BorderRadius.circular(2),
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
                                '${names[currentProfileIndex]}, ${ages[currentProfileIndex]}',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 28,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
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
                                    distances[currentProfileIndex],
                                    style: const TextStyle(
                                      color: Colors.white70,
                                      fontSize: 16,
                                    ),
                                  ),
                                ],
                              ),
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
                  onTap: onDislike,
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
                  onTap: onLike,
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
      bottomNavigationBar: SharedNavigationBar(
        currentIndex: 1,
        onTap: (index) {
          // 네비게이션 처리
        },
      ),
    );
  }
}

void main() {
  runApp(
    const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: FirstImpressionVote(),
    ),
  );
}
