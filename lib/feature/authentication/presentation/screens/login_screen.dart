import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../config/router/app_router.dart';
import '../riverpod/login_riverpod.dart';

class SoulfitLoginScreen extends ConsumerStatefulWidget {
  const SoulfitLoginScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<SoulfitLoginScreen> createState() => _SoulfitLoginScreenState();
}

class _SoulfitLoginScreenState extends ConsumerState<SoulfitLoginScreen> {
  final _emailController = TextEditingController(text: 'giryongi@kyonggi.ac.kr');
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Riverpod으로 상태 관리
    final authState = ref.watch(authNotifierProvider);
    final authNotifier = ref.read(authNotifierProvider.notifier);

    // 로그인 성공 시 홈 화면으로 이동
    ref.listen<AuthStateData>(authNotifierProvider, (previous, next) {
      if (next.state == AuthState.success) {
        print('successful login');
        context.go(AppRoutes.home);
      }
    });

    return Scaffold(
      backgroundColor: const Color(0xFFF5F8F5),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // 로고 및 타이틀
                _buildHeader(),

                const SizedBox(height: 80),

                // 이메일 입력 필드
                _buildEmailField(),

                const SizedBox(height: 16),

                // 비밀번호 입력 필드
                _buildPasswordField(),

                const SizedBox(height: 32),

                // 로그인 버튼
                _buildLoginButton(authNotifier, authState),

                const SizedBox(height: 20),

                // 구분선
                _buildDivider(),

                const SizedBox(height: 20),

                // 회원가입 버튼
                _buildRegisterButton(),

                // 에러 메시지
                if (authState.errorMessage != null)
                  _buildErrorMessage(authState.errorMessage!),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return const Column(
      children: [
        Text(
          'soulfit',
          style: TextStyle(
            fontSize: 48,
            fontWeight: FontWeight.w300,
            color: Color(0xFF8FBC8F),
            letterSpacing: 2,
          ),
        ),
        SizedBox(height: 12),
        Text(
          '나의 소울메이트를 찾는 여정의 시작',
          style: TextStyle(
            fontSize: 16,
            color: Color(0xFF666666),
            fontWeight: FontWeight.w400,
          ),
        ),
      ],
    );
  }

  Widget _buildEmailField() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: TextFormField(
        controller: _emailController,
        keyboardType: TextInputType.emailAddress,
        decoration: const InputDecoration(
          hintText: '이메일을 입력하세요',
          hintStyle: TextStyle(color: Color(0xFFBBBBBB)),
          border: InputBorder.none,
          contentPadding: EdgeInsets.all(20),
        ),
        style: const TextStyle(
          fontSize: 16,
          color: Color(0xFF333333),
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return '이메일을 입력해주세요';
          }
          if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
            return '올바른 이메일 형식을 입력해주세요';
          }
          return null;
        },
      ),
    );
  }

  Widget _buildPasswordField() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: TextFormField(
        controller: _passwordController,
        obscureText: true,
        decoration: const InputDecoration(
          hintText: '비밀번호를 입력하세요',
          hintStyle: TextStyle(color: Color(0xFFBBBBBB)),
          border: InputBorder.none,
          contentPadding: EdgeInsets.all(20),
        ),
        style: const TextStyle(
          fontSize: 16,
          color: Color(0xFF333333),
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return '비밀번호를 입력해주세요';
          }
          if (value.length < 6) {
            return '비밀번호는 6자 이상이어야 합니다';
          }
          return null;
        },
      ),
    );
  }

  Widget _buildLoginButton(AuthNotifier authNotifier, AuthStateData authState) {
    return SizedBox(
      height: 56,
      child: ElevatedButton(
        onPressed: authState.state == AuthState.loading
            ? null
            : () => _handleLogin(authNotifier),
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF8FBC8F),
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          elevation: 2,
        ),
        child: authState.state == AuthState.loading
            ? const SizedBox(
          width: 24,
          height: 24,
          child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
            strokeWidth: 2,
          ),
        )
            : const Text(
          '로그인',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  Widget _buildDivider() {
    return const Row(
      children: [
        Expanded(
          child: Divider(
            height: 1,
            color: Color(0xFFE0E0E0),
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Text(
            'or',
            style: TextStyle(
              color: Color(0xFF999999),
              fontSize: 14,
            ),
          ),
        ),
        Expanded(
          child: Divider(
            height: 1,
            color: Color(0xFFE0E0E0),
          ),
        ),
      ],
    );
  }

  Widget _buildRegisterButton() {
    return SizedBox(
      height: 56,
      child: ElevatedButton(
        onPressed: () => context.go(AppRoutes.register),
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFFE8F5E8),
          foregroundColor: const Color(0xFF8FBC8F),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          elevation: 0,
        ),
        child: const Text(
          '회원가입',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  Widget _buildErrorMessage(String message) {
    return Container(
      margin: const EdgeInsets.only(top: 16),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.red.shade50,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        message,
        style: TextStyle(
          color: Colors.red.shade700,
          fontSize: 14,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }

  void _handleLogin(AuthNotifier authNotifier) {
    if (_formKey.currentState?.validate() ?? false) {
      authNotifier.login(
        _emailController.text.trim(),
        _passwordController.text,
      );
    }
  }
}

// 추가 화면들 (예시)
class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('홈'),
        actions: [
          IconButton(
            onPressed: () => context.go(AppRoutes.login),
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      body: const Center(
        child: Text('홈 화면'),
      ),
    );
  }
}
