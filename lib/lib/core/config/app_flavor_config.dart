import 'package:flutter/widgets.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_flavor/flutter_flavor.dart';

enum AppFlavor { dev, profile, release }

extension AppFlavorExt on AppFlavor {
  String get name => switch (this) {
    AppFlavor.dev => 'dev',
    AppFlavor.profile => 'profile',
    AppFlavor.release => 'release',
  };
}

class AppFlavorConfig {
  static Future<void> setFlavorConfig() async {
    await dotenv.load(fileName: '.env');

    final currentFlavor = _getCurrentFlavor();
    final config = _getFlavorConfig(currentFlavor);

    // 환경변수 누락 체크
    assert(
      config.baseUrl.isNotEmpty && config.anonKey.isNotEmpty,
      'Supabase 환경변수가 누락되었습니다.',
    );

    FlavorConfig(
      name: config.name,
      color: config.color,
      location: BannerLocation.topEnd,
      variables: {"baseUrl": config.baseUrl, "anonKey": config.anonKey},
    );
  }
}

// 내부에서만 사용하는 헬퍼 함수들
AppFlavor _getCurrentFlavor() {
  const String flavorString = String.fromEnvironment(
    'FLAVOR',
    defaultValue: 'release',
  );

  try {
    final result = AppFlavor.values.firstWhere((e) => e.name == flavorString);
    return result;
  } catch (e) {
    // 기본값으로 release 사용
    return AppFlavor.release;
  }
}

FlavorConfigData _getFlavorConfig(AppFlavor flavor) {
  switch (flavor) {
    case AppFlavor.dev:
      return FlavorConfigData(
        name: 'dev',
        color: const Color(0xFF00BFAE),
        baseUrl: dotenv.env['SUPABASE_URL_DEV'] ?? '',
        anonKey: dotenv.env['SUPABASE_ANON_KEY_DEV'] ?? '',
      );
    case AppFlavor.profile:
      return FlavorConfigData(
        name: 'profile',
        color: const Color(0xFFFFC107),
        baseUrl: dotenv.env['SUPABASE_URL_PROD'] ?? '',
        anonKey: dotenv.env['SUPABASE_ANON_KEY_PROD'] ?? '',
      );
    case AppFlavor.release:
      return FlavorConfigData(
        name: 'release',
        color: const Color(0xFF1976D2),
        baseUrl: dotenv.env['SUPABASE_URL_PROD'] ?? '',
        anonKey: dotenv.env['SUPABASE_ANON_KEY_PROD'] ?? '',
      );
  }
}

class FlavorConfigData {
  final String name;
  final Color color;
  final String baseUrl;
  final String anonKey;

  FlavorConfigData({
    required this.name,
    required this.color,
    required this.baseUrl,
    required this.anonKey,
  });
}
