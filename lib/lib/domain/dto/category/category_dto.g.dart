// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'category_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$CategoryDtoImpl _$$CategoryDtoImplFromJson(Map<String, dynamic> json) =>
    _$CategoryDtoImpl(
      id: json['id'] as String,
      name: json['name'] as String,
      userId: json['userId'] as String,
      templateId: json['templateId'] as String,
      customIconUrl: json['customIconUrl'] as String?,
      type: json['type'] as String,
      isActive: json['isActive'] as bool,
      isFixed: json['isFixed'] as bool,
      sortOrder: (json['sortOrder'] as num).toInt(),
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$$CategoryDtoImplToJson(_$CategoryDtoImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'userId': instance.userId,
      'templateId': instance.templateId,
      'customIconUrl': instance.customIconUrl,
      'type': instance.type,
      'isActive': instance.isActive,
      'isFixed': instance.isFixed,
      'sortOrder': instance.sortOrder,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
    };
