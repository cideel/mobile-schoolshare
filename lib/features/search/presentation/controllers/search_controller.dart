import 'package:get/get.dart';
import 'package:schoolshare/data/models/base_search_models.dart';
import 'package:schoolshare/features/search/presentation/domain/repositories/search_repository.dart';

class SearchController extends GetxController {
  final SearchRepository _repository = SearchRepository();

  // State untuk query pencarian
  final RxString currentQuery = ''.obs;

  // State untuk status loading dan error
  final RxBool isLoadingPeople = false.obs;
  final RxBool isLoadingPublication = false.obs;
  final RxBool isLoadingDiscussion = false.obs;

  final RxString errorPeople = ''.obs;
  final RxString errorPublication = ''.obs;
  final RxString errorDiscussion = ''.obs;

  // State untuk hasil pencarian
  final RxList<UserSearchModel> peopleResults = <UserSearchModel>[].obs;
  final RxList<PublicationSearchModel> publicationResults =
      <PublicationSearchModel>[].obs;
  final RxList<DiscussionSearchModel> discussionResults =
      <DiscussionSearchModel>[].obs;

  // Debouncer untuk menghindari spam API call saat mengetik
  void onQueryChanged(String query) {
    if (query.trim() == currentQuery.value.trim()) return;

    currentQuery.value = query.trim();

    // Gunakan debounce untuk menunda pemanggilan fungsi pencarian
    // dan memastikan hanya dipanggil sekali setelah user berhenti mengetik (misal 500ms)
    // jika query cukup panjang (misal > 2 karakter)
    debounce(currentQuery, (value) {
      if (value.length >= 2) {
        performAllSearches(value);
      } else {
        // Clear results if query is too short
        peopleResults.clear();
        publicationResults.clear();
        discussionResults.clear();
      }
    }, time: const Duration(milliseconds: 500));
  }

  Future<void> performAllSearches(String query) async {
    if (query.isEmpty) return;

    // Panggil semua fungsi pencarian secara bersamaan (parallel)
    await Future.wait([
      _searchPeople(query),
      _searchPublication(query),
      _searchDiscussion(query),
    ]);
  }

  Future<void> _searchPeople(String query) async {
    isLoadingPeople.value = true;
    errorPeople.value = '';
    try {
      final results = await _repository.searchPeople(query);
      peopleResults.assignAll(results);
    } catch (e) {
      errorPeople.value = e.toString().replaceAll('Exception: ', '');
      peopleResults.clear();
    } finally {
      isLoadingPeople.value = false;
    }
  }

  Future<void> _searchPublication(String query) async {
    isLoadingPublication.value = true;
    errorPublication.value = '';
    try {
      final results = await _repository.searchPublication(query);
      publicationResults.assignAll(results);
    } catch (e) {
      errorPublication.value = e.toString().replaceAll('Exception: ', '');
      publicationResults.clear();
    } finally {
      isLoadingPublication.value = false;
    }
  }

  Future<void> _searchDiscussion(String query) async {
    isLoadingDiscussion.value = true;
    errorDiscussion.value = '';
    try {
      final results = await _repository.searchDiscussion(query);
      discussionResults.assignAll(results);
    } catch (e) {
      errorDiscussion.value = e.toString().replaceAll('Exception: ', '');
      discussionResults.clear();
    } finally {
      isLoadingDiscussion.value = false;
    }
  }
}
