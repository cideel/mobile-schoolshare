// lib/own_profile/controllers/profile_tab_profile_controller.dart
import 'package:get/get.dart';
import 'package:schoolshare/data/models/users_model.dart';
import 'package:schoolshare/data/models/institution_model.dart';
// 🔥 Impor Position Model (Asumsi file ini ada)
import 'package:schoolshare/data/models/position_model.dart';
import 'package:schoolshare/features/own_profile/domain/repositories/profile_tab_profile_repository.dart';

class ProfileTabProfileController extends GetxController
    with StateMixin<UserModel> {
  final ProfileTabProfileRepository _repository =
      Get.find<ProfileTabProfileRepository>();

  final Rx<Institution?> institution = Rx<Institution?>(null);

  // 🔥 PERBAIKAN 1: Ganti hardcode String dengan Rx<String> untuk nama posisi
  // Kita akan menyimpan nama posisi secara reaktif.
  final RxString userPositionName = 'N/A'.obs;

  @override
  void onInit() {
    fetchProfile();
    super.onInit();
  }

  Future<void> fetchProfile() async {
    change(null, status: RxStatus.loading());

    try {
      final UserModel user = await _repository.fetchUserProfile();
      final Institution? inst = await _repository.fetchUserInstitution();
      final Position? positionName = await _repository.fetchUserPosition();

      institution.value = inst;
      userPositionName.value = positionName?.name ?? 'N/A';

      change(user, status: RxStatus.success());
    } catch (e) {
      print("Error fetching profile: $e");
      // Jika error, pastikan posisi direset (optional)
      userPositionName.value = 'N/A';
      change(null, status: RxStatus.error(e.toString()));
    }
  }
}
