import 'package:creet/lib/core/constants/app_colors.dart';
import 'package:creet/lib/core/constants/app_typo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SignInButton extends StatelessWidget {
  final VoidCallback onTap;
  final String text;
  final String? iconPath;
  final Color backgroundColor;
  final Color textColor;
  final bool isLoading;

  const SignInButton({
    super.key,
    required this.onTap,
    required this.text,
    this.iconPath,
    this.backgroundColor = AppColors.backgroundDefault,
    this.textColor = AppColors.textPrimary,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: isLoading ? null : onTap,
      child: Container(
        width: 343,
        height: 48,
        decoration: BoxDecoration(
          color: isLoading ? backgroundColor.withOpacity(0.6) : backgroundColor,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.black, width: 1),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (isLoading)
              SizedBox(
                width: 16,
                height: 16,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation<Color>(textColor),
                ),
              )
            else if (iconPath != null)
              SvgPicture.asset(iconPath!),
            SizedBox(width: 8),
            Text(
              isLoading ? '로그인 중...' : text,
              style: AppTypo.body1Medium.colored(textColor),
            ),
          ],
        ),
      ),
    );
  }
}
