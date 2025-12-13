// lib/screens/mypage_screen.dart

import 'package:flutter/material.dart';
import 'package:gnu_real_pbl/screens/login_screen.dart';

class MyPageScreen extends StatelessWidget {
  const MyPageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      // 메인 화면의 바디로 들어가므로 AppBar는 자동으로 처리되거나 없어도 됩니다.
      // 하지만 스크롤 시 내용을 보호하기 위해 SafeArea를 사용합니다.
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),

              // 1. 프로필 헤더
              Row(
                children: [
                  // 프로필 이미지 (임시 아이콘)
                  Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.green, width: 2),
                    ),
                    child:
                        const Icon(Icons.person, size: 50, color: Colors.grey),
                  ),
                  const SizedBox(width: 20),
                  // 이름 및 이메일
                  const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'GNU_PBL', // 닉네임 (나중에 변수로 교체)
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        'Gnu_pbl@gnu.ac.kr', // 이메일
                        style: TextStyle(fontSize: 14, color: Colors.grey),
                      ),
                    ],
                  ),
                ],
              ),

              const SizedBox(height: 32),

              // 2. 나의 활동 요약 (그린 카드)
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [
                      Color.fromARGB(255, 116, 155, 118),
                      Color.fromARGB(255, 116, 180, 122)
                    ], // 초록 그라데이션
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.green.withOpacity(0.3),
                      blurRadius: 10,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '나의 에코 레벨',
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        ),
                        Icon(Icons.workspace_premium, color: Colors.white),
                      ],
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      'Lv. 3 ',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        _buildStatItem('분리수거', '12회'),
                        _buildVerticalLine(),
                        _buildStatItem('포인트', '1,250 P'),
                      ],
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 32),

              // 3. 메뉴 리스트
              const Text(
                '설정',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),

              _buildMenuButton(
                icon: Icons.notifications_outlined,
                text: '알림 설정',
                onTap: () {},
              ),
              _buildMenuButton(
                icon: Icons.campaign_outlined,
                text: '공지사항',
                onTap: () {},
              ),
              _buildMenuButton(
                icon: Icons.help_outline,
                text: '고객센터',
                onTap: () {},
              ),
              _buildMenuButton(
                icon: Icons.info_outline,
                text: '앱 정보 (v1.0.0)',
                onTap: () {},
              ),

              const SizedBox(height: 20),

              // 로그아웃 버튼
              Center(
                child: TextButton(
                  onPressed: () {
                    // 로그아웃 로직: 로그인 화면으로 이동하고 이전 스택 삭제
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const LoginScreen()),
                      (route) => false,
                    );
                  },
                  child: const Text(
                    '로그아웃',
                    style: TextStyle(
                        color: Colors.grey,
                        fontSize: 16,
                        decoration: TextDecoration.underline),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // 통계 아이템 위젯
  Widget _buildStatItem(String label, String value) {
    return Column(
      children: [
        Text(
          value,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(color: Colors.white.withOpacity(0.8), fontSize: 14),
        ),
      ],
    );
  }

  // 세로 구분선 위젯
  Widget _buildVerticalLine() {
    return Container(
      width: 1,
      height: 30,
      color: Colors.white.withOpacity(0.5),
    );
  }

  // 메뉴 버튼 위젯
  Widget _buildMenuButton({
    required IconData icon,
    required String text,
    required VoidCallback onTap,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.grey[50], // 아주 연한 회색 배경
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey[200]!),
      ),
      child: ListTile(
        leading: Icon(icon, color: Colors.green),
        title: Text(text, style: const TextStyle(fontWeight: FontWeight.w500)),
        trailing: const Icon(Icons.chevron_right, color: Colors.grey),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        onTap: onTap,
      ),
    );
  }
}
