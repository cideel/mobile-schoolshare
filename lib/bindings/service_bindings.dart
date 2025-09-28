import 'package:get/get.dart';
import '../controllers/auth_controller.dart';
import '../services/auth_service.dart';
import '../services/home_service.dart';
import '../services/bookmark_service.dart';
import '../controllers/home_controller.dart';
import '../controllers/bookmark_controller.dart';

// Service Bindings - Dependency Injection
class ServiceBindings extends Bindings {
  @override
  void dependencies() {
    // Services - Business Logic Layer
    Get.lazyPut(() => AuthService(), fenix: true);
    Get.lazyPut(() => HomeService(), fenix: true);
    Get.lazyPut(() => BookmarkService(), fenix: true);
    
    // Controllers - UI Logic Layer
    Get.lazyPut(() => AuthController());
    Get.lazyPut(() => HomeController());
    Get.lazyPut(() => BookmarkController());
  }
}

// Auth Binding - untuk halaman auth saja
class AuthBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AuthController());
  }
}

// Home Binding - untuk halaman home saja
class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => HomeController());
  }
}
