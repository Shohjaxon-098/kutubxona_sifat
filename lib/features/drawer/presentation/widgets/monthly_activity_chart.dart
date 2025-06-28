import 'package:kutubxona/export.dart';
import 'package:kutubxona/features/drawer/domain/entities/statistic_entity.dart';

class MonthlyActivityChart extends StatelessWidget {
  const MonthlyActivityChart({super.key, required this.statistic});
  final StatisticEntity? statistic;

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.r),
        side: BorderSide(color: Colors.grey.shade300),
      ),
      child: Padding(
        padding: EdgeInsets.all(12.w),
        child: Column(
          children: [
            Text(
              "Охирги ой ичида олинган ва қайтарилган китоблар",
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
                fontFamily: 'OpenSans',
              ),
            ),
            SizedBox(height: 12.h),
            const Row(
              children: [
                Expanded(
                  child: Legend(
                    color: Color(0xffFF92AE),
                    text: 'Қайтарилган китоблар',
                  ),
                ),
                Expanded(
                  child: Legend(
                    color: Color(0xffA6B7D4),
                    text: 'Олинган китоблар',
                  ),
                ),
              ],
            ),
            SizedBox(height: 24.h),
            ...List.generate(statistic!.last30DaysStatistics.length, (i) {
              final dayStat = statistic!.last30DaysStatistics[i];
              final takenPercent = dayStat!.takenBooks / 10;
              final returnedPercent = dayStat.returnedBooks / 10;
              return Padding(
                padding: EdgeInsets.symmetric(vertical: 12.h),
                child: Row(
                  children: [
                    SizedBox(
                      width: 40.w,
                      child: Text(
                        dayStat.date,
                        style: TextStyle(
                          fontSize: 9.sp,
                          fontWeight: FontWeight.w600,
                          color: AppColors().textBodyMuted,
                        ),
                      ),
                    ),
                    SizedBox(width: 10.w),
                    Expanded(
                      child: Column(
                        children: [
                          LinearProgressIndicator(
                            value: takenPercent,
                            backgroundColor: const Color(0xffF1F5F9),
                            valueColor: const AlwaysStoppedAnimation(
                              Color(0xffA6B7D4),
                            ),
                            minHeight: 8.h,
                            borderRadius: BorderRadius.circular(8.r),
                          ),
                          SizedBox(height: 3.h),
                          LinearProgressIndicator(
                            value: returnedPercent,
                            backgroundColor: const Color(0xffF1F5F9),
                            valueColor: const AlwaysStoppedAnimation(
                              Color(0xffFF92AE),
                            ),
                            minHeight: 8.h,
                            borderRadius: BorderRadius.circular(8.r),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}

class Legend extends StatelessWidget {
  final Color color;
  final String text;

  const Legend({super.key, required this.color, required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CircleAvatar(radius: 4.r, backgroundColor: color),
        SizedBox(width: 6.w),
        Flexible(
          child: Text(
            text,
            overflow: TextOverflow.clip,
            style: TextStyle(
              fontFamily: 'Roboto',
              fontSize: 10.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    );
  }
}
