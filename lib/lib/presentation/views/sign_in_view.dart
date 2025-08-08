import 'package:creet/lib/core/constants/app_colors.dart';
import 'package:creet/lib/core/constants/app_typo.dart';
import 'package:creet/lib/presentation/viewmodels/sign_in/sign_in_view_model.dart';
import 'package:creet/lib/presentation/widgets/auth/sign_in_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

class SignInView extends ConsumerWidget {
  const SignInView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(signInViewModelProvider);
    final authViewModel = ref.read(signInViewModelProvider.notifier);
    final navigationState = authViewModel.navigationState;

    // 네비게이션 상태에 따라 페이지 이동
    if (navigationState != SignInNavigationState.none) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        switch (navigationState) {
          case SignInNavigationState.toMain:
            context.go('/main');
            break;
          case SignInNavigationState.toTerms:
            authState.whenData((credential) {
              if (credential != null) {
                context.push('/terms', extra: {'credential': credential});
              }
            });
            break;
          case SignInNavigationState.none:
            break;
        }
      });
    }

    return Scaffold(
      backgroundColor: AppColors.backgroundDefault,
      body: Center(
        child: Column(
          children: [
            SizedBox(height: 250),
            SvgPicture.asset('assets/icons/logo.svg'),
            SizedBox(height: 10),
            Text(
              '가계부 시작하기',
              style: AppTypo.body1Regular.colored(AppColors.textSecondary),
            ),
            Spacer(),
            Column(
              children: [
                SignInButton(
                  iconPath: 'assets/icons/google.svg',
                  text: '구글로 시작하기',
                  backgroundColor: AppColors.backgroundGoogleSignInButton,
                  isLoading: authViewModel.isSigningIn,
                  onTap: () => authViewModel.signInWithGoogle(),
                ),
                if (authViewModel.isAppleSignInAvailable) ...[
                  const SizedBox(height: 10),
                  SignInButton(
                    iconPath: 'assets/icons/apple.svg',
                    backgroundColor: AppColors.backgroundAppleSignInButton,
                    textColor: AppColors.textInverse,
                    text: 'Apple로 시작하기',
                    isLoading: authViewModel.isSigningIn,
                    onTap: () => authViewModel.signInWithApple(),
                  ),
                ],
              ],
            ),
            SizedBox(height: 80),
          ],
        ),
      ),
    );
  }
}
