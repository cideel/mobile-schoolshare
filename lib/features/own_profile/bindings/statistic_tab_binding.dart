// lib/features/own_profile/statistic_tab/bindings/statistic_tab_binding.dart
import 'package:get/get.dart';
import 'package:schoolshare/features/own_profile/controllers/statistic_tab_controller.dart';

class StatisticTabBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<StatisticTabController>(
      StatisticTabController(),
    );
  }
}
