import 'package:flutter/material.dart';

class SharedAppBar extends StatelessWidget implements PreferredSizeWidget {
  final bool showBackButton;

  const SharedAppBar({super.key, this.showBackButton = false});

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
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                ),
              const Text('soulfit',
                  style: TextStyle(
                      fontSize: 24, color: Colors.green, fontWeight: FontWeight.bold)),
            ],
          ),
          Row(
            children: const [
              Icon(Icons.history, size: 20),
              SizedBox(width: 12),
              Icon(Icons.send, size: 20),
              SizedBox(width: 12),
              Icon(Icons.search, size: 20),
            ],
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
