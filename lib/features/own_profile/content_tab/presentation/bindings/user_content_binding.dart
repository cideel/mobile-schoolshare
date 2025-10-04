// lib/features/own_profile/content_tab/presentation/bindings/user_content_binding.dart

import 'package:get/get.dart';
import 'package:schoolshare/core/services/user_content/user_content_service.dart';
import '../controllers/user_content_controller_active.dart';
import '../../data/repositories/user_content_repository_impl.dart';
import '../../domain/repositories/user_content_repository.dart';

class UserContentBinding extends Bindings {
  @override
  void dependencies() {
    // Service layer
    Get.lazyPut<UserContentService>(() => UserContentService());
    
    // Repository layer
    Get.lazyPut<UserContentRepository>(
      () => UserContentRepositoryImpl(service: Get.find<UserContentService>()),
    );
    
    // Controller layer
    Get.lazyPut<UserContentController>(
      () => UserContentController(repository: Get.find<UserContentRepository>()),
    );
  }
}
