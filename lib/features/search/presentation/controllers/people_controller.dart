import 'package:schoolshare/data/models/users_model.dart';
import 'package:schoolshare/features/search/presentation/domain/repositories/people_repository.dart';
import 'base_search_controller.dart';

class PeopleController extends BaseSearchController<UserModel> {
  final PeopleRepository repository;

  PeopleController({required this.repository});

  @override
  Future<List<UserModel>> search(String? query) {
    return repository.searchUsers(query: query);
  }
}
