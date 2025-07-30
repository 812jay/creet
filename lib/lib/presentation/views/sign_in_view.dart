import 'package:creet/lib/core/constants/app_colors.dart';
import 'package:creet/lib/presentation/viewmodels/sign_in/sign_in_view_model.dart';
import 'package:creet/lib/presentation/widgets/auth/sign_in_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class SignInView extends ConsumerWidget {
  const SignInView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(signInViewModelProvider);
    final authViewModel = ref.read(signInViewModelProvider.notifier);
    final isSigningIn = authViewModel.isSigningIn;

    // 인증 성공 시 이용약관 페이지로 이동
    authState.whenData((credential) {
      if (credential != null && !isSigningIn) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          context.go('/terms', extra: {'credential': credential});
        });
      }
    });

    return Scaffold(
      backgroundColor: AppColors.backgroundDefault,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Creet Sign In',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 40),
            Column(
              children: [
                SignInButton(
                  iconPath: 'assets/icons/google.svg',
                  text: 'Google 로그인',
                  onTap: () => authViewModel.signInWithGoogle(),
                ),
                if (authViewModel.isAppleSignInAvailable) ...[
                  const SizedBox(height: 10),
                  SignInButton(
                    iconPath: 'assets/icons/apple.svg',
                    backgroundColor: AppColors.backgroundAppleSignInButton,
                    textColor: AppColors.textInverse,
                    text: 'Apple 로그인',
                    onTap: () => authViewModel.signInWithApple(),
                  ),
                ],
              ],
            ),
          ],
        ),
      ),
    );
  }
}
