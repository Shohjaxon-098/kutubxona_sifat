import '../entities/about_us_entity.dart';

abstract class AboutUsRepository {
  Future<AboutUsEntity> getAboutUs();
}
