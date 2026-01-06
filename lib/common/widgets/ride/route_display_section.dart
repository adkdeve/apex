import 'package:apex/app/core/core.dart';
import 'package:flutter/material.dart';
import '../painters/dashed_line_painter.dart';

class RouteDisplaySection extends StatelessWidget {
  const RouteDisplaySection({
    Key? key,
    required this.pickupLocation,
    required this.dropoffLocation,
    this.pickupSubtitle,
    this.dropoffSubtitle,
    this.pickupTime,
    this.dropoffTime,
    this.distance,
    this.pickupColor = Colors.redAccent,
    this.dropoffColor = const Color(
      0xFFCFA854,
    ), // TODO: Should use R.theme.goldAccent but requires import
    this.backgroundColor,
    this.showStops = false,
    this.onStopsTap,
    this.padding,
  }) : super(key: key);

  final String pickupLocation;
  final String dropoffLocation;
  final String? pickupSubtitle;
  final String? dropoffSubtitle;
  final String? pickupTime;
  final String? dropoffTime;
  final String? distance;
  final Color pickupColor;
  final Color dropoffColor;
  final Color? backgroundColor;
  final bool showStops;
  final VoidCallback? onStopsTap;
  final EdgeInsets? padding;

  @override
  Widget build(BuildContext context) {
    Widget content = Container(
      padding: padding ?? const EdgeInsets.all(6),
      decoration: backgroundColor != null
          ? BoxDecoration(
              color: backgroundColor,
              borderRadius: BorderRadius.circular(16),
            )
          : null,
      child: Row(
        children: [
          Column(
            children: [
              Container(
                width: 18,
                height: 18,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: pickupColor, width: 4),
                ),
              ),

              SizedBox(
                height: 40,
                child: CustomPaint(painter: DashedLineVerticalPainter()),
              ),

              Icon(Icons.location_on, color: dropoffColor, size: 20),
            ],
          ),

          16.sbw,

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            pickupLocation,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          if (pickupSubtitle != null) ...[
                            const SizedBox(height: 4),
                            Text(
                              pickupSubtitle!,
                              style: TextStyle(
                                color: Colors.grey[500],
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ],
                      ),
                    ),
                    if (pickupTime != null) ...[
                      const SizedBox(width: 8),
                      Text(
                        pickupTime!,
                        style: TextStyle(color: Colors.grey[500], fontSize: 13),
                      ),
                    ],
                  ],
                ),
                const SizedBox(height: 4),
                const Divider(color: Colors.grey, thickness: 0.5),
                const SizedBox(height: 4),

                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Text(
                                  dropoffLocation,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                              if (distance != null) ...[
                                const SizedBox(width: 8),
                                Text(
                                  distance!,
                                  style: TextStyle(
                                    color: Colors.grey[500],
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ],
                          ),
                          if (dropoffSubtitle != null) ...[
                            const SizedBox(height: 4),
                            Text(
                              dropoffSubtitle!,
                              style: TextStyle(
                                color: Colors.grey[500],
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ],
                      ),
                    ),
                    if (dropoffTime != null) ...[
                      const SizedBox(width: 8),
                      Text(
                        dropoffTime!,
                        style: TextStyle(color: Colors.grey[500], fontSize: 13),
                      ),
                    ],
                  ],
                ),

                if (showStops) ...[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      InkWell(
                        onTap: onStopsTap,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: Colors.grey[700]!),
                          ),
                          child: const Text(
                            "Stops",
                            style: TextStyle(color: Colors.white, fontSize: 12),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );

    return content;
  }
}
