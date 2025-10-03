import 'package:get/get.dart';
import 'package:schoolshare/core/services/search/publication_service.dart';
import 'package:schoolshare/data/repositories/publication_repository_impl.dart';
import 'package:schoolshare/features/search/presentation/controllers/publication_controller.dart';
import 'package:schoolshare/features/search/presentation/domain/repositories/publication_repository.dart';

class PublicationBinding extends Bindings {
  @override
  void dependencies() {
    print("✅ PublicationBinding dipanggil");
    Get.lazyPut<PublicationService>(() => PublicationService());
    Get.lazyPut<PublicationRepository>(
        () => PublicationRepositoryImpl(service: Get.find()));
    Get.lazyPut<PublicationController>(
        () => PublicationController(repository: Get.find()));
  }
}