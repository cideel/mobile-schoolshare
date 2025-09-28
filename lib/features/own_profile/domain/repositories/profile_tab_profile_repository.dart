import 'package:schoolshare/data/models/position_model.dart';
import 'package:schoolshare/data/models/users_model.dart';
import 'package:schoolshare/data/models/institution_model.dart';

abstract class ProfileTabProfileRepository {
  Future<UserModel> fetchUserProfile();

  Future<Institution?> fetchUserInstitution();

  Future<Position?> fetchUserPosition();
}
