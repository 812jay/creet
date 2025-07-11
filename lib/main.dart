import 'package:creet/lib/presentation/views/sign_in_test_view.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await dotenv.load(fileName: '.env');

  await GoogleSignIn.instance.initialize(
    clientId: dotenv.env['GOOGLE_CLIENT_ID_DEV'] ?? '',
    serverClientId: dotenv.env['GOOGLE_SERVER_CLIENT_ID_DEV'] ?? '',
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(title: 'Flutter Demo', home: SignInTestView());
  }
}
