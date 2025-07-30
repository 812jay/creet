import 'package:creet/lib/domain/dto/user/user_dto.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:gotrue/src/types/user.dart';

part 'user_entity.freezed.dart';
part 'user_entity.g.dart';

@freezed
class UserEntity with _$UserEntity {
  const factory UserEntity({
    @JsonKey(name: 'id') required String userId,
    required String email,
    @JsonKey(name: 'display_name') String? displayName,
    @JsonKey(name: 'profile_url') String? profileUrl,
  }) = _UserEntity;

  factory UserEntity.fromJson(Map<String, dynamic> json) =>
      _$UserEntityFromJson(json);

  factory UserEntity.fromSupabaseUser(User? user) => UserEntity(
    userId: user?.id ?? '',
    email: user?.email ?? '',
    displayName:
        user?.userMetadata?['full_name'] ?? user?.userMetadata?['name'],
    profileUrl: user?.userMetadata?['avatar_url'],
  );

  UserDto toDto() => UserDto(
    id: userId,
    email: email,
    displayName: displayName ?? '',
    photoURL: profileUrl,
  );
}
