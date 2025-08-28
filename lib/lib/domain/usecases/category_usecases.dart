import 'package:creet/lib/domain/dto/category/category_dto.dart';
import 'package:creet/lib/domain/repositories/category_repository.dart';

class CategoryUseCase {
  final CategoryRepository _categoryRepository;

  CategoryUseCase(this._categoryRepository);

  Future<void> addCategory({
    required String userId,
    required String name,
    required String imageFileName,
    required bool isFixed,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) async {
    return _categoryRepository.addCategory(
      userId: userId,
      name: name,
      imageFileName: imageFileName,
      isFixed: isFixed,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }

  Future<void> updateCategory(String userId, CategoryDto category) async {
    return _categoryRepository.updateCategory(userId, category);
  }

  Future<void> deleteCategory(String id) async {
    return _categoryRepository.deleteCategory(id);
  }

  Future<List<CategoryDto>> fetchCategories(String userId) async {
    return _categoryRepository.fetchCategories(userId);
  }
}
