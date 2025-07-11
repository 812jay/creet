import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class SignInTestView extends StatelessWidget {
  const SignInTestView({super.key});

  Future<void> _signInWithGoogle(BuildContext context) async {
    final account = await GoogleSignIn.instance.authenticate();
    try {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('로그인 성공: ${account.displayName ?? account.email}'),
          ),
        );
      }
    } catch (e) {
      log(e.toString());
      if (context.mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('로그인 실패: $e')));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Google Sign-In Test')),
      body: Center(
        child: ElevatedButton(
          onPressed: () => _signInWithGoogle(context),
          child: const Text('Google 로그인 테스트'),
        ),
      ),
    );
  }
}
