import 'package:kutubxona/features/profile/data/datasources/edit_profile_remote_datasource.dart';
import 'package:kutubxona/features/profile/data/model/edit_profile_model.dart';
import 'package:kutubxona/features/profile/domain/entities/edit_profile_entity.dart';
import 'package:kutubxona/features/profile/domain/repositories/edit_profile_repository.dart';

class ProfileRepositoryImpl implements ProfileRepository {
  final ProfileRemoteDataSource remoteDataSource;

  ProfileRepositoryImpl(this.remoteDataSource);

  @override
  Future<void> updateProfile( EditProfileEntity entity) {
    final model = UpdateProfileModel(
      firstName: entity.firstName ?? '',
      lastName: entity.lastName ?? '',
      gender: entity.gender,
      telegramUsername: entity.telegramUsername,
      password: entity.password,
      birthDate: entity.birthDate,
      documentNumber: entity.documentNumber,
      documentFile1: entity.documentFile1,
      documentFile2: entity.documentFile2,
      photo: entity.photo,
      verificationType: entity.verificationType,
    
    );
    return remoteDataSource.updateProfile( model);
  }
}
