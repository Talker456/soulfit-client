import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:soulfit_client/feature/main_profile/ui/widgets/album_section.dart';
import 'package:soulfit_client/feature/main_profile/ui/widgets/hosted_meetings_placeholder.dart';
import 'package:soulfit_client/feature/main_profile/ui/widgets/perception_card.dart';
import 'package:soulfit_client/feature/main_profile/ui/widgets/profile_card.dart';
import 'package:soulfit_client/feature/main_profile/ui/widgets/value_analysis_card.dart';
import 'package:soulfit_client/feature/user_report/presentation/widgets/user_report_dialog.dart'; // 유저 신고
import '../provider/main_profile_provider.dart';
import '../state/main_profile_state.dart';

class MainProfileScreen extends ConsumerStatefulWidget {
  final String viewerUserId;
  final String targetUserId;

  const MainProfileScreen({
    super.key,
    required this.viewerUserId,
    required this.targetUserId,
  });

  @override
  ConsumerState<MainProfileScreen> createState() => _MainProfileScreenState();
}

class _MainProfileScreenState extends ConsumerState<MainProfileScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      ref
          .read(mainProfileNotifierProvider.notifier)
          .load(widget.viewerUserId, widget.targetUserId);
    });
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(mainProfileNotifierProvider);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: const Column(
          children: [
            Text(
              "soulfit",
              style: TextStyle(
                fontFamily: 'Serif',
                fontSize: 20,
                color: Colors.green,
              ),
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "메인 프로필",
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Icon(Icons.keyboard_arrow_down, color: Colors.black),
              ],
            ),
          ],
        ),
      ),

      body: switch (state) {
        MainProfileInitial() || MainProfileLoading() => const Center(
          child: CircularProgressIndicator(),
        ),
        MainProfileError(:final message) => Center(
          child: Text("오류 발생: $message"),
        ),
        MainProfileLoaded(:final data) => ListView(
          padding: const EdgeInsets.all(16),
          children: [
            // 유저 신고 버튼 코드 시작
            Stack(
              children: [
                ProfileCard(data: data),
                Positioned(
                  top: 8,
                  right: 8,
                  child: IconButton(
                    icon: const Icon(Icons.warning, color: Colors.red),
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder:
                            (_) => UserReportDialog(
                              reporterUserId: widget.viewerUserId,
                              reportedUserId: widget.targetUserId,
                            ),
                      );
                    },
                  ),
                ),
              ],
            ), // 유저 신고 버튼 코드 끝
            // ProfileCard(data: data), // 유저 신고 버튼 코드 삭제 시 주석 해제하기
            const SizedBox(height: 12),
            PerceptionCard(
              title: "상대방이 보는 나는...",
              keywords: data.perceivedByOthersKeywords,
            ),
            const SizedBox(height: 8),
            PerceptionCard(
              title: "내가 보는 나는...",
              keywords: data.mainProfileInfo.selfKeywords,
            ),
            const SizedBox(height: 8),
            PerceptionCard(
              title: "AI가 보는 나는...",
              keywords: data.aiPredictedKeywords,
            ),
            const SizedBox(height: 12),
            ValueAnalysisCard(data: data),
            const SizedBox(height: 16),
            const HostedMeetingsPlaceholder(),
            const SizedBox(height: 16),
            AlbumSection(urls: data.albumImages),
            const SizedBox(height: 16),
          ],
        ),
      },
    );
  }
}
