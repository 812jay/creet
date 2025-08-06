import 'package:creet/lib/domain/dto/income/income_dto.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'income_entity.freezed.dart';
part 'income_entity.g.dart';

@freezed
class IncomeEntity with _$IncomeEntity {
  const factory IncomeEntity({
    @JsonKey(name: 'id') required String id,
    @JsonKey(name: 'user_id') required String userId,
    @JsonKey(name: 'category_id') required String categoryId,
    @JsonKey(name: 'amount') required String amount,
    @JsonKey(name: 'date') required String date,
    @JsonKey(name: 'description') String? description,
    @JsonKey(name: 'created_at') required DateTime createdAt,
    @JsonKey(name: 'updated_at') required DateTime updatedAt,
  }) = _IncomeEntity;

  factory IncomeEntity.fromJson(Map<String, dynamic> json) =>
      _$IncomeEntityFromJson(json);
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
