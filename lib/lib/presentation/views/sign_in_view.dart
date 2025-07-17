import 'package:creet/lib/presentation/viewmodels/auth_viewmodel.dart';
import 'package:creet/lib/presentation/widgets/auth/auth_app_bar.dart';
import 'package:creet/lib/presentation/widgets/auth/user_profile_card.dart';
import 'package:creet/lib/presentation/widgets/auth/sign_in_button.dart';
import 'package:creet/lib/presentation/widgets/common/loading_indicator.dart';
import 'package:creet/lib/presentation/widgets/common/error_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SignInView extends ConsumerWidget {
  const SignInView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authViewModelProvider);
    final authViewModel = ref.read(authViewModelProvider.notifier);

    return Scaffold(
      appBar: AuthAppBar(
        isSignedIn: authState.value != null,
        onSignOut: () => authViewModel.signOut(),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: authState.when(
            data: (user) {
              if (user != null) {
                return UserProfileCard(
                  user: user,
                  onSignOut: () => authViewModel.signOut(),
                );
              } else {
                return Column(
                  children: [
                    SignInButton(
                      text: 'Google 로그인',
                      onSignIn: () => authViewModel.signInWithGoogle(),
                    ),
                    if (authViewModel.isAppleSignInAvailable) ...[
                      SizedBox(height: 10),
                      SignInButton(
                        text: 'Apple 로그인',
                        onSignIn: () => authViewModel.signInWithApple(),
                      ),
                    ],
                  ],
                );
              }
            },
            loading: () => const LoadingIndicator(),
            error:
                (error, stack) => CustomErrorWidget(
                  message: error.toString(),
                  onRetry: () => authViewModel.retryLastSignIn(),
                ),
          ),
        ),
      ),
    );
  }
}
