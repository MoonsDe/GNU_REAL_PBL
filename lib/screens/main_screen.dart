// lib/screens/main_screen.dart

import 'package:flutter/material.dart';
import 'package:gnu_real_pbl/screens/scan_screen.dart';
import 'package:gnu_real_pbl/screens/search_screen.dart'; // 검색 화면 import

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  // --- 최근 스캔 기록 데이터 ---
  final List<Map<String, dynamic>> recentScans = [
    {'name': '투명 페트병', 'icon': Icons.local_drink_outlined, 'date': '오늘'},
    {'name': '종이 상자', 'icon': Icons.inventory_2_outlined, 'date': '오늘'},
    {'name': '알루미늄 캔', 'icon': Icons.local_drink_rounded, 'date': '어제'},
    {'name': '유리병', 'icon': Icons.wine_bar_outlined, 'date': '3일 전'},
    {'name': '플라스틱 컵', 'icon': Icons.local_cafe_outlined, 'date': '1주 전'},
  ];

  @override
  Widget build(BuildContext context) {
    // --- 실시간 날짜 계산 로직 ---
    final now = DateTime.now(); // 오늘
    final yesterday = now.subtract(const Duration(days: 1)); // 어제
    final tomorrow = now.add(const Duration(days: 1)); // 내일

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        // [수정됨] 뒤로가기 버튼 제거 및 자동 생성 방지
        automaticallyImplyLeading: false,
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
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        children: [
          const SizedBox(height: 4),
          const SizedBox(height: 24),

          // --- 2. 오늘의 환경 팁 카드 ---
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

          // --- 3. 요약 및 월 선택 ---
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                '분리수거 7개 완료!',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey[300]!),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: [
                    Text('${now.month}월'),
                    const Icon(Icons.arrow_drop_down, color: Colors.grey),
                  ],
                ),
              ),
            ],
          ),

          const SizedBox(height: 16),

          // --- 4. 에코 트리 & 진행률 카드 ---
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
                  color: Colors.green.withOpacity(0.2),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Row(
              children: [
                Container(
                  width: 90,
                  height: 90,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 5,
                        offset: Offset(0, 2),
                      )
                    ],
                  ),
                  child: const Center(
                    child: Icon(Icons.park, size: 50, color: Colors.green),
                  ),
                ),
                const SizedBox(width: 20),
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
                          valueColor:
                              AlwaysStoppedAnimation<Color>(Colors.green),
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

          // --- 5. 스캔 및 추가 버튼 ---
          Row(
            children: [
              Expanded(
                child: OutlinedButton.icon(
                  icon:
                      const Icon(Icons.add_circle_outline, color: Colors.green),
                  label: const Text('더 찾아보기',
                      style: TextStyle(color: Colors.black)),
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
                      MaterialPageRoute(
                          builder: (context) => const ScanScreen()),
                    );
                  },
                ),
              ),
            ],
          ),

          const SizedBox(height: 32),

          // --- 6. 최근 스캔 기록 (가로 스크롤) ---
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
            height: 140, // 카드 높이
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
      ),

      // --- FAB 및 하단 바 ---
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
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        notchMargin: 8.0,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(icon: const Icon(Icons.home_outlined), onPressed: () {}),
            IconButton(
              icon: const Icon(Icons.search),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const SearchScreen()),
                );
              },
            ),
            const SizedBox(width: 48),
            IconButton(
                icon: const Icon(Icons.bookmark_border_outlined),
                onPressed: () {}),
            IconButton(
                icon: const Icon(Icons.person_outline), onPressed: () {}),
          ],
        ),
      ),
    );
  }

  // --- Helper Widgets ---

  Widget _buildDateChip(String day, String month, {bool isSelected = false}) {
    return Column(
      children: [
        if (isSelected)
          const Icon(Icons.check_circle, color: Colors.green, size: 20)
        else
          const SizedBox(height: 20),
        const SizedBox(height: 4),
        Text(
          day,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: isSelected ? Colors.black : Colors.grey[400],
          ),
        ),
        Text(
          month,
          style: TextStyle(color: isSelected ? Colors.black : Colors.grey[400]),
        ),
      ],
    );
  }

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
