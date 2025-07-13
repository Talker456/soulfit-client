import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:soulfit_client/config/router/app_router.dart';

import '../../domain/entity/signup_data.dart';
import '../riverpod/register_riverpod.dart';
import '../riverpod/register_state.dart';

class SignUpScreen extends ConsumerStatefulWidget {
  const SignUpScreen({super.key});

  @override
  ConsumerState<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends ConsumerState<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();

  final _nameController = TextEditingController();
  final _birthDateController = TextEditingController();
  final _genderController = TextEditingController();
  final _emailController = TextEditingController();
  final _verificationCodeController = TextEditingController();
  final _passwordController = TextEditingController();

  void _onSignUp() {
    if (!_formKey.currentState!.validate()) return;

    final signUpData = SignUpData(
      name: _nameController.text.trim(),
      birthDate: _birthDateController.text.trim(),
      gender: _genderController.text.trim(),
      email: _emailController.text.trim(),
      verificationCode: _verificationCodeController.text.trim(),
      password: _passwordController.text.trim(),
    );

    ref.read(regiserNotifierProvider.notifier).register(signUpData);
    context.go(AppRoutes.login);
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(regiserNotifierProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('회원가입')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              _buildTextField(_nameController, '이름'),
              _buildTextField(_birthDateController, '생년월일 (예: 1990-01-01)'),
              _buildTextField(_genderController, '성별 (예: male, female)'),
              _buildTextField(_emailController, '이메일'),
              _buildTextField(_verificationCodeController, '인증코드'),
              _buildTextField(_passwordController, '비밀번호', obscureText: true),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: state.status == SignUpStatus.loading ? null : _onSignUp,
                child: state.status == SignUpStatus.loading
                    ? const CircularProgressIndicator(color: Colors.white)
                    : const Text('회원가입'),
              ),
              const SizedBox(height: 12),
              if (state.status == SignUpStatus.error)
                Text(
                  '오류: ${state.error ?? '알 수 없는 오류'}',
                  style: const TextStyle(color: Colors.red),
                ),
              if (state.status == SignUpStatus.success)
                const Text(
                  '회원가입 성공!',
                  style: TextStyle(color: Colors.green),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(
      TextEditingController controller,
      String label, {
        bool obscureText = false,
      }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: TextFormField(
        controller: controller,
        obscureText: obscureText,
        decoration: InputDecoration(labelText: label, border: const OutlineInputBorder()),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return '$label을 입력해주세요.';
          }
          return null;
        },
      ),
    );
  }
}
