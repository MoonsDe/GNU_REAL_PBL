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
    name: '신문',
    bigCategory: '종이',
    category: '종이류',
    method: '반듯하게 펴서 차곡차곡 쌓은 후 흩날리지 않도록 끈 등으로 묶어서 배출하세요.',
    notes: '비닐 코팅된 전단지나 광고지는 섞이지 않도록 골라내어 일반 종량제 봉투로 버려주세요.',
  ),
  RecyclingItem(
    name: '책자',
    bigCategory: '종이',
    category: '종이류',
    method: '스프링 등 종이류와 다른 재질은 제거한 후 배출하세요.',
    notes: '겉표지가 비닐 코팅되어 있다면 표지는 뜯어서 일반 쓰레기로 버리고, 내지만 재활용해주세요.',
  ),
  RecyclingItem(
    name: '노트',
    bigCategory: '종이',
    category: '종이류',
    method: '스프링 등 종이류와 다른 재질은 제거한 후 배출하세요.',
    notes: '스프링 제본된 경우, 스프링(철/플라스틱)을 반드시 제거하고 종이만 배출해야 합니다.',
  ),
  RecyclingItem(
    name: '상자',
    bigCategory: '종이',
    category: '종이류',
    method: '테이프 등 종이류와 다른 재질은 제거한 후 배출하세요.',
    notes: '운송장 스티커와 테이프는 비닐류이므로 완벽히 제거한 후, 납작하게 접어서 배출해주세요.',
  ),
  RecyclingItem(
    name: '감열지(영수증)',
    bigCategory: '일반쓰레기',
    category: '혼합 재질',
    method: '종량제 봉투로 배출하세요.',
    notes: '약품 처리가 된 종이이므로 재활용이 불가능합니다. 반드시 일반 쓰레기(종량제 봉투)로 버려주세요.',
  ),
  RecyclingItem(
    name: '금박지,은박지',
    bigCategory: '일반쓰레기',
    category: '혼합 재질',
    method: '종량제 봉투로 배출하세요.',
    notes: '알루미늄이나 비닐이 혼합된 재질이므로 재활용이 안 됩니다. 일반 쓰레기로 배출하세요.',
  ),
  RecyclingItem(
    name: '혼합 벽지',
    bigCategory: '일반쓰레기',
    category: '혼합 재질',
    method: '종량제 봉투로 배출하세요.',
    notes: '실크 벽지나 PVC 코팅 벽지는 재활용이 불가하므로 일반 쓰레기로 배출해야 합니다.',
  ),
  RecyclingItem(
    name: '종이팩',
    bigCategory: '종이',
    category: '종이팩',
    method:
        '1. 내용물을 비우고 이물질을 제거한 후 말려서 배출하세요.\n2. 빨대, 비닐 등 다른 재질 제거 후 배출하세요.\n3. 일반 종이류와 혼합되지 않게 종이팩 전용수거함에 배출하세요.',
    notes: '일반 폐지와 섞이면 재활용이 안 됩니다. 가능하다면 주민센터 등에서 화장지로 교환하세요.',
  ),
  RecyclingItem(
    name: '종이컵',
    bigCategory: '종이',
    category: '종이팩',
    method: '내용물을 비우고 이물질을 제거한 후 배출하세요.',
    notes: '내부에 코팅이 되어 있어 일반 종이와 다릅니다. 이물질이 묻었다면 일반 쓰레기로 버려주세요.',
  ),
  RecyclingItem(
    name: '철캔',
    bigCategory: '캔',
    category: '금속캔',
    method:
        '1. 내용물을 비우고 물로 헹구는 등 이물질을 제거하여 배출하세요.\n2. 담배꽁초 등 이물질을 넣지 않고 배출하세요.\n3. 플라스틱 뚜껑 등 금속캔과 다른 재질은 제거한 후 배출하세요.',
    notes: '캔 속에 담배꽁초 등 이물질을 넣으면 재활용 공정에서 문제가 발생하므로 절대 넣지 마세요.',
  ),
  RecyclingItem(
    name: '알루미늄캔',
    bigCategory: '캔',
    category: '금속캔',
    method:
        '1. 내용물을 비우고 물로 헹구는 등 이물질을 제거하여 배출하세요.\n2. 담배꽁초 등 이물질을 넣지 않고 배출하세요.\n3. 플라스틱 뚜껑 등 금속캔과 다른 재질은 제거한 후 배출한다.',
    notes: '찌그러뜨려서 부피를 줄이면 수거와 처리가 더 효율적입니다. 뚜껑과 본체가 다른 재질이면 분리하세요.',
  ),
  RecyclingItem(
    name: '부탄가스',
    bigCategory: '캔',
    category: '금속캔',
    method: '내용물을 제거한 후 배출하세요.',
    notes: '가스용기는 가급적 통풍이 잘되는 장소에서 노즐을 누르는 등 내용물을 완전히 제거한 후 배출',
  ),
  RecyclingItem(
    name: '살충제용기',
    bigCategory: '캔',
    category: '금속캔',
    method: '내용물을 제거한 후 배출하세요.',
    notes: '가스용기는 가급적 통풍이 잘되는 장소에서 노즐을 누르는 등 내용물을 완전히 제거한 후 배출',
  ),
  RecyclingItem(
    name: '고철',
    bigCategory: '기타',
    category: '고철류',
    method: '이물질이 섞이지 않도록 한 후 배출하세요.',
    notes: '',
  ),
  RecyclingItem(
    name: '비철금속',
    bigCategory: '기타',
    category: '비철금속',
    method: '이물질이 섞이지 않도록 한 후 배출하세요.',
    notes: '',
  ),
  RecyclingItem(
    name: '음료수병',
    bigCategory: '유리',
    category: '음료수병',
    method:
        '1. 내용물을 비우고 물로 헹구는 등 이물질을 제거하여 배출하세요.\n2. 담배꽁초 등 이물질을 넣지않고 배출하세요.\n3.유리병이 깨지지 않도록 주의하여 배출하세요.\n4. 소주, 맥주 등 빈용기보증금 대상 유리병은 소매점 등으로 반납하여 보증금 환급받을 수 있습니다.',
    notes:
        '빈용기 보증금 제도 : 사용된 빈 병을 회수하고 재사용을 촉진하기 위해 제품의 가격에(빈용기보증금)을 포함시켜 판매한다. 소비자는 유리용기의 제품을 구입한 후, 빈용기보증금 제품을 취급하고 있는 슈퍼, 대형마트 등의 소매점에 반환하면 (빈용기보증금)을 다시 돌려받을 수 있다. 환불가능한 빈 병의 유형 : 빈용기 정면 또는 측면에 재사용 표시가 있는 경우 (소주, 맥주, 청량음료 등), 환불 불가능 : 유리분표 배출표가 있는 경우 (드링크 병, 소형 주스 등)',
  ),
  RecyclingItem(
    name: '기타병류',
    bigCategory: '유리',
    category: '기타병류',
    method:
        '1. 내용물을 비우고 물로 헹구는 등 이물질을 제거하여 배출하세요.\n2. 담배꽁초 등 이물질을 넣지않고 배출하세요.\n3. 유리병이 깨지지 않도록 주의하여 배출하세요.\n4. 소주, 맥주 등 빈용기보증금 대상 유리병은 소매점 등으로 반납하여 보증금 환급받을 수 있습니다.',
    notes: '',
  ),
  RecyclingItem(
    name: '페트병',
    bigCategory: '플라스틱',
    category: '페트병류',
    method:
        '1. 내용물을 비우고 물로 헹구는 등 이물질을 제거하여 배출하세요.\n2.부착상표, 부속품 등 본체와 다른 재질은 제거한 후 배출하세요.',
    notes: '',
  ),
  RecyclingItem(
    name: '플라스틱 용기',
    bigCategory: '플라스틱',
    category: '플라스틱 용기류',
    method:
        '1. 내용물을 비우고 물로 헹구는 등 이물질을 제거하여 배출하세요.\n2. 부착상표, 부속품 등 본체와 다른 재질은 제거한 후 배출하세요.',
    notes: '',
  ),
  RecyclingItem(
    name: '비닐포장재',
    bigCategory: '비닐',
    category: '비닐류(필름류)',
    method: '1. 내용물을 비우고 물로 헹구는 등 이물질을 제거하여 배출하세요.\n2. 흩날리지 않도록 봉투에 담아 배출하세요.',
    notes: '',
  ),
  RecyclingItem(
    name: '1회용비닐봉투',
    bigCategory: '비닐',
    category: '비닐류(필름류)',
    method: '1. 내용물을 비우고 물로 헹구는 등 이물질을 제거하여 배출하세요.\n2. 흩날리지 않도록 봉투에 담아 배출하세요.',
    notes: '',
  ),
  RecyclingItem(
    name: '스티로폼 완충제',
    bigCategory: '스티로폼',
    category: '발포합성수지(스티로폼)',
    method:
        '1. 내용물을 비우고 물로 헹구는 등 이물질을 제거하여 배출하세요.\n2. 부착상표 등 스티로폼과 다른 재질은 제거한 후 배출하세요.\n3.TV 등 전자제품 구입 시 완충제로 사용되는 발포합성수지 포장재는 가급적 구입처로 반납하세요.',
    notes: '',
  ),
  RecyclingItem(
    name: '의류 및 원단류',
    bigCategory: '의류',
    category: '의류 및 원단류',
    method:
        '1. 폐의류 전용수거함에 배출하세요.\n2. 전용수거함이 없는 문전수거 지역 등에서는 물기에 젖지 않도록 마대 등에 담거나 묶어서 배출하세요.',
    notes: '',
  ),
  RecyclingItem(
    name: '폐식용유',
    bigCategory: '기타',
    category: '폐식용유',
    method: '1. 음식물 등 이물질이 섞이지 않게 모아 폐식용유 전용 수거함에 배출하세요.',
    notes: '',
  ),
  RecyclingItem(
    name: '농약 용기',
    bigCategory: '유해 폐기물',
    category: '영농폐기물류',
    method: '1. 폐농약 플라스틱 용기, 폐농약 봉지류만 투명 그물망(배추망, 양파망)에 모아서 배출하세요.',
    notes: '(수거보상비 지급)',
  ),
  RecyclingItem(
    name: '농촌 폐비닐',
    bigCategory: '기타',
    category: '영농폐기물류',
    method:
        '1. 하우스용 비닐과 멀칭용 비닐을 구분하여 흙과 자갈, 잡초를 털어낸 후 운반이 쉽도록 묶어주세요.\n2. 마을 공동집하장 또는 수거.운반차량 진입이 가능한 일정 장소에 보관하세요.',
    notes: '',
  ),
  RecyclingItem(
    name: '폐형광등',
    bigCategory: '유해 폐기물',
    category: '폐형광등',
    method:
        '1. 유해물질을 포함하고 있으므로 깨지지 않도록 주의하여 폐형광등 전용수거함에 배출하세요.\n2. 깨진 폐형광등은 신문지 등으로 감싸 사람이 찔리거나 베이지 않도록 하여 종량제 봉투에 담아 배출하세요.',
    notes:
        '재화룡이 가능한 형광등 종류 : 직관형 형광램프(FL), 환형(원형)형광램프(FCL), 안정기 내장형램프(CFL), 콤팩트형 램프(FPL)',
  ),
  RecyclingItem(
    name: '폐건전지',
    bigCategory: '유해 폐기물',
    category: '폐건전지',
    method:
        '1. 전지를 제품에서 분리하여 배출하세요.\n2. 주요거점(동 주민센터. 아파트의 폐형광등.폐건전지 일체함 또는 편의점, 아파트 동별 우편함 등)의 전용수거함에 배출하세요.',
    notes: '휴대폰 배터리 버리는 방법 : 휴대폰배터리는 휴대폰과 함께 배출한다.',
  ),
];
