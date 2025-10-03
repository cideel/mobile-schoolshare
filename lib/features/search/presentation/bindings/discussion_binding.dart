// lib/features/search/bindings/discussion_binding.dart

import 'package:get/get.dart';
import 'package:schoolshare/core/services/search/discussion_service.dart';
import 'package:schoolshare/data/repositories/discussion_repository_impl.dart';

import 'package:schoolshare/features/search/presentation/controllers/discussion_controller.dart';
import 'package:schoolshare/features/search/presentation/domain/repositories/discussion_repository.dart';

class DiscussionBinding extends Bindings {
  @override
  void dependencies() {
    // 1. Daftarkan Service (Instansiasi kelas http.Client hanya di sini jika perlu)
    Get.lazyPut(() => DiscussionService());

    // 2. Daftarkan Repository (Menggunakan Service yang sudah didaftarkan)
    // Pastikan DiscussionRepository di-bind ke implementasinya
    Get.lazyPut<DiscussionRepository>(
      () => DiscussionRepositoryImpl(
        discussionService: Get.find<DiscussionService>(),
      ),
    );

    // 3. Daftarkan Controller (Menggunakan Repository yang sudah didaftarkan)
    Get.lazyPut(() => DiscussionController(
          repository: Get.find<DiscussionRepository>(),
        ));
  }
}
