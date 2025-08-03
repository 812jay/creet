import 'package:creet/lib/domain/dto/auth/auth_credential_dto.dart';

abstract class UserRepository {
  Future<void> signUp(AuthCredentialDto credential);
}
