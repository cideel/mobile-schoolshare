import 'package:get/get.dart';
import 'package:schoolshare/controllers/auth_controller.dart';

class AuthBinding extends Bindings {
  @override
  void dependencies() {
    // Lazy initialization - controller akan dibuat saat dibutuhkan
    Get.lazyPut<AuthController>(() => AuthController());
  }
}
