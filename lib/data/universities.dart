class DropItemService {
  static final DropItemService _singleton = DropItemService._internal();

  factory DropItemService() {
    return _singleton;
  }
  DropItemService._internal();
  static List<String> get universities => _universities;
  static List<String> get grades => _grades;
  static List<String> get departments => _departments;

  static const List<String> _universities = [
    'Yıldız Teknik Üniversitesi',
    "İstanbul Teknik Üniversitesi",
    "Boğaziçi Üniversitesi",
    "Bahçeşehir Üniversitesi",
  ];

  static const List<String> _departments = [
    'Matematik Mühendisliği',
    "Makine Mühendisliği",
    "TIP",
    "Eczacılık",
    "Diş Hekimliği"
  ];

  static const List<String> _grades = [
    '9',
    '10',
    '11',
    '12',
    'Diğer',
  ];
}
