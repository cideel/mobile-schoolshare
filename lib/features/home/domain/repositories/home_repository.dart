// lib/features/home/domain/repositories/home_repository.dart
import '../../../../data/models/publication.dart';

abstract class HomeRepository {
  Future<List<Publication>> getPublications();
  Future<List<Publication>> getPublicationsByCategory(String category);
  Future<List<String>> getCategories();
  Future<List<String>> getPopularTopics();
  Future<Publication> getPublicationById(String id);
  Future<List<Publication>> searchPublications(String query);
}
