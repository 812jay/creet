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

  factory IncomeDto.fromJson(Map<String, dynamic> json) =>
      _$IncomeDtoFromJson(json);
}
