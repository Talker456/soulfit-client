// lib/feature/community/presentation/widgets/floating_post_button.dart

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class FloatingPostButton extends StatelessWidget {
  const FloatingPostButton({super.key});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        context.push('/community/create');
      },
      child: const Icon(Icons.add),
    );
  }
}
