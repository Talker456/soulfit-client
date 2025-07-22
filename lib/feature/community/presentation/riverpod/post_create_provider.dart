// lib/feature/community/presentation/riverpod/post_create_provider.dart

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// 게시판 타입
enum PostType { flash, meeting }

final selectedPostTypeProvider = StateProvider<PostType>((ref) => PostType.flash);

// 제목/내용 컨트롤러
final titleControllerProvider = Provider.autoDispose((ref) => TextEditingController());
final contentControllerProvider = Provider.autoDispose((ref) => TextEditingController());

// 이미지 첨부 상태
final postImagesProvider = StateNotifierProvider<PostImagesNotifier, List<File>>(
  (ref) => PostImagesNotifier(),
);

class PostImagesNotifier extends StateNotifier<List<File>> {
  PostImagesNotifier() : super([]);

  void add(File image) {
    if (state.length < 4) {
      state = [...state, image];
    }
  }

  void removeAt(int index) {
    state = [...state]..removeAt(index);
  }
}
