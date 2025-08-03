import 'package:creet/lib/domain/dto/auth/auth_credential_dto.dart';
import 'package:creet/lib/domain/repositories/user_repository.dart';

class SignUpUseCase {
  final UserRepository _userRepository;

  SignUpUseCase(this._userRepository);

  Future<void> call(AuthCredentialDto credential) async {
    return await _userRepository.signUp(credential);
  }
}
