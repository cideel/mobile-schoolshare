import 'package:schoolshare/core/services/search/publication_service.dart';
import 'package:schoolshare/data/models/publication.dart';
import 'package:schoolshare/features/search/presentation/domain/repositories/publication_repository.dart';

class PublicationRepositoryImpl implements PublicationRepository {
  final PublicationService service;

  PublicationRepositoryImpl({required this.service});

  @override
  Future<List<Publication>> searchPublications({String? query}) {
    return service.searchPublications(query: query);
  }
}
