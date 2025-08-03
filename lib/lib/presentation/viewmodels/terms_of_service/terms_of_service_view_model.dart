import 'package:creet/lib/domain/dto/auth/auth_credential_dto.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'terms_of_service_view_model.g.dart';

// 단일 상태 클래스로 모든 UI 상태 관리
class TermsOfServiceState {
  TermsOfServiceState({
    required this.isLoading,
    required this.privacyAgreed,
    required this.termsAgreed,
  });

  final bool isLoading;
  final bool privacyAgreed;
  final bool termsAgreed;

  // "모두 동의"는 계산된 값
  bool get isAgreed => privacyAgreed && termsAgreed;

  bool get canProceed => privacyAgreed && termsAgreed;

  TermsOfServiceState copyWith({
    bool? isLoading,
    bool? privacyAgreed,
    bool? termsAgreed,
  }) {
    return TermsOfServiceState(
      isLoading: isLoading ?? this.isLoading,
      privacyAgreed: privacyAgreed ?? this.privacyAgreed,
      termsAgreed: termsAgreed ?? this.termsAgreed,
    );
  }
}

@riverpod
class TermsOfServiceViewModel extends _$TermsOfServiceViewModel {
  late final AuthCredentialDto credential;

  @override
  TermsOfServiceState build() {
    return TermsOfServiceState(
      isLoading: false,
      privacyAgreed: false,
      termsAgreed: false,
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
}
