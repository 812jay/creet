import 'package:creet/lib/domain/dto/auth/auth_credential_dto.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'auth_credential_entity.freezed.dart';
part 'auth_credential_entity.g.dart';

@freezed
class AuthCredentialEntity with _$AuthCredentialEntity {
  const factory AuthCredentialEntity({
    @JsonKey(name: 'id_token') required String idToken,
    @JsonKey(name: 'provider') required String provider,
    @JsonKey(name: 'provider_id') required String providerId,
    @JsonKey(name: 'email') String? email,
    @JsonKey(name: 'display_name') String? displayName,
    @JsonKey(name: 'photo_url') String? photoURL,
  }) = _AuthCredentialEntity;

  factory AuthCredentialEntity.fromJson(Map<String, dynamic> json) =>
      _$AuthCredentialEntityFromJson(json);

  AuthCredentialDto toDto() => AuthCredentialDto(
    idToken: idToken,
    provider: provider,
    providerId: providerId,
    email: email,
    displayName: displayName,
    photoURL: photoURL,
  );
}
