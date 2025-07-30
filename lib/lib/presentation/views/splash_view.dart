import 'package:creet/lib/presentation/viewmodels/sign_in/sign_in_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class SplashView extends ConsumerStatefulWidget {
  const SplashView({super.key});

  @override
  ConsumerState<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends ConsumerState<SplashView> {
  bool _hasNavigated = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // 인증 상태 확인
    final authState = ref.watch(signInViewModelProvider);

    // 인증 상태에 따라 네비게이션 (한 번만)
    if (!_hasNavigated) {
      authState.whenData((user) {
        if (!_hasNavigated) {
          _hasNavigated = true;
          // 2초 후에 네비게이션
          Future.delayed(const Duration(seconds: 2), () {
            if (mounted) {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                if (user != null) {
                  context.go('/main');
                } else {
                  context.go('/signin');
                }
              });
            }
          });
        }
      });
    }

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // 앱 로고 또는 아이콘
            const Icon(Icons.flutter_dash, size: 100, color: Colors.white),
            const SizedBox(height: 24),
            // 앱 이름
            const Text(
              'Creet!',
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 48),
            // 로딩 인디케이터
            const CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}
