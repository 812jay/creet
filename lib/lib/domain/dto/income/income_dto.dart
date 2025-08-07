import 'package:freezed_annotation/freezed_annotation.dart';

part 'income_dto.freezed.dart';
part 'income_dto.g.dart';

@freezed
class IncomeDto with _$IncomeDto {
  const factory IncomeDto({
    required String id,
    required String userId,
    required String categoryId,
    required String amount,
    required String date,
    String? description,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _IncomeDto;

  factory IncomeDto.fromJson(Map<String, dynamic> json) => IncomeDto(
    id: json['id'] as String,
    userId: json['user_id'] as String,
    categoryId: json['category_id'] as String,
    amount: json['amount'] as String,
    date: json['date'] as String,
    description: json['description'] as String?,
    createdAt: DateTime.parse(json['created_at'] as String),
    updatedAt: DateTime.parse(json['updated_at'] as String),
  );
}
