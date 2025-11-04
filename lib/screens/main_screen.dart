// lib/screens/main_screen.dart

import 'package:flutter/material.dart';
import 'package:gnu_real_pbl/screens/scan_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  // --- 캘린더 격자를 위한 임시 데이터 ---
  final List<bool> recyclingDays = [
    false,
    false,
    false,
    true,
    true,
    true,
    true,
    true,
    false,
    false,
    true,
    true,
    true,
    true,
    true,
    true,
    true,
    true,
    true,
    true,
    true,
    true,
    true,
    true,
    true,
    true,
    true,
    true,
    false,
    false,
    true,
  ];

  // --- (추가됨) 아이템 그리드를 위한 임시 데이터 ---
  // 나중에 DB에서 불러올 데이터입니다.
  final List<Map<String, dynamic>> recycledItems = [
    {'name': 'Plastic Cup', 'icon': Icons.local_cafe_outlined},
    {'name': 'Plastic Bag', 'icon': Icons.shopping_bag_outlined},
    {'name': 'Water Bottle', 'icon': Icons.water_drop_outlined},
    {'name': 'Cardboard Box', 'icon': Icons.inventory_2_outlined},
    {'name': 'Glass Jar', 'icon': Icons.wine_bar_outlined},
    {'name': 'Soda Can', 'icon': Icons.local_drink_outlined},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leadingWidth: 0,
        title: const Text(
          'My Collections',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 24,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.more_vert, color: Colors.black),
            onPressed: () {},
          ),
        ],
      ),
      body: ListView(
        // 부모 스크롤
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        children: [
          const SizedBox(height: 16),
          // --- 1. 날짜 선택기 ---
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildDateChip('18', 'June', isSelected: false),
              _buildDateChip('19', 'June', isSelected: false),
              _buildDateChip('20', 'June', isSelected: true),
            ],
          ),
          const SizedBox(height: 24),
          // --- 2. 요약 및 월 선택 ---
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                '12 items recycled',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey[300]!),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Row(
                  children: [
                    Text('3월'),
                    Icon(Icons.arrow_drop_down, color: Colors.grey),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          // --- 3. 재활용 캘린더 GridView ---
          Container(
            padding: const EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: Colors.grey[200]!),
            ),
            child: GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 7,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
              ),
              itemCount: recyclingDays.length,
              itemBuilder: (context, index) {
                return _buildCalendarCell(isRecycled: recyclingDays[index]);
              },
            ),
          ),
          const SizedBox(height: 24),
          // --- 4. 스캔 및 추가 버튼 ---
          Row(
            children: [
              Expanded(
                child: OutlinedButton.icon(
                  icon: const Icon(
                    Icons.add_circle_outline,
                    color: Colors.green,
                  ),
                  label: const Text(
                    'Add More',
                    style: TextStyle(color: Colors.black),
                  ),
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    side: BorderSide(color: Colors.grey[300]!, width: 1.5),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  // (수정됨) 여기는 비워둡니다.
                  onPressed: () {
                    // TODO: "Add More" 기능 나중에 구현
                  },
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: ElevatedButton.icon(
                  icon: const Icon(Icons.qr_code_scanner_rounded),
                  label: const Text('Scan and collect'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  // (수정됨) ScanScreen으로 가는 코드를 이쪽으로 옮깁니다.
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const ScanScreen(),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
          // --- (대체됨) 5. 아이템 목록 GridView ---
          const Text(
            'Items',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          GridView.builder(
            // GridView가 부모 ListView 안에서 스크롤되도록 설정
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),

            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3, // 1. 한 줄에 3개씩
              crossAxisSpacing: 12, // 가로 아이템 간격
              mainAxisSpacing: 12, // 세로 아이템 간격
              childAspectRatio: 0.9, // 아이템의 (가로 / 세로) 비율. 1.0은 정사각형.
            ),
            itemCount: recycledItems.length, // DB에서 가져온 아이템 개수
            itemBuilder: (context, index) {
              final item = recycledItems[index];
              // _buildItemCard 헬퍼 위젯을 재사용
              return _buildItemCard(item['name'], item['icon']);
            },
          ),
          const SizedBox(height: 32), // 하단 여백 추가
          // --- --------------------------------- ---
        ],
      ),
      // --- 6. 하단 네비게이션 바 및 중앙 버튼 ---
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
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
              icon: const Icon(Icons.bar_chart_outlined),
              onPressed: () {},
            ),
            const SizedBox(width: 48),
            IconButton(
              icon: const Icon(Icons.bookmark_border_outlined),
              onPressed: () {},
            ),
            IconButton(
              icon: const Icon(Icons.person_outline),
              onPressed: () {},
            ),
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

  // --- (수정됨) 아이템 카드 헬퍼 위젯 ---
  Widget _buildItemCard(String itemName, IconData icon) {
    // GridView가 크기와 위치를 제어하므로 width, margin 속성을 제거합니다.
    return Container(
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        // 3. Column의 mainAxisAlignment: MainAxisAlignment.center
        //    이것이 아이콘과 텍스트를 카드 *내부*에서 세로로 가운데 정렬시킵니다.
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 40, color: Colors.grey[600]),
          const SizedBox(height: 8),
          Text(
            itemName,
            textAlign: TextAlign.center, // 텍스트도 가운데 정렬
            overflow: TextOverflow.ellipsis, // 이름이 길면 ...으로 표시
          ),
        ],
      ),
    );
  }

  Widget _buildCalendarCell({required bool isRecycled}) {
    return Container(
      decoration: BoxDecoration(
        color: isRecycled ? const Color(0xFFAEE5C0) : const Color(0xFFECECEC),
        borderRadius: BorderRadius.circular(8),
      ),
    );
  }
}
