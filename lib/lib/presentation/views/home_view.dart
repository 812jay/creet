import 'package:creet/lib/core/constants/app_colors.dart';
import 'package:creet/lib/core/constants/app_typo.dart';
import 'package:creet/lib/presentation/viewmodels/sign_in/sign_in_view_model.dart';
import 'package:creet/lib/presentation/widgets/auth/user_profile_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class HomeView extends ConsumerWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(signInViewModelProvider);
    final authViewModel = ref.read(signInViewModelProvider.notifier);

    // 로그아웃 시 SignIn으로 이동
    authState.whenData((user) {
      if (user == null) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          context.go('/signin');
        });
      }
    });

    return PopScope(
      canPop: false, // 뒤로가기 방지
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Home',
            style: AppTypo.body1Bold.colored(AppColors.textPrimary),
          ),
          actions: [
            IconButton(
              onPressed: () => authViewModel.signOut(),
              icon: const Icon(Icons.logout),
              tooltip: '로그아웃',
            ),
          ],
        ),
        body: authState.when(
          data: (user) {
            if (user != null) {
              return Center(
                child: UserProfileCard(
                  user: user,
                  onSignOut: () => authViewModel.signOut(),
                ),
              );
            } else {
              return const Center(child: Text('사용자 정보를 불러올 수 없습니다.'));
            }
          },
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (error, stack) => Center(child: Text('에러: $error')),
        ),
      ),
    );
  }
}
