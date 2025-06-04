class DailyStatisticEntity {
  final String date;
  final int takenBooks;
  final int returnedBooks;

  const DailyStatisticEntity({
    required this.date,
    required this.takenBooks,
    required this.returnedBooks,
  });
}
