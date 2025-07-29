
import 'package:flutter/material.dart';
import 'package:soulfit_client/feature/main_profile/domain/entity/user_profile_screen_data.dart';

class ProfileCard extends StatelessWidget {
  final UserProfileScreenData data;

  const ProfileCard({
    super.key,
    required this.data,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 1,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            CircleAvatar(
              radius: 40,
              backgroundImage:
                  NetworkImage(data.mainProfileInfo.profileImageUrl),
              backgroundColor: Colors.purple[100],
            ),
            const SizedBox(height: 8),
            const Text("이름 (나이)",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            Text("mbti", style: TextStyle(color: Colors.grey[700])),
            const SizedBox(height: 8),
            Text(data.mainProfileInfo.introduction),
            const Divider(),
            Wrap(
              spacing: 8,
              children: data.mainProfileInfo.personalityKeywords
                  .map<Widget>(
                      (e) => Chip(label: Text(e), backgroundColor: Colors.green[50]))
                  .toList(),
            )
          ],
        ),
      ),
    );
  }
}
