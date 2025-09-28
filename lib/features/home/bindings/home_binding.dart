// lib/features/home/bindings/home_binding.dart

import 'package:get/get.dart';
import 'package:schoolshare/core/services/home/content_matrix_service.dart';
import 'package:schoolshare/core/services/home/home_service.dart';
import 'package:schoolshare/data/repositories/home_repository_impl.dart';
import '../controllers/home_controller.dart';
import '../domain/repositories/home_repository.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    // 🔥 0. Service Metrik Konten
    Get.lazyPut<ContentMetricsService>(
      () => ContentMetricsService(),
    );

    // 1. Service Home
    Get.lazyPut<HomeServices>(
      () => HomeServices(),
    );

    // 2. Repository (Menerima DUA Service)
    Get.lazyPut<HomeRepository>(
      () => HomeRepositoryImpl(
        Get.find<HomeServices>(),
        Get.find<ContentMetricsService>(),
      ),
    );

    // 3. Controller
    Get.lazyPut<HomeController>(
      () => HomeController(),
      fenix: true,
    );
  }
}
