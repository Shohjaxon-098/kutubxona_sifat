import '../../domain/entities/daily_statistic_entity.dart';

class DailyStatisticModel extends DailyStatisticEntity {
  const DailyStatisticModel({
    required String date,
    required int takenBooks,
    required int returnedBooks,
  }) : super(
          date: date,
          takenBooks: takenBooks,
          returnedBooks: returnedBooks,
        );

  factory DailyStatisticModel.fromJson(Map<String, dynamic> json) {
    return DailyStatisticModel(
      date: json['date'] ?? '',
      takenBooks: json['taken_books'] ?? 0,
      returnedBooks: json['returned_books'] ?? 0,
    );
  }
}
