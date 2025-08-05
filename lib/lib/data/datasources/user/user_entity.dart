import 'package:creet/lib/domain/dto/user/user_dto.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_entity.freezed.dart';
part 'user_entity.g.dart';

@freezed
class UserEntity with _$UserEntity {
  const factory UserEntity({
    @JsonKey(name: 'id') required String id,
    @JsonKey(name: 'email') required String email,
    @JsonKey(name: 'provider') required String provider,
    @JsonKey(name: 'provider_id') required String providerId,
    @JsonKey(name: 'nickname') String? nickname,
    @JsonKey(name: 'avatar_url') String? avatarUrl,
    @JsonKey(name: 'created_at') DateTime? createdAt,
    @JsonKey(name: 'updated_at') DateTime? updatedAt,
  }) = _UserEntity;

  factory UserEntity.fromJson(Map<String, dynamic> json) =>
      _$UserEntityFromJson(json);

  UserDto toDto() => UserDto(
    id: id,
    email: email,
    provider: provider,
    providerId: providerId,
    nickname: nickname,
    avatarUrl: avatarUrl,
    createdAt: createdAt,
    updatedAt: updatedAt,
  );
}
