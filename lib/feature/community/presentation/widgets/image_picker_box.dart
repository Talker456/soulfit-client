// lib/feature/community/presentation/widgets/image_picker_box.dart

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import '../riverpod/post_create_provider.dart';

class ImagePickerBox extends ConsumerWidget {
  const ImagePickerBox({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final images = ref.watch(postImagesProvider);

    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.green),
        borderRadius: BorderRadius.circular(8),
        color: const Color(0xFFEFFFEF),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              for (int i = 0; i < images.length; i++)
                Stack(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.file(
                        images[i],
                        width: 80,
                        height: 80,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Positioned(
                      top: -4,
                      right: -4,
                      child: GestureDetector(
                        onTap: () =>
                            ref.read(postImagesProvider.notifier).removeAt(i),
                        child: const CircleAvatar(
                          radius: 12,
                          backgroundColor: Colors.black54,
                          child: Icon(
                            Icons.close,
                            size: 16,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              if (images.length < 4)
                GestureDetector(
                  onTap: () async {
                    final picker = ImagePicker();
                    final picked = await picker.pickImage(
                      source: ImageSource.gallery,
                    );
                    if (picked != null) {
                      ref
                          .read(postImagesProvider.notifier)
                          .add(File(picked.path));
                    }
                  },
                  child: Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.green),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Center(child: Icon(Icons.add, size: 30)),
                  ),
                ),
            ],
          ),
          const SizedBox(height: 4),
          Text(
            '${images.length}/4',
            style: const TextStyle(color: Colors.grey),
          ),
        ],
      ),
    );
  }
}
