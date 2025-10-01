import 'package:schoolshare/data/models/users_model.dart';

abstract class PeopleRepository {
  Future<List<UserModel>> searchUsers({String? query});
}
