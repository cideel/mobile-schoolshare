// lib/features/own_profile/content_tab/presentation/controllers/user_content_controller_active.dart

import 'package:get/get.dart';
import 'package:schoolshare/data/models/publication.dart';
import '../../domain/repositories/user_content_repository.dart';
import '../../data/datasources/dummy_content_uploaded.dart';

class UserContentController extends GetxController {
  final UserContentRepository _repository;

  UserContentController({required UserContentRepository repository}) 
      : _repository = repository;

  // Observable variables
  final RxList<Publication> _userContents = <Publication>[].obs;
  final RxBool _isLoading = false.obs;
  final RxString _error = ''.obs;
  final RxBool _hasError = false.obs;

  // Getters
  List<Publication> get userContents => _userContents;
  bool get isLoading => _isLoading.value;
  String get error => _error.value;
  bool get hasError => _hasError.value;
  bool get hasContent => _userContents.isNotEmpty;

  @override
  void onInit() {
    super.onInit();
    loadUserContent();
  }

  /// Memuat konten user dari API
  Future<void> loadUserContent() async {
    try {
      _isLoading.value = true;
      _hasError.value = false;
      _error.value = '';

      print('🔄 Starting to load user content from API...');
      final contents = await _repository.getUserUploadedContent();
      
      _userContents.value = contents;
      print('✅ Loaded ${contents.length} user contents from API');
      
      if (contents.isNotEmpty) {
        print('📋 First content: ${contents.first.title}');
        print('📋 Content types: ${contents.map((c) => c.type).toList()}');
      } else {
        print('📋 No content found for user');
      }

    } catch (e) {
      _hasError.value = true;
      _error.value = e.toString();
      print('❌ Error loading user content: $e');
      
      // Fallback ke mock data untuk development
      _fallbackToMockData();
    } finally {
      _isLoading.value = false;
    }
  }

  /// Fallback ke mock data jika API gagal
  void _fallbackToMockData() {
    print('🔄 Falling back to mock data...');
    
    try {
      // Gunakan data dummy yang sudah tersedia
      final mockContents = HomeMockData.getUserContent();
      _userContents.value = mockContents;
      print('✅ Loaded ${mockContents.length} mock contents as fallback');
    } catch (e) {
      print('❌ Error loading mock data: $e');
      _userContents.value = [];
    }
  }

  /// Refresh konten user
  Future<void> refreshUserContent() async {
    await loadUserContent();
  }

  /// Menambah konten baru ke list (setelah submit berhasil)
  void addNewContent(Publication newContent) {
    _userContents.insert(0, newContent); // Tambah di posisi teratas
    print('✅ Added new content to list: ${newContent.title}');
  }

  /// Menghapus konten dari list
  void removeContent(String contentId) {
    _userContents.removeWhere((content) => content.id.toString() == contentId);
    print('🗑️ Removed content with ID: $contentId');
  }

  /// Update konten di list
  void updateContent(Publication updatedContent) {
    final index = _userContents.indexWhere((content) => content.id == updatedContent.id);
    if (index != -1) {
      _userContents[index] = updatedContent;
      print('✏️ Updated content: ${updatedContent.title}');
    }
  }

  /// Clear error state
  void clearError() {
    _hasError.value = false;
    _error.value = '';
  }

  /// Get content stats
  Future<Map<String, dynamic>> getContentStats() async {
    try {
      return await _repository.getUserContentStats();
    } catch (e) {
      print('❌ Error getting content stats: $e');
      return {
        'total': 0,
        'total_reads': 0,
        'total_downloads': 0,
        'total_likes': 0,
        'total_shares': 0,
        'by_type': {},
      };
    }
  }
}
