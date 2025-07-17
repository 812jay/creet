import 'package:flutter/material.dart';

class AuthAppBar extends StatelessWidget implements PreferredSizeWidget {
  final bool isSignedIn;
  final VoidCallback onSignOut;
  final String title;

  const AuthAppBar({
    super.key,
    required this.isSignedIn,
    required this.onSignOut,
    this.title = '',
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(title),
      actions: [
        if (isSignedIn)
          IconButton(
            onPressed: onSignOut,
            icon: const Icon(Icons.logout),
            tooltip: '로그아웃',
          ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
