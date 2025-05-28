// domain/entities/contribution.dart
class Contribution {
  final int id;
  final String cardNumber1;
  final String cardNumber2;
  final String description;
  final String imageUrl;

  const Contribution({
    required this.id,
    required this.cardNumber1,
 required   this.cardNumber2,
    required this.description,
    required this.imageUrl,
  });
}
