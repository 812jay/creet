import 'package:flutter/material.dart';

class SignInButton extends StatelessWidget {
  final VoidCallback onSignIn;
  final String text;
  final IconData? icon;

  const SignInButton({
    super.key,
    required this.onSignIn,
    required this.text,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: onSignIn,
      icon: icon != null ? Icon(icon) : const Icon(Icons.login),
      label: Text(text),
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      ),
    );
  }
}
