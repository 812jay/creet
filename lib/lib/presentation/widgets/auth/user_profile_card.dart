import 'package:creet/lib/core/service/image_service.dart';
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
    final imageService = ImageService();
    final avatarUrl = imageService.getAvatarUrl(user.avatarUrl);

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (avatarUrl != null)
          CircleAvatar(
            radius: 50,
            backgroundImage: NetworkImage(avatarUrl),
            onBackgroundImageError: (exception, stackTrace) {
              print('이미지 로드 실패: $exception');
            },
          )
        else
          CircleAvatar(
            radius: 50,
            backgroundColor: Colors.grey[300],
            child: Icon(Icons.person, size: 50, color: Colors.grey[600]),
          ),
        const SizedBox(height: 16),
        Text('환영합니다!', style: Theme.of(context).textTheme.headlineSmall),
        const SizedBox(height: 8),
        Text(
          user.nickname ?? user.email,
          style: Theme.of(context).textTheme.bodyLarge,
        ),
        const SizedBox(height: 24),
        ElevatedButton(onPressed: onSignOut, child: const Text('로그아웃')),
      ],
    );
  }
}
