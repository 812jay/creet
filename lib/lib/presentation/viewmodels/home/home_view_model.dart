import 'package:creet/lib/domain/entities/user_entity.dart';
import 'package:creet/lib/presentation/viewmodels/sign_in/sign_in_view_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'home_view_model.g.dart';

@riverpod
class HomeViewModel extends _$HomeViewModel {
  @override
  Future<HomeState> build() async {
    final useCase = ref.read(getCurrentUserUseCaseProvider);
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
