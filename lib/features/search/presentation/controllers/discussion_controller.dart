// lib/features/search/presentation/controllers/discussion_controller.dart

import 'package:schoolshare/data/models/discussion_item.dart';
import 'package:schoolshare/data/repositories/discussion_repository_impl.dart';
import 'package:schoolshare/features/search/presentation/controllers/base_search_controller.dart';
import 'package:schoolshare/features/search/presentation/domain/repositories/discussion_repository.dart';

// Ganti GetxController menjadi BaseSearchController
class DiscussionController extends BaseSearchController<DiscussionItem> {
  // Hanya simpan _repository, tidak perlu RxList, isLoading, dll.
  final DiscussionRepository _repository;

  // Menggunakan 'repo' sebagai prefix untuk menghindari konflik
  DiscussionController({DiscussionRepository? repository})
      : _repository = repository ?? DiscussionRepositoryImpl();

  // Implementasi wajib dari BaseSearchController
  @override
  Future<List<DiscussionItem>> search(String? query) async {
    // Pastikan query tidak null
    final q = query ?? '';
    return await _repository.searchDiscussions(query: q);
  }
}
