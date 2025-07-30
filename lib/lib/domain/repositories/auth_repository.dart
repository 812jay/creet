import 'package:creet/lib/domain/dto/auth/auth_credential_dto.dart';
import 'package:creet/lib/domain/dto/user/user_dto.dart';

abstract class AuthRepository {
  Future<AuthCredentialDto?> signinWithGoogle();
  Future<AuthCredentialDto?> signinWithApple();
  Future<void> signOut();
  Future<UserDto?> getCurrentUser();
  Stream<UserDto?> get authStateChanges;
}
