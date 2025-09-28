import 'package:get/get.dart';
import 'package:schoolshare/controllers/controllers.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeController>(
      () => HomeController(),
      fenix: true, 
    );
  }
}
