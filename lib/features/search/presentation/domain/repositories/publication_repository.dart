import 'package:schoolshare/data/models/publication.dart';

abstract class PublicationRepository {
  Future<List<Publication>> searchPublications({String? query});
}
