import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kutubxona/config/theme/app_colors.dart';
import 'package:kutubxona/features/drawer/domain/entities/statistic_entity.dart';

class BooksStatisticsSection extends StatelessWidget {
  final StatisticEntity value;
  final double percent;

  const BooksStatisticsSection({
    super.key,
    required this.value,
    required this.percent,
  });

  @override
  Widget build(BuildContext context) {
    final stats = [
      {
        "label": "Умумий ўқиш учун берилган китоблар",
        'value': value.totalReservations,
      },
      {
        "label": "Кунлик бериладиган китоблар сони",
        'value': value.reservationsLastDay,
      },
      {
        "label": "Охирги ойда берилган китоблар",
        'value': value.reservationsLastWeek,
      },
      {
        "label": "Охирги ҳафтада берилган китоблар",
        'value': value.reservationsLastMonth,
      },
      {
        "label": "Охирги 24 соат ичида берилган китоблар",
        'value': value.averageReservationsPerDay,
      },
    ];

    final maxValue = stats.map((e) => e['value'] as int).reduce((a, b) => a > b ? a : b);

    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.r),
        side: BorderSide(color: Colors.grey.shade300),
      ),
      child: Padding(
        padding: EdgeInsets.all(12.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: stats.map((stat) {
            final statValue = stat['value'] as int;
            final localPercent = maxValue == 0 ? 0.0 : statValue / maxValue;

            return Padding(
              padding: EdgeInsets.only(bottom: 16.h),
              child: Row(
                children: [
                  SizedBox(
                    width: 150.w,
                    child: Text(
                      stat['label'].toString(),
                      style: TextStyle(
                        fontSize: 11.sp,
                        color: AppColors().textBodyMuted,
                      ),
                    ),
                  ),
                  Expanded(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(16.r),
                      child: LinearProgressIndicator(
                        value: localPercent,
                        backgroundColor: const Color(0xFFE2E8F0),
                        valueColor: const AlwaysStoppedAnimation(Color(0xFFFF70B5)),
                        minHeight: 10.h,
                      ),
                    ),
                  ),
                  SizedBox(width: 8.w),
                  SizedBox(
                    width: 60.w,
                    child: Text(
                      stat['value'].toString(),
                      textAlign: TextAlign.end,
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 13.sp,
                      ),
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
