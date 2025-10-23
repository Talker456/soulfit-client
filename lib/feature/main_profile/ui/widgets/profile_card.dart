
import 'package:flutter/material.dart';
import 'package:soulfit_client/feature/main_profile/domain/entity/user_profile_screen_data.dart';

class ProfileCard extends StatelessWidget {
  final UserProfileScreenData data;

  const ProfileCard({
    super.key,
    required this.data,
  });

  int _calculateAge(String birthDateString) {
    final birthDate = DateTime.parse(birthDateString);
    final today = DateTime.now();
    int age = today.year - birthDate.year;
    if (today.month < birthDate.month ||
        (today.month == birthDate.month && today.day < birthDate.day)) {
      age--;
    }
    return age;
  }

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
            height: 200, // Set a fixed height for the image container
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(data.mainProfileInfo.profileImageUrl),
                fit: BoxFit.cover,
              ),
            ),
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.black.withOpacity(0.6), Colors.transparent],
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${data.mainProfileInfo.nickname} (${_calculateAge(data.mainProfileInfo.birthDate)}, ${data.mainProfileInfo.gender == 'MALE' ? '남' : '여'})',
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        shadows: [Shadow(blurRadius: 2.0, color: Colors.black45)],
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      data.mainProfileInfo.mbti,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        shadows: [Shadow(blurRadius: 2.0, color: Colors.black45)],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  data.mainProfileInfo.introduction,
                  style: const TextStyle(color: Colors.black87, fontSize: 15),
                  textAlign: TextAlign.start,
                ),
                const SizedBox(height: 12),
                Wrap(
                  spacing: 8,
                  runSpacing: 4,
                  children: data.mainProfileInfo.personalityKeywords
                      .map<Widget>((e) => Chip(
                            label: Text(e, style: const TextStyle(fontSize: 12)),
                            backgroundColor: Colors.green[50],
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0),
                              side: const BorderSide(color: Colors.transparent),
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
