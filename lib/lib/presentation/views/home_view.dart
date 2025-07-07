import 'package:creet/lib/core/constants/app_colors.dart';
import 'package:creet/lib/core/constants/app_typo.dart';
import 'package:flutter/material.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Home',
          style: AppTypo.body1Bold.colored(AppColors.textPrimary),
        ),
      ),
      body: Center(
        child: Text(
          'Hello World',
          style: AppTypo.body1Bold.colored(AppColors.textPrimary),
        ),
      ),
    );
  }
}
