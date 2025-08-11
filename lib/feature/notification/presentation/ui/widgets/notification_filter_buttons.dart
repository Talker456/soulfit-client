
import 'package:flutter/material.dart';
import 'package:soulfit_client/feature/notification/presentation/riverpod/notification_filter_category.dart';
import 'package:soulfit_client/feature/notification/presentation/riverpod/notification_notifier.dart';

class NotificationFilterButtons extends StatelessWidget {
  final NotificationNotifier notifier;
  final NotificationFilterCategory currentFilter;

  const NotificationFilterButtons({
    Key? key,
    required this.notifier,
    required this.currentFilter,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildFilterButton('커뮤니티', NotificationFilterCategory.community, currentFilter, notifier),
        _buildFilterButton('모임', NotificationFilterCategory.meeting, currentFilter, notifier),
        _buildFilterButton('소개팅', NotificationFilterCategory.matching, currentFilter, notifier),
      ],
    );
  }

  Widget _buildFilterButton(String label, NotificationFilterCategory category,
      NotificationFilterCategory current, NotificationNotifier notifier) {
    final isSelected = current == category;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: ElevatedButton(
        onPressed: () => notifier.updateFilterAndReload(category),
        style: ElevatedButton.styleFrom(
          backgroundColor: isSelected
              ? (category == NotificationFilterCategory.community
                  ? const Color(0xFFDAEDF8)
                  : category == NotificationFilterCategory.meeting
                      ? const Color(0xFFE3F8DF)
                      : const Color(0xFFFFDBF2)) // Default to matching if not community or meeting
              : Colors.grey,
        ),
        child: Text(label),
      ),
    );
  }
}
