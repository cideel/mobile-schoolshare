import 'package:get/get.dart';
import 'package:schoolshare/services/home_service.dart';
import 'package:schoolshare/models/models.dart';

// Home Controller - UI Logic untuk Home Page
class HomeController extends GetxController {
  // Get service
  final HomeService _homeService = Get.find<HomeService>();

  // UI state
  final RxString searchQuery = ''.obs;
  final RxBool isSearching = false.obs;

  // Getters dari service
  List<Content> get contents => _homeService.contents;
  List<Content> get filteredContents => _homeService.filteredContents;
  List<String> get categories => _homeService.categories;
  List<String> get popularTopics => _homeService.popularTopics;
  bool get isLoading => _homeService.isLoading;
  String get errorMessage => _homeService.errorMessage;
  String get selectedCategory => _homeService.selectedCategory;

  // Reactive getters
  RxList<Content> get contentsRx => _homeService.contentsRx;
  RxBool get isLoadingRx => _homeService.isLoadingRx;
  RxString get selectedCategoryRx => _homeService.selectedCategoryRx;

  // Search functionality
  List<Content> get searchResults {
    if (searchQuery.value.isEmpty) {
      return filteredContents;
    }
    return filteredContents.where((content) =>
        content.name.toLowerCase().contains(searchQuery.value.toLowerCase()) ||
        content.description.toLowerCase().contains(searchQuery.value.toLowerCase())
    ).toList();
  }

  // UI Actions
  void onSearchChanged(String query) {
    searchQuery.value = query;
    isSearching.value = query.isNotEmpty;
  }

  void clearSearch() {
    searchQuery.value = '';
    isSearching.value = false;
  }

  void selectCategory(String category) {
    _homeService.setCategory(category);
  }

  Future<void> refreshData() async {
    await _homeService.refreshData();
  }

  // Navigation helpers
  void goToContentDetail(Content content) {
    Get.toNamed('/content-detail', arguments: content);
  }

  void goToSearch() {
    Get.toNamed('/search');
  }

  void goToProfile() {
    Get.toNamed('/profile');
  }
}