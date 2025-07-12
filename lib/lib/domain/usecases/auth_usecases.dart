import 'package:creet/lib/domain/entities/user_entity.dart';
import 'package:creet/lib/domain/repositories/auth_repository.dart';

class SignInWithGoogleUseCase {
  final AuthRepository _authRepository;

  SignInWithGoogleUseCase(this._authRepository);

  Future<UserEntity?> call() async {
    return await _authRepository.signInWithGoogle();
  }
}

class SignOutUseCase {
  final AuthRepository _authRepository;

  SignOutUseCase(this._authRepository);

  Future<void> call() async {
    await _authRepository.signOut();
  }
}

class GetCurrentUserUseCase {
  final AuthRepository _authRepository;

  GetCurrentUserUseCase(this._authRepository);

  Future<UserEntity?> call() async {
    return await _authRepository.getCurrentUser();
  }
}

class GetAuthStateChangesUseCase {
  final AuthRepository _authRepository;

  GetAuthStateChangesUseCase(this._authRepository);

  Stream<UserEntity?> call() {
    return _authRepository.authStateChanges;
  }
}
