import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kutubxona/config/theme/app_colors.dart';
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

    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.r),
        side: BorderSide(color: AppColors().border),
      ),
      child: Padding(
        padding: EdgeInsets.all(12.w),
        child: Column(
          children: [
            Text(
              title,
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16.sp),
            ),
            SizedBox(height: 12.h),
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
                SizedBox(width: 12.w),
                SizedBox(
                  width: 100.w,
                  height: 100.w,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      CircularPercentIndicator(
                        radius: 50.r,
                        lineWidth: 12.w,
                        percent: leftPercent,
                        progressColor: const Color(0xffFF92AE),
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
                        style: TextStyle(fontSize: 12.sp),
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
        SizedBox(height: 12.h),
        if (showExtraText && cntrLabel != null && cntrValue != null)
          Column(
            children: [
              _buildLegend(
                color: AppColors().donutCenter,
                label: cntrLabel,
                number: cntrValue.toString(),
              ),
              SizedBox(height: 12.h),
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
            CircleAvatar(radius: 6.r, backgroundColor: color),
            SizedBox(width: 6.w),
            Text(
              number,
              style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w500),
            ),
          ],
        ),
        Text(
          label,
          style: TextStyle(color: AppColors().textBodyMuted, fontSize: 12.sp),
        ),
      ],
    );
  }
}
