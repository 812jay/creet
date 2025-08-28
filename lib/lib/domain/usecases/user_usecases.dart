import 'package:creet/lib/core/utils/logger.dart';
import 'package:creet/lib/domain/dto/user/user_dto.dart';
import 'package:creet/lib/domain/dto/auth/auth_credential_dto.dart';
import 'package:creet/lib/domain/repositories/category_repository.dart';
import 'package:creet/lib/domain/repositories/user_repository.dart';

class UserUseCase {
  final UserRepository _userRepository;
  final CategoryRepository _categoryRepository;

  UserUseCase(this._userRepository, this._categoryRepository);

  Future<void> signUp(AuthCredentialDto credential) async {
    try {
      await _userRepository.signUp(credential);
      await _categoryRepository.initializeUserCategories(credential.providerId);
    } catch (e) {
      Logger.error('signUp 실패: $e', tag: 'UserUseCase');
    }
  }

  Future<UserDto?> getCurrentUser() async {
    return await _userRepository.getCurrentUser();
  }
}
