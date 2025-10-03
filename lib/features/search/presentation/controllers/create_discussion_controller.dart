// lib/features/discussion/presentation/controllers/create_discussion_controller.dart (FINAL REVISION)

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:schoolshare/data/models/discussion_item.dart';
import 'package:schoolshare/features/search/presentation/domain/repositories/create_forum_repository.dart';

class CreateDiscussionController extends GetxController {
  final CreateForumRepository _repository;

  // State
  final RxBool isLoading = false.obs;
  final RxBool isCategoryLoading = true.obs;
  final RxString errorMessage = ''.obs;

  // Data
  final RxList<DiscussionCategory> categories = <DiscussionCategory>[].obs;
  // Jika pengguna memilih kategori yang sudah ada
  final Rx<DiscussionCategory?> selectedCategory =
      Rx<DiscussionCategory?>(null);

  CreateDiscussionController({required CreateForumRepository repository})
      : _repository = repository;

  @override
  void onInit() {
    fetchCategories();
    super.onInit();
  }

  void selectCategoryByName(String name) {
    final category = categories.firstWhereOrNull((cat) => cat.name == name);
    selectedCategory.value = category;
  }

  // Method untuk memilih kategori yang sudah ada
  void selectExistingCategory(DiscussionCategory category) {
    selectedCategory.value = category;
  }

  Future<void> fetchCategories() async {
    isCategoryLoading.value = true;
    errorMessage.value = '';
    try {
      final fetchedCategories = await _repository.fetchCategories();
      categories.assignAll(fetchedCategories);
    } catch (e) {
      debugPrint('Fetch Categories Error: $e');
      errorMessage.value =
          'Gagal memuat topik: ${e.toString().replaceAll('Exception: ', '')}';
    } finally {
      isCategoryLoading.value = false;
    }
  }

  Future<DiscussionItem?> submitForum({
    required String title,
    required String body,
    required String
        topicText, // Digunakan untuk ID Kategori atau Nama Kategori Baru
  }) async {
    // 1. Tentukan mode submission
    int? categoryId;
    String? newCategoryName;

    // Cari apakah topik yang diketik pengguna ada di daftar kategori yang sudah ada
    final existingCategory = categories.firstWhereOrNull(
        (cat) => cat.name.toLowerCase() == topicText.trim().toLowerCase());

    if (existingCategory != null) {
      // Mode 1: Memilih kategori yang sudah ada
      categoryId = existingCategory.id;
    } else if (topicText.trim().isNotEmpty) {
      // Mode 2: Membuat kategori baru
      newCategoryName = topicText.trim();
    } else {
      // Gagal validasi
      errorMessage.value = 'Topik diskusi harus diisi.';
      return null;
    }

    isLoading.value = true;
    errorMessage.value = '';
    DiscussionItem? newDiscussion;

    try {
      newDiscussion = await _repository.createForum(
        categoryId: categoryId,
        newCategoryName: newCategoryName,
        title: title,
        body: body,
      );

      // Reset state setelah sukses
      selectExistingCategory(newDiscussion?.category ?? categories.first);

      return newDiscussion;
    } catch (e) {
      errorMessage.value = e.toString().replaceAll('Exception: ', '');
      debugPrint('Submit Forum Error: $e');
      return null;
    } finally {
      isLoading.value = false;
    }
  }
}
