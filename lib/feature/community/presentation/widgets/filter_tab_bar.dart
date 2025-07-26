// filter_tab_bar.dart

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../riverpod/community_filter_provider.dart';
import '../riverpod/community_filter_types.dart';

class FilterButton extends StatelessWidget {
  final String label;
  final bool selected;
  final VoidCallback onTap;

  const FilterButton({
    super.key,
    required this.label,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
        decoration: BoxDecoration(
          color: selected ? Colors.green.shade100 : Colors.grey.shade200,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: selected ? Colors.green.shade800 : Colors.black87,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}

class FilterTabBar extends ConsumerWidget {
  const FilterTabBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final postType = ref.watch(postTypeProvider);
    final sortType = ref.watch(sortTypeProvider);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      child: Row(
        children: [
          FilterButton(
            label: '모임 후기',
            selected: postType == PostType.meeting,
            onTap: () =>
                ref.read(postTypeProvider.notifier).state = PostType.meeting,
          ),
          const SizedBox(width: 8),
          FilterButton(
            label: '번개 모임',
            selected: postType == PostType.flash,
            onTap: () =>
                ref.read(postTypeProvider.notifier).state = PostType.flash,
          ),
          const Spacer(),
          FilterButton(
            label: sortType == SortType.popular ? '인기순 ⌄' : '최신순 ⌄',
            selected: true,
            onTap: () {
              final newSort = sortType == SortType.popular
                  ? SortType.recent
                  : SortType.popular;
              ref.read(sortTypeProvider.notifier).state = newSort;
            },
          ),
        ],
      ),
    );
  }
}
