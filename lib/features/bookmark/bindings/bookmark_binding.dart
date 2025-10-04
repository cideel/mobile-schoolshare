


import 'package:get/get.dart';
import 'package:schoolshare/core/services/bookmark/bookmark_service.dart';
import 'package:schoolshare/core/services/profile/header_profile_services.dart';
import 'package:schoolshare/features/bookmark/controllers/bookmark_controller.dart';
import 'package:schoolshare/features/bookmark/domain/repositories/bookmark_repository.dart';

class BookmarkBinding extends Bindings {
  @override
  void dependencies() {
    // Register services
    Get.lazyPut<BookmarkService>(() => BookmarkService());
    Get.lazyPut<HeaderProfileService>(() => HeaderProfileService());
    
    // Register repository with both dependencies
    Get.lazyPut<BookmarkRepository>(
        () => BookmarkRepositoryImpl(
          Get.find<BookmarkService>(),
          Get.find<HeaderProfileService>(),
        ));
    
    // Register controller
    Get.put<BookmarkController>(
        BookmarkController(Get.find<BookmarkRepository>()));
  }
}
