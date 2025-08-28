import 'package:creet/lib/domain/dto/category/category_dto.dart';

abstract class CategoryRepository {
  Future<void> initializeUserCategories(String userId);
  Future<List<CategoryDto>> fetchCategories(String userId);

  Future<void> addCategory({
    required String userId,
    required String name,
    required String imageFileName,
    required bool isFixed,
    required DateTime createdAt,
    required DateTime updatedAt,
  });

  Future<void> updateCategory(String userId, CategoryDto category);

  Future<void> deleteCategory(String id);
}
