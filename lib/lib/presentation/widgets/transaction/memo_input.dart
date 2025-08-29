import 'package:creet/lib/core/constants/app_colors.dart';
import 'package:creet/lib/core/constants/app_typo.dart';
import 'package:flutter/material.dart';

class MemoInput extends StatelessWidget {
  final String memo;
  final ValueChanged<String> onChanged;
  final int maxLength;

  const MemoInput({
    super.key,
    required this.memo,
    required this.onChanged,
    this.maxLength = 100,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.componentLineDefault),
        borderRadius: BorderRadius.circular(8),
      ),
      child: TextField(
        controller: TextEditingController(text: memo)
          ..selection = TextSelection.fromPosition(
            TextPosition(offset: memo.length),
          ),
        onChanged: onChanged,
        maxLength: maxLength,
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: '메모를 입력하세요 ($maxLength자 이내)',
          hintStyle: AppTypo.body1Medium.copyWith(
            color: AppColors.textSecondary,
          ),
          counterStyle: AppTypo.caption1Regular.copyWith(
            color: AppColors.textSecondary,
          ),
        ),
        style: AppTypo.body1Medium.copyWith(color: AppColors.textPrimary),
        maxLines: 3,
        minLines: 1,
      ),
    );
  }
}
