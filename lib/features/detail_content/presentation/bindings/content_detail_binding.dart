import 'package:get/get.dart';
import 'package:schoolshare/core/services/home/detail_content_services.dart';
import 'package:schoolshare/features/detail_content/presentation/controllers/detail_content_controller.dart';
import 'package:schoolshare/data/repositories/detail_content_repository_impl.dart';

class ContentDetailBinding extends Bindings {
  @override
  void dependencies() {
    final contentId = Get.arguments as String? ?? '';

    final repository = DetailContentRepositoryImpl(
      service: DetailContentService(),
    );

    final controller = Get.put(
      DetailContentController(repository: repository),
      tag: contentId,
    );

    controller.loadDetail(contentId);
  }
}
