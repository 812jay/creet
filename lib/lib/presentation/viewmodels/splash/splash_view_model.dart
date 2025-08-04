import 'dart:developer' as developer;
import 'package:creet/lib/core/di/service_locator.dart';
import 'package:creet/lib/domain/dto/user/user_dto.dart';
import 'package:creet/lib/domain/usecases/user_usecases.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'splash_view_model.g.dart';

@riverpod
class SplashViewModel extends _$SplashViewModel {
  @override
  Future<UserDto?> build() async {
    developer.log('SplashViewModel 초기화', name: 'SplashViewModel');

    // 앱 시작 시 현재 사용자 상태 확인
    final useCase = serviceLocator.get<GetCurrentUserUseCase>();
    try {
      final user = await useCase();
      if (user != null) {
        developer.log('자동 로그인 가능: ${user.email}', name: 'SplashViewModel');
      } else {
        developer.log('자동 로그인 불가: 사용자 정보 없음', name: 'SplashViewModel');
      }
      return user;
    } catch (e) {
      developer.log('자동 로그인 확인 실패: $e', name: 'SplashViewModel');
      return null;
    }
  }
}
