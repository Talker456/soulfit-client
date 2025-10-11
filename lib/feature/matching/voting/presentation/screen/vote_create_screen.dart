import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:soulfit_client/core/ui/widget/shared_app_bar_dating.dart';
import 'package:soulfit_client/core/ui/widget/shared_navigation_bar.dart';
import '../riverpod/voting_provider.dart';

/// 투표 생성 화면
/// 사용자가 자신의 사진으로 첫인상 투표를 생성하는 화면
class VoteCreateScreen extends ConsumerStatefulWidget {
  const VoteCreateScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<VoteCreateScreen> createState() => _VoteCreateScreenState();
}

class _VoteCreateScreenState extends ConsumerState<VoteCreateScreen> {
  String? selectedImageUrl;
  File? selectedImageFile;
  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage() async {
    try {
      final XFile? image = await _picker.pickImage(
        source: ImageSource.gallery,
        maxWidth: 1920,
        maxHeight: 1920,
        imageQuality: 85,
      );

      if (image != null) {
        setState(() {
          selectedImageFile = File(image.path);
          // TODO: 실제 서버에 이미지 업로드 후 URL 받아오기
          selectedImageUrl = image.path; // 임시로 로컬 경로 사용
        });
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('이미지 선택 실패: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final votingState = ref.watch(votingProvider);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const SharedAppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // 뒤로가기 버튼과 타이틀
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
              child: Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                  const Expanded(
                    child: Text(
                      '남들이 보는 나는?',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  const SizedBox(width: 40),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // 사진 업로드 카드
                  GestureDetector(
                    onTap: _pickImage,
                    child: Container(
                      width: double.infinity,
                      height: 200,
                      decoration: BoxDecoration(
                        color: const Color(0xFFF8E1F5),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: selectedImageFile != null
                          ? ClipRRect(
                              borderRadius: BorderRadius.circular(16),
                              child: Image.file(
                                selectedImageFile!,
                                fit: BoxFit.cover,
                              ),
                            )
                          : const Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.add_photo_alternate,
                                    size: 48,
                                    color: Colors.black54,
                                  ),
                                  SizedBox(height: 8),
                                  Text(
                                    '사진 업로드 하기',
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.black87,
                                    ),
                                  ),
                                  SizedBox(height: 8),
                                  Text(
                                    '(얼굴이 잘 보이는 사진)',
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.black54,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                    ),
                  ),
                  const SizedBox(height: 30),

                  // 평가받기 버튼
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: votingState.isLoading
                          ? null
                          : () async {
                              if (selectedImageUrl == null) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text('사진을 선택해주세요'),
                                  ),
                                );
                                return;
                              }

                              // 투표 생성
                              await ref.read(votingProvider.notifier).createVoteForm(
                                    imageUrl: selectedImageUrl!,
                                    title: '첫인상 투표',
                                  );

                              if (votingState.error == null && mounted) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text('투표가 생성되었습니다!'),
                                  ),
                                );
                                Navigator.of(context).pop();
                              }
                            },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFE8C4E1),
                        foregroundColor: Colors.black87,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25),
                        ),
                        elevation: 0,
                      ),
                      child: votingState.isLoading
                          ? const CircularProgressIndicator()
                          : const Text(
                              '평가 받기',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                    ),
                  ),
                  const SizedBox(height: 20),

                  // 에러 메시지
                  if (votingState.error != null)
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.red.shade50,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        votingState.error!,
                        style: const TextStyle(color: Colors.red),
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: SharedNavigationBar(
        currentIndex: 0,
        onTap: (index) {},
      ),
    );
  }
}
