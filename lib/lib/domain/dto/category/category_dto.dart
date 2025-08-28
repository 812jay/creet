import 'package:freezed_annotation/freezed_annotation.dart';

part 'category_dto.freezed.dart';
part 'category_dto.g.dart';

@freezed
class CategoryDto with _$CategoryDto {
  const factory CategoryDto({
    required String id,
    required String name,
    required String userId,
    String? imageFileName,
    required bool isFixed,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _CategoryDto;

  factory CategoryDto.fromJson(Map<String, dynamic> json) => CategoryDto(
    id: json['id'] as String,
    userId: json['user_id'] as String,
    name: json['name'] as String,
    imageFileName: json['image_file_name'] as String,
    isFixed: json['is_fixed'] as bool,
    createdAt: DateTime.parse(json['created_at'] as String),
    updatedAt: DateTime.parse(json['updated_at'] as String),
  );
}
