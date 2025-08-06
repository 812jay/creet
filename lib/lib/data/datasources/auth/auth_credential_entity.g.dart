// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_credential_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AuthCredentialEntityImpl _$$AuthCredentialEntityImplFromJson(
  Map<String, dynamic> json,
) => _$AuthCredentialEntityImpl(
  idToken: json['idToken'] as String,
  provider: json['provider'] as String,
  providerId: json['providerId'] as String,
  email: json['email'] as String?,
  displayName: json['displayName'] as String?,
  photoURL: json['photoURL'] as String?,
);

Map<String, dynamic> _$$AuthCredentialEntityImplToJson(
  _$AuthCredentialEntityImpl instance,
) => <String, dynamic>{
  'idToken': instance.idToken,
  'provider': instance.provider,
  'providerId': instance.providerId,
  'email': instance.email,
  'displayName': instance.displayName,
  'photoURL': instance.photoURL,
};
