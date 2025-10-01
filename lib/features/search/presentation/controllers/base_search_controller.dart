import 'package:get/get.dart';

abstract class BaseSearchController<T> extends GetxController {
  var items = <T>[].obs;
  var isLoading = false.obs;
  var errorMessage = "".obs;

  /// Implementasikan di masing-masing controller
  Future<List<T>> search(String? query);

  Future<void> fetchItems({String? query}) async {
    try {
      isLoading.value = true;
      errorMessage.value = "";
      final result = await search(query);
      items.assignAll(result);
    } catch (e) {
      errorMessage.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onInit() {
    super.onInit();
    fetchItems(); // default fetch
  }
}
