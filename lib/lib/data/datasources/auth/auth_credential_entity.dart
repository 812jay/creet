import 'package:creet/lib/domain/dto/auth/auth_credential_dto.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'auth_credential_entity.freezed.dart';
part 'auth_credential_entity.g.dart';

@freezed
class AuthCredentialEntity with _$AuthCredentialEntity {
  const factory AuthCredentialEntity({
    required String idToken,
    required String provider,
    required String providerId,
    String? email,
    String? displayName,
    String? photoURL,
  }) = _AuthCredentialEntity;

  // 커스텀 fromJson 메서드
  factory AuthCredentialEntity.fromJson(Map<String, dynamic> json) =>
      AuthCredentialEntity(
        idToken: json['id_token'] as String,
        provider: json['provider'] as String,
        providerId: json['provider_id'] as String,
        email: json['email'] as String?,
        displayName: json['display_name'] as String?,
        photoURL: json['photo_url'] as String?,
      );
}

extension AuthCredentialEntityExtensions on AuthCredentialEntity {
  AuthCredentialDto toDto() => AuthCredentialDto(
    idToken: idToken,
    provider: provider,
    providerId: providerId,
    email: email,
    displayName: displayName,
    photoURL: photoURL,
  );
}
