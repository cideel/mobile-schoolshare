  // lib/own_profile/bindings/profile_tab_binding.dart
  import 'package:get/get.dart';
  import 'package:schoolshare/core/services/profile/profile_tab_profile_services.dart';
  import 'package:schoolshare/data/repositories/profile_tab_profile_repository_impl.dart';
  import 'package:schoolshare/features/own_profile/controllers/profile_tab_profile_controller.dart';
  import 'package:schoolshare/features/own_profile/domain/repositories/profile_tab_profile_repository.dart';

  class ProfileTabBinding extends Bindings {
    @override
    void dependencies() {
      Get.lazyPut<ProfileTabProfileServices>(
        () => ProfileTabProfileServices(),
      );

      Get.lazyPut<ProfileTabProfileRepository>(
        () => ProfileTabProfileRepositoryImpl(
          remoteDataSource: Get.find<ProfileTabProfileServices>(),
        ),
      );

      Get.put<ProfileTabProfileController>(
        ProfileTabProfileController(),
      );
    }
  }
