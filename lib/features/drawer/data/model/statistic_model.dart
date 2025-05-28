import '../../domain/entities/statistic_entity.dart';

class StatisticModel extends StatisticEntity {
  const StatisticModel({
    required int totalMembers,
    required int maleMembers,
    required int femaleMembers,
    required int totalBooks,
    required int availableBooks,
    required int totalReservations,
    required int activeReservations,
    required int overdueBooks,
    required int reservationsLastDay,
    required int reservationsLastWeek,
    required int reservationsLastMonth,
    required int averageReservationsPerDay,
    required List<dynamic> topReservedBooksLastWeek,
    required List<dynamic> topBooks,
    required List<dynamic> topReaders,
  }) : super(
         totalMembers: totalMembers,
         maleMembers: maleMembers,
         femaleMembers: femaleMembers,
         totalBooks: totalBooks,
         availableBooks: availableBooks,
         totalReservations: totalReservations,
         activeReservations: activeReservations,
         overdueBooks: overdueBooks,
         reservationsLastDay: reservationsLastDay,
         reservationsLastWeek: reservationsLastWeek,
         reservationsLastMonth: reservationsLastMonth,
         averageReservationsPerDay: averageReservationsPerDay,
         topReservedBooksLastWeek: topReservedBooksLastWeek,
         topBooks: topBooks,
         topReaders: topReaders,
       );

  factory StatisticModel.fromJson(Map<String, dynamic> json) {
    return StatisticModel(
      totalMembers: json['total_members'],
      maleMembers: json['male_members'],
      femaleMembers: json['female_members'],
      totalBooks: json['total_books'],
      availableBooks: json['available_books'],
      totalReservations: json['total_reservations'],
      activeReservations: json['active_reservations'],
      overdueBooks: json['overdue_books'],
      reservationsLastDay: json['reservations_last_day'],
      reservationsLastWeek: json['reservations_last_week'],
      reservationsLastMonth: json['reservations_last_month'],
      averageReservationsPerDay: json['average_reservations_per_day'],
      topReservedBooksLastWeek: json['top_reserved_books_last_week'],
      topBooks: json['top_books'],
      topReaders: json['top_readers'],
    );
  }
}
