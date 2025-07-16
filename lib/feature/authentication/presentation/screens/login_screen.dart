import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../config/di/provider.dart';
import '../../../../config/router/app_router.dart';
import '../../domain/entity/user_entity.dart';
import '../riverpod/login_riverpod.dart';

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

// HomePage를 ConsumerWidget으로 변경하여 Riverpod 프로바이더를 사용할 수 있게 합니다.
class HomePage extends ConsumerWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // authNotifierProvider의 현재 상태를 watch하여 상태 변경 시 위젯을 다시 빌드합니다.
    final authStateData = ref.watch(authNotifierProvider);

    // 위젯이 처음 빌드될 때 (또는 의존성이 변경될 때) 현재 사용자 정보를 로드합니다.
    // 이 부분은 앱 시작 시 로그인 상태를 확인하는 로직에 추가될 수 있습니다.
    // initState와 유사한 역할을 하려면 `ref.read`를 사용하고 `FutureProvider` 또는 `onInit` 패턴을 고려할 수 있습니다.
    // 여기서는 간단하게 build 메서드 내에서 상태가 initial일 때 로드하도록 합니다.
    if (authStateData.state == AuthState.initial) {
      // AuthNotifier의 loadCurrentUser 메서드를 호출하여 사용자 정보를 로드합니다.
      // 이 호출은 UI 빌드 중에는 피해야 하므로, `WidgetsBinding.instance.addPostFrameCallback`을 사용하거나
      // 상태 관리 로직 내에서 초기 로딩을 처리하는 것이 더 좋습니다.
      // 여기서는 예시를 위해 직접 호출합니다.
      Future.microtask(() => ref.read(authNotifierProvider.notifier).loadCurrentUser());
    }

    return Scaffold(
      appBar: AppBar(title: const Text('홈 화면')),
      body: _buildBody(context, authStateData),
    );
  }

  Widget _buildBody(BuildContext context, AuthStateData authStateData) {
    switch (authStateData.state) {
      case AuthState.loading:
        return const Center(child: CircularProgressIndicator());
      case AuthState.success:
      // 사용자 정보가 성공적으로 로드되었을 때
        if (authStateData.user != null) {
          final user = authStateData.user!;
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('환영합니다, ${user.username}!'),
                Text('이메일: ${user.email}'),
                // User 엔티티의 다른 정보를 활용하여 UI 표시
                ElevatedButton(
                  onPressed: () {
                    // 사용자 정보를 활용한 비즈니스 로직 예시
                    // 예를 들어, 마이페이지로 이동 시 사용자 정보를 전달
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ProfilePage(user: user)),
                    );
                  },
                  child: const Text('마이페이지'),
                ),
                ElevatedButton(
                  onPressed: () {
                    // 로그아웃 기능 추가 (AuthNotifier에 로그아웃 메서드 필요)
                    // ref.read(authNotifierProvider.notifier).logout();
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('로그아웃 기능은 구현되지 않았습니다.')),
                    );
                  },
                  child: const Text('로그아웃'),
                ),
              ],
            ),
          );
        } else {
          // success 상태이지만 user가 null인 경우 (예: 로그인되지 않은 상태)
          return const Center(child: Text('로그인이 필요합니다.'));
        }
      case AuthState.error:
        return Center(child: Text('에러: ${authStateData.errorMessage ?? '알 수 없는 에러'}'));
      case AuthState.initial:
      default:
      // 초기 상태 또는 알 수 없는 상태일 때
        return const Center(child: Text('로그인 상태를 확인 중입니다...'));
    }
  }
}
