import 'package:flutter/material.dart';

class UserBubble extends StatelessWidget {
  final String avatarUrl;
  const UserBubble({super.key, required this.avatarUrl});

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: 28,
      backgroundImage: NetworkImage(avatarUrl),
      backgroundColor: Colors.grey.shade200,
    );
  }
}
