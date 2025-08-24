import 'package:flutter/material.dart';
import 'package:soulfit_client/core/ui/widget/shared_app_bar.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  // 각 스위치의 On/Off 상태를 저장하기 위한 변수들
  bool _chatNotifications = true;
  bool _marketingNotifications = false;
  bool _customInfoAgreement = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SharedAppBar(
      title: const Text('설정'),
      showBackButton: true, // 뒤로가기 버튼이 필요하면 true
    ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // --- 1. 알림 설정 섹션 ---
              const Text(
                '알림 설정하기',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              _buildSwitchListTile(
                title: '채팅 메세지 알림',
                value: _chatNotifications,
                onChanged: (value) {
                  setState(() {
                    _chatNotifications = value;
                  });
                },
              ),
              _buildSwitchListTile(
                title: '마케팅 정보 수신 동의',
                value: _marketingNotifications,
                onChanged: (value) {
                  setState(() {
                    _marketingNotifications = value;
                  });
                },
              ),
              _buildSwitchListTile(
                title: '맞춤 정보 수신 동의',
                value: _customInfoAgreement,
                onChanged: (value) {
                  setState(() {
                    _customInfoAgreement = value;
                  });
                },
              ),
              const SizedBox(height: 20),
              const Divider(),
              const SizedBox(height: 30),

              // --- 2. 계정 정보 섹션 ---
              _buildInfoRow('이메일', 'kevin@soulfit.com'),
              const SizedBox(height: 24),
              _buildInfoRow('휴대폰 번호', '010-1234-5678'),
              const SizedBox(height: 24),
              _buildPasswordRow(), // 비밀번호 변경 섹션
              const SizedBox(height: 40),
              const Divider(),
              const SizedBox(height: 20),

              // --- 3. 계정 관리 섹션 ---
              ListTile(
                title: const Text('로그아웃', style: TextStyle(fontSize: 16)),
                onTap: () {
                  print('로그아웃 버튼 클릭!');
                },
                contentPadding: EdgeInsets.zero,
              ),
              const SizedBox(height: 40),

              // 회원 탈퇴 버튼
              Center(
                child: TextButton(
                  onPressed: () {
                    print('회원 탈퇴 버튼 클릭!');
                  },
                  child: Text(
                    '회원 탈퇴',
                    style: TextStyle(
                      color: Colors.grey[400],
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // --- 재사용 가능한 위젯 빌더 메서드들 ---

  // 제목과 스위치로 구성된 한 줄을 만드는 메서드
  Widget _buildSwitchListTile({
    required String title,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return SwitchListTile(
      title: Text(title),
      value: value,
      onChanged: onChanged,
      activeColor: const Color.fromARGB(255, 51, 255, 16), // 켜졌을 때 스위치 색상
      inactiveThumbColor: const Color.fromARGB(255, 255, 255, 255), // 꺼졌을 때 스위치 색상
      inactiveTrackColor: const Color(0xFFE4FFDF),
      contentPadding: EdgeInsets.zero,
    );
  }

  // 제목과 내용으로 구성된 한 줄을 만드는 메서드
  Widget _buildInfoRow(String title, String content) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(color: Colors.grey[600], fontSize: 14),
        ),
        const SizedBox(height: 8),
        Text(
          content,
          style: const TextStyle(fontSize: 16),
        ),
      ],
    );
  }

  // 비밀번호와 변경 버튼으로 구성된 한 줄을 만드는 메서드
  Widget _buildPasswordRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // Column을 사용해 '비밀번호'와 '********'를 세로로 배치
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '비밀번호',
              style: TextStyle(color: Colors.grey[600], fontSize: 14),
            ),
            const SizedBox(height: 8),
            const Text(
              '********',
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
        OutlinedButton(
          onPressed: () {
            print('비밀번호 변경 버튼 클릭!');
          },
          child: const Text('변경하기'),
          style: OutlinedButton.styleFrom(
            foregroundColor: Colors.black,
            side: BorderSide(color: Colors.grey[300]!),
          ),
        ),
      ],
    );
  }
}
