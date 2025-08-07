import 'package:creet/lib/core/di/service_locator.dart';
import 'package:creet/lib/core/utils/logger.dart';
import 'package:creet/lib/domain/dto/user/user_dto.dart';
import 'package:creet/lib/domain/usecases/auth_usecases.dart';
import 'package:creet/lib/domain/usecases/user_usecases.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'home_view_model.g.dart';

@riverpod
class HomeViewModel extends _$HomeViewModel {
  final getCurrentUserUseCase = serviceLocator.get<GetCurrentUserUseCase>();
  final signOutUseCase = serviceLocator.get<SignOutUseCase>();

  @override
  Future<HomeState> build() async {
    Logger.info('HomeViewModel 초기화', tag: 'HomeViewModel');

    try {
      final user = await getCurrentUserUseCase();
      Logger.info('사용자 정보 로드 완료: ${user?.email}', tag: 'HomeViewModel');
      return HomeState(user: user, isLoading: false);
    } catch (e) {
      Logger.error('사용자 정보 로드 실패: $e', tag: 'HomeViewModel');
      return const HomeState(user: null, isLoading: false);
    }
  }

  Future<void> signOut() async {
    Logger.info('로그아웃 시작', tag: 'HomeViewModel');

    try {
      await signOutUseCase();
      Logger.info('로그아웃 성공', tag: 'HomeViewModel');
      // 로그아웃 후 상태 업데이트
      state = const AsyncValue.data(HomeState(user: null, isLoading: false));
    } catch (e) {
      Logger.error('로그아웃 실패: $e', tag: 'HomeViewModel');
    }
  }
}

class HomeState {
  final UserDto? user;
  final bool isLoading;

  const HomeState({this.user, this.isLoading = false});

  HomeState copyWith({UserDto? user, bool? isLoading}) {
    return HomeState(
      user: user ?? this.user,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}
