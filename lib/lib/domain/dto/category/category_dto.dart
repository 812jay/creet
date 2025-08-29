import 'package:freezed_annotation/freezed_annotation.dart';

part 'category_dto.freezed.dart';
part 'category_dto.g.dart';

@freezed
class CategoryDto with _$CategoryDto {
  const factory CategoryDto({
    required String id,
    required String name,
    required String userId,
    required String templateId,
    String? customIconUrl,
    required String type,
    required bool isActive,
    required bool isFixed,
    required int sortOrder,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _CategoryDto;

  factory CategoryDto.fromJson(Map<String, dynamic> json) => CategoryDto(
    id: json['id'] as String,
    userId: json['user_id'] as String,
    name: json['name'] as String,
    templateId: json['template_id'] as String,
    type: json['type'] as String,
    isActive: json['is_active'] as bool,
    sortOrder: json['sort_order'] as int,
    isFixed: json['is_fixed'] as bool,
    customIconUrl: json['custom_icon_url'] as String?,
    createdAt: DateTime.parse(json['created_at'] as String),
    updatedAt: DateTime.parse(json['updated_at'] as String),
  );
}
