import 'package:kutubxona/config/theme/app_colors.dart';
import 'package:kutubxona/core/core_exports.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class StatCard extends StatelessWidget {
  final String title;
  final String leftLabel;
  final int leftValue;
  final String rightLabel;
  final int rightValue;
  final int total;

  const StatCard({
    super.key,
    required this.title,
    required this.leftLabel,
    required this.leftValue,
    required this.rightLabel,
    required this.rightValue,
    required this.total,
  });

  @override
  Widget build(BuildContext context) {
    final leftPercent = total == 0 ? 0.0 : leftValue / total;

    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(color: AppColors().border),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            Text(
              title,
              style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                // Legend uchun joyni moslashtirish
                Expanded(
                  child: _buildLegendColumn(
                    leftLabel,
                    leftValue,
                    rightLabel,
                    rightValue,
                  ),
                ),

                // Spacer qo‘shib bo‘shliq ochish (ixtiyoriy)
                const SizedBox(width: 12),

                // Indicatorni qat'iy o‘lcham bilan cheklash
                SizedBox(
                  width: 100,
                  height: 100,
                  child: CircularPercentIndicator(
                    radius: 50,
                    lineWidth: 12,
                    percent: leftPercent,
                    center: Text("$total\nжами", textAlign: TextAlign.center),
                    progressColor: const Color(0xffFF92AE),
                    backgroundColor: const Color(0xffA6B7D4),
                    circularStrokeCap: CircularStrokeCap.round,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLegendColumn(
    String leftLabel,
    int leftValue,
    String rightLabel,
    int rightValue,
  ) {
    return Column(
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
          style: TextStyle(color: AppColors().textBodyMuted, fontSize: 12),
        ),
      ],
    );
  }
}
