import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:creet/lib/domain/entities/user_entity.dart';

part 'user_dto.freezed.dart';
part 'user_dto.g.dart';

@freezed
class UserDto with _$UserDto {
  const factory UserDto({
    @JsonKey(name: 'user_id') required String userId,
    required String email,
    @JsonKey(name: 'display_name') String? displayName,
    @JsonKey(name: 'profile_url') String? profileUrl,
  }) = _UserDto;

  factory UserDto.fromJson(Map<String, dynamic> json) =>
      _$UserDtoFromJson(json);
}

// 👇 이렇게 extension으로!
extension UserDtoExt on UserDto {
  UserEntity toEntity() => UserEntity(
    id: userId,
    email: email,
    displayName: displayName,
    photoURL: profileUrl,
  );
}
