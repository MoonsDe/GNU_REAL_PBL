// lib/screens/main_screen.dart

import 'package:flutter/material.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Scaffold는 화면의 기본 뼈대(상단바, 본문)를 제공합니다.
    return Scaffold(
      appBar: AppBar(title: const Text('Re:Cycle 메인')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center, // 자식들을 세로 중앙에 배치
          children: [
            // 1. 재활용품 촬영 버튼 (임시)
            ElevatedButton(onPressed: () {}, child: const Text('재활용품 촬영하기')),

            const SizedBox(height: 20), // 버튼 사이에 간격 주기
            // 2. 분리수거 가이드 버튼 (임시)
            ElevatedButton(onPressed: () {}, child: const Text('분리수거 가이드 보기')),
          ],
        ),
      ),
    );
  }
}
