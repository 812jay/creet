import 'package:creet/lib/domain/dto/auth/auth_credential_dto.dart';
import 'package:creet/lib/presentation/views/calendar/calendar_view.dart';
import 'package:creet/lib/presentation/views/income_expense/add_income_expense_view.dart';
import 'package:creet/lib/presentation/views/main_view.dart';
import 'package:creet/lib/presentation/views/setting_view.dart';
import 'package:creet/lib/presentation/views/sign_in_view.dart';
import 'package:creet/lib/presentation/views/terms_of_service_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:creet/lib/presentation/views/splash_view.dart';
import 'package:creet/lib/presentation/views/home_view.dart';

// 라우터 Provider
final routerProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(
        path: '/',
        name: 'splash',
        builder: (context, state) => const SplashView(),
      ),
      GoRoute(
        path: '/main',
        name: 'main',
        builder: (context, state) => MainView(),
      ),
      GoRoute(
        path: '/signin',
        name: 'signin',
        builder: (context, state) => const SignInView(),
      ),
      GoRoute(
        path: '/home',
        name: 'home',
        builder: (context, state) => const HomeView(),
      ),
      GoRoute(
        path: '/calendar',
        name: 'calendar',
        builder: (context, state) => const CalendarView(),
      ),
      GoRoute(
        path: '/setting',
        name: 'setting',
        builder: (context, state) => const SettingView(),
      ),
      GoRoute(
        path: '/terms',
        name: 'terms',
        builder: (context, state) {
          final extra = state.extra as Map<String, dynamic>?;
          final credential = extra?['credential'] as AuthCredentialDto?;

          if (credential == null) {
            // credential이 없으면 로그인 화면으로 리다이렉트
            WidgetsBinding.instance.addPostFrameCallback((_) {
              showDialog(
                context: context,
                barrierDismissible: false,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: const Text('오류'),
                    content: const Text('인증 정보를 찾을 수 없습니다.\n로그인을 다시 진행해주세요.'),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                          context.go('/signin');
                        },
                        child: const Text('확인'),
                      ),
                    ],
                  );
                },
              );
            });
            return const SignInView();
          }

          return TermsOfServiceView(credential: credential);
        },
      ),
      GoRoute(
        path: '/incomeExpense',
        name: 'incomeExpense',
        builder: (context, state) {
          final extra = state.extra as Map<String, dynamic>?;
          final initialDay =
              extra != null ? extra['initialDay'] as DateTime : DateTime.now();
          return AddIncomeExpenseView(initialDay: initialDay);
        },
      ),
    ],
  );
});
