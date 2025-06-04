import 'package:flutter/material.dart';
import 'package:kutubxona/export.dart';
import 'package:kutubxona/features/drawer/domain/entities/statistic_entity.dart'; // AppColors uchun kerak bo‘lsa

class MonthlyActivityChart extends StatelessWidget {
  const MonthlyActivityChart({super.key, required this.statistic});
  final StatisticEntity statistic;
  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(color: Colors.grey.shade300),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            const Text(
              "Охирги ой ичида олинган ва қайтарилган китоблар",
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: const [
                _Legend(color: Color(0xffFF92AE), text: 'Қайтарилган китоблар'),
                _Legend(color: Color(0xffA6B7D4), text: 'Олинган китоблар'),
              ],
            ),
            const SizedBox(height: 24),
            ...List.generate(statistic.last30DaysStatistics.length, (i) {
              final dayStat = statistic.last30DaysStatistics[i];
              final takenPercent = dayStat.takenBooks / 100;
              final returnedPercent = dayStat.returnedBooks / 100;
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 12),
                child: Row(
                  children: [
                    Text(
                      dayStat.date,
                      style: TextStyle(
                        fontSize: 9,
                        fontWeight: FontWeight.w600,
                        color: AppColors().textBodyMuted,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        children: [
                          LinearProgressIndicator(
                            value: takenPercent,
                            backgroundColor: const Color(0xffF1F5F9),
                            valueColor: const AlwaysStoppedAnimation(
                              Color(0xffA6B7D4),
                            ),
                            minHeight: 8,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          const SizedBox(height: 3),
                          LinearProgressIndicator(
                            value: returnedPercent,
                            backgroundColor: const Color(0xffF1F5F9),
                            valueColor: const AlwaysStoppedAnimation(
                              Color(0xffFF92AE),
                            ),
                            minHeight: 8,
                            borderRadius: BorderRadius.circular(8),
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

class _Legend extends StatelessWidget {
  final Color color;
  final String text;

  const _Legend({required this.color, required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CircleAvatar(radius: 4, backgroundColor: color),
        const SizedBox(width: 6),
        Text(
          text,
          style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
        ),
      ],
    );
  }
}
