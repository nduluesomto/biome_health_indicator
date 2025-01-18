import 'dart:math';

import 'package:flutter/material.dart';


class StepTrackerContent extends StatelessWidget {
  final int steps;
  final double calories;
  final double distance;

  const StepTrackerContent({
    required this.steps,
    required this.calories,
    required this.distance,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const int stepTarget = 15000;
    double progress = min(steps / stepTarget, 1.0);

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: 300,
            width: 300,
            child: CustomPaint(
              painter: ArcProgressPainter(progress),
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      '$steps / $stepTarget',
                      style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      '${calories.toStringAsFixed(2)} kcal burned',
                      style: const TextStyle(fontSize: 18, color: Colors.grey),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      '${distance.toStringAsFixed(2)} km covered',
                      style: const TextStyle(fontSize: 18, color: Colors.grey),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ArcProgressPainter extends CustomPainter {
  final double progress;

  ArcProgressPainter(this.progress);

  @override
  void paint(Canvas canvas, Size size) {
    final Paint backgroundPaint = Paint()
      ..color = Colors.teal.shade300.withOpacity(0.5)
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 14;

    final Paint progressPaint = Paint()
      ..color = Colors.blue
      ..style = PaintingStyle.fill
      ..strokeWidth = 14
      ..strokeCap = StrokeCap.round;

    final Rect rect = Rect.fromCircle(
      center: Offset(size.width / 2, size.height / 2),
      radius: size.width / 2.5,
    );

    const double startAngle = pi * 0.77; // Start from bottom-left
    const double sweepAngle = pi * 1.45; // Sweep to bottom-right

    // Draw background arc
    canvas.drawArc(rect, startAngle, sweepAngle, false, backgroundPaint);

    // Draw progress arc
    canvas.drawArc(rect, startAngle, sweepAngle * progress, false, progressPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
