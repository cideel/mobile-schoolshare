// lib/features/home/controllers/home_controller.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../data/models/publication.dart';
import '../../../data/repositories/home_repository_impl.dart';
import '../domain/repositories/home_repository.dart';

class HomeController extends GetxController {
  final HomeRepository _homeRepository = HomeRepositoryImpl();

  // Observable variables
  final RxList<Publication> _publications = <Publication>[].obs;
  final RxList<String> _popularTopics = <String>[].obs;
  final RxBool _isLoading = false.obs;
  final RxString _errorMessage = ''.obs;
  final RxString _searchQuery = ''.obs;

  // Getters
  List<Publication> get publications => _publications;
  List<String> get popularTopics => _popularTopics;
  bool get isLoading => _isLoading.value;
  String get errorMessage => _errorMessage.value;
  String get searchQuery => _searchQuery.value;

  RxList<Publication> get publicationsRx => _publications;
  RxBool get isLoadingRx => _isLoading;

  @override
  void onInit() {
    super.onInit();
    loadInitialData();
  }

  Future<void> loadInitialData() async {
    await Future.wait([
      loadPublications(),
      loadPopularTopics(),
    ]);
  }

  Future<void> loadPublications() async {
    try {
      _isLoading.value = true;
      _errorMessage.value = '';
      
      final publications = await _homeRepository.getPublications();
      _publications.assignAll(publications);
    } catch (e) {
      _errorMessage.value = 'Gagal memuat konten ${e.toString()}';
      _showErrorSnackbar(_errorMessage.value);
    } finally {
      _isLoading.value = false;
    }
  }

  Future<void> loadPopularTopics() async {
    try {
      final topics = await _homeRepository.getPopularTopics();
      _popularTopics.assignAll(topics);
    } catch (e) {
      _showErrorSnackbar('Failed to load popular topics: ${e.toString()}');
    }
  }

  
  Future<void> refreshData() async {
    await loadInitialData();
  }

  void clearSearch() {
    _searchQuery.value = '';
    loadPublications();
  }

  Publication? getPublicationById(String id) {
    try {
      return _publications.firstWhere((pub) => pub.id == id);
    } catch (e) {
      return null;
    }
  }

  void _showErrorSnackbar(String message) {
    Get.snackbar(
      'Error',
      message,
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.red.shade100,
      colorText: Colors.red.shade800,
    );
  }
}
