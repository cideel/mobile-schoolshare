// lib/data/repositories/home_repository_impl.dart
import '../models/publication.dart';
import '../datasources/home_mock_data.dart';
import '../../features/home/domain/repositories/home_repository.dart';

class HomeRepositoryImpl implements HomeRepository {
  @override
  Future<List<Publication>> getPublications() async {
    await Future.delayed(HomeMockData.networkDelay);
    
    try {
      return HomeMockData.publications;
    } catch (e) {
      throw Exception('Failed to fetch publications: $e');
    }
  }

  @override
  Future<List<Publication>> getPublicationsByCategory(String category) async {
    await Future.delayed(HomeMockData.networkDelay);
    
    try {
      if (category == 'All') {
        return HomeMockData.publications;
      }
      
      return HomeMockData.publications
          .where((publication) => publication.category == category)
          .toList();
    } catch (e) {
      throw Exception('Failed to fetch publications by category: $e');
    }
  }

  @override
  Future<List<String>> getCategories() async {
    await Future.delayed(HomeMockData.networkDelay);
    
    try {
      return HomeMockData.categories;
    } catch (e) {
      throw Exception('Failed to fetch categories: $e');
    }
  }

  @override
  Future<List<String>> getPopularTopics() async {
    await Future.delayed(HomeMockData.networkDelay);
    
    try {
      return HomeMockData.popularTopics;
    } catch (e) {
      throw Exception('Failed to fetch popular topics: $e');
    }
  }

  @override
  Future<Publication> getPublicationById(String id) async {
    await Future.delayed(HomeMockData.networkDelay);
    
    try {
      return HomeMockData.publications
          .firstWhere((publication) => publication.id == id);
    } catch (e) {
      throw Exception('Publication not found: $e');
    }
  }

  @override
  Future<List<Publication>> searchPublications(String query) async {
    await Future.delayed(HomeMockData.networkDelay);
    
    try {
      return HomeMockData.publications
          .where((publication) =>
              publication.title.toLowerCase().contains(query.toLowerCase()) ||
              publication.description.toLowerCase().contains(query.toLowerCase()) ||
              publication.authors.any((author) =>
                  author.toLowerCase().contains(query.toLowerCase())))
          .toList();
    } catch (e) {
      throw Exception('Failed to search publications: $e');
    }
  }
}
