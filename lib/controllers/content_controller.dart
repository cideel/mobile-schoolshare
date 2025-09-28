import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:schoolshare/services/content_service.dart';
import 'package:schoolshare/models/models.dart';

// Content Controller - UI Logic untuk Content Management
class ContentController extends GetxController {
  // Get service
  final ContentService _contentService = Get.find<ContentService>();

  // Form controllers untuk submit content
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  // UI state
  final RxString selectedContentType = 'Peraturan'.obs;
  final RxString selectedAuthor = ''.obs;
  final RxString uploadedFileName = ''.obs;
  final RxBool isFormValid = false.obs;
  final RxInt currentTab = 0.obs; // 0: Profil, 1: Konten, 2: Statistik

  // Content types untuk bottom sheet
  final List<Map<String, dynamic>> contentTypes = [
    {'name': 'Peraturan', 'color': 0xFF4CAF50},
    {'name': 'Silabus', 'color': 0xFF2196F3},
    {'name': 'Rencana Pembelajaran', 'color': 0xFFFF9800},
    {'name': 'Materi', 'color': 0xFF9C27B0},
    {'name': 'Latihan Soal', 'color': 0xFFE91E63},
    {'name': 'Lembar Kerja', 'color': 0xFF00BCD4},
    {'name': 'Evaluasi', 'color': 0xFFFF5722},
    {'name': 'Modul', 'color': 0xFF795548},
    {'name': 'Panduan', 'color': 0xFF607D8B},
  ];

  // Author options
  final List<String> authorOptions = [
    'Johan Liebert',
    'Admin Sekolah',
    'Tim Kurikulum',
  ];

  // Getters dari service
  List<Content> get userContents => _contentService.userContents;
  List<Content> get allContents => _contentService.allContents;
  bool get isLoading => _contentService.isLoading;
  String get errorMessage => _contentService.errorMessage;

  // Reactive getters
  RxList<Content> get userContentsRx => _contentService.userContentsRx;
  RxBool get isLoadingRx => _contentService.isLoadingRx;

  // Statistics
  Map<String, int> get contentStatistics {
    final stats = {'totalViews': 0, 'totalDownloads': 0, 'totalRecommendations': 0};
    for (var content in userContents) {
      stats['totalViews'] = (stats['totalViews'] ?? 0) + content.viewsCount;
      stats['totalDownloads'] = (stats['totalDownloads'] ?? 0) + content.downloadsCount;
      stats['totalRecommendations'] = (stats['totalRecommendations'] ?? 0) + content.recommendationsCount;
    }
    return stats;
  }

  @override
  void onInit() {
    super.onInit();
    // Load user's content
    loadUserContents();
    
    // Listen untuk form validation
    titleController.addListener(_validateForm);
    descriptionController.addListener(_validateForm);
  }

  @override
  void onClose() {
    titleController.dispose();
    descriptionController.dispose();
    super.onClose();
  }

  // Load content functions
  Future<void> loadUserContents() async {
    await _contentService.loadUserContents();
  }

  Future<void> loadAllContents() async {
    await _contentService.loadAllContents();
  }

  Future<void> refreshContent() async {
    await _contentService.refreshUserContents();
  }

  // Submit content
  Future<void> submitContent() async {
    if (!formKey.currentState!.validate() || selectedAuthor.value.isEmpty) {
      Get.snackbar('Error', 'Mohon lengkapi semua field yang diperlukan');
      return;
    }

    final content = Content(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      title: titleController.text.trim(),
      description: descriptionController.text.trim(),
      type: selectedContentType.value,
      authors: [selectedAuthor.value],
      authorId: 'user_1', // Mock user ID
      createdAt: DateTime.now(),
    );

    final success = await _contentService.submitContent(content, uploadedFileName.value);
    
    if (success) {
      // Reset form
      _resetForm();
      Get.back(); // Kembali ke content list
      Get.snackbar('Sukses', 'Konten berhasil diunggah');
      await refreshContent(); // Refresh content list
    }
  }

  // Content type selection
  void selectContentType(String type) {
    selectedContentType.value = type;
    Get.back(); // Close bottom sheet
  }

  void showContentTypeBottomSheet() {
    Get.bottomSheet(
      Container(
        padding: const EdgeInsets.all(20),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Pilih Tipe Konten',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            ...contentTypes.map((type) => ListTile(
              leading: CircleAvatar(
                backgroundColor: Color(type['color']),
                radius: 12,
              ),
              title: Text(type['name']),
              onTap: () => selectContentType(type['name']),
            )),
          ],
        ),
      ),
    );
  }

  // Author selection
  void selectAuthor(String author) {
    selectedAuthor.value = author;
    _validateForm();
  }

  // File upload
  void setUploadedFile(String fileName) {
    uploadedFileName.value = fileName;
    _validateForm();
  }

  void removeUploadedFile() {
    uploadedFileName.value = '';
    _validateForm();
  }

  // Tab navigation
  void changeTab(int index) {
    currentTab.value = index;
  }

  // Navigation
  void goToSubmitContent() {
    Get.toNamed('/submit-content');
  }

  void goToContentDetail(Content content) {
    Get.toNamed('/content-detail', arguments: content);
  }

  // Form validation
  void _validateForm() {
    final titleValid = titleController.text.trim().isNotEmpty;
    final descriptionValid = descriptionController.text.trim().isNotEmpty;
    final authorValid = selectedAuthor.value.isNotEmpty;
    final fileValid = uploadedFileName.value.isNotEmpty;
    
    isFormValid.value = titleValid && descriptionValid && authorValid && fileValid;
  }

  void _resetForm() {
    titleController.clear();
    descriptionController.clear();
    selectedContentType.value = 'Peraturan';
    selectedAuthor.value = '';
    uploadedFileName.value = '';
    isFormValid.value = false;
  }

  // Content actions
  Future<void> deleteContent(String contentId) async {
    final confirmed = await Get.dialog<bool>(
      AlertDialog(
        title: const Text('Hapus Konten'),
        content: const Text('Apakah Anda yakin ingin menghapus konten ini?'),
        actions: [
          TextButton(
            onPressed: () => Get.back(result: false),
            child: const Text('Batal'),
          ),
          TextButton(
            onPressed: () => Get.back(result: true),
            child: const Text('Hapus'),
          ),
        ],
      ),
    );

    if (confirmed == true) {
      await _contentService.deleteContent(contentId);
      Get.snackbar('Sukses', 'Konten berhasil dihapus');
    }
  }

  Future<void> toggleBookmark(String contentId) async {
    await _contentService.toggleBookmark(contentId);
  }
}
