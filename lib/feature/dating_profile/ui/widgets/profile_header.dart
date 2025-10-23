import 'package:flutter/material.dart';
import './profile_card.dart';
import 'profile_tag_wrap.dart';

class ProfileHeader extends StatelessWidget {
  final String imageUrl;
  final String nickname;
  final int age;
  final String mbti;
  final List<String> personalityTags;
  final String intro;
  final List<String> idealKeywords;

  const ProfileHeader({
    super.key,
    required this.imageUrl,
    required this.nickname,
    required this.age,
    required this.mbti,
    required this.personalityTags,
    required this.intro,
    required this.idealKeywords,
  });

  @override
  Widget build(BuildContext context) {
    return ProfileCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              AspectRatio(
                aspectRatio: 1.1, // 시안에 가까운 비율로 조정
                child: Image.network(imageUrl, fit: BoxFit.cover, width: double.infinity),
              ),
              Positioned.fill(
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Colors.transparent, Colors.black.withOpacity(0.8)],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      stops: const [0.5, 1.0],
                    ),
                  ),
                ),
              ),
              Positioned(
                bottom: 16,
                left: 16,
                right: 16,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '($nickname), ${age}세',
                      style: Theme.of(context).textTheme.headlineSmall?.copyWith(color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),
                    ProfileTagWrap(tags: [mbti, ...personalityTags]),
                  ],
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('자기소개 내용', style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
                const SizedBox(height: 8),
                Text(intro, style: Theme.of(context).textTheme.bodyMedium),
                const SizedBox(height: 16),
                Divider(color: Colors.pink.shade100),
                const SizedBox(height: 16),
                Text('이상형 키워드', style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
                const SizedBox(height: 8),
                ProfileTagWrap(tags: idealKeywords),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
