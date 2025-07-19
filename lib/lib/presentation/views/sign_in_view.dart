import 'package:creet/lib/presentation/viewmodels/sign_in/sign_in_view_model.dart';
import 'package:creet/lib/presentation/widgets/auth/auth_app_bar.dart';
import 'package:creet/lib/presentation/widgets/auth/sign_in_button.dart';
import 'package:creet/lib/presentation/widgets/common/loading_indicator.dart';
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

    // 로그인 성공 시 Home으로 이동
    authState.whenData((user) {
      if (user != null && !isSigningIn) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          context.go('/home');
        });
      }
    });

    return Scaffold(
      appBar: AuthAppBar(
        isSignedIn: false,
        onSignOut: () => authViewModel.signOut(),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Creet Sign In',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 40),
            // 로그인 진행 중일 때만 로딩 인디케이터 표시
            if (isSigningIn) ...[
              const LoadingIndicator(),
              const SizedBox(height: 20),
              const Text('로그인 중...', style: TextStyle(fontSize: 16)),
            ] else ...[
              SignInButton(
                text: 'Google 로그인',
                onSignIn: () => authViewModel.signInWithGoogle(),
              ),
              if (authViewModel.isAppleSignInAvailable) ...[
                const SizedBox(height: 10),
                SignInButton(
                  text: 'Apple 로그인',
                  onSignIn: () => authViewModel.signInWithApple(),
                ),
              ],
            ],
          ],
        ),
      ),
    );
  }
}
