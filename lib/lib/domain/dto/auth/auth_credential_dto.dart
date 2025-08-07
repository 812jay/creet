import 'package:freezed_annotation/freezed_annotation.dart';

part 'auth_credential_dto.freezed.dart';
part 'auth_credential_dto.g.dart';

@freezed
class AuthCredentialDto with _$AuthCredentialDto {
  const factory AuthCredentialDto({
    required String idToken,
    required String provider,
    required String providerId,
    String? email,
    String? displayName,
    String? photoURL,
  }) = _AuthCredentialDto;

  // 커스텀 fromJson 메서드
  factory AuthCredentialDto.fromJson(Map<String, dynamic> json) =>
      AuthCredentialDto(
        idToken: json['id_token'] as String,
        provider: json['provider'] as String,
        providerId: json['provider_id'] as String,
        email: json['email'] as String?,
        displayName: json['display_name'] as String?,
        photoURL: json['photo_url'] as String?,
      );
}
