// lib/screens/main_screen.dart

import 'package:flutter/material.dart';
import 'package:gnu_real_pbl/screens/scan_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  // --- 월 이름을 영어로 변환하기 위한 리스트 ---
  final List<String> _monthNames = [
    'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
    'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'
  ];

  // --- 캘린더 격자를 위한 임시 데이터 ---
  final List<bool> recyclingDays = [
    false, false, false, true, true, true, true,
    true, false, false, true, true, true, true,
    true, true, true, true, true, true, true,
    true, true, true, true, true, true, true,
    false, false, true,
  ];

  // --- 아이템 그리드를 위한 임시 데이터 ---
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
    // --- 실시간 날짜 계산 로직 ---
    final now = DateTime.now(); // 오늘
    final yesterday = now.subtract(const Duration(days: 1)); // 어제
    final tomorrow = now.add(const Duration(days: 1)); // 내일

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leadingWidth: 0,
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
          
          // --- 1. 실시간 날짜 선택기 ---
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              // 어제
              _buildDateChip(
                yesterday.day.toString(),
                _monthNames[yesterday.month - 1],
                isSelected: false,
              ),
              // 오늘 (선택됨)
              _buildDateChip(
                now.day.toString(),
                _monthNames[now.month - 1],
                isSelected: true,
              ),
              // 내일
              _buildDateChip(
                tomorrow.day.toString(),
                _monthNames[tomorrow.month - 1],
                isSelected: false,
              ),
            ],
          ),
          
          const SizedBox(height: 28),
          
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
                child: Row(
                  children: [
                    // 현재 월 표시
                    Text('${now.month}월'), 
                    const Icon(Icons.arrow_drop_down, color: Colors.grey),
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
          
          // --- 5. 아이템 목록 GridView ---
          const SizedBox(height: 32),
          const Text(
            'Items',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              childAspectRatio: 0.9,
            ),
            itemCount: recycledItems.length,
            itemBuilder: (context, index) {
              final item = recycledItems[index];
              return _buildItemCard(item['name'], item['icon']);
            },
          ),
          const SizedBox(height: 32),
        ],
      ),
      
      // --- 6. 하단 네비게이션 바 및 중앙 버튼 ---
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
              icon: const Icon(Icons.search), // 돋보기 아이콘
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

  Widget _buildItemCard(String itemName, IconData icon) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 40, color: Colors.grey[600]),
          const SizedBox(height: 8),
          Text(
            itemName,
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
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