import 'package:creet/lib/core/constants/app_colors.dart';
import 'package:creet/lib/core/constants/app_typo.dart';
import 'package:creet/lib/presentation/viewmodels/terms_of_service/terms_of_service_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:creet/lib/domain/dto/auth/auth_credential_dto.dart';

class TermsOfServiceView extends StatelessWidget {
  const TermsOfServiceView({super.key, required this.credential});
  final AuthCredentialDto credential;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 70),
            const _HeaderSection(),
            const SizedBox(height: 50),
            const _AllAgreementSection(),
            const SizedBox(height: 30),
            const _PrivacyAgreementSection(),
            const SizedBox(height: 20),
            const _TermsAgreementSection(),
            const Spacer(),
            _SignUpButton(credential: credential),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}

class _HeaderSection extends StatelessWidget {
  const _HeaderSection();

  @override
  Widget build(BuildContext context) {
    return const Text('서비스 이용을 위한\n이용약관 동의', style: AppTypo.title1Bold);
  }
}

class _AllAgreementSection extends ConsumerWidget {
  const _AllAgreementSection();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(termsOfServiceViewModelProvider);
    final viewModel = ref.watch(termsOfServiceViewModelProvider.notifier);

    return Row(
      children: [
        Text('다음 약관에 모두 동의', style: AppTypo.body1Bold),
        const Spacer(),
        _AgreementCheckbox(
          isChecked: state.isAgreed,
          onTap: () => viewModel.toggleAllAgreement(),
        ),
      ],
    );
  }
}

class _PrivacyAgreementSection extends ConsumerWidget {
  const _PrivacyAgreementSection();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(termsOfServiceViewModelProvider);
    final viewModel = ref.watch(termsOfServiceViewModelProvider.notifier);

    return Row(
      children: [
        Expanded(
          child: _AgreementText(
            title: '개인정보수집 및 이용에 대한 안내',
            isRequired: true,
            onTap: () {},
          ),
        ),
        const SizedBox(width: 10),
        _AgreementCheckbox(
          isChecked: state.privacyAgreed,
          onTap: () => viewModel.togglePrivacyAgreement(),
        ),
      ],
    );
  }
}

class _TermsAgreementSection extends ConsumerWidget {
  const _TermsAgreementSection();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(termsOfServiceViewModelProvider);
    final viewModel = ref.watch(termsOfServiceViewModelProvider.notifier);

    return Row(
      children: [
        Expanded(
          child: _AgreementText(
            title: '크립 이용약관 동의',
            isRequired: true,
            onTap: () {},
          ),
        ),
        const SizedBox(width: 10),
        _AgreementCheckbox(
          isChecked: state.termsAgreed,
          onTap: () => viewModel.toggleTermsAgreement(),
        ),
      ],
    );
  }
}

class _AgreementText extends StatelessWidget {
  const _AgreementText({
    required this.title,
    required this.isRequired,
    required this.onTap,
  });

  final String title;
  final bool isRequired;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: RichText(
        text: TextSpan(
          text: title,
          style: AppTypo.body1Regular.copyWith(
            decoration: TextDecoration.underline,
          ),
          children: [
            TextSpan(
              text: isRequired ? ' (필수)' : '',
              style: AppTypo.body1Regular,
            ),
          ],
        ),
      ),
    );
  }
}

class _AgreementCheckbox extends StatelessWidget {
  const _AgreementCheckbox({this.onTap, required this.isChecked});

  final bool isChecked;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 24,
        height: 24,
        decoration: BoxDecoration(
          color: isChecked ? AppColors.primary : Colors.grey,
          borderRadius: BorderRadius.circular(12),
        ),
        child: const Icon(Icons.check, color: Colors.white, size: 16),
      ),
    );
  }
}

class _SignUpButton extends ConsumerWidget {
  const _SignUpButton({required this.credential});

  final AuthCredentialDto credential;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(termsOfServiceViewModelProvider);
    final viewModel = ref.watch(termsOfServiceViewModelProvider.notifier);

    return SizedBox(
      width: double.infinity,
      height: 56,
      child: ElevatedButton(
        onPressed: state.isAgreed ? () => viewModel.signUp(credential) : null,
        style: ElevatedButton.styleFrom(
          backgroundColor: state.isAgreed ? AppColors.primary : Colors.grey,
          shadowColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(28),
          ),
        ),
        child: _ButtonText(),
      ),
    );
  }
}

class _ButtonText extends StatelessWidget {
  const _ButtonText();

  @override
  Widget build(BuildContext context) {
    return Text(
      '동의하고 시작하기',
      style: AppTypo.body1Bold.copyWith(color: Colors.white),
    );
  }
}
