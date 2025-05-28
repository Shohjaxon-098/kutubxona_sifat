import 'package:flutter/material.dart';
import 'package:kutubxona/export.dart'; // AppColors uchun kerak bo‘lsa

class MonthlyActivityChart extends StatelessWidget {
  const MonthlyActivityChart({super.key});

  @override
  Widget build(BuildContext context) {
    final dates = List.generate(12, (i) => "12.05.2025");
    final values = [30, 50, 40, 70, 90, 80, 60, 40, 20, 50, 70, 100];

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
            ...List.generate(dates.length, (i) {
              final percent = values[i] / 100;
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 12),
                child: Row(
                  children: [
                    Text(
                      dates[i],
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
                            value: percent,
                            backgroundColor: const Color(0xffF1F5F9),
                            valueColor: const AlwaysStoppedAnimation(
                              Color(0xffA6B7D4),
                            ),
                            minHeight: 8,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          const SizedBox(height: 3),
                          LinearProgressIndicator(
                            value: percent,
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

  const _Legend({super.key, required this.color, required this.text});

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
