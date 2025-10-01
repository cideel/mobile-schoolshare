import 'package:schoolshare/core/services/search/people_service.dart';
import 'package:schoolshare/data/models/users_model.dart';
import 'package:schoolshare/features/search/presentation/domain/repositories/people_repository.dart';

class PeopleRepositoryImpl implements PeopleRepository {
  final PeopleService service;

  PeopleRepositoryImpl({required this.service});

  @override
  Future<List<UserModel>> searchUsers({String? query}) async {
    final data = await service.searchUsers(query: query);
    return data.map((e) => UserModel.fromJson(e)).toList();
  }
}
