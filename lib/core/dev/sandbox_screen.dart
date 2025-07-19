// sandbox_screen.dart

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../config/router/app_router.dart';

class SandboxScreen extends StatelessWidget {
  const SandboxScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final routes = AppRoutes.allRoutes;

    return Scaffold(
      appBar: AppBar(title: const Text('Sandbox')),
      body: ListView.builder(
        itemCount: routes.length,
        itemBuilder: (context, index) {
          final route = routes[index];
          return ListTile(
            title: Text(route),
            trailing: const Icon(Icons.arrow_forward),
            onTap: () => context.go(route),
          );
        },
      ),
    );
  }
}
