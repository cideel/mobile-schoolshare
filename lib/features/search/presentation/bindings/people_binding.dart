import 'package:get/get.dart';
import 'package:schoolshare/core/services/search/people_service.dart';
import 'package:schoolshare/data/repositories/people_repository_impl.dart';

import 'package:schoolshare/features/search/presentation/controllers/people_controller.dart';
import 'package:schoolshare/features/search/presentation/domain/repositories/people_repository.dart';

class PeopleBinding extends Bindings {
  @override
  void dependencies() {
    final service = PeopleService();
    Get.lazyPut<PeopleRepository>(() => PeopleRepositoryImpl(service: service));
    Get.lazyPut(() => PeopleController(repository: Get.find()));
  }
}
