// lib/features/kutubxona/domain/entities/category.dart
class Category {
  final int id;
  final String name;
  final String icon; // Yangi maydon

  Category({
    required this.id,
    required this.name,
    required this.icon,
  });

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json['id'],
      name: json['name'],
      icon: json['icon'], // JSONdan olingan icon maydoni
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'icon': icon, // iconni JSONga qo'shish
    };
  }
}
