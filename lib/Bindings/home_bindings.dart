import 'package:get/get.dart';
import 'package:schoolshare/Controller/home/home_controller.dart';
import 'package:schoolshare/services/home_services.dart';

/// HomeBinding memastikan bahwa HomeController dan HomeServices
/// disiapkan dan tersedia di dalam GetX dependency injection container.
/// Dengan ini, Home widget dapat dengan aman memanggil Get.find().
class HomeBinding implements Bindings {
  @override
  void dependencies() {
    // Daftarkan HomeServices sebagai service, yang akan diinisiasi
    // dan disimpan di memori selama aplikasi berjalan.
    Get.put<HomeServices>(HomeServices());

    // Daftarkan HomeController sebagai lazy put.
    // Ini berarti controller hanya akan diinisiasi saat dibutuhkan
    // untuk pertama kali (saat Home widget dibuat).
    Get.lazyPut<HomeController>(() => HomeController());
  }
}
