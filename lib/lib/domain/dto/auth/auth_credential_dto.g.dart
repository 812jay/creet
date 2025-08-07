// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_credential_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AuthCredentialDtoImpl _$$AuthCredentialDtoImplFromJson(
  Map<String, dynamic> json,
) => _$AuthCredentialDtoImpl(
  idToken: json['idToken'] as String,
  provider: json['provider'] as String,
  providerId: json['providerId'] as String,
  email: json['email'] as String?,
  displayName: json['displayName'] as String?,
  photoURL: json['photoURL'] as String?,
);

Map<String, dynamic> _$$AuthCredentialDtoImplToJson(
  _$AuthCredentialDtoImpl instance,
) => <String, dynamic>{
  'idToken': instance.idToken,
  'provider': instance.provider,
  'providerId': instance.providerId,
  'email': instance.email,
  'displayName': instance.displayName,
  'photoURL': instance.photoURL,
};
