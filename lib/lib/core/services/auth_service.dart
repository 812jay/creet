import 'package:creet/lib/core/di/service_locator.dart';
import 'package:creet/lib/domain/entities/user_entity.dart';
import 'package:creet/lib/domain/usecases/auth_usecases.dart';

/// GetIt을 사용하는 인증 서비스
class AuthService {
  static final AuthService _instance = AuthService._internal();
  factory AuthService() => _instance;
  AuthService._internal();

  /// 현재 사용자 가져오기
  Future<UserEntity?> getCurrentUser() async {
    final useCase = serviceLocator.get<GetCurrentUserUseCase>();
    return await useCase();
  }

  /// Google 로그인
  Future<UserEntity?> signInWithGoogle() async {
    final useCase = serviceLocator.get<SignInWithGoogleUseCase>();
    return await useCase();
  }

  /// Apple 로그인
  Future<UserEntity?> signInWithApple() async {
    final useCase = serviceLocator.get<SignInWithAppleUseCase>();
    return await useCase();
  }

  /// 로그아웃
  Future<void> signOut() async {
    final useCase = serviceLocator.get<SignOutUseCase>();
    await useCase();
  }

  /// 인증 상태 변화 스트림
  Stream<UserEntity?> get authStateChanges {
    final useCase = serviceLocator.get<GetAuthStateChangesUseCase>();
    return useCase();
  }
}
