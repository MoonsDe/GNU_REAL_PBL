// lib/screens/login_screen.dart

import 'package:flutter/material.dart';
// 1. (오류 수정됨) 'packagepackage:' -> 'package:'
import 'package:gnu_real_pbl/screens/main_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  // 텍스트 필드를 제어하기 위한 컨트롤러
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    // 위젯이 종료될 때 컨트롤러도 정리합니다.
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _login() {
    // TODO: 여기에 실제 이메일/비밀번호 로그인 로직을 구현합니다.
    // (예: Firebase Auth, 백엔드 API 호출)

    // 지금은 로그인에 성공했다고 가정하고,
    // 현재 화면을 닫고 MainScreen으로 이동시킵니다.
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (context) => const MainScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      // 키보드가 올라올 때 UI가 밀려 올라가도록
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // 1. 앱 로고 (메인 화면의 초록색과 통일)
                const Icon(
                  Icons.recycling_rounded, // Re:Cycle 앱의 아이덴티티
                  size: 80,
                  color: Colors.green,
                ),
                const SizedBox(height: 16),

                // 2. 앱 이름
                const Text(
                  'Re:Cycle',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 48),

                // 3. 이메일 텍스트 필드
                // (메인 화면의 버튼/카드와 동일한 둥근 모서리)
                TextField(
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    labelText: '이메일',
                    prefixIcon: const Icon(Icons.email_outlined),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16.0),
                    ),
                  ),
                ),
                const SizedBox(height: 16),

                // 4. 비밀번호 텍스트 필드
                TextField(
                  controller: _passwordController,
                  obscureText: true, // 비밀번호 숨기기
                  decoration: InputDecoration(
                    labelText: '비밀번호',
                    prefixIcon: const Icon(Icons.lock_outlined),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16.0),
                    ),
                  ),
                ),
                const SizedBox(height: 32),

                // 5. 로그인 버튼
                // (메인 화면의 'Scan and collect' 버튼과 동일한 스타일)
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green, // 초록색 배경
                    foregroundColor: Colors.white, // 흰색 글씨
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  onPressed: _login, // _login 함수 호출
                  child: const Text(
                    '로그인',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                  ),
                ),
                const SizedBox(height: 16),

                // 6. 회원가입 / 비밀번호 찾기 (텍스트 버튼)
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextButton(
                      onPressed: () {
                        /* TODO: 회원가입 화면 이동 */
                      },
                      child: const Text('회원가입'),
                    ),
                    const Text('|', style: TextStyle(color: Colors.grey)),
                    TextButton(
                      onPressed: () {
                        /* TODO: 비밀번호 찾기 */
                      },
                      child: const Text('비밀번호 찾기'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
