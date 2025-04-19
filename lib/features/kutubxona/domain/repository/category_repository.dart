// lib/features/kutubxona/domain/repositories/category_repository.dart
import 'package:kutubxona/features/kutubxona/domain/entities/category.dart';

abstract class CategoryRepository {
  Future<List<Category>> getCategories(); // Kategoriyalarni olish
}
