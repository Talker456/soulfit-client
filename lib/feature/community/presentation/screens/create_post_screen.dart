// lib/feature/community/presentation/screens/create_post_screen.dart

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../riverpod/post_create_provider.dart';
import '../riverpod/community_post_provider.dart'; // postListProvider import
import '../widgets/image_picker_box.dart';
import '../../data/models/post_model.dart'; // PostModel import

class CreatePostScreen extends ConsumerWidget {
  const CreatePostScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final postType = ref.watch(selectedPostTypeProvider);
    final images = ref.watch(postImagesProvider);
    final titleController = ref.watch(titleControllerProvider);
    final contentController = ref.watch(contentControllerProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('게시글 작성')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 제목
            const Text("제목"),
            TextField(
              controller: titleController,
              decoration: const InputDecoration(hintText: '제목을 입력하세요'),
              maxLength: 20,
            ),

            const SizedBox(height: 16),

            // 내용
            const Text("내용"),
            TextField(
              controller: contentController,
              decoration: const InputDecoration(hintText: '내용을 입력하세요'),
              maxLength: 400,
              maxLines: 6,
            ),

            const SizedBox(height: 16),

            // 게시판 선택
            const Text("게시판"),
            Row(
              children: PostType.values.map((type) {
                final isSelected = postType == type;
                return Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      backgroundColor: isSelected ? Colors.green : null,
                      foregroundColor: isSelected ? Colors.white : Colors.green,
                      side: const BorderSide(color: Colors.green),
                    ),
                    onPressed: () {
                      ref.read(selectedPostTypeProvider.notifier).state = type;
                    },
                    child: Text(type == PostType.flash ? '번개모임' : '모임후기'),
                  ),
                );
              }).toList(),
            ),

            const SizedBox(height: 16),

            // 이미지 첨부
            const Text("이미지 첨부"),
            const ImagePickerBox(),

            const SizedBox(height: 16),

            // 업로드 버튼
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  final title = titleController.text.trim();
                  final content = contentController.text.trim();

                  if (title.isEmpty || content.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('제목과 내용을 모두 입력해주세요')),
                    );
                    return;
                  }

                  // 게시글 모델 생성
                  final newPost = PostModel(
                    id: DateTime.now().millisecondsSinceEpoch.toString(),
                    author: '익명', // 로그인 연동 시 사용자 닉네임으로 대체
                    content: content,
                    imageUrl: images.isNotEmpty
                        ? images.first.path
                        : null, // 대표 이미지 (또는 null)
                    postType: postType.name, // String으로 저장
                    likeCount: 0,
                    commentCount: 0,
                    bookmarkCount: 0,
                    createdAt: DateTime.now(),
                    isLiked: false,
                    isBookmarked: false,
                  );

                  // 게시글 상태에 추가
                  ref.read(postListProvider.notifier).addPost(newPost);

                  // 뒤로가기
                  Navigator.of(context).pop();
                },
                child: const Text('업로드'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
