import 'package:creet/lib/domain/dto/auth/auth_credential_dto.dart';
import 'package:creet/lib/domain/dto/user/user_dto.dart';

abstract class AuthRepository {
  Future<AuthCredentialDto?> signInWithGoogle();
  Future<AuthCredentialDto?> signInWithApple();
  Future<void> signOut();
  Stream<UserDto?> get authStateChanges;
}
