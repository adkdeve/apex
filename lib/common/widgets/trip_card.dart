import 'package:flutter/material.dart';

import '../../app/data/models/trip_model.dart';
import '../../utils/helpers/dashed_line_painter.dart';

class TripCard extends StatelessWidget {
  final TripModel trip;

  const TripCard({Key? key, required this.trip}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFF1C1C1E), // Dark Grey Card
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        children: [
          // --- Route Section ---
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 1. Timeline Visuals
              Column(
                children: [
                  const Icon(
                    Icons.radio_button_checked,
                    color: Colors.redAccent,
                    size: 20,
                  ),
                  Container(
                    height: 25,
                    width: 2,
                    margin: const EdgeInsets.symmetric(vertical: 4),
                    child: CustomPaint(painter: DashedLinePainter()),
                  ),
                  const Icon(
                    Icons.location_on,
                    color: Colors.greenAccent,
                    size: 20,
                  ),
                ],
              ),
              const SizedBox(width: 15),

              // 2. Locations
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 2), // Align text with icon
                    Text(
                      trip.pickupLocation,
                      style: const TextStyle(color: Colors.white, fontSize: 16),
                    ),
                    const SizedBox(height: 28),
                    Text(
                      trip.dropoffLocation,
                      style: const TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  ],
                ),
              ),

              // 3. Times
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  const SizedBox(height: 2),
                  Text(
                    trip.pickupTime,
                    style: TextStyle(color: Colors.grey[500], fontSize: 14),
                  ),
                  const SizedBox(height: 30),
                  Text(
                    trip.dropoffTime,
                    style: TextStyle(color: Colors.grey[500], fontSize: 14),
                  ),
                ],
              ),
            ],
          ),

          const SizedBox(height: 20),
          Divider(color: Colors.grey[800], thickness: 0.5),
          const SizedBox(height: 15),

          // --- Driver & Price Section ---
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Driver Info
              Row(
                children: [
                  CircleAvatar(
                    radius: 20,
                    backgroundImage: NetworkImage(trip.driverImage),
                  ),
                  const SizedBox(width: 12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        trip.driverName,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          const Icon(Icons.star, color: Colors.amber, size: 14),
                          const SizedBox(width: 4),
                          Text(
                            trip.rating.toString(),
                            style: TextStyle(
                              color: Colors.grey[500],
                              fontSize: 13,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),

              // Price
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    "Price",
                    style: TextStyle(color: Colors.grey[600], fontSize: 12),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    "\$${trip.price}",
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
