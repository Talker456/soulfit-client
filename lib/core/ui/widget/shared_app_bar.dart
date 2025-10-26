import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SharedAppBar extends StatelessWidget implements PreferredSizeWidget {
  final bool showBackButton;
  final VoidCallback? onBackButtonPressed;
  final Widget? title;
  final List<Widget>? actions;

  const SharedAppBar({
    super.key,
    this.showBackButton = false,
    this.onBackButtonPressed,
    this.title,
    this.actions,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              if (showBackButton)
                Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: IconButton(
                    icon: const Icon(Icons.arrow_back_ios),
                    onPressed: onBackButtonPressed ?? () => context.pop(),
                  ),
                ),
              title ?? const Text('soulfit',
                  style: TextStyle(
                      fontSize: 28, color: Colors.green, fontWeight: FontWeight.bold)),
            ],
          ),
          if (actions != null)
            Row(
              children: actions!,
            ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
