import 'package:flutter/material.dart';

import '../../domain/entity/chat_request.dart';

class ConversationRequestCard extends StatelessWidget {
  final ChatRequest request;
  final VoidCallback onAccept;
  final VoidCallback onReject;
  final VoidCallback onViewProfile;

  const ConversationRequestCard({
    super.key,
    required this.request,
    required this.onAccept,
    required this.onReject,
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
              // 프로필 이미지
              CircleAvatar(
                radius: 36,
                backgroundImage: NetworkImage(request.profileImageUrl),
              ),
              const SizedBox(width: 16),
              // 사용자 정보 텍스트 + 버튼 영역
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('${request.username} | ${request.age}',
                        style: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 8),
                    Text(
                      '“${request.greetingMessage}”',
                      style: const TextStyle(
                          fontSize: 14, color: Colors.black87),
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        _buildIconButton(Icons.person, onViewProfile),
                        const SizedBox(width: 8),
                        _buildIconButton(Icons.block, onReject),
                        const SizedBox(width: 8),
                        _buildIconButton(Icons.check, onAccept),
                      ],
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

  Widget _buildIconButton(IconData icon, VoidCallback onPressed) {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: const Color(0xFFAAFFAA), width: 2),
        color: Colors.white,
      ),
      padding: const EdgeInsets.all(6),
      child: InkWell(
        customBorder: const CircleBorder(),
        onTap: onPressed,
        child: Icon(icon, size: 20),
      ),
    );
  }
}
