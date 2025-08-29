import 'package:creet/lib/core/constants/app_colors.dart';
import 'package:creet/lib/core/constants/app_typo.dart';
import 'package:creet/lib/core/constants/enum/transaction_enum.dart';
import 'package:flutter/material.dart';

class EntryTypeTabBar extends StatelessWidget {
  final TransactionType selectedType;
  final ValueChanged<TransactionType> onChanged;

  const EntryTypeTabBar({
    super.key,
    required this.selectedType,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          _TabButton(
            text: '지출',
            isSelected: selectedType == TransactionType.expense,
            onTap: () => onChanged(TransactionType.expense),
          ),
          const SizedBox(width: 32),
          _TabButton(
            text: '수입',
            isSelected: selectedType == TransactionType.income,
            onTap: () => onChanged(TransactionType.income),
          ),
        ],
      ),
    );
  }
}

class _TabButton extends StatelessWidget {
  final String text;
  final bool isSelected;
  final VoidCallback onTap;

  const _TabButton({
    required this.text,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Text(
            text,
            style:
                isSelected
                    ? AppTypo.title1Bold.copyWith(color: AppColors.textPrimary)
                    : AppTypo.title1Medium.copyWith(
                      color: AppColors.textSecondary,
                    ),
          ),
          const SizedBox(height: 8),
          Container(
            width: 40,
            height: 2,
            decoration: BoxDecoration(
              color: isSelected ? AppColors.textPrimary : Colors.transparent,
              borderRadius: BorderRadius.circular(1),
            ),
          ),
        ],
      ),
    );
  }
}
