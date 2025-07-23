import 'package:creet/lib/core/config/app_flavor_config.dart';
import 'package:creet/lib/core/config/supabase_config.dart';
import 'package:creet/lib/core/di/service_locator.dart';
import 'package:creet/lib/core/router/app_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_flavor/flutter_flavor.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  //  환경변수 설정
  await AppFlavorConfig.setFlavorConfig();

  // Supabase 초기화
  await SupabaseConfig.initialize();

  // Service Locator 초기화
  await ServiceLocator.initialize();

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
        routerConfig: router,
      ),
    );
  }
}
