import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:soulfit_client/feature/dating_profile/ui/notifier/dating_profile_notifier.dart';
import 'package:soulfit_client/feature/dating_profile/ui/provider/dating_profile_providers.dart';
import 'package:soulfit_client/feature/dating_profile/ui/widgets/profile_header.dart';
import 'package:soulfit_client/feature/dating_profile/ui/widgets/profile_info_section.dart';
import 'package:soulfit_client/feature/dating_profile/ui/widgets/love_values_card.dart';

final selectedUserIdProvider = StateProvider<String?>((_) => null);

class DatingProfileScreen extends ConsumerStatefulWidget {
  const DatingProfileScreen({super.key});

  @override
  ConsumerState<DatingProfileScreen> createState() =>
      _DatingProfileScreenState();
}

class _DatingProfileScreenState extends ConsumerState<DatingProfileScreen> {
  bool _loadedOnce = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_loadedOnce) return;
      _loadedOnce = true;

      final s = GoRouterState.of(context);
      final fromQuery = s.uri.queryParameters['userId'];
      final fromPath = s.pathParameters['userId'];
      final fromExtra = s.extra is String ? s.extra as String : null;
      final fromProv = ref.read(selectedUserIdProvider);

      // 실제 연동 시 제거
      const kDefaultUserId = 'mock-001';

      final userId =
          fromQuery ?? fromPath ?? fromExtra ?? fromProv ?? kDefaultUserId;

      debugPrint(
        '[DatingProfile] params -> '
        'query=$fromQuery, path=$fromPath, extra=$fromExtra, prov=$fromProv, choose=$userId',
      );

      ref.read(datingProfileNotifierProvider.notifier).load(userId: userId);
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
        appBar: AppBar(title: Text('소개팅 프로필')),
        body: Center(child: Text('프로필이 없습니다.')),
      );
    }
    final p = st.profile!;

    return Scaffold(
      appBar: AppBar(title: const Text('소개팅 프로필')),
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
            LoveValuesCard(text: p.loveValues),
          ],
        ),
      ),
    );
  }
}
