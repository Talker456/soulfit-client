import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../config/di/provider.dart';
import '../../../../config/router/app_router.dart';
import '../../domain/entity/change_credential_data.dart';
import '../../domain/entity/user_entity.dart';
import '../riverpod/change_credential_state.dart';
import '../riverpod/login_riverpod.dart';
import '../widget/intro_widget.dart';

class SoulfitLoginScreen extends ConsumerStatefulWidget {
  const SoulfitLoginScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<SoulfitLoginScreen> createState() => _SoulfitLoginScreenState();
}

class _SoulfitLoginScreenState extends ConsumerState<SoulfitLoginScreen> {
  final _emailController = TextEditingController(text: 'email@example.com');
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
      backgroundColor: const Color(0xFFE4FFDF),
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
                IntroHeader(),

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

                const SizedBox(height: 10),

                _buildFindIdText(),

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
            fontSize: 54,
            fontWeight: FontWeight.w600,
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
          backgroundColor: const Color(0xFF99E48B),
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

  Widget _buildFindIdText(){
    return Align(
      alignment: Alignment.centerRight,
      child: GestureDetector(
        onTap: () => context.go("/findId"),
        child: const Text(
          '아이디, 비밀번호 찾기',
          style: TextStyle(
            color: Colors.black, // 필요에 따라 색상 조정
          ),
        ),
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
class HomeScreen extends ConsumerWidget {
  const HomeScreen({Key? key}) : super(key: key);

  void _onLogout(BuildContext context, WidgetRef ref) async {
    final notifier = ref.read(logoutNotifierProvider.notifier);
    await notifier.logout();

    final state = ref.read(logoutNotifierProvider);
    if (state is AsyncError) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('로그아웃 실패: ${state.error}')),
      );
    } else {
      context.go(AppRoutes.login); // 로그아웃 성공 시 로그인 화면으로 이동
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final logoutState = ref.watch(logoutNotifierProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('홈'),
        actions: [
          IconButton(
            onPressed: logoutState is AsyncLoading
                ? null
                : () => _onLogout(context, ref),
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

// ProfilePage는 예시이므로 실제 경로에 맞게 수정하거나 더미 위젯을 사용하세요.
class ProfilePage extends StatelessWidget {
  final User user;
  const ProfilePage({Key? key, required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('마이페이지')),
      body: Center(
        child: Text('프로필 정보: ${user.username} (${user.email})'),
      ),
    );
  }
}

class HomePage extends ConsumerWidget {
  const HomePage({Key? key}) : super(key: key);

  void _onLogout(BuildContext context, WidgetRef ref) async {
    final notifier = ref.read(logoutNotifierProvider.notifier);
    await notifier.logout();

    final state = ref.read(logoutNotifierProvider);
    if (state is AsyncError) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('로그아웃 실패: ${state.error}')),
      );
    } else {
      context.go(AppRoutes.login); // 로그아웃 성공 시 로그인 화면으로 이동
    }
  }

  /// ✅ 테스트용 credential 변경 함수
  Future<void> _onChangeCredentialTest(BuildContext context, WidgetRef ref, User user) async {
    final notifier = ref.read(credentialNotifierProvider.notifier);

    final testData = ChangeCredentialData(
      currentPassword: 'admin123', // 기존 비밀번호
      accessToken: 'fakeAccessToken', // 실제 앱에서는 사용자 토큰 사용
      newEmail: 'adminNew@example.com',
      newPassword: 'adminNew',
    );

    await notifier.changeCredential(testData);

    final state = ref.read(credentialNotifierProvider);
    if (state.state == CredentialState.success) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('이메일/비밀번호 변경 성공')),
      );
    } else if (state.state == CredentialState.error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('변경 실패: ${state.errorMessage}')),
      );
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authStateData = ref.watch(authNotifierProvider);
    final logoutState = ref.watch(logoutNotifierProvider);


      if (authStateData.state == AuthState.initial) {
        Future.microtask(() => ref.read(authNotifierProvider.notifier).loadCurrentUser());
      }

    return Scaffold(
      appBar: AppBar(
        title: const Text('홈 화면'),
        actions: [
          IconButton(
            onPressed: logoutState is AsyncLoading
                ? null
                : () => _onLogout(context, ref),
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      body: _buildBody(context, ref, authStateData),
    );
  }

  /// ✅ ref 인자 추가
  Widget _buildBody(BuildContext context, WidgetRef ref, AuthStateData authStateData) {
    print("[login screen] : "+authStateData.state.toString());
    final logoutState = ref.watch(logoutNotifierProvider);

    switch (authStateData.state) {
      case AuthState.loading:
        return const Center(child: CircularProgressIndicator());
      case AuthState.success:

        if (authStateData.user != null) {
          final user = authStateData.user!;
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('환영합니다, ${user.username}!'),
                Text('이메일: ${user.email}'),
                const SizedBox(height: 16),

                /// ✅ 마이페이지 버튼
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ProfilePage(user: user)),
                    );
                  },
                  child: const Text('마이페이지'),
                ),

                /// ✅ change credential 테스트 버튼
                ElevatedButton(
                  onPressed: () => _onChangeCredentialTest(context, ref, user),
                  child: const Text('이메일/비밀번호 변경 테스트'),
                ),

                /// 기존 로그아웃 버튼
                ElevatedButton(
                  onPressed: logoutState is AsyncLoading
                      ? null
                      : () => _onLogout(context, ref),
                  child: const Text('로그아웃'),
                ),
              ],
            ),
          );
        } else {
          return const Center(child: Text('로그인이 필요합니다.'));
        }
      case AuthState.error:
        return Center(child: Text('에러: ${authStateData.errorMessage ?? '알 수 없는 에러'}'));
      case AuthState.initial:
      default:
        return const Center(child: Text('로그인 상태를 확인 중입니다...'));
    }
  }
}

