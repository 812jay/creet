import 'package:creet/lib/domain/dto/user/user_dto.dart';
import 'package:creet/lib/domain/dto/auth/auth_credential_dto.dart';

abstract class UserRepository {
  Future<void> signUp(AuthCredentialDto credential);
  Future<UserDto?> getCurrentUser();
}
