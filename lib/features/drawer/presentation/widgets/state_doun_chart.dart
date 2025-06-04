import 'dart:math';
import 'package:flutter/material.dart';
import 'package:kutubxona/export.dart';

class StatDonutChart extends StatelessWidget {
  final int left;
  final int center;
  final int right;
  final int total;

  const StatDonutChart({
    super.key,
    required this.left,
    required this.center,
    required this.right,
    required this.total,
  });

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _SegmentedCirclePainter(
        left: left,
        center: center,
        right: right,
        total: total,
      ),
      child: const SizedBox(width: 100, height: 100),
    );
  }
}

class _SegmentedCirclePainter extends CustomPainter {
  final int left;
  final int center;
  final int right;
  final int total;

  _SegmentedCirclePainter({
    required this.left,
    required this.center,
    required this.right,
    required this.total,
  });

  @override
  void paint(Canvas canvas, Size size) {
    if (total == 0) return;

    final strokeWidth = 12.0;
    final radius = (size.width - strokeWidth) / 2;
    final centerOffset = Offset(size.width / 2, size.height / 2);
    final paint =
        Paint()
          ..style = PaintingStyle.stroke
          ..strokeWidth = strokeWidth
          ..strokeCap = StrokeCap.round;

    double startAngle = -pi / 2;
    double totalSweep = 2 * pi;
    double minSweep = 0.035; // Minimum visible segment

    // Convert raw values to sweep angles
    List<_Segment> segments = [
      _Segment(value: left.toDouble(), color: AppColors().donutLeft),
      _Segment(value: center.toDouble(), color: AppColors().donutCenter),
      _Segment(value: right.toDouble(), color: AppColors().donutRight),
    ];

    double valueSum = segments.fold(0, (sum, s) => sum + s.value);
    double reserved = segments.where((s) => s.value > 0).length * minSweep;
    double scale = (totalSweep - reserved) / valueSum;

    for (final segment in segments) {
      if (segment.value == 0) continue;
      double sweepAngle = segment.value * scale + minSweep;
      paint.color = segment.color;
      canvas.drawArc(
        Rect.fromCircle(center: centerOffset, radius: radius),
        startAngle,
        sweepAngle,
        false,
        paint,
      );
      startAngle += sweepAngle;
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

class _Segment {
  final double value;
  final Color color;
  _Segment({required this.value, required this.color});
}
