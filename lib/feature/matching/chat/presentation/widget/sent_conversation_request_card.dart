import 'package:flutter/material.dart';
import '../../domain/entity/sent_chat_request.dart';

class SentConversationRequestCard extends StatelessWidget {
  final SentChatRequest request;
  final VoidCallback onViewProfile;

  const SentConversationRequestCard({
    super.key,
    required this.request,
    required this.onViewProfile,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 프로필 이미지 및 상태 표시
              Stack(
                children: [
                  CircleAvatar(
                    radius: 36,
                    backgroundImage: NetworkImage(request.recipientProfileImageUrl),
                  ),
                  if (request.isViewed) // isViewed가 true일 때만 점 표시
                    Positioned(
                      right: 0,
                      top: 0,
                      child: Container(
                        width: 12,
                        height: 12,
                        decoration: BoxDecoration(
                          color: Colors.lightGreenAccent[400], // 밝은 녹색 점
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.white, width: 2),
                        ),
                      ),
                    ),
                ],
              ),
              const SizedBox(width: 16),
              // 인사말
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 8), // 이미지와 인사말 간격 조절
                    Text(
                      '“${request.sentGreetingMessage}”',
                      style: const TextStyle(
                          fontSize: 14, color: Colors.black87),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        // 연두색 구분선
        Container(
          height: 1,
          color: const Color(0xFFDDFFDD),
          margin: const EdgeInsets.symmetric(horizontal: 16),
        ),
      ],
    );
  }
}