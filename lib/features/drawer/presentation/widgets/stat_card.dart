import 'package:kutubxona/config/theme/app_colors.dart';
import 'package:kutubxona/core/core_exports.dart';
import 'package:kutubxona/features/drawer/presentation/widgets/state_doun_chart.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class StatCard extends StatelessWidget {
  final String title;
  final bool showExtraText;
  final String leftLabel;
  final int? leftValue;
  final String rightLabel;
  final int? rightValue;
  final int? total;
  final String? cntrLabel;
  final int? cntrvalue;
  const StatCard({
    super.key,
    required this.title,
    required this.leftLabel,
    required this.leftValue,
    required this.rightLabel,
    required this.rightValue,
    this.cntrLabel,
    this.cntrvalue,
    required this.total,
    this.showExtraText = false,
  });
  @override
  Widget build(BuildContext context) {
    final leftPercent = total == 0 ? 0.0 : leftValue! / total!;
    // final centerPercent =
    //     (showExtraText && cntrvalue != null && total != 0)
    //         ? cntrvalue! / total
    //         : 0.0;
    // final rightPercent = total == 0 ? 0.0 : rightValue / total;

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
                Expanded(
                  child: _buildLegendColumn(
                    leftLabel,
                    leftValue!,
                    rightLabel,
                    rightValue!,
                    cntrLabel,
                    cntrvalue,
                  ),
                ),
                const SizedBox(width: 12),
                SizedBox(
                  width: 100,
                  height: 100,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      CircularPercentIndicator(
                        radius: 50,
                        lineWidth: 12,
                        percent: leftPercent,
                        progressColor: const Color(0xffFF92AE), // pink
                        backgroundColor: AppColors().donutRight,
                        circularStrokeCap: CircularStrokeCap.round,
                      ),
                      if (showExtraText)
                        StatDonutChart(
                          left: leftValue!,
                          center: cntrvalue ?? 0,
                          right: rightValue!,
                          total: total!,
                        ),

                      Text(
                        "$total\nжами",
                        textAlign: TextAlign.center,
                        style: const TextStyle(fontSize: 12),
                      ),
                    ],
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
    String? cntrLabel,
    int? cntrValue,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildLegend(
          color: AppColors().donutLeft,
          label: leftLabel,
          number: leftValue.toString(),
        ),
        const SizedBox(height: 12),

        if (showExtraText && cntrLabel != null && cntrValue != null)
          Column(
            children: [
              _buildLegend(
                color: AppColors().donutCenter,
                label: cntrLabel,
                number: cntrValue.toString(),
              ),
              const SizedBox(height: 12),
            ],
          ),

        _buildLegend(
          color: AppColors().donutRight,
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
