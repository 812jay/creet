import 'package:freezed_annotation/freezed_annotation.dart';

part 'expense_res_dto.freezed.dart';
part 'expense_res_dto.g.dart';

@freezed
class ExpenseResDto with _$ExpenseResDto {
  const factory ExpenseResDto({
    required String id,
    required String userId,
    required String categoryId,
    required String amount,
    required DateTime date,
    String? description,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _ExpenseResDto;

  factory ExpenseResDto.fromJson(Map<String, dynamic> json) => ExpenseResDto(
    id: json['id'] as String,
    userId: json['user_id'] as String,
    categoryId: json['category_id'] as String,
    amount: json['amount'] as String,
    date: json['date'] as DateTime,
    description: json['description'] as String?,
    createdAt: DateTime.parse(json['created_at'] as String),
    updatedAt: DateTime.parse(json['updated_at'] as String),
  );
}
