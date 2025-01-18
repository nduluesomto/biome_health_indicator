import 'dart:math';

import 'package:biome_activity_test/core/constants/app_assets.dart';
import 'package:biome_activity_test/presentation/widgets/arc_progress_painter.dart';
import 'package:flutter/material.dart';

class StepWidgetContent extends StatelessWidget {
  final int steps;
  final double calories;
  final double distance;

  const StepWidgetContent(
      {super.key,
      required this.steps,
      required this.calories,
      required this.distance});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    const int stepTarget = 15000;
    double progress = min(steps / stepTarget, 1.0);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 20),
        Container(
            padding:
                const EdgeInsets.only(top: 12, bottom: 18, right: 14, left: 14),
            width: width / 1.5,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                border: Border.all(width: 1, color: Colors.white30),
                gradient:  LinearGradient(
                    begin: Alignment.bottomLeft,
                    end: Alignment.topRight,
                    colors: [
                      Colors.grey.shade600,
                      Colors.blueGrey.shade500
                      // Color(0xBF032D3D),
                      //Color(0xFF005B96)
                    ])),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Шагомер',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                        fontWeight: FontWeight.w400),
                  ),
                  const SizedBox(height: 8),
                  Row(children: [
                    Image.asset(AppAssets.locationIcon,
                        width: 25, height: 25, color: Colors.white),
                    const SizedBox(width: 6),
                    Text(distance.toStringAsFixed(2),
                        style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                            fontSize: 17)),
                    const SizedBox(width: 3),
                    const Text('км', style: TextStyle(color: Colors.white60)),
                  ]),
                  const SizedBox(height: 10),
                  Center(
                    child: SizedBox(
                      height: 155,
                      width: 155,
                      child: Stack(

                        children: [
                          CustomPaint(
                            painter: ArcProgressPainter(progress),
                            child: Center(
                              child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text('$steps',
                                        style: const TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white)),
                                    const Text('шаги',
                                        style: TextStyle(color: Colors.white60))
                                  ]),
                            ),
                          ),
                          Positioned(
                              left: 47,
                              bottom: 0,
                              child: Row(
                                children: [
                                  Image.asset(AppAssets.caloriesIcon,
                                      width: 25, height: 25, color: Colors.white),
                                  Column(
                                    children: [
                                      Text(
                                        calories.toStringAsFixed(2),
                                        style:
                                            const TextStyle(color: Colors.white),
                                      ),
                                      const Text(
                                        'ккал',
                                        style: TextStyle(
                                            fontSize: 13, color: Colors.white),
                                      )
                                    ],
                                  )
                                ],
                              ))
                        ],
                      ),
                    ),
                  ),
                ])),
      ],
    );
  }
}
