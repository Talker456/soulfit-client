import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:soulfit_client/config/router/app_router.dart';

import '../../../../config/di/provider.dart';
import '../../domain/entity/signup_data.dart';
import '../riverpod/register_riverpod.dart';
import '../riverpod/register_state.dart';
import 'portone_certification.dart';

class SignUpScreenV3 extends ConsumerStatefulWidget {
  const SignUpScreenV3({super.key});

  @override
  ConsumerState<SignUpScreenV3> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends ConsumerState<SignUpScreenV3> {
  final _formKey = GlobalKey<FormState>();

  final _nameController = TextEditingController();
  final _birthDateController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  String? _verificationId; // 인증 스킵
  String? _selectedGender;

  void _onSignUp() {
    if (!_formKey.currentState!.validate()) return;
    if (_verificationId == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('본인인증을 진행해주세요.')),
      );
      return;
    }
    if (_selectedGender == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('성별을 선택해주세요.')),
      );
      return;
    }

    final signUpData = SignUpData(
      name: _nameController.text.trim(),
      birthDate: _birthDateController.text.trim(),
      gender: _selectedGender!,
      email: _emailController.text.trim(),
      verificationCode: _verificationId!,
      password: _passwordController.text.trim(),
    );

    ref.read(regiserNotifierProvider.notifier).register(signUpData);
    context.go(AppRoutes.login);
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(regiserNotifierProvider);

    return Scaffold(
      backgroundColor: const Color(0xFFE8F5E8), // 연한 초록색 배경
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              // 브랜드 로고
              Center(
                child: Column(
                  children: [
                    Text(
                      'soulfit',
                      style: TextStyle(
                        fontSize: 48,
                        fontWeight: FontWeight.w300,
                        color: Colors.green.shade600,
                        letterSpacing: 2,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      '나의 소울메이트를 찾는 여정의 시작',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey.shade600,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 40),
              // 회원가입 제목
              const Text(
                '회원가입',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 24),

              // 입력 필드들
              _buildStyledTextField(_passwordController, '비밀번호', obscureText: true),
              _buildStyledTextField(_emailController, '아이디'),

              // 본인인증 섹션
              const SizedBox(height: 16),
              Text(
                '본인인증',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey.shade600,
                ),
              ),
              const SizedBox(height: 8),
              Container(
                width: double.infinity,
                height: 56,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.grey.shade300),
                ),
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    borderRadius: BorderRadius.circular(12),
                    onTap: () async {
                      final result = await Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Certification()),
                      );

                      if (result != null && result['success'] == 'true') {
                        setState(() {
                          _verificationId = result['imp_uid'];
                        });
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text(result != null ? result['error_msg'] : '인증 실패')),
                        );
                      }
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                              _verificationId != null ? '인증 완료' : '본인인증을 진행해주세요',
                              style: TextStyle(
                                fontSize: 16,
                                color: _verificationId != null ? Colors.green : Colors.grey.shade500,
                              ),
                            ),
                          ),
                          Icon(
                            _verificationId != null ? Icons.check_circle : Icons.arrow_forward_ios,
                            color: _verificationId != null ? Colors.green : Colors.grey.shade400,
                            size: 20,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),

              _buildGenderSelector(),
              _buildStyledTextField(_birthDateController, '생년월일'),
              _buildStyledTextField(_nameController, '이름'),

              const SizedBox(height: 40),

              // 회원가입 버튼
              Container(
                width: double.infinity,
                height: 56,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  gradient: LinearGradient(
                    colors: [
                      Colors.green.shade400,
                      Colors.green.shade600,
                    ],
                  ),
                ),
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    borderRadius: BorderRadius.circular(12),
                    onTap: state.status == SignUpStatus.loading ? null : _onSignUp,
                    child: Center(
                      child: state.status == SignUpStatus.loading
                          ? const SizedBox(
                        width: 24,
                        height: 24,
                        child: CircularProgressIndicator(
                          color: Colors.white,
                          strokeWidth: 2,
                        ),
                      )
                          : const Text(
                        '회원가입',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 16),

              // 상태 메시지
              if (state.status == SignUpStatus.error)
                Center(
                  child: Text(
                    '오류: ${state.error ?? '알 수 없는 오류'}',
                    style: const TextStyle(color: Colors.red, fontSize: 14),
                  ),
                ),
              if (state.status == SignUpStatus.success)
                const Center(
                  child: Text(
                    '회원가입 성공!',
                    style: TextStyle(color: Colors.green, fontSize: 14),
                  ),
                ),

              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStyledTextField(
      TextEditingController controller,
      String label, {
        bool obscureText = false,
      }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 16),
        Text(
          label,
          style: TextStyle(
            fontSize: 14,
            color: Colors.grey.shade600,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          height: 56,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.grey.shade300),
          ),
          child: TextFormField(
            controller: controller,
            obscureText: obscureText,
            style: const TextStyle(
              fontSize: 16,
              color: Colors.black,
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              hintText: _getHintText(label),
              hintStyle: TextStyle(
                color: Colors.grey.shade500,
                fontSize: 16,
              ),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return '$label을 입력해주세요.';
              }
              return null;
            },
          ),
        ),
      ],
    );
  }

  Widget _buildGenderSelector() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 16),
        Text(
          '성별',
          style: TextStyle(
            fontSize: 14,
            color: Colors.grey.shade600,
          ),
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            Expanded(
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    _selectedGender = 'MALE';
                  });
                },
                child: Container(
                  height: 56,
                  decoration: BoxDecoration(
                    color: _selectedGender == 'MALE' ? Colors.green.shade50 : Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: _selectedGender == 'MALE' ? Colors.green.shade400 : Colors.grey.shade300,
                      width: _selectedGender == 'MALE' ? 2 : 1,
                    ),
                  ),
                  child: Center(
                    child: Text(
                      '남자',
                      style: TextStyle(
                        fontSize: 16,
                        color: _selectedGender == 'MALE' ? Colors.green.shade600 : Colors.grey.shade600,
                        fontWeight: _selectedGender == 'MALE' ? FontWeight.w600 : FontWeight.normal,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    _selectedGender = 'FEMALE';
                  });
                },
                child: Container(
                  height: 56,
                  decoration: BoxDecoration(
                    color: _selectedGender == 'FEMALE' ? Colors.green.shade50 : Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: _selectedGender == 'FEMALE' ? Colors.green.shade400 : Colors.grey.shade300,
                      width: _selectedGender == 'FEMALE' ? 2 : 1,
                    ),
                  ),
                  child: Center(
                    child: Text(
                      '여자',
                      style: TextStyle(
                        fontSize: 16,
                        color: _selectedGender == 'FEMALE' ? Colors.green.shade600 : Colors.grey.shade600,
                        fontWeight: _selectedGender == 'FEMALE' ? FontWeight.w600 : FontWeight.normal,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  String _getHintText(String label) {
    switch (label) {
      case '생년월일':
        return '2004-10-04';
      case '아이디':
        return 'email@example.com';
      case '이름':
        return '이름';
      default:
        return '';
    }
  }
}