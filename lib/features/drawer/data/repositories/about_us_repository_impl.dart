import '../../domain/entities/about_us_entity.dart';
import '../../domain/repositories/about_us_repository.dart';
import '../datasources/about_us_remote_datasource.dart';

class AboutUsRepositoryImpl implements AboutUsRepository {
  final AboutUsRemoteDataSource remoteDataSource;

  AboutUsRepositoryImpl(this.remoteDataSource);

  @override
  Future<AboutUsEntity> getAboutUs() async {
    try {
      final model = await remoteDataSource.getAboutUs();
      return AboutUsEntity(
        id: model.id,
        title: model.title,library_name: model.library_name,
        description: model.description,
        address: model.address,
        phone1: model.phone1,
        phone2: model.phone2,
        email: model.email,
        instagram: model.instagram,
        telegram: model.telegram,
        youtube: model.youtube,
        facebook: model.facebook,
        twitter: model.twitter,
        image: model.image,
      );
    } catch (e) {
      throw Exception('Repository error: ${e.toString()}');
    }
  }
}
