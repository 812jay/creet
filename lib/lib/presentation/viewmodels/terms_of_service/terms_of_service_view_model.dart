import 'package:creet/lib/core/di/service_locator.dart';
import 'package:creet/lib/domain/dto/auth/auth_credential_dto.dart';
import 'package:creet/lib/domain/usecases/user_usecases.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'terms_of_service_view_model.g.dart';

// 단일 상태 클래스로 모든 UI 상태 관리
class TermsOfServiceState {
  TermsOfServiceState({
    required this.isLoading,
    required this.privacyAgreed,
    required this.termsAgreed,
    required this.shouldNavigate,
  });

  final bool isLoading;
  final bool privacyAgreed;
  final bool termsAgreed;
  final bool shouldNavigate;

  // "모두 동의"는 계산된 값
  bool get isAgreed => privacyAgreed && termsAgreed;

  bool get canProceed => privacyAgreed && termsAgreed;

  TermsOfServiceState copyWith({
    bool? isLoading,
    bool? privacyAgreed,
    bool? termsAgreed,
    bool? shouldNavigate,
  }) {
    return TermsOfServiceState(
      isLoading: isLoading ?? this.isLoading,
      privacyAgreed: privacyAgreed ?? this.privacyAgreed,
      termsAgreed: termsAgreed ?? this.termsAgreed,
      shouldNavigate: shouldNavigate ?? this.shouldNavigate,
    );
  }
}

@riverpod
class TermsOfServiceViewModel extends _$TermsOfServiceViewModel {
  TermsOfServiceViewModel();

  @override
  TermsOfServiceState build() {
    return TermsOfServiceState(
      isLoading: false,
      privacyAgreed: false,
      termsAgreed: false,
      shouldNavigate: false,
    );
  }

  // "모두 동의" 클릭 시: 모든 개별 체크박스를 동일한 상태로 변경
  void toggleAllAgreement() {
    final newValue = !state.isAgreed; // 현재 "모두 동의" 상태의 반대
    state = state.copyWith(privacyAgreed: newValue, termsAgreed: newValue);
    print('toggleAllAgreement: ${state.isAgreed}');
  }

  // 개별 체크박스 클릭 시: 해당 체크박스만 변경
  void togglePrivacyAgreement() {
    state = state.copyWith(privacyAgreed: !state.privacyAgreed);
    print('togglePrivacyAgreement: ${state.privacyAgreed}');
  }

  void toggleTermsAgreement() {
    state = state.copyWith(termsAgreed: !state.termsAgreed);
    print('toggleTermsAgreement: ${state.termsAgreed}');
  }

  Future<void> signUp(AuthCredentialDto credential) async {
    try {
      state = state.copyWith(isLoading: true);

      final useCase = serviceLocator.get<SignUpUseCase>();
      await useCase(credential);

      // 성공 시 상태 초기화 및 네비게이션 플래그 설정
      state = state.copyWith(isLoading: false, shouldNavigate: true);
      print('SignUp 성공!');
    } catch (e) {
      state = state.copyWith(isLoading: false);
      print('SignUp 실패: $e');
      // 에러 처리 (필요시)
    }
  }

  // 네비게이션 플래그 리셋
  void resetNavigationFlag() {
    state = state.copyWith(shouldNavigate: false);
  }
}
