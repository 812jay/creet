// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$UserEntityImpl _$$UserEntityImplFromJson(Map<String, dynamic> json) =>
    _$UserEntityImpl(
      userId: json['user_id'] as String,
      email: json['email'] as String,
      displayName: json['display_name'] as String?,
      profileUrl: json['profile_url'] as String?,
    );

Map<String, dynamic> _$$UserEntityImplToJson(_$UserEntityImpl instance) =>
    <String, dynamic>{
      'user_id': instance.userId,
      'email': instance.email,
      'display_name': instance.displayName,
      'profile_url': instance.profileUrl,
    };
