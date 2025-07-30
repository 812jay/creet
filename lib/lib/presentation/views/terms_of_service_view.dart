import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:creet/lib/domain/dto/auth/auth_credential_dto.dart';

class TermsOfServiceView extends ConsumerStatefulWidget {
  final AuthCredentialDto credential;

  const TermsOfServiceView({super.key, required this.credential});

  @override
  ConsumerState<TermsOfServiceView> createState() => _TermsOfServiceViewState();
}

class _TermsOfServiceViewState extends ConsumerState<TermsOfServiceView> {
  bool _isAgreed = false;
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('이용약관 동의'),
        automaticallyImplyLeading: false, // 뒤로가기 버튼 숨기기
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(widget.credential.toJson().toString()),
            const Text(
              '이용약관',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.shade300),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const SingleChildScrollView(
                  child: Text('''
제1조 (목적)
이 약관은 [서비스명]이 제공하는 서비스의 이용과 관련하여 서비스와 이용자 간의 권리, 의무 및 책임사항을 규정함을 목적으로 합니다.

제2조 (정의)
1. "서비스"라 함은 [서비스명]이 제공하는 모든 서비스를 의미합니다.
2. "이용자"라 함은 이 약관에 따라 서비스를 이용하는 회원을 의미합니다.

제3조 (약관의 효력 및 변경)
1. 이 약관은 서비스 이용을 신청한 이용자에 대하여 효력을 발생합니다.
2. 서비스는 필요한 경우 관련법령을 위배하지 않는 범위에서 이 약관을 변경할 수 있습니다.

[이하 생략...]
                    ''', style: TextStyle(fontSize: 14, height: 1.5)),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Checkbox(
                  value: _isAgreed,
                  onChanged: (value) {
                    setState(() {
                      _isAgreed = value ?? false;
                    });
                  },
                ),
                const Expanded(
                  child: Text('이용약관에 동의합니다', style: TextStyle(fontSize: 16)),
                ),
              ],
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: _isAgreed && !_isLoading ? _onAgree : null,
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16),
                backgroundColor: _isAgreed ? Colors.blue : Colors.grey,
              ),
              child:
                  _isLoading
                      ? const SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          valueColor: AlwaysStoppedAnimation<Color>(
                            Colors.white,
                          ),
                        ),
                      )
                      : const Text(
                        '동의하고 계속하기',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
            ),
            const SizedBox(height: 12),
            TextButton(
              onPressed: _isLoading ? null : _onCancel,
              child: const Text('취소', style: TextStyle(fontSize: 16)),
            ),
          ],
        ),
      ),
    );
  }

  void _onAgree() async {
    setState(() {
      _isLoading = true;
    });

    try {
      // TODO: Supabase 가입 로직 호출
      // final useCase = serviceLocator.get<SignUpWithSupabaseUseCase>();
      // final user = await useCase(widget.credential);

      // 가입 성공 시 메인 화면으로 이동
      if (mounted) {
        Navigator.of(context).pushReplacementNamed('/main');
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('가입 중 오류가 발생했습니다: $e')));
      }
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  void _onCancel() {
    // 로그인 화면으로 돌아가기
    Navigator.of(context).pop();
  }
}
