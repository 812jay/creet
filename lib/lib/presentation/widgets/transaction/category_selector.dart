import 'package:creet/lib/core/constants/app_colors.dart';
import 'package:creet/lib/core/constants/app_typo.dart';
import 'package:creet/lib/domain/dto/category/category_dto.dart';
import 'package:flutter/material.dart';

class CategorySelector extends StatelessWidget {
  final CategoryDto? selectedCategory;
  final List<CategoryDto> categorieList;
  final ValueChanged<CategoryDto> onSelected;

  const CategorySelector({
    super.key,
    required this.selectedCategory,
    required this.categorieList,
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
                selectedCategory == null
                    ? '카테고리를 선택해 주세요'
                    : selectedCategory!.name,
                style:
                    selectedCategory == null
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
              itemCount: categorieList.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(
                    categorieList[index].name,
                    style: AppTypo.body1Medium,
                  ),
                  onTap: () {
                    onSelected(categorieList[index]);
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
