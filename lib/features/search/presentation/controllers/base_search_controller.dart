import 'package:get/get.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

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
      String message = "Terjadi kesalahan";

      // Jika error dari http package
      if (e is http.Response) {
        // coba ambil message dari API
        try {
          final data = jsonDecode(e.body);
          if (data is Map && data['message'] != null) {
            message = data['message'].toString();
          }
        } catch (_) {
          message = e.body;
        }
      } else if (e is Exception) {
        message = e.toString();
      }

      errorMessage.value = message;
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
