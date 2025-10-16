import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:soulfit_client/feature/dating_profile/ui/notifier/dating_profile_notifier.dart';
import 'package:soulfit_client/feature/dating_profile/ui/provider/dating_profile_providers.dart';
import 'package:soulfit_client/feature/dating_profile/ui/widgets/profile_header.dart';
import 'package:soulfit_client/feature/dating_profile/ui/widgets/profile_info_section.dart';
import 'package:soulfit_client/feature/dating_profile/ui/widgets/love_values_card.dart';

class DatingProfileScreen extends ConsumerStatefulWidget {
  final String viewerUserId;
  final String targetUserId;

  const DatingProfileScreen({
    super.key,
    required this.viewerUserId,
    required this.targetUserId,
  });

  @override
  ConsumerState<DatingProfileScreen> createState() =>
      _DatingProfileScreenState();
}

class _DatingProfileScreenState extends ConsumerState<DatingProfileScreen> {
  late final bool isMyProfile;

  @override
  void initState() {
    super.initState();

    isMyProfile = widget.viewerUserId == widget.targetUserId;

    Future.microtask(() {
      ref
          .read(datingProfileNotifierProvider.notifier)
          .load(userId: widget.targetUserId);
    });
  }

  @override
  Widget build(BuildContext context) {
    final st = ref.watch(datingProfileNotifierProvider);

    if (st.loading) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }
    if (st.error != null) {
      return Scaffold(
        appBar: AppBar(title: const Text('소개팅 프로필')),
        body: Center(child: Text(st.error!)),
      );
    }
    if (st.profile == null) {
      return Scaffold(
        appBar: AppBar(title: const Text('소개팅 프로필')),
        body: const Center(child: Text('프로필이 없습니다.')),
      );
    }
    final p = st.profile!;

    return Scaffold(
      backgroundColor: const Color(0xFFFFF0F5),
      appBar: AppBar(
        backgroundColor: const Color(0xFFFFF0F5),
        elevation: 0,
        centerTitle: true,
        title: PopupMenuButton<String>(
          onSelected: (value) {
            if (value == 'mainProfile') {
              context.go(
                  '/main-profile/${widget.viewerUserId}/${widget.targetUserId}');
            }
          },
          itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
            const PopupMenuItem<String>(
              value: 'mainProfile',
              child: Text('메인 프로필 보기'),
            ),
          ],
          child: const Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                '소개팅 프로필',
                style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
              ),
              Icon(Icons.keyboard_arrow_down, color: Colors.black),
            ],
          ),
        ),
        actions: [
          if (isMyProfile)
            IconButton(
              icon: const Icon(Icons.edit, color: Colors.black),
              onPressed: () {
                // TODO: Implement profile edit navigation
              },
            ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ProfileHeader(
              imageUrl: p.imageUrl,
              nickname: p.nickname,
              age: p.age,
              mbti: p.mbti,
              personalityTags: p.personalityTags,
              intro: p.introduction,
              idealKeywords: p.idealKeywords,
            ),
            const SizedBox(height: 16),
            ProfileInfoSection(
              job: p.job,
              heightBody: p.heightBody,
              religion: p.religion,
              smokingDrinking: p.smokingDrinking,
            ),
            const SizedBox(height: 16),
            LoveValuesCard(text: p.loveValues, nickname: p.nickname),
          ],
        ),
      ),
    );
  }
}
