// lib/features/own_profile/content_tab/data/repositories/user_content_repository_impl.dart

import 'package:schoolshare/core/services/user_content/user_content_service.dart';
import 'package:schoolshare/data/models/publication.dart';
import '../../domain/repositories/user_content_repository.dart';

class UserContentRepositoryImpl implements UserContentRepository {
  final UserContentService _service;

  UserContentRepositoryImpl({required UserContentService service}) : _service = service;

  @override
  Future<List<Publication>> getUserUploadedContent() async {
    return await _service.getUserUploadedContent();
  }

  @override
  Future<Map<String, dynamic>> getUserContentStats() async {
    return await _service.getUserContentStats();
  }
}
