import 'package:creet/lib/domain/dto/auth/auth_credential_dto.dart';
import 'package:creet/lib/domain/dto/user/user_dto.dart';
import 'package:creet/lib/domain/repositories/auth_repository.dart';

class AuthUseCase {
  final AuthRepository _authRepository;

  AuthUseCase(this._authRepository);

  Future<AuthCredentialDto?> signInWithGoogle() async {
    final result = await _authRepository.signInWithGoogle();
    return result;
  }

  Future<AuthCredentialDto?> signInWithApple() async {
    final result = await _authRepository.signInWithApple();
    return result;
  }

  Future<void> signOut() async {
    await _authRepository.signOut();
  }

  Stream<UserDto?> getAuthStateChanges() {
    return _authRepository.authStateChanges;
  }
}
