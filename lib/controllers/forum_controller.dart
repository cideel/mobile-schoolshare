import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:schoolshare/models/models.dart';

// Forum Controller - UI Logic untuk Forum Management
class ForumController extends GetxController {
  // Form controllers
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  final commentController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  // UI state
  final RxString selectedCategory = 'Umum'.obs;
  final RxList<String> selectedTags = <String>[].obs;
  final RxBool isFormValid = false.obs;
  final RxString searchQuery = ''.obs;
  final RxBool isSearching = false.obs;

  // Mock data untuk development
  final RxList<Forum> _forums = <Forum>[].obs;
  final RxList<Comment> _comments = <Comment>[].obs;
  final RxBool _isLoading = false.obs;
  final RxString _errorMessage = ''.obs;

  // Forum categories
  final List<String> categories = [
    'Umum',
    'Pembelajaran',
    'Kurikulum',
    'Teknologi',
    'Administrasi',
    'Tanya Jawab',
  ];

  // Available tags
  final List<String> availableTags = [
    'Urgent',
    'Diskusi',
    'Tips',
    'Pengumuman',
    'Bantuan',
    'Sharing',
    'Review',
    'Saran',
  ];

  // Getters
  List<Forum> get forums => _forums;
  List<Comment> get comments => _comments;
  bool get isLoading => _isLoading.value;
  String get errorMessage => _errorMessage.value;

  // Reactive getters
  RxList<Forum> get forumsRx => _forums;
  RxBool get isLoadingRx => _isLoading;

  // Filtered forums
  List<Forum> get filteredForums {
    if (searchQuery.value.isEmpty) {
      return forums;
    }
    return forums.where((forum) =>
        forum.title.toLowerCase().contains(searchQuery.value.toLowerCase()) ||
        forum.description.toLowerCase().contains(searchQuery.value.toLowerCase())
    ).toList();
  }

  // Filtered forums by category
  List<Forum> get categoryForums {
    return filteredForums.where((forum) => 
        forum.category == selectedCategory.value
    ).toList();
  }

  // Pinned forums
  List<Forum> get pinnedForums {
    return forums.where((forum) => forum.isPinned).toList();
  }

  @override
  void onInit() {
    super.onInit();
    loadForums();
    
    // Listen untuk form validation
    titleController.addListener(_validateForm);
    descriptionController.addListener(_validateForm);
  }

  @override
  void onClose() {
    titleController.dispose();
    descriptionController.dispose();
    commentController.dispose();
    super.onClose();
  }

  // Load forums - Mock implementation
  Future<void> loadForums() async {
    _isLoading.value = true;
    // TODO: Replace with actual service call
    await Future.delayed(const Duration(milliseconds: 500));
    
    // Mock data
    _forums.addAll([
      Forum(
        id: '1',
        title: 'Panduan Implementasi Kurikulum Merdeka',
        description: 'Diskusi mengenai implementasi kurikulum merdeka di sekolah',
        authorId: '1',
        authorName: 'Admin Sekolah',
        authorAvatarUrl: '',
        category: 'Kurikulum',
        tags: ['Kurikulum', 'Panduan'],
        viewsCount: 125,
        commentsCount: 8,
        likesCount: 12,
        isPinned: true,
        createdAt: DateTime.now().subtract(const Duration(days: 2)),
      ),
      Forum(
        id: '2',
        title: 'Tips Menggunakan Platform Digital',
        description: 'Sharing tips dan trik menggunakan platform digital untuk pembelajaran',
        authorId: '2',
        authorName: 'Johan Liebert',
        authorAvatarUrl: '',
        category: 'Teknologi',
        tags: ['Tips', 'Digital'],
        viewsCount: 89,
        commentsCount: 5,
        likesCount: 7,
        createdAt: DateTime.now().subtract(const Duration(hours: 6)),
      ),
    ]);
    
    _isLoading.value = false;
  }

  Future<void> refreshForums() async {
    _isLoading.value = true;
    await Future.delayed(const Duration(milliseconds: 500));
    _isLoading.value = false;
  }

  // Create forum
  Future<void> createForum() async {
    if (!formKey.currentState!.validate()) {
      Get.snackbar('Error', 'Mohon lengkapi semua field yang diperlukan');
      return;
    }

    final forum = Forum(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      title: titleController.text.trim(),
      description: descriptionController.text.trim(),
      authorId: 'user_1', // Mock user ID
      authorName: 'Johan Liebert', // Mock user name
      authorAvatarUrl: '',
      category: selectedCategory.value,
      tags: selectedTags.toList(),
      createdAt: DateTime.now(),
    );

    // Mock implementation
    _isLoading.value = true;
    await Future.delayed(const Duration(milliseconds: 500));
    _forums.insert(0, forum);
    _isLoading.value = false;

    // Reset form
    _resetForm();
    Get.back();
    Get.snackbar('Sukses', 'Forum berhasil dibuat');
  }

  // Add comment to forum
  Future<void> addComment(String forumId) async {
    if (commentController.text.trim().isEmpty) {
      Get.snackbar('Error', 'Komentar tidak boleh kosong');
      return;
    }

    final comment = Comment(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      contentId: forumId,
      userId: 'user_1', // Mock user ID
      userName: 'Johan Liebert', // Mock user name
      userAvatarUrl: '',
      text: commentController.text.trim(),
      createdAt: DateTime.now(),
    );

    // Mock implementation
    _comments.add(comment);
    commentController.clear();

    // Update forum comment count
    final forumIndex = _forums.indexWhere((f) => f.id == forumId);
    if (forumIndex != -1) {
      final forum = _forums[forumIndex];
      _forums[forumIndex] = forum.copyWith(
        commentsCount: forum.commentsCount + 1,
      );
    }

    Get.snackbar('Sukses', 'Komentar berhasil ditambahkan');
  }

  // Toggle like forum
  Future<void> toggleLikeForum(String forumId) async {
    final forumIndex = _forums.indexWhere((f) => f.id == forumId);
    if (forumIndex != -1) {
      final forum = _forums[forumIndex];
      final isCurrentlyLiked = forum.isLikedByUser;
      
      _forums[forumIndex] = forum.copyWith(
        isLikedByUser: !isCurrentlyLiked,
        likesCount: isCurrentlyLiked 
            ? forum.likesCount - 1 
            : forum.likesCount + 1,
      );
    }
  }

  // Search functionality
  void onSearchChanged(String query) {
    searchQuery.value = query;
    isSearching.value = query.isNotEmpty;
  }

  void clearSearch() {
    searchQuery.value = '';
    isSearching.value = false;
  }

  // Category selection
  void selectCategory(String category) {
    selectedCategory.value = category;
  }

  // Tag management
  void toggleTag(String tag) {
    if (selectedTags.contains(tag)) {
      selectedTags.remove(tag);
    } else {
      selectedTags.add(tag);
    }
    _validateForm();
  }

  void removeTag(String tag) {
    selectedTags.remove(tag);
    _validateForm();
  }

  // Navigation
  void goToForumDetail(Forum forum) {
    Get.toNamed('/forum-detail', arguments: forum);
  }

  void goToCreateForum() {
    Get.toNamed('/create-forum');
  }

  // Form validation
  void _validateForm() {
    final titleValid = titleController.text.trim().isNotEmpty;
    final descriptionValid = descriptionController.text.trim().isNotEmpty;
    
    isFormValid.value = titleValid && descriptionValid;
  }

  void _resetForm() {
    titleController.clear();
    descriptionController.clear();
    selectedCategory.value = 'Umum';
    selectedTags.clear();
    isFormValid.value = false;
  }

  // Delete forum
  Future<void> deleteForum(String forumId) async {
    final confirmed = await Get.dialog<bool>(
      AlertDialog(
        title: const Text('Hapus Forum'),
        content: const Text('Apakah Anda yakin ingin menghapus forum ini?'),
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
      _forums.removeWhere((forum) => forum.id == forumId);
      Get.snackbar('Sukses', 'Forum berhasil dihapus');
    }
  }
}
