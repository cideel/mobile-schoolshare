import 'package:get/get.dart';
import 'package:schoolshare/features/own_profile/update_profile/presentation/controllers/update_profile_controller.dart';

class UpdateProfileBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<UpdateProfileController>(() => UpdateProfileController());
  }
}
