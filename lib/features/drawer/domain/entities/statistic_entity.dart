class StatisticEntity {
  final int totalMembers;
  final int maleMembers;
  final int femaleMembers;
  final int totalBooks;
  final int availableBooks;
  final int totalReservations;
  final int activeReservations;
  final int overdueBooks;
  final int reservationsLastDay;
  final int reservationsLastWeek;
  final int reservationsLastMonth;
  final int averageReservationsPerDay;
  final List<dynamic> topReservedBooksLastWeek;
  final List<dynamic> topBooks;
  final List<dynamic> topReaders;

  const StatisticEntity({
    required this.totalMembers,
    required this.maleMembers,
    required this.femaleMembers,
    required this.totalBooks,
    required this.availableBooks,
    required this.totalReservations,
    required this.activeReservations,
    required this.overdueBooks,
    required this.reservationsLastDay,
    required this.reservationsLastWeek,
    required this.reservationsLastMonth,
    required this.averageReservationsPerDay,
    required this.topReservedBooksLastWeek,
    required this.topBooks,
    required this.topReaders,
  });
}
