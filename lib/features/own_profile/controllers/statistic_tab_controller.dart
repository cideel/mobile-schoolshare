import 'package:get/get.dart';
import 'package:schoolshare/data/models/users_model.dart';
import 'package:schoolshare/features/own_profile/domain/repositories/profile_tab_profile_repository.dart';

class StatisticTabController extends GetxController with StateMixin<UserModel> {
  final ProfileTabProfileRepository _repository =
      Get.find<ProfileTabProfileRepository>();

  final RxString riScore = '0'.obs;
  final RxString readDocs = '0'.obs;
  final RxString recommendation = '0'.obs;
  final RxString sitasi = '0'.obs;

  @override
  void onInit() {
    fetchStatistics();
    super.onInit();
  }

  Future<void> fetchStatistics() async {
    change(null, status: RxStatus.loading());

    try {
      final UserModel user = await _repository.fetchUserProfile();

      riScore.value = user.hScore?.toString() ?? '0';
      readDocs.value = user.readDocs?.toString() ?? '0';
      recommendation.value = user.totalRecommendation?.toString() ?? '0';
      sitasi.value = user.totalSitasi?.toString() ?? '0';

      change(user, status: RxStatus.success());
    } catch (e) {
      print("Error fetching statistics: $e");
      riScore.value = 'N/A';
      readDocs.value = 'N/A';
      recommendation.value = 'N/A';
      sitasi.value = 'N/A';
      change(null, status: RxStatus.error(e.toString()));
    }
  }
}
