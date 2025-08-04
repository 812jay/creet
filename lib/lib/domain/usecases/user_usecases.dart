import 'package:creet/lib/domain/dto/auth/auth_credential_dto.dart';
import 'package:creet/lib/domain/dto/user/user_dto.dart';
import 'package:creet/lib/domain/repositories/user_repository.dart';

class SignUpUseCase {
  final UserRepository _userRepository;

  SignUpUseCase(this._userRepository);

  Future<void> call(AuthCredentialDto credential) async {
    return await _userRepository.signUp(credential);
  }
}

class GetCurrentUserUseCase {
  final UserRepository _userRepository;

  GetCurrentUserUseCase(this._userRepository);

  Future<UserDto?> call() async {
    return await _userRepository.getCurrentUser();
  }
}
