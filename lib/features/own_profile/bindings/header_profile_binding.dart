import 'package:get/get.dart';
import 'package:schoolshare/features/own_profile/controllers/header_profile_controller.dart';
import 'package:schoolshare/core/services/profile/header_profile_services.dart';
import 'package:schoolshare/features/own_profile/domain/repositories/header_profile_repository.dart';

class HeaderProfileBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HeaderProfileRepository>(() => HeaderProfileService());

    Get.lazyPut<HeaderProfileController>(
      () => HeaderProfileController(
          repository: Get.find<HeaderProfileRepository>()),
    );
  }
}
