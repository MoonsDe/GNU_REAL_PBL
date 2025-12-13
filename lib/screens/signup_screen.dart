// lib/screens/signup_screen.dart

import 'package:flutter/material.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  // 텍스트 입력을 제어하기 위한 컨트롤러들
  final _nicknameController = TextEditingController(); // 닉네임 컨트롤러
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  @override
  void dispose() {
    // 위젯이 종료될 때 컨트롤러도 정리합니다.
    _nicknameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _signup() {
    // TODO: 실제 회원가입 로직 구현 (API 연동)
    // 1. 입력값 유효성 검사 (비밀번호 일치 여부, 빈칸 확인 등)
    // 2. 백엔드 서버로 데이터 전송 (닉네임, 이메일, 비번)

    // [수정됨] 회원가입 성공 알림창(SnackBar)을 띄우고 이전 화면으로 돌아갑니다.
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('회원가입 성공! 로그인해주세요.'),
        duration: Duration(seconds: 2), // 2초 동안 보여줌
        behavior: SnackBarBehavior.floating, // 하단에 띄우는 스타일
      ),
    );

    // 현재 화면(회원가입)을 닫고(pop) 로그인 화면으로 돌아갑니다.
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // 배경색 통일
      // 상단 앱바 (뒤로가기 버튼을 위해)
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
          onPressed: () => Navigator.pop(context), // 뒤로가기
        ),
      ),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              // [수정됨] 기존 MainAxisAlignment.center 에서 start로 변경하여 위쪽부터 배치
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // [수정됨] Transform.translate를 사용하여 강제로 위로 끌어올립니다.
                // dy 값을 -20, -30 등으로 조절하여 원하는 만큼 올릴 수 있습니다.
                Transform.translate(
                  offset: const Offset(0, -30), // 위로 30픽셀 이동
                  child: Column(
                    children: const [
                      // 1. 타이틀
                      Text(
                        '회원가입',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        'Re:Cycle과 함께 지구를 지켜요!',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 16, color: Colors.grey),
                      ),
                    ],
                  ),
                ),
                
                // [수정됨] 타이틀과 입력창 사이의 간격을 요청하신 대로 48로 유지합니다.
                const SizedBox(height: 48),

                // 2. 닉네임 입력
                _buildTextField(
                  controller: _nicknameController,
                  label: '닉네임',
                  icon: Icons.badge_outlined,
                ),
                const SizedBox(height: 16),

                // 3. 이메일 입력
                _buildTextField(
                  controller: _emailController,
                  label: '이메일',
                  icon: Icons.email_outlined,
                  inputType: TextInputType.emailAddress,
                ),
                const SizedBox(height: 16),

                // 4. 비밀번호 입력
                _buildTextField(
                  controller: _passwordController,
                  label: '비밀번호',
                  icon: Icons.lock_outline,
                  isObscure: true,
                ),
                const SizedBox(height: 16),

                // 5. 비밀번호 확인 입력
                _buildTextField(
                  controller: _confirmPasswordController,
                  label: '비밀번호 확인',
                  icon: Icons.lock_outline,
                  isObscure: true,
                ),
                const SizedBox(height: 32),

                // 6. 가입하기 버튼
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green, // 초록색 포인트
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  onPressed: _signup, // _signup 함수 호출
                  child: const Text(
                    '가입하기',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                  ),
                ),

                // 하단 여백 추가 (스크롤 시 잘림 방지)
                const SizedBox(height: 40),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // 디자인 통일성을 위해 텍스트 필드를 만드는 헬퍼 위젯
  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    bool isObscure = false,
    TextInputType inputType = TextInputType.text,
  }) {
    return TextField(
      controller: controller,
      obscureText: isObscure,
      keyboardType: inputType,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16.0), // 둥근 모서리 통일
        ),
        // 포커스 됐을 때 초록색 테두리
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16.0),
          borderSide: const BorderSide(color: Colors.green, width: 2.0),
        ),
      ),
    );
  }
}