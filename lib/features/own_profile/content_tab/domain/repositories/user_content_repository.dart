// lib/features/own_profile/content_tab/domain/repositories/user_content_repository.dart

import 'package:schoolshare/data/models/publication.dart';

abstract class UserContentRepository {
  Future<List<Publication>> getUserUploadedContent();
  Future<Map<String, dynamic>> getUserContentStats();
}
