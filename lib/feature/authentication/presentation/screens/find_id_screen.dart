import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:soulfit_client/feature/authentication/presentation/widget/intro_widget.dart';

import '../riverpod/find_id_riverpod.dart';

class FindIdScreen extends StatefulWidget {
  const FindIdScreen({Key? key}) : super(key: key);

  @override
  State<FindIdScreen> createState() => _FindIdScreenState();
}

class _FindIdScreenState extends State<FindIdScreen> {
  final _phoneController = TextEditingController();
  final _codeController = TextEditingController();
  final _viewModel = FindIdViewModel(); // 실제로는 DI를 통해 주입

  @override
  void initState() {
    super.initState();
    _viewModel.addListener(_onStateChanged);
  }

  @override
  void dispose() {
    _viewModel.removeListener(_onStateChanged);
    _phoneController.dispose();
    _codeController.dispose();
    _viewModel.dispose();
    super.dispose();
  }

  void _onStateChanged() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE4FFDF), // Light green background

      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              IntroHeader(),

              const SizedBox(height: 30),

              // Tab-like headers
              Row(
                children: [
                  const Text(
                    '아이디 찾기',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(width: 40),
                  GestureDetector(
                    onTap: () {
                      // TODO: Navigate to password reset screen
                    },
                    child: const Text(
                      '비밀번호 재설정',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: Colors.black54,
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 30),

              // Phone number input
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _phoneController,
                      keyboardType: TextInputType.phone,
                      onChanged: _viewModel.updatePhoneNumber,
                      decoration: InputDecoration(
                        hintText: '휴대폰번호 입력 (-제외)',
                        hintStyle: const TextStyle(color: Colors.black38),
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide.none,
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 16,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 6),
                  SizedBox(
                    width: 60,
                    height: 52,
                    child: ElevatedButton(
                      onPressed: _viewModel.state.isPhoneNumberValid &&
                          !_viewModel.state.isLoading
                          ? () => _viewModel.sendVerificationCode(_phoneController.text)
                          : null,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF7CB342),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: _viewModel.state.isLoading
                          ? const SizedBox(
                        width: 22,
                        height: 16,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                        ),
                      )
                          : const Text(
                        '확인',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 16),

              // Verification code input
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _codeController,
                      keyboardType: TextInputType.number,
                      enabled: _viewModel.state.isVerificationCodeSent,
                      onChanged: _viewModel.updateVerificationCode,
                      decoration: InputDecoration(
                        hintText: '인증번호 입력',
                        hintStyle: const TextStyle(color: Colors.black38),
                        filled: true,
                        fillColor: _viewModel.state.isVerificationCodeSent
                            ? Colors.white
                            : Colors.grey[100],
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide.none,
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 16,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  SizedBox(
                    width: 60,
                    height: 52,
                    child: ElevatedButton(
                      onPressed: _viewModel.state.isVerificationCodeSent &&
                          _viewModel.state.verificationCode.isNotEmpty &&
                          !_viewModel.state.isLoading
                          ? () => _viewModel.verifyCode(_codeController.text)
                          : null,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF7CB342),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: const Text(
                        '확인',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 30),

              // Find ID button
              SizedBox(
                height: 52,
                child: ElevatedButton(
                  onPressed: _viewModel.state.isVerificationCodeValid &&
                      !_viewModel.state.isLoading
                      ? _onFindIdPressed
                      : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF7CB342),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: _viewModel.state.isLoading
                      ? const CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                  )
                      : const Text(
                    '아이디 찾기',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // Back to login link
              Center(
                child: TextButton(
                  onPressed: () => context.go("/login"),
                  child: const Text(
                    '로그인으로 돌아가기',
                    style: TextStyle(
                      color: Colors.black54,
                      fontSize: 14,
                    ),
                  ),
                ),
              ),

              // Error message
              if (_viewModel.state.errorMessage != null)
                Padding(
                  padding: const EdgeInsets.only(top: 16),
                  child: Text(
                    _viewModel.state.errorMessage!,
                    style: const TextStyle(
                      color: Colors.red,
                      fontSize: 14,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  void _onFindIdPressed() async {
    final userId = await _viewModel.findUserId();
    if (userId != null) {
      // Show found user ID dialog
      _showUserIdDialog(userId);
    }
  }

  void _showUserIdDialog(String userId) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('아이디 찾기 완료'),
        content: Text('회원님의 아이디는 "$userId" 입니다.'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(); // Close dialog
              Navigator.of(context).pop(); // Back to login
            },
            child: const Text('확인'),
          ),
        ],
      ),
    );
  }
}