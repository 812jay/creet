import 'package:creet/lib/presentation/views/calendar_view.dart';
import 'package:creet/lib/presentation/views/main_view.dart';
import 'package:creet/lib/presentation/views/setting_view.dart';
import 'package:creet/lib/presentation/views/sign_in_view.dart';
import 'package:creet/lib/presentation/views/terms_of_service_view.dart';
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
          final credential = state.extra as Map<String, dynamic>?;
          return TermsOfServiceView(credential: credential?['credential']);
        },
      ),
    ],
  );
});
