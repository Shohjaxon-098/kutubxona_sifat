// data/models/contribution_model.dart
import '../../domain/entities/contribution.dart';

class ContributionModel extends Contribution {
  const ContributionModel({
    required int id,
    required String cardNumber1,
    required String cardNumber2,
    required String description,
    required String imageUrl,
  }) : super(
         id: id,
         cardNumber1: cardNumber1,
         cardNumber2: cardNumber2,
         description: description,
         imageUrl: imageUrl,
       );

  factory ContributionModel.fromJson(Map<String, dynamic> json) {
    return ContributionModel(
      id: json['id'] ?? 0,
      cardNumber1: json['card_number1'] ?? '',
      cardNumber2: json['card_number2'] ?? '', // nullable
      description: json['description'] ?? '',
      imageUrl: json['image'] ?? '', // MediaURL ichidagi url
    );
  }
}
