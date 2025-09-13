import 'package:flutter/material.dart';
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
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: AspectRatio(
                aspectRatio: 16 / 10,
                child: Image.network(imageUrl, fit: BoxFit.cover),
              ),
            ),
            const SizedBox(height: 12),
            Text(
              '($nickname), ${age}세',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 6),
            ProfileTagWrap(tags: [mbti, ...personalityTags]),
            const SizedBox(height: 12),
            Text('자기소개 내용', style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 6),
            Text(intro),
            const SizedBox(height: 8),
            Divider(color: Colors.grey.shade300),
            const SizedBox(height: 8),
            Text('이상형 키워드', style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 6),
            ProfileTagWrap(tags: idealKeywords),
          ],
        ),
      ),
    );
  }
}
