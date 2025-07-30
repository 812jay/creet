import 'package:creet/lib/domain/dto/user/user_dto.dart';
import 'package:flutter/material.dart';

class UserProfileCard extends StatelessWidget {
  final UserDto user;
  final VoidCallback onSignOut;

  const UserProfileCard({
    super.key,
    required this.user,
    required this.onSignOut,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (user.photoURL != null)
          CircleAvatar(
            radius: 50,
            backgroundImage: NetworkImage(user.photoURL!),
          ),
        const SizedBox(height: 16),
        Text('환영합니다!', style: Theme.of(context).textTheme.headlineSmall),
        const SizedBox(height: 8),
        Text(
          user.displayName ?? user.email,
          style: Theme.of(context).textTheme.bodyLarge,
        ),
        const SizedBox(height: 24),
        ElevatedButton(onPressed: onSignOut, child: const Text('로그아웃')),
      ],
    );
  }
}
