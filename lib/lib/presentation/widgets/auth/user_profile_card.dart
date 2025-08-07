import 'package:creet/lib/core/constants/app_colors.dart';
import 'package:creet/lib/core/constants/app_typo.dart';
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
    return Container(
      padding: const EdgeInsets.all(20),
      margin: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.componentFillPrimary,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: AppColors.componentLineDefault,
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          _ProfileAvatar(user: user),
          const SizedBox(height: 16),
          _UserInfo(user: user),
          const SizedBox(height: 20),
          _SignOutButton(onSignOut: onSignOut),
        ],
      ),
    );
  }
}

class _ProfileAvatar extends StatelessWidget {
  final UserDto user;

  const _ProfileAvatar({required this.user});

  @override
  Widget build(BuildContext context) {
    final imageService = ImageService();
    final avatarUrl = imageService.getAvatarUrl(user.avatarUrl);

    return CircleAvatar(
      radius: 40,
      backgroundColor: AppColors.componentFillSecondary,
      backgroundImage: avatarUrl != null ? NetworkImage(avatarUrl) : null,
      child:
          avatarUrl == null
              ? Icon(Icons.person, size: 40, color: AppColors.textSecondary)
              : null,
    );
  }
}

class _UserInfo extends StatelessWidget {
  final UserDto user;

  const _UserInfo({required this.user});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(user.displayName, style: AppTypo.title1Bold),
        const SizedBox(height: 4),
        Text(
          user.email,
          style: AppTypo.body2Regular.colored(AppColors.textSecondary),
        ),
      ],
    );
  }
}

class _SignOutButton extends StatelessWidget {
  final VoidCallback onSignOut;

  const _SignOutButton({required this.onSignOut});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: onSignOut,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.statusError,
          foregroundColor: AppColors.textInverse,
          padding: const EdgeInsets.symmetric(vertical: 12),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
        child: const Text('로그아웃'),
      ),
    );
  }
}
