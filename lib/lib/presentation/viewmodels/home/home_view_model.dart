import 'package:creet/lib/core/di/service_locator.dart';
import 'package:creet/lib/domain/entities/user_entity.dart';
import 'package:creet/lib/domain/usecases/auth_usecases.dart';
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
}

class HomeState {
  final UserEntity? user;
  final bool isLoading;

  const HomeState({this.user, this.isLoading = false});

  HomeState copyWith({UserEntity? user, bool? isLoading}) {
    return HomeState(
      user: user ?? this.user,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}
