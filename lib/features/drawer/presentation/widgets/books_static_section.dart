import 'package:flutter/material.dart';
import 'package:kutubxona/config/theme/app_colors.dart';

class BooksStatisticsSection extends StatelessWidget {
  final int value;
  final double percent;
  const BooksStatisticsSection({
    super.key,
    required this.value,
    required this.percent,
  });

  @override
  Widget build(BuildContext context) {
    final stats = [
      {"label": "Умумий ўқиш учун берилган китоблар"},
      {"label": "Кунлик бериладиган китоблар сони"},
      {"label": "Охирги ойда берилган китоблар"},
      {"label": "Охирги ҳафтада берилган китоблар"},
      {"label": "Охирги 24 соат ичида берилган китоблар"},
    ];

    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(color: Colors.grey.shade300),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children:
              stats.map((stat) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: Row(
                    children: [
                      SizedBox(
                        width: 150,
                        child: Text(
                          stat['label'].toString(),
                          style: TextStyle(
                            fontSize: 11,
                            color: AppColors().textBodyMuted,
                          ),
                        ),
                      ),
                      Expanded(
                        child: LinearProgressIndicator(
                          value: percent,
                          backgroundColor: const Color(0xFFE2E8F0),
                          valueColor: const AlwaysStoppedAnimation(
                            Color(0xFFFF70B5),
                          ),
                          minHeight: 10,
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                      SizedBox(
                        width: 60,
                        child: Text(
                          value.toString(),
                          textAlign: TextAlign.end,
                          style: const TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 13,
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
