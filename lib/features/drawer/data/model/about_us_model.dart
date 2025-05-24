import '../../domain/entities/about_us_entity.dart';

class AboutUsModel extends AboutUsEntity {
  AboutUsModel({
    required int id,
    required String title,
    required String library_name,
    required String description,
    required String address,
    required String phone1,
    required String phone2,
    required String email,
    required String instagram,
    required String telegram,
    required String youtube,
    required String facebook,
    required String twitter,
    required String image,
  }) : super(
         id: id,
         title: title,
         library_name: library_name,
         description: description,
         address: address,
         phone1: phone1,
         phone2: phone2,
         email: email,
         instagram: instagram,
         telegram: telegram,
         youtube: youtube,
         facebook: facebook,
         twitter: twitter,
         image: image,
       );

  factory AboutUsModel.fromJson(Map<String, dynamic> json) {
    return AboutUsModel(
      id: json['id'] ?? '',
      library_name: json['library_name'] ?? '',
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      address: json['address'] ?? '',
      phone1: json['phone1'] ?? '',
      phone2: json['phone2'] ?? '',
      email: json['email'] ?? '',
      instagram: json['instagram'] ?? '',
      telegram: json['telegram'] ?? '',
      youtube: json['youtube'] ?? '',
      facebook: json['facebook'] ?? '',
      twitter: json['twitter'] ?? '',
      image: json['image'] ?? '',
    );
  }
}
