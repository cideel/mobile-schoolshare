// lib/own_profile/data/repositories/profile_tab_profile_repository_impl.dart
import 'package:get/get.dart';
import 'package:schoolshare/core/services/profile/profile_tab_profile_services.dart';
import 'package:schoolshare/data/models/position_model.dart';
import 'package:schoolshare/data/models/users_model.dart';
import 'package:schoolshare/data/models/institution_model.dart';
import 'package:schoolshare/features/own_profile/domain/repositories/profile_tab_profile_repository.dart';

class ProfileTabProfileRepositoryImpl implements ProfileTabProfileRepository {
  final ProfileTabProfileServices remoteDataSource;

  ProfileTabProfileRepositoryImpl({required this.remoteDataSource});

  @override
  Future<UserModel> fetchUserProfile() async {
    final rawData = await remoteDataSource.fetchUserProfileRaw();

    return remoteDataSource.getUserModelFromRawData(rawData);
  }

  @override
  Future<Institution?> fetchUserInstitution() async {
    final rawData = await remoteDataSource.fetchUserProfileRaw();

    return remoteDataSource.getInstitutionFromRawData(rawData);
  }

  @override
  Future<Position?> fetchUserPosition() async {
    final rawData = await remoteDataSource.fetchUserProfileRaw();

    return remoteDataSource.getPositionFromRawData(rawData);
  }
}
