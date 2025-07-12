import 'package:creet/lib/presentation/viewmodels/auth_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SignInView extends ConsumerWidget {
  const SignInView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authViewModelProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Sign-In'),
        actions: [
          if (authState.value != null)
            IconButton(
              onPressed:
                  () => ref.read(authViewModelProvider.notifier).signOut(),
              icon: const Icon(Icons.logout),
            ),
        ],
      ),
      body: Center(
        child: authState.when(
          data: (user) {
            if (user != null) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (user.photoURL != null)
                    CircleAvatar(
                      radius: 50,
                      backgroundImage: NetworkImage(user.photoURL!),
                    ),
                  const SizedBox(height: 16),
                  Text(
                    '환영합니다!',
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    user.displayName ?? user.email,
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  const SizedBox(height: 24),
                  ElevatedButton(
                    onPressed:
                        () =>
                            ref.read(authViewModelProvider.notifier).signOut(),
                    child: const Text('로그아웃'),
                  ),
                ],
              );
            } else {
              return ElevatedButton(
                onPressed:
                    () =>
                        ref
                            .read(authViewModelProvider.notifier)
                            .signInWithGoogle(),
                child: const Text('Google 로그인'),
              );
            }
          },
          loading: () => const CircularProgressIndicator(),
          error:
              (error, stack) => Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('오류: $error'),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed:
                        () =>
                            ref
                                .read(authViewModelProvider.notifier)
                                .signInWithGoogle(),
                    child: const Text('다시 시도'),
                  ),
                ],
              ),
        ),
      ),
    );
  }
}
