import 'package:apex/app/core/core.dart';
import 'package:apex/app/modules/driver/shared/utils/dotted_line_painter.dart';
import 'package:apex/app/modules/driver/shared/widgets/driver_card.dart';
import 'package:apex/app/modules/driver/shared/widgets/driver_divider.dart';
import 'package:apex/app/modules/driver/shared/widgets/info_row.dart';
import 'package:flutter/material.dart';

class ScheduleModel {
  final String passengerName;
  final String passengerImage;
  final String pickupLabel;
  final String pickupAddress;
  final String dropoffLabel;
  final String dropoffAddress;
  final String distance;
  final String travelTime;
  final String baseFare;
  final String distanceFare;
  final String timeFare;
  final String totalEstimate;
  final String scheduledTime;

  ScheduleModel({
    required this.passengerName,
    required this.passengerImage,
    required this.pickupLabel,
    required this.pickupAddress,
    required this.dropoffLabel,
    required this.dropoffAddress,
    required this.distance,
    required this.travelTime,
    required this.baseFare,
    required this.distanceFare,
    required this.timeFare,
    required this.totalEstimate,
    required this.scheduledTime,
  });
}

class ScheduleCard extends StatelessWidget {
  final ScheduleModel data;
  final VoidCallback onStartRide;

  const ScheduleCard({
    Key? key,
    required this.data,
    required this.onStartRide,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DriverCard(
      borderRadius: 24,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Passenger Info
          Row(
            children: [
              CircleAvatar(
                radius: 20,
                backgroundImage: NetworkImage(data.passengerImage),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  data.passengerName,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),

          const SizedBox(height: 16),
          Divider(color: R.theme.driverBorderColor, thickness: 1),
          const SizedBox(height: 16),

          // Route Visualization
          _buildRouteSection(),

          const SizedBox(height: 16),
          Divider(color: R.theme.driverBorderColor, thickness: 1),
          const SizedBox(height: 16),

          // Fare Breakdown
          InfoRow(
            label: "Travel time",
            value: data.travelTime,
            isHighlight: true,
          ),
          InfoRow(label: "Base fare", value: data.baseFare),
          InfoRow(label: "Distance fare", value: data.distanceFare),
          InfoRow(label: "Time fare", value: data.timeFare),
          const SizedBox(height: 12),
          const DriverDivider(),
          const SizedBox(height: 12),

          // Total Estimate
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Total Estimate",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                data.totalEstimate,
                style: TextStyle(
                  color: R.theme.goldAccent,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),

          const SizedBox(height: 24),

          // --- FIXED FOOTER SECTION ---
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: const Color(0xFF252525),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Row(
              // Changed from spaceBetween to allow Expanded to work properly
              children: [
                // 1. Wrap the info section in Expanded so it takes available space
                Expanded(
                  child: Row(
                    children: [
                      Icon(
                        Icons.calendar_today_outlined,
                        color: R.theme.driverGreyText,
                        size: 18,
                      ),
                      const SizedBox(width: 8),
                      // 2. Wrap Text in Flexible/Expanded to handle long strings
                      Expanded(
                        child: Text(
                          data.scheduledTime,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                          ),
                          overflow: TextOverflow.ellipsis, // Prevents overflow
                          maxLines: 1,
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(width: 12), // Gap between time and button

                // 3. The Button (keeps its size)
                SizedBox(
                  height: 40,
                  child: ElevatedButton(
                    onPressed: onStartRide,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: R.theme.goldAccent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                    ),
                    child: const Text(
                      "Start Ride",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 13, // Slightly smaller font to fit tight spaces
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRouteSection() {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Column(
            children: [
              Icon(Icons.location_on, color: R.theme.driverRedColor, size: 20),
              Expanded(
                child: CustomPaint(
                  painter: DottedLinePainter(color: R.theme.goldAccent),
                ),
              ),
              Icon(Icons.location_on, color: R.theme.goldAccent, size: 20),
            ],
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Pickup
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      data.pickupLabel,
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      data.pickupAddress,
                      style: TextStyle(
                        color: R.theme.driverGreyText,
                        fontSize: 12,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
                // Spacer matches the expanded dotted line
                const SizedBox(height: 24),
                // Dropoff
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            data.dropoffLabel,
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            data.dropoffAddress,
                            style: TextStyle(
                              color: R.theme.driverGreyText,
                              fontSize: 12,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      data.distance,
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}