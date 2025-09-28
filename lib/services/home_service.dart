import 'package:get/get.dart';
import 'package:schoolshare/models/models.dart';

// Home Service - Business Logic untuk Home Page
class HomeService extends GetxService {
  // Storage untuk home data
  final RxList<Content> _contents = <Content>[].obs;
  final RxList<Content> _filteredContents = <Content>[].obs;
  final RxBool _isLoading = false.obs;
  final RxString _errorMessage = ''.obs;
  final RxString _selectedCategory = 'Semua'.obs;

  // Categories dan topics
  final List<String> _categories = [
    'Semua',
    'Peraturan',
    'Silabus',
    'Rencana Pembelajaran',
    'Materi',
    'Latihan Soal',
    'Lembar Kerja',
    'Evaluasi',
    'Modul',
    'Panduan',
  ];

  final List<String> _popularTopics = [
    'Kurikulum Merdeka',
    'Pembelajaran Digital',
    'Asesmen Formatif',
    'Diferensiasi',
    'Projek P5',
    'STEAM',
    'Literasi',
    'Numerasi',
  ];

  // Getters
  List<Content> get contents => _contents;
  List<Content> get filteredContents => _filteredContents;
  List<String> get categories => _categories;
  List<String> get popularTopics => _popularTopics;
  bool get isLoading => _isLoading.value;
  String get errorMessage => _errorMessage.value;
  String get selectedCategory => _selectedCategory.value;

  // Reactive getters
  RxList<Content> get contentsRx => _contents;
  RxList<Content> get filteredContentsRx => _filteredContents;
  RxBool get isLoadingRx => _isLoading;
  RxString get selectedCategoryRx => _selectedCategory;

  @override
  void onInit() {
    super.onInit();
    _initializeMockData();
    loadContents();

    // Listen to category changes
    ever(_selectedCategory, (_) => _filterContents());
  }

  // Initialize mock data
  void _initializeMockData() {
    _contents.addAll([
      Content(
        id: '1',
        title: 'Analisis Implementasi Machine Learning dan Artificial Intelligence dalam Sistem Pembelajaran Adaptif untuk Meningkatkan Efektivitas Pendidikan Digital',
        description: 'Penelitian komprehensif tentang penerapan teknologi ML dan AI dalam sistem pendidikan modern dengan fokus pada adaptasi pembelajaran individual.',
        type: 'Panduan',
        authors: [
          'Dr. Sari Indah Maharani Putri Dewi Sari',
          'Prof. Ahmad Fauzan Hakim Wijaya Santoso Raharjo', 
          'Dr. Maria Santos Rodriguez De La Cruz Martinez',
          'Dr. Budi Wijaya Kusuma Negara Dharma Putra',
          'Prof. Indira Kusuma Wardani Sari Maharani',
        ],
        authorId: 'author_1',
        institutionName: 'Universitas Indonesia',
        viewCount: 245,
        downloadCount: 78,
        recommendationCount: 42,
        createdAt: DateTime.now().subtract(Duration(days: 2)),
        isPublished: true,
        tags: ['machine learning', 'ai', 'pendidikan', 'digital'],
      ),
      Content(
        id: '2',
        title: 'Pengembangan Modul Projek Penguatan Profil Pelajar Pancasila (P5) dengan Pendekatan Kewirausahaan Sosial dan Teknologi Berkelanjutan',
        description: 'Modul projek penguatan profil pelajar Pancasila dengan tema kewirausahaan sosial terintegrasi teknologi berkelanjutan untuk siswa SMA.',
        type: 'Modul',
        authors: [
          'Rina Kusuma Dewi Anggraini Putri Maharani',
          'Dr. Johan Liebert Van Der Berg Wellington Smith',
          'Prof. Sarah Wilson Rodriguez Martinez De La Torre', 
          'Dr. Ahmad Rahman Habibie Kusuma Wardani Santoso',
        ],
        authorId: 'author_2',
        institutionName: 'Institut Teknologi Bandung',
        viewCount: 189,
        downloadCount: 65,
        recommendationCount: 28,
        createdAt: DateTime.now().subtract(Duration(days: 5)),
        isPublished: true,
        tags: ['p5', 'kewirausahaan', 'sosial', 'berkelanjutan'],
      ),
      Content(
        id: '3',
        title: 'Pengembangan Silabus Bahasa Indonesia Fase F dengan Integrasi Literasi Digital dan Keterampilan Abad 21',
        description: 'Silabus mata pelajaran Bahasa Indonesia untuk fase F (kelas XI-XII) dengan integrasi literasi digital dan keterampilan abad 21 sesuai kurikulum merdeka.',
        type: 'Silabus',
        authors: [
          'Dinda Pratiwi Maharani Dewi Sari Indah',
          'Dr. Siti Nurhaliza Anggraini Putri Kusuma',
          'Prof. Bambang Suryadi Hakim Wijaya Santoso',
          'Dr. Eka Purwanti Rodriguez Martinez De La Torre',
          'Dr. Rizki Pratama Van Der Berg Wellington',
          'Prof. Lestari Indah Maharani Kusuma Wardani',
          'Dr. Ahmad Fauzi Rahman Habibie Santoso',
        ],
        authorId: 'author_3',
        institutionName: 'Universitas Gadjah Mada',
        viewCount: 156,
        downloadCount: 43,
        recommendationCount: 19,
        createdAt: DateTime.now().subtract(Duration(hours: 18)),
        isPublished: true,
        tags: ['silabus', 'bahasa indonesia', 'literasi digital', 'abad 21'],
      ),
      Content(
        id: '4',
        title: 'Instrumen Asesmen Formatif Matematika Berbasis Higher Order Thinking Skills (HOTS) untuk Kurikulum Merdeka',
        description: 'Kumpulan instrumen asesmen formatif untuk mata pelajaran matematika tingkat SMP dengan pendekatan HOTS dan critical thinking.',
        type: 'Evaluasi',
        authors: [
          'Budi Santoso',
          'Dr. Andi Wijaya',
          'Prof. Sinta Dewi', 
          'Dr. Rahmat Hidayat',
        ],
        authorId: 'author_4',
        institutionName: 'Universitas Padjadjaran',
        viewCount: 134,
        downloadCount: 56,
        recommendationCount: 25,
        createdAt: DateTime.now().subtract(Duration(days: 1)),
        isPublished: true,
        tags: ['asesmen', 'formatif', 'matematika', 'hots'],
      ),
      Content(
        id: '5',
        title: 'Rencana Pembelajaran Sains Terintegrasi dengan Pendekatan Science, Technology, Engineering, Arts, and Mathematics (STEAM)',
        description: 'Template dan contoh rencana pembelajaran sains dengan pendekatan STEAM untuk meningkatkan kreativitas dan inovasi siswa.',
        type: 'Rencana Pembelajaran',
        authors: [
          'Prof. Indira Sari',
          'Dr. Maya Kusuma',
          'Dr. Fajar Pratama',
          'Prof. Lisa Anggraini',
          'Dr. Denny Setiawan',
        ],
        authorId: 'author_5',
        institutionName: 'Institut Teknologi Sepuluh Nopember',
        viewCount: 98,
        downloadCount: 34,
        recommendationCount: 15,
        createdAt: DateTime.now().subtract(Duration(hours: 6)),
        isPublished: true,
        tags: ['rpp', 'sains', 'steam', 'kreativitas'],
      ),
      Content(
        id: '6',
        title: 'Pengembangan Lembar Kerja Digital Berbasis Artificial Intelligence untuk Meningkatkan Literasi dan Numerasi Siswa',
        description: 'Worksheet interaktif berbasis AI untuk meningkatkan kemampuan literasi digital dan numerasi siswa dengan pendekatan gamifikasi.',
        type: 'Lembar Kerja',
        authors: [
          'Maya Sari',
          'Dr. Rizki Ramadhan',
          'Prof. Andi Kusuma',
          'Dr. Lina Marlina',
        ],
        authorId: 'author_6',
        institutionName: 'Universitas Brawijaya',
        viewCount: 87,
        downloadCount: 29,
        recommendationCount: 12,
        createdAt: DateTime.now().subtract(Duration(days: 3)),
        isPublished: true,
        tags: ['worksheet', 'ai', 'literasi', 'numerasi'],
      ),
    ]);

    _filteredContents.addAll(_contents);
  }

  // Load contents
  Future<void> loadContents() async {
    try {
      _isLoading.value = true;
      _errorMessage.value = '';

      // Simulate API call
      await Future.delayed(Duration(milliseconds: 1500));

      // Mock success - content already loaded in _initializeMockData
      _filterContents();
      _isLoading.value = false;

    } catch (e) {
      _isLoading.value = false;
      _errorMessage.value = e.toString();
      
      Get.snackbar(
        'Error',
        'Gagal memuat konten: ${e.toString()}',
        snackPosition: SnackPosition.TOP,
      );
    }
  }

  // Refresh data
  Future<void> refreshData() async {
    await loadContents();
  }

  // Set category filter
  void setCategory(String category) {
    _selectedCategory.value = category;
  }

  // Filter contents based on category
  void _filterContents() {
    if (_selectedCategory.value == 'Semua') {
      _filteredContents.value = List.from(_contents);
    } else {
      _filteredContents.value = _contents
          .where((content) => content.type == _selectedCategory.value)
          .toList();
    }
  }

  // Search contents
  List<Content> searchContents(String query) {
    if (query.isEmpty) return _filteredContents;

    return _filteredContents.where((content) =>
        content.title.toLowerCase().contains(query.toLowerCase()) ||
        content.description.toLowerCase().contains(query.toLowerCase()) ||
        content.tags.any((tag) => tag.toLowerCase().contains(query.toLowerCase()))
    ).toList();
  }

  // Get trending contents
  List<Content> getTrendingContents() {
    final sortedContents = List<Content>.from(_contents);
    sortedContents.sort((a, b) => b.viewCount.compareTo(a.viewCount));
    return sortedContents.take(5).toList();
  }

  // Get recent contents
  List<Content> getRecentContents() {
    final sortedContents = List<Content>.from(_contents);
    sortedContents.sort((a, b) => b.createdAt.compareTo(a.createdAt));
    return sortedContents.take(5).toList();
  }

  // Get recommended contents
  List<Content> getRecommendedContents() {
    final sortedContents = List<Content>.from(_contents);
    sortedContents.sort((a, b) => b.recommendationCount.compareTo(a.recommendationCount));
    return sortedContents.take(5).toList();
  }

  // Get contents by topic
  List<Content> getContentsByTopic(String topic) {
    return _contents.where((content) =>
        content.title.toLowerCase().contains(topic.toLowerCase()) ||
        content.description.toLowerCase().contains(topic.toLowerCase()) ||
        content.tags.any((tag) => tag.toLowerCase().contains(topic.toLowerCase()))
    ).toList();
  }

  // Clear error
  void clearError() {
    _errorMessage.value = '';
  }
}
