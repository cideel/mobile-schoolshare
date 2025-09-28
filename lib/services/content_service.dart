import 'package:get/get.dart';
import 'package:schoolshare/models/models.dart';

// Content Service - Business Logic untuk Content Management
class ContentService extends GetxService {
  // Storage untuk content data
  final RxList<Content> _userContents = <Content>[].obs;
  final RxList<Content> _allContents = <Content>[].obs;
  final RxBool _isLoading = false.obs;
  final RxString _errorMessage = ''.obs;

  // Getters
  List<Content> get userContents => _userContents;
  List<Content> get allContents => _allContents;
  bool get isLoading => _isLoading.value;
  String get errorMessage => _errorMessage.value;

  // Reactive getters
  RxList<Content> get userContentsRx => _userContents;
  RxList<Content> get allContentsRx => _allContents;
  RxBool get isLoadingRx => _isLoading;

  @override
  void onInit() {
    super.onInit();
    _initializeMockData();
  }

  // Initialize mock data
  void _initializeMockData() {
    _userContents.addAll([
      Content(
        id: '1',
        title: 'Panduan Kurikulum Merdeka',
        description: 'Panduan lengkap implementasi kurikulum merdeka di sekolah menengah.',
        type: 'Panduan',
        authors: ['Johan Liebert'],
        authorId: 'user_1',
        viewCount: 125,
        downloadCount: 45,
        recommendationCount: 23,
        createdAt: DateTime.now().subtract(Duration(days: 7)),
        isPublished: true,
        tags: ['kurikulum', 'panduan', 'pendidikan'],
      ),
      Content(
        id: '2',
        title: 'Modul Pembelajaran Digital',
        description: 'Modul komprehensif untuk pembelajaran berbasis teknologi digital.',
        type: 'Modul',
        authors: ['Johan Liebert'],
        authorId: 'user_1',
        viewCount: 89,
        downloadCount: 32,
        recommendationCount: 15,
        createdAt: DateTime.now().subtract(Duration(days: 3)),
        isPublished: true,
        tags: ['digital', 'teknologi', 'pembelajaran'],
      ),
      Content(
        id: '3',
        title: 'Rencana Pembelajaran Semester',
        description: 'Template dan panduan penyusunan RPS yang efektif.',
        type: 'Rencana Pembelajaran',
        authors: ['Johan Liebert'],
        authorId: 'user_1',
        viewCount: 67,
        downloadCount: 28,
        recommendationCount: 12,
        createdAt: DateTime.now().subtract(Duration(days: 1)),
        isPublished: false,
        tags: ['rps', 'perencanaan', 'semester'],
      ),
    ]);

    _allContents.addAll(_userContents);
  }

  // Load user's content
  Future<void> loadUserContents() async {
    try {
      _isLoading.value = true;
      _errorMessage.value = '';

      // Simulate API call
      await Future.delayed(Duration(milliseconds: 1000));

      // Mock success - content already loaded in _initializeMockData
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

  // Load all content
  Future<void> loadAllContents() async {
    try {
      _isLoading.value = true;
      _errorMessage.value = '';

      // Simulate API call
      await Future.delayed(Duration(milliseconds: 1000));

      // Mock success
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

  // Refresh user's content
  Future<void> refreshUserContents() async {
    await loadUserContents();
  }

  // Submit new content
  Future<bool> submitContent(Content content, String fileName) async {
    try {
      _isLoading.value = true;
      _errorMessage.value = '';

      // Simulate file upload and content creation
      await Future.delayed(Duration(milliseconds: 2000));

      // Add to user contents
      final newContent = content.copyWith(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        fileUrl: 'https://example.com/files/$fileName',
        isPublished: true,
      );

      _userContents.insert(0, newContent);
      _allContents.insert(0, newContent);

      _isLoading.value = false;
      return true;

    } catch (e) {
      _isLoading.value = false;
      _errorMessage.value = e.toString();
      
      Get.snackbar(
        'Error',
        'Gagal mengunggah konten: ${e.toString()}',
        snackPosition: SnackPosition.TOP,
      );
      return false;
    }
  }

  // Delete content
  Future<bool> deleteContent(String contentId) async {
    try {
      _isLoading.value = true;
      _errorMessage.value = '';

      // Simulate API call
      await Future.delayed(Duration(milliseconds: 500));

      // Remove from lists
      _userContents.removeWhere((content) => content.id == contentId);
      _allContents.removeWhere((content) => content.id == contentId);

      _isLoading.value = false;
      return true;

    } catch (e) {
      _isLoading.value = false;
      _errorMessage.value = e.toString();
      
      Get.snackbar(
        'Error',
        'Gagal menghapus konten: ${e.toString()}',
        snackPosition: SnackPosition.TOP,
      );
      return false;
    }
  }

  // Toggle bookmark
  Future<void> toggleBookmark(String contentId) async {
    try {
      // Simulate API call
      await Future.delayed(Duration(milliseconds: 300));

      // TODO: Implement bookmark logic
      Get.snackbar(
        'Info',
        'Fitur bookmark akan segera tersedia',
        snackPosition: SnackPosition.BOTTOM,
      );

    } catch (e) {
      Get.snackbar(
        'Error',
        'Gagal mengubah bookmark: ${e.toString()}',
        snackPosition: SnackPosition.TOP,
      );
    }
  }

  // Clear error
  void clearError() {
    _errorMessage.value = '';
  }

  // Search content
  List<Content> searchContent(String query) {
    if (query.isEmpty) return _allContents;

    return _allContents.where((content) =>
        content.title.toLowerCase().contains(query.toLowerCase()) ||
        content.description.toLowerCase().contains(query.toLowerCase()) ||
        content.tags.any((tag) => tag.toLowerCase().contains(query.toLowerCase()))
    ).toList();
  }

  // Get content by type
  List<Content> getContentByType(String type) {
    return _allContents.where((content) => content.type == type).toList();
  }

  // Get content statistics
  Map<String, int> getContentStatistics(String userId) {
    final userContent = _allContents.where((content) => content.authorId == userId).toList();
    
    return {
      'totalContent': userContent.length,
      'totalViews': userContent.fold(0, (sum, content) => sum + content.viewCount),
      'totalDownloads': userContent.fold(0, (sum, content) => sum + content.downloadCount),
      'totalRecommendations': userContent.fold(0, (sum, content) => sum + content.recommendationCount),
      'publishedContent': userContent.where((content) => content.isPublished).length,
    };
  }
}
