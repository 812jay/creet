import 'package:creet/lib/core/constants/app_colors.dart';
import 'package:creet/lib/core/constants/app_typo.dart';
import 'package:creet/lib/presentation/viewmodels/home/home_view_model.dart';
import 'package:creet/lib/presentation/widgets/auth/user_profile_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

class HomeView extends ConsumerWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final homeState = ref.watch(homeViewModelProvider);
    final homeViewModel = ref.read(homeViewModelProvider.notifier);

    // 로그아웃 시 SignIn으로 이동
    homeState.whenData((state) {
      if (state.user == null) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          context.go('/signin');
        });
      }
    });

    return PopScope(
      canPop: false, // 뒤로가기 방지
      child: Scaffold(
        backgroundColor: AppColors.backgroundDefault,
        body: homeState.when(
          data: (state) {
            if (state.user != null) {
              return SingleChildScrollView(
                child: Center(
                  child: Column(
                    children: [
                      HomeAppBar(),
                      UserProfileCard(
                        user: state.user!,
                        onSignOut: () => homeViewModel.signOut(),
                      ),
                    ],
                  ),
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

class HomeAppBar extends ConsumerWidget {
  const HomeAppBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AppBar(
      backgroundColor: AppColors.backgroundDefault,
      title: SvgPicture.asset(
        'assets/icons/appbar_logo.svg',
        width: 67,
        height: 26,
      ),
      actions: [
        GestureDetector(
          onTap: () {},
          child: Text(
            '예산설정',
            style: AppTypo.body2Bold.colored(AppColors.primary),
          ),
        ),
      ],
      actionsPadding: EdgeInsets.only(right: 16),
    );
  }
}
