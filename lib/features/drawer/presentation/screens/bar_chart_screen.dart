import 'package:flutter/material.dart';
import 'package:kutubxona/export.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class StatistikaScreen extends StatelessWidget {
  const StatistikaScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.surface,
        title: const Text(
          "Статистика",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
      ),
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildStatCard(
                title: "Китобхонлар",
                leftLabel: "Аёллар",
                leftValue: 500,
                rightLabel: "Эркаклар",
                rightValue: 300,
              ),
              const SizedBox(height: 16),
              _buildStatCard(
                title: "Китоблар",
                leftLabel: "Талаб қилиб",
                leftValue: 450,
                rightLabel: "Ўқиш учун берилган",
                rightValue: 550,
              ),
              const SizedBox(height: 24),

              _buildBooksStatisticsSection(context),

              const SizedBox(height: 24),
              _buildMonthlyActivityChart(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatCard({
    required String title,
    required String leftLabel,
    required int leftValue,
    required String rightLabel,
    required int rightValue,
  }) {
    final total = leftValue + rightValue;
    final leftPercent = leftValue / total;

    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(color: AppColors().border),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            Text(
              title,
              style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
            ),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildLegend(
                      color: const Color(0xffFF92AE),
                      label: leftLabel,
                      number: leftValue.toString(),
                    ),
                    const SizedBox(height: 21),
                    _buildLegend(
                      color: const Color(0xffA6B7D4),
                      label: rightLabel,
                      number: rightValue.toString(),
                    ),
                  ],
                ),
                CircularPercentIndicator(
                  radius: 50,
                  lineWidth: 12,
                  percent: leftPercent,
                  center: Text(
                    "$total\nжами",
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontWeight: FontWeight.w500),
                  ),
                  progressColor: const Color(0xffFF92AE),
                  backgroundColor: const Color(0xffA6B7D4),
                  circularStrokeCap: CircularStrokeCap.round,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLegend({
    required Color color,
    required String label,
    required String number,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            CircleAvatar(radius: 6, backgroundColor: color),
            const SizedBox(width: 6),
            Text(
              number,
              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
            ),
          ],
        ),
        Text(
          label,
          style: const TextStyle(color: Color(0xff718096), fontSize: 12),
        ),
      ],
    );
  }

  Widget _buildSubTitle(String title) {
    return Text(
      title,
      style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
    );
  }

  Widget _buildBooksStatisticsSection(BuildContext context) {
    final stats = [
      {
        "label": "Умумий ўқиш учун берилган китоблар",
        "value": 500235,
        "percent": 1.0,
      },
      {
        "label": "Кунлик бериладиган китоблар сони",
        "value": 2353,
        "percent": 0.45,
      },
      {
        "label": "Охирги ойда берилган китоблар",
        "value": 2134,
        "percent": 0.35,
      },
      {
        "label": "Охирги ҳафтада берилган китоблар",
        "value": 40312,
        "percent": 0.2,
      },
      {
        "label": "Охирги 24 соат ичида берилган китоблар",
        "value": 21314,
        "percent": 0.1,
      },
    ];

    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(color: Colors.grey.shade300),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Китоблар умумий статистикаси",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: 20),
            ...stats.map((stat) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: Row(
                  children: [
                    /// Matn uchun cheklangan kenglik
                    SizedBox(
                      width: 150,
                      child: Text(
                        stat["label"] as String,
                        style: const TextStyle(fontSize: 11),
                      ),
                    ),

                    /// Progress bar
                    Expanded(
                      child: LinearProgressIndicator(
                        value: stat["percent"] as double,
                        backgroundColor: const Color(0xFFE2E8F0),
                        valueColor: const AlwaysStoppedAnimation<Color>(
                          Color(0xFFFF70B5),
                        ),
                        minHeight: 10,
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),

                    /// Qiymat (son)
                    SizedBox(
                      width: 60,
                      child: Text(
                        "${stat["value"]}",
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
          ],
        ),
      ),
    );
  }
}

Widget _buildMonthlyActivityChart() {
  final months = [
    "12.05.2025",
    "12.05.2025",
    "12.05.2025",
    "12.05.2025",
    "12.05.2025",
    "12.05.2025",
    "12.05.2025",
    "12.05.2025",
    "12.05.2025",
    "12.05.2025",
    "12.05.2025",
    "12.05.2025",
  ];
  final values = [30, 50, 40, 70, 90, 80, 60, 40, 20, 50, 70, 100];

  return Card(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(16),
      side: BorderSide(color: Colors.grey.shade300),
    ),
    child: Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        children: [
          const Text(
            "Охирги ой ичида олинган ва қайтарилган китоблар",
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
          ),
          SizedBox(height: 12),
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    radius: 4,
                    backgroundColor: const Color(0xffFF92AE),
                  ),

                  const SizedBox(width: 6),
                  Text(
                    'Қайтарилган китоблар',
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  CircleAvatar(
                    radius: 4,
                    backgroundColor: const Color(0xffA6B7D4),
                  ),

                  const SizedBox(width: 6),
                  Text(
                    'Олинган китоблар',
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: 24),
          Column(
            children: List.generate(months.length, (index) {
              final percent = values[index] / 100;
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 4),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Text(
                          months[index],
                          style: const TextStyle(fontSize: 12),
                        ),
                        SizedBox(width: 10),
                        Expanded(
                          child: LinearProgressIndicator(
                            value: percent,
                            backgroundColor: const Color(0xffF1F5F9),
                            valueColor: AlwaysStoppedAnimation<Color>(
                              Color(0xffFF92AE),
                            ),
                            minHeight: 8,
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          "${values[index]}",
                          style: const TextStyle(fontSize: 12),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            }),
          ),
        ],
      ),
    ),
  );
}
