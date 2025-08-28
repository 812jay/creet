import 'package:creet/lib/core/utils/exceptions/async_wrapper.dart';
import 'package:creet/lib/core/utils/logger.dart';
import 'package:creet/lib/domain/dto/category/category_dto.dart';
import 'package:creet/lib/domain/repositories/category_repository.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class CategoryRepositoryImpl extends CategoryRepository {
  final SupabaseClient _supabaseClient;

  CategoryRepositoryImpl(this._supabaseClient);

  @override
  Future<void> initializeUserCategories(String userId) async {
    await AsyncWrapper.wrap(() async {
      final hasUserCategories = await _supabaseClient
          .from('user_categories')
          .select('*')
          .eq('user_id', userId)
          .limit(1);
      if (hasUserCategories.isNotEmpty) return;

      final categoryTemplates = await _supabaseClient
          .from('category_templates')
          .select('*');

      Logger.debug(
        'categoryTemplates: $categoryTemplates',
        tag: 'UserRepository',
      );

      for (var categoryTemplate in categoryTemplates) {
        await _supabaseClient.from('user_categories').insert({
          'user_id': userId,
          'name': categoryTemplate['name'], // 추가
          'template_id': categoryTemplate['id'], // category_id → template_id
          'type': categoryTemplate['type'], // 추가
          'is_fixed_expense':
              categoryTemplate['is_fixed_expense'] ?? false, // 추가
          'is_active': true, // 추가
          'sort_order': categoryTemplate['sort_order'] ?? 0, // 추가
          'created_at': DateTime.now().toIso8601String(), // 추가
          'updated_at': DateTime.now().toIso8601String(), // 추가
        });
      }
    });
  }

  @override
  Future<List<CategoryDto>> fetchCategories(String userId) async {
    final response = await _supabaseClient
        .from('categories')
        .select('*')
        .eq('user_id', userId);

    return response.map((e) => CategoryDto.fromJson(e)).toList();
  }

  @override
  Future<void> addCategory({
    required String userId,
    required String name,
    required String imageFileName,
    required bool isFixed,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) async {
    await _supabaseClient.from('categories').insert({
      'user_id': userId,
      'name': name,
      'image_file_name': imageFileName,
      'is_fixed': isFixed,
      'created_at': createdAt,
      'updated_at': updatedAt,
    });
  }

  @override
  Future<void> updateCategory(String userId, CategoryDto category) async {
    await _supabaseClient
        .from('categories')
        .update(category.toJson())
        .eq('id', category.id)
        .eq('user_id', userId);
  }

  @override
  Future<void> deleteCategory(String id) async {
    await _supabaseClient.from('categories').delete().eq('id', id);
  }
}
