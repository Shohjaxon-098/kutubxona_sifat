import 'package:kutubxona/features/profile/data/datasources/edit_profile_remote_datasource.dart';
import 'package:kutubxona/features/profile/data/datasources/user_profile_remote_data_source.dart';
import 'package:kutubxona/features/profile/data/model/edit_profile_model.dart';
import 'package:kutubxona/features/profile/domain/entities/user_entity.dart';
import 'package:kutubxona/features/profile/domain/repositories/edit_profile_repository.dart';
import 'package:kutubxona/features/profile/domain/repositories/user_profile_repository.dart';

class UserProfileRepositoryImpl implements UserProfileRepository {
  final UserProfileRemoteDataSource remoteDataSource;

  UserProfileRepositoryImpl(this.remoteDataSource);

  @override
  Future<UserProfileEntity> getUserProfile() async {
    final model = await remoteDataSource.getUserProfile();
    return model;
  }
}
