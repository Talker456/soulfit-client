
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
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: const BorderSide(color: Color(0xFFDFF5DB), width: 5),
      ),
      elevation: 1,
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(data.mainProfileInfo.profileImageUrl),
                fit: BoxFit.cover,

              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 88),
                  const Text(
                    "이름 (나이)",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    "mbti",
                    style: TextStyle(color: Colors.white70),
                  ),
                ],
              ),
            ),
          ),
          const Divider(height: 1),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  data.mainProfileInfo.introduction,
                  style: const TextStyle(color: Colors.black87),
                  textAlign: TextAlign.start,
                ),
                const SizedBox(height: 8),
                Wrap(
                  spacing: 8,
                  runSpacing: 4,
                  children: data.mainProfileInfo.personalityKeywords
                      .map<Widget>((e) => Chip(
                            label: Text(e, style: const TextStyle(fontSize: 12)),
                            backgroundColor: Colors.green[50],
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0),
                              side: const BorderSide(color: Colors.white),
                            ),
                          ))
                      .toList(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
