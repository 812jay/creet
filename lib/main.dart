import 'package:creet/lib/core/config/supabase_config.dart';
import 'package:creet/lib/presentation/views/sign_in_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await SupabaseConfig.initialize();

  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Creet',
      theme: ThemeData(primarySwatch: Colors.blue, useMaterial3: true),
      home: const SignInView(),
    );
  }
}
