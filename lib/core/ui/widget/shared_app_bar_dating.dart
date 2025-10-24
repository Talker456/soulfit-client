import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SharedAppBar extends StatelessWidget implements PreferredSizeWidget {
  final bool showBackButton;
  final VoidCallback? onBackButtonPressed;
  final Widget? title;
  final List<Widget>? actions;

  const SharedAppBar({
    super.key,
    this.showBackButton = true,
    this.onBackButtonPressed,
    this.title,
    this.actions,
  });

  @override
  Widget build(BuildContext context) {  
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      automaticallyImplyLeading: showBackButton,
      iconTheme: const IconThemeData(color: Colors.black),
      leading: showBackButton
          ? IconButton(
              icon: const Icon(Icons.arrow_back_ios),
              onPressed: onBackButtonPressed ?? () => context.pop(),
            )
          : null,
      title: title ?? const Text(
        'soulfit',
        style: TextStyle(
          color: Color(0xFFD070B9),
          fontSize: 28,
          fontFamily: 'Arima Madurai',
          fontWeight: FontWeight.w700,
        ),
      ),
      actions: actions ?? [
        IconButton(
          icon: const Icon(Icons.send_outlined, color: Colors.black54),
          onPressed: () {},
        ),
        IconButton(
          icon: const Icon(Icons.search, color: Colors.black54),
          onPressed: () {},
        ),
        IconButton(
          icon: const Icon(Icons.settings_outlined, color: Colors.black54),
          onPressed: () {},
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
