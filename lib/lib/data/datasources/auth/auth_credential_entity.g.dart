// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_credential_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AuthCredentialEntityImpl _$$AuthCredentialEntityImplFromJson(
  Map<String, dynamic> json,
) => _$AuthCredentialEntityImpl(
  idToken: json['id_token'] as String,
  provider: json['provider'] as String,
  providerId: json['provider_id'] as String,
  email: json['email'] as String?,
  displayName: json['display_name'] as String?,
  photoURL: json['photo_url'] as String?,
);

Map<String, dynamic> _$$AuthCredentialEntityImplToJson(
  _$AuthCredentialEntityImpl instance,
) => <String, dynamic>{
  'id_token': instance.idToken,
  'provider': instance.provider,
  'provider_id': instance.providerId,
  'email': instance.email,
  'display_name': instance.displayName,
  'photo_url': instance.photoURL,
};
