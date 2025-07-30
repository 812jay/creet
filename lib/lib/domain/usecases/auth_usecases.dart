import 'package:creet/lib/domain/dto/user/user_dto.dart';
import 'package:creet/lib/domain/repositories/auth_repository.dart';

class SignInWithGoogleUseCase {
  final AuthRepository _authRepository;

  SignInWithGoogleUseCase(this._authRepository);

  Future<UserDto?> call() async {
    return await _authRepository.signInWithGoogle();
  }
}

class SignInWithAppleUseCase {
  final AuthRepository _authRepository;

  SignInWithAppleUseCase(this._authRepository);

  Future<UserDto?> call() async {
    return await _authRepository.signInWithApple();
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

  Future<UserDto?> call() async {
    return await _authRepository.getCurrentUser();
  }
}

class GetAuthStateChangesUseCase {
  final AuthRepository _authRepository;

  GetAuthStateChangesUseCase(this._authRepository);

  Stream<UserDto?> call() {
    return _authRepository.authStateChanges;
  }
}
