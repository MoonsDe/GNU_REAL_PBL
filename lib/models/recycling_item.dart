// lib/models/recycling_item.dart

class RecyclingItem {
  final String name; // 품목명 (ITEM_NAME)
  final String bigCategory; // 대분류 (BIG_CATEGORY)
  final String category; // 소분류 (CATEGORY)
  final String method; // 배출 방법 (DISPOSAL_METHOD)
  final String notes; // 주의사항 (NOTES)

  RecyclingItem({
    required this.name,
    required this.bigCategory,
    required this.category,
    required this.method,
    required this.notes,
  });
}

// --- 샘플 데이터 (PDF 내용을 여기에 추가하세요) ---
final List<RecyclingItem> recyclingData = [
  RecyclingItem(
    name: '생수통',
    bigCategory: '플라스틱',
    category: '페트병',
    method: '내용물을 비우고 라벨을 제거한 후 압착하여 배출합니다.',
    notes: '뚜껑은 닫아서 배출하거나 별도로 모아 배출합니다.',
  ),
  RecyclingItem(
    name: '신문지',
    bigCategory: '종이',
    category: '신문',
    method: '물기에 젖지 않게 하여 반듯하게 펴서 차곡차곡 쌓은 후 묶어서 배출합니다.',
    notes: '비닐 코팅된 광고지는 섞이지 않게 주의합니다.',
  ),
  RecyclingItem(
    name: '음료수 캔',
    bigCategory: '캔류',
    category: '알미늄/철캔',
    method: '내용물을 비우고 물로 헹군 후 배출합니다.',
    notes: '담배꽁초 등 이물질을 넣지 않습니다.',
  ),
  RecyclingItem(
    name: '택배 상자',
    bigCategory: '종이',
    category: '골판지',
    method: '테이프와 운송장 스티커를 완전히 제거하고 접어서 배출합니다.',
    notes: '이물질이 묻은 상자는 종량제 봉투에 버립니다.',
  ),
  RecyclingItem(
    name: '철캔',
    bigCategory: '캔',
    category: '금속캔',
    method:
        '1. 내용물을 비우고 물로 헹구는 등 이물질을 제거하여 배출하세요. \n\n 2. 담배꽁초 등 이물질을 넣지 않고 배출하세요. \n\n 3. 플라스틱 뚜껑 등 금속캔과 다른 재질은 제거한 후 배출하세요.',
    notes: '이물질이 묻은 상자는 종량제 봉투에 버립니다.',
  ),
];
