import 'package:schoolshare/features/search/presentation/domain/repositories/publication_repository.dart';
import 'package:schoolshare/data/models/publication.dart';
import 'base_search_controller.dart';

class PublicationController extends BaseSearchController<Publication> {
  final PublicationRepository repository;

  PublicationController({required this.repository});

  @override
  Future<List<Publication>> search(String? query) async {
    final result = await repository.searchPublications(query: query);
    print("✅ Search result length: ${result.length}");
    return result;
  }
}
