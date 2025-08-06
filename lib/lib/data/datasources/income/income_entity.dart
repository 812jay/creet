import 'package:creet/lib/domain/dto/income/income_dto.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'income_entity.freezed.dart';
part 'income_entity.g.dart';

@freezed
class IncomeEntity with _$IncomeEntity {
  const factory IncomeEntity({
    required String id,
    required String userId,
    required String categoryId,
    required String amount,
    required String date,
    String? description,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _IncomeEntity;

  factory IncomeEntity.fromJson(Map<String, dynamic> json) => IncomeEntity(
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

extension IncomeEntityExtensions on IncomeEntity {
  IncomeDto toDto() => IncomeDto(
    id: id,
    userId: userId,
    categoryId: categoryId,
    amount: amount,
    date: date,
    description: description,
    createdAt: createdAt,
    updatedAt: updatedAt,
  );
}
