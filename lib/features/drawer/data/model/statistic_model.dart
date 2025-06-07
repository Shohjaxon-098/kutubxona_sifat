import 'package:kutubxona/features/drawer/data/model/book_static_model.dart';
import 'package:kutubxona/features/drawer/data/model/daily_statistic_model.dart';
import 'package:kutubxona/features/drawer/data/model/top_reader_model.dart';
import 'package:kutubxona/features/drawer/domain/entities/book_statistic_entity.dart';
import 'package:kutubxona/features/drawer/domain/entities/daily_statistic_entity.dart';
import 'package:kutubxona/features/drawer/domain/entities/top_reader_entity.dart';

import '../../domain/entities/statistic_entity.dart';

class StatisticModel extends StatisticEntity {
  const StatisticModel({
    required int? totalMembers,
    required int? maleMembers,
    required int? femaleMembers,
    required int? totalBooks,
    required int? availableBooks,
    required int? totalReservations,
    required int? activeReservations,
    required int? overdueBooks,
    required int? reservationsLastDay,
    required int? reservationsLastWeek,
    required int? reservationsLastMonth,
    required int? averageReservationsPerDay,
    required List<BookStatisticEntity?> topReservedBooksLastWeek,
    required List<BookStatisticEntity?> topBooks,
    required List<TopReaderEntity?> topReaders,
    required List<DailyStatisticEntity?> last30DaysStatistics,
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
         last30DaysStatistics: last30DaysStatistics,
       );
  factory StatisticModel.fromJson(Map<String, dynamic> json) {
    return StatisticModel(
      totalMembers: json['total_members'] ?? 0,
      maleMembers: json['male_members'] ?? 0,
      femaleMembers: json['female_members'] ?? 0,
      totalBooks: json['total_books'] ?? 0,
      availableBooks: json['available_books'] ?? 0,
      totalReservations: json['total_reservations'] ?? 0,
      activeReservations: json['active_reservations'] ?? 0,
      overdueBooks: json['overdue_books'] ?? 0,
      reservationsLastDay: json['reservations_last_day'] ?? 0,
      reservationsLastWeek: json['reservations_last_week'] ?? 0,
      reservationsLastMonth: json['reservations_last_month'] ?? 0,
      averageReservationsPerDay: json['average_reservations_per_day'] ?? 0,

      topBooks:
          (json['top_books'] as List? ?? [])
              .where((e) => e != null)
              .map((e) => BookStatisticModel.fromJson(e))
              .toList()
              .cast<BookStatisticEntity>(),

      topReservedBooksLastWeek:
          (json['top_reserved_books_last_week'] as List? ?? [])
              .where((e) => e != null)
              .map((e) => BookStatisticModel.fromJson(e))
              .toList()
              .cast<BookStatisticEntity>(),

      topReaders:
          (json['top_readers'] as List? ?? [])
              .where((e) => e != null)
              .map((e) => TopReaderModel.fromJson(e))
              .toList()
              .cast<TopReaderEntity>(),

      last30DaysStatistics:
          (json['last_30_days_statistics'] as List? ?? [])
              .where((e) => e != null)
              .map((e) => DailyStatisticModel.fromJson(e))
              .toList()
              .cast<DailyStatisticEntity>(),
    );
  }
}
