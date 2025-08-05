import 'package:creet/lib/core/di/service_locator.dart';
import 'package:creet/lib/domain/dto/user/user_dto.dart';
import 'package:creet/lib/domain/usecases/auth_usecases.dart';
import 'package:creet/lib/domain/usecases/user_usecases.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'home_view_model.g.dart';

@riverpod
class HomeViewModel extends _$HomeViewModel {
  @override
  Future<HomeState> build() async {
    final useCase = serviceLocator.get<GetCurrentUserUseCase>();
    final user = await useCase();
    return HomeState(user: user, isLoading: false);
  }

  /// 로그아웃
  Future<void> signOut() async {
    try {
      // 로딩 상태로 변경
      state = const AsyncValue.loading();

      final useCase = serviceLocator.get<SignOutUseCase>();
      await useCase();

      // 로그아웃 후 상태를 null로 변경
      state = AsyncValue.data(const HomeState(user: null, isLoading: false));
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
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
