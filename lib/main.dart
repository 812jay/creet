import 'package:creet/lib/core/config/app_flavor_config.dart';
import 'package:creet/lib/core/config/supabase_config.dart';
import 'package:creet/lib/core/di/service_locator.dart';
import 'package:creet/lib/core/router/app_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_flavor/flutter_flavor.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/date_symbol_data_local.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  //  환경변수 설정
  await AppFlavorConfig.setFlavorConfig();

  // Supabase 초기화
  await SupabaseConfig.initialize();

  // Service Locator 초기화
  await ServiceLocator.initialize();

  // 한국어 locale 초기화
  await initializeDateFormatting('ko_KR', null);

  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(routerProvider);

    return FlavorBanner(
      child: MaterialApp.router(
        title: 'Creet',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(primarySwatch: Colors.blue, useMaterial3: true),
        supportedLocales: const [Locale('ko', 'KR'), Locale('en', 'US')],
        localizationsDelegates: const [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        routerConfig: router,
      ),
    );
  }
}
