import 'package:creet/lib/core/constants/app_colors.dart';
import 'package:creet/lib/core/constants/app_typo.dart';
import 'package:flutter/material.dart';

class CategorySelector extends StatelessWidget {
  final String selectedCategory;
  final List<String> categories;
  final ValueChanged<String> onSelected;

  const CategorySelector({
    super.key,
    required this.selectedCategory,
    required this.categories,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _showCategoryDialog(context),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        decoration: BoxDecoration(
          border: Border.all(color: AppColors.componentLineDefault),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [
            Expanded(
              child: Text(
                selectedCategory.isEmpty ? '카테고리를 선택해 주세요' : selectedCategory,
                style:
                    selectedCategory.isEmpty
                        ? AppTypo.body1Medium.copyWith(
                          color: AppColors.textSecondary,
                        )
                        : AppTypo.body1Medium.copyWith(
                          color: AppColors.textPrimary,
                        ),
              ),
            ),
            Icon(Icons.chevron_right, color: AppColors.textSecondary, size: 20),
          ],
        ),
      ),
    );
  }

  void _showCategoryDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) {
        return AlertDialog(
          title: Text('카테고리 선택', style: AppTypo.title1Bold),
          content: SizedBox(
            width: double.maxFinite,
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: categories.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(categories[index], style: AppTypo.body1Medium),
                  onTap: () {
                    onSelected(categories[index]);
                    Navigator.of(context).pop();
                  },
                );
              },
            ),
          ),
        );
      },
    );
  }
}
