// lib/screens/main_screen.dart

import 'package:flutter/material.dart';
import 'package:gnu_real_pbl/screens/scan_screen.dart';
import 'package:gnu_real_pbl/screens/search_screen.dart';
import 'package:gnu_real_pbl/screens/mypage_screen.dart'; // 마이페이지 import

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  // 0: 홈, 1: 북마크(미구현), 2: 마이페이지
  int _selectedIndex = 0;

  // --- 최근 스캔 기록 데이터 (임시) ---
  final List<Map<String, dynamic>> recentScans = [
    {'name': '투명 페트병', 'icon': Icons.local_drink_outlined, 'date': '오늘'},
    {'name': '종이 상자', 'icon': Icons.inventory_2_outlined, 'date': '오늘'},
    {'name': '알루미늄 캔', 'icon': Icons.local_drink_rounded, 'date': '어제'},
    {'name': '유리병', 'icon': Icons.wine_bar_outlined, 'date': '3일 전'},
    {'name': '플라스틱 컵', 'icon': Icons.local_cafe_outlined, 'date': '1주 전'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      // 홈 화면(Index 0)일 때만 AppBar 표시 (마이페이지 등은 자체 헤더 사용)
      appBar: _selectedIndex == 0
          ? AppBar(
              backgroundColor: const Color.fromARGB(255, 255, 255, 255),
              elevation: 0,
              automaticallyImplyLeading: false, // 뒤로가기 버튼 자동 생성 방지
              title: const Text(
                'Re:Cycle',
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 28,
                ),
              ),
              actions: [
                IconButton(
                  icon: const Icon(Icons.more_vert, color: Colors.black),
                  iconSize: 30.0,
                  onPressed: () {},
                ),
              ],
            )
          : null, // 다른 탭에서는 앱바 숨김

      // [핵심] 인덱스에 따라 화면 전환 (상태 유지됨)
      body: IndexedStack(
        index: _selectedIndex,
        children: [
          _buildHomeBody(), // Index 0: 홈 화면
          const Center(child: Text('북마크 화면 준비중...')), // Index 1: 북마크 (추후 구현)
          const MyPageScreen(), // Index 2: 마이페이지
        ],
      ),

      // FAB (스캔 버튼)
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const ScanScreen()),
          );
        },
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
        child: const Icon(Icons.recycling_rounded),
        shape: const CircleBorder(),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,

      // 하단 네비게이션 바
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        notchMargin: 8.0,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            // 1. 홈 탭 (Index 0)
            IconButton(
              icon: const Icon(Icons.home_outlined),
              // 선택된 탭이면 초록색, 아니면 회색
              color: _selectedIndex == 0 ? Colors.green : Colors.black54,
              onPressed: () {
                setState(() {
                  _selectedIndex = 0;
                });
              },
            ),

            // 2. 검색 (화면 이동 - 탭 아님)
            IconButton(
              icon: const Icon(Icons.search, color: Colors.black54),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const SearchScreen()),
                );
              },
            ),

            const SizedBox(width: 48), // FAB 공간

            // 3. 북마크 탭 (Index 1)
            IconButton(
              icon: const Icon(Icons.bookmark_border_outlined),
              color: _selectedIndex == 1 ? Colors.green : Colors.black54,
              onPressed: () {
                setState(() {
                  _selectedIndex = 1;
                });
              },
            ),

            // 4. 마이페이지 탭 (Index 2)
            IconButton(
              icon: const Icon(Icons.person_outline),
              color: _selectedIndex == 2 ? Colors.green : Colors.black54,
              onPressed: () {
                setState(() {
                  _selectedIndex = 2;
                });
              },
            ),
          ],
        ),
      ),
    );
  }

  // --- 홈 화면의 내용을 별도 함수로 분리 ---
  Widget _buildHomeBody() {
    // 실시간 날짜 계산 로직
    final now = DateTime.now(); // 오늘
    final yesterday = now.subtract(const Duration(days: 1)); // 어제
    final tomorrow = now.add(const Duration(days: 1)); // 내일

    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      children: [
        const SizedBox(height: 24),

        // 2. 오늘의 환경 팁 카드
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.green.withOpacity(0.1),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Row(
            children: [
              const Icon(Icons.lightbulb_outline,
                  color: Colors.green, size: 28),
              const SizedBox(width: 12),
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '오늘의 환경 Tip',
                      style: TextStyle(
                        color: Colors.green,
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      '다 쓴 치약 튜브는 잘라서 씻어 배출해요!',
                      style: TextStyle(
                        color: Colors.black87,
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),

        const SizedBox(height: 24),

        // 3. 요약 및 월 선택
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              '분리수거 7개 완료!',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey[300]!),
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Row(
                children: [
                  Text('12월'),
                  Icon(Icons.arrow_drop_down, color: Colors.grey),
                ],
              ),
            ),
          ],
        ),

        const SizedBox(height: 16),

        // 4. 에코 트리 & 진행률 카드
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [Color(0xFFE8F5E9), Colors.white],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
            borderRadius: BorderRadius.circular(24),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.1),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Row(
            children: [
              // 나무 아이콘 영역
              Container(
                width: 90,
                height: 90,
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.green.withOpacity(0.2),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    )
                  ],
                  border: Border.all(
                      color: Colors.green.withOpacity(0.1), width: 2),
                ),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Container(
                      width: 70,
                      height: 70,
                      decoration: BoxDecoration(
                        color: Colors.green.withOpacity(0.1),
                        shape: BoxShape.circle,
                      ),
                    ),
                    const Icon(Icons.park_rounded,
                        size: 48, color: Colors.green),
                    const Positioned(
                      top: 15,
                      right: 15,
                      child: Icon(Icons.auto_awesome,
                          size: 16, color: Colors.amber),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 20),

              // 텍스트 및 진행률 바
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      '이번 달 목표 달성을 위해!',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 4),
                    const Text(
                      '조금만 더 힘내세요 🌱',
                      style: TextStyle(fontSize: 14, color: Colors.grey),
                    ),
                    const SizedBox(height: 12),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: const LinearProgressIndicator(
                        value: 0.7,
                        minHeight: 10,
                        backgroundColor: Color(0xFFE0E0E0),
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.green),
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        '70%',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.green,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),

        const SizedBox(height: 24),

        // 5. 버튼 영역 (Search More & Scan)
        Row(
          children: [
            Expanded(
              child: OutlinedButton.icon(
                icon: const Icon(Icons.add_circle_outline, color: Colors.green),
                label:
                    const Text('더 찾아보기', style: TextStyle(color: Colors.black)),
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  side: BorderSide(color: Colors.grey[300]!, width: 1.5),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const SearchScreen()),
                  );
                },
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: ElevatedButton.icon(
                icon: const Icon(Icons.qr_code_scanner_rounded),
                label: const Text('스캔하기'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const ScanScreen()),
                  );
                },
              ),
            ),
          ],
        ),

        const SizedBox(height: 32),

        // 6. 최근 스캔 기록
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              '최근 스캔 기록',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            TextButton(
              onPressed: () {},
              child: const Text('전체보기', style: TextStyle(color: Colors.grey)),
            ),
          ],
        ),
        const SizedBox(height: 8),

        SizedBox(
          height: 140,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: recentScans.length,
            itemBuilder: (context, index) {
              final item = recentScans[index];
              return _buildRecentScanCard(
                item['name'],
                item['icon'],
                item['date'],
              );
            },
          ),
        ),

        const SizedBox(height: 32),
      ],
    );
  }

  // --- Helper Widgets ---

  Widget _buildRecentScanCard(String itemName, IconData icon, String date) {
    return Container(
      width: 120,
      margin: const EdgeInsets.only(right: 12),
      padding: const EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey[200]!),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.05),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.grey[100],
              shape: BoxShape.circle,
            ),
            child: Icon(icon, size: 28, color: Colors.green),
          ),
          const Spacer(),
          Text(
            itemName,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 4),
          Text(
            date,
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey[500],
            ),
          ),
        ],
      ),
    );
  }
}
