// lib/screens/result_screen.dart

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:gnu_real_pbl/screens/main_screen.dart'; // 1. MainScreen import 추가

// 백엔드 응답 데이터를 담을 클래스
class ScanResult {
  final int id;
  final String name;
  final String category;
  final String howToRecycle;
  final String caution;

  ScanResult({
    required this.id,
    required this.name,
    required this.category,
    required this.howToRecycle,
    required this.caution,
  });

  // JSON 데이터를 객체로 변환하는 생성자
  factory ScanResult.fromJson(Map<String, dynamic> json) {
    return ScanResult(
      id: json['id'] ?? 0,
      name: json['name'] ?? '알 수 없음',
      category: json['category'] ?? '기타',
      howToRecycle: json['howToRecycle'] ?? '정보 없음',
      caution: json['caution'] ?? '정보 없음',
    );
  }
}

class ResultScreen extends StatelessWidget {
  final String imagePath; // 촬영한 이미지 경로
  final Map<String, dynamic> resultData; // 백엔드 응답 데이터

  const ResultScreen({
    super.key,
    required this.imagePath,
    required this.resultData,
  });

  @override
  Widget build(BuildContext context) {
    // 1. 받은 JSON 데이터를 객체로 변환
    final result = ScanResult.fromJson(resultData);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          '분석 결과',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
      ),
      body: Column(
        children: [
          // 2. 상단: 촬영한 이미지 표시
          Expanded(
            flex: 4, // 화면의 40% 차지
            child: Container(
              width: double.infinity,
              margin: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                image: DecorationImage(
                  image: FileImage(File(imagePath)), // 파일 경로로 이미지 로드
                  fit: BoxFit.cover,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 2,
                    blurRadius: 7,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
            ),
          ),

          // 3. 하단: 분석 결과 정보 표시
          Expanded(
            flex: 6, // 화면의 60% 차지
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(24),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 10,
                    offset: Offset(0, -5),
                  ),
                ],
              ),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // 품목명 및 카테고리 칩
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          result.name,
                          style: const TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        Chip(
                          label: Text(
                            result.category.toUpperCase(),
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          backgroundColor: Colors.green,
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),

                    // 배출 방법 섹션
                    _buildInfoSection(
                      title: '배출 방법',
                      content: result.howToRecycle,
                      icon: Icons.recycling,
                      color: Colors.blueAccent,
                    ),
                    const SizedBox(height: 20),

                    // 주의 사항 섹션
                    _buildInfoSection(
                      title: '주의 사항',
                      content: result.caution,
                      icon: Icons.warning_amber_rounded,
                      color: Colors.orangeAccent,
                    ),
                    const SizedBox(height: 30),

                    // [수정됨] 확인 버튼 (메인으로 이동)
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          // 기존 스택을 모두 비우고 MainScreen을 새로 띄웁니다.
                          // 이렇게 해야 뒤로가기를 눌러도 결과 화면이나 스캔 화면으로 돌아오지 않습니다.
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const MainScreen(),
                            ),
                            (route) => false, // 모든 이전 라우트 제거
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                        ),
                        child: const Text(
                          '확인',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // 정보 섹션을 만드는 헬퍼 위젯
  Widget _buildInfoSection({
    required String title,
    required String content,
    required IconData icon,
    required Color color,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(icon, color: color, size: 24),
            const SizedBox(width: 8),
            Text(
              title,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.grey[100],
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.grey[300]!),
          ),
          child: Text(
            content,
            style: const TextStyle(fontSize: 16, height: 1.5),
          ),
        ),
      ],
    );
  }
}
