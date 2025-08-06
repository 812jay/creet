// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'income_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$IncomeEntityImpl _$$IncomeEntityImplFromJson(Map<String, dynamic> json) =>
    _$IncomeEntityImpl(
      id: json['id'] as String,
      userId: json['user_id'] as String,
      categoryId: json['category_id'] as String,
      amount: json['amount'] as String,
      date: json['date'] as String,
      description: json['description'] as String?,
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
    );

Map<String, dynamic> _$$IncomeEntityImplToJson(_$IncomeEntityImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'user_id': instance.userId,
      'category_id': instance.categoryId,
      'amount': instance.amount,
      'date': instance.date,
      'description': instance.description,
      'created_at': instance.createdAt.toIso8601String(),
      'updated_at': instance.updatedAt.toIso8601String(),
    };
