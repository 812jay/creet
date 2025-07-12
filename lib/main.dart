import 'package:creet/lib/presentation/views/sign_in_view.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await dotenv.load(fileName: '.env');

  await GoogleSignIn.instance.initialize(
    clientId: dotenv.env['GOOGLE_CLIENT_ID_DEV'] ?? '',
    serverClientId: dotenv.env['GOOGLE_SERVER_CLIENT_ID_DEV'] ?? '',
  );

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
