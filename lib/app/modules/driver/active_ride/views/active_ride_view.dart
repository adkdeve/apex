import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:get/get.dart';
// import 'package:latlong2/latlong.dart'; // Ensure this is imported if using LatLng

import '../../../../routes/app_pages.dart';
import '../controllers/active_ride_controller.dart';

class ActiveRideView extends GetView<ActiveRideController> {
  const ActiveRideView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true, // Allows map to fill screen behind elements
      body: Stack(
        children: [
          // 1. Map Layer
          _buildMap(),

          // 2. Top Navigation Bar (Back Button + Title)
          Positioned(
            top: 50,
            left: 20,
            right: 20,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Back Button
                InkWell(
                  onTap: () => Get.back(),
                  child: Container(
                    height: 40,
                    width: 40,
                    decoration: BoxDecoration(
                      color: const Color(0xFF2D2D2D), // Dark grey circle
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          blurRadius: 4,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: const Icon(
                      Icons.arrow_back_ios_new,
                      color: Colors.white,
                      size: 18,
                    ),
                  ),
                ),

                // Title
                GestureDetector(
                  onTap: () {
                    Get.toNamed(Routes.DROPOFF_NAVIGATION);
                  },
                  child: const Text(
                    "Start Ride",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),

                // Empty placeholder for center balance
                const SizedBox(width: 40),
              ],
            ),
          ),

          // 3. Gold Navigation Guide Banner (Full Width)
          Positioned(
            top: 110,
            left: 0, // Expanded to full width
            right: 0,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              decoration: const BoxDecoration(
                color: Color(0xFFC7A049), // Gold Color
                // No border radius, full width rectangular banner
              ),
              child: Row(
                children: [
                  // Turn Icon (Curved Arrow)
                  const Icon(
                    Icons.turn_right_rounded,
                    color: Colors.white,
                    size: 36,
                  ),
                  const SizedBox(width: 16),

                  // Distance and Address
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          controller.distance, // e.g., "1.4 Km"
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          controller
                              .dropoffAddress, // e.g., "108 William St, Chicago, US"
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                            fontWeight: FontWeight.w400,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          // 4. Bottom Pickup Address Detail Card
          _buildPickupCard(),
        ],
      ),
    );
  }

  Widget _buildMap() {
    return FlutterMap(
      mapController: controller.mapController,
      options: MapOptions(
        initialCenter: controller.currentLocation.value,
        initialZoom: 15,
        interactionOptions: const InteractionOptions(
          flags: InteractiveFlag.all & ~InteractiveFlag.rotate,
        ),
      ),
      children: [
        TileLayer(
          // Using a light map style to match the background
          urlTemplate:
              'https://{s}.basemaps.cartocdn.com/rastertiles/voyager/{z}/{x}/{y}@2x.png',
          subdomains: const ['a', 'b', 'c', 'd'],
        ),

        // Route Line
        Obx(
          () => PolylineLayer(
            polylines: [
              Polyline(
                points: controller.polylines.expand((e) => e.points).toList(),
                strokeWidth: 4.0,
                color: const Color(0xFF2F4EFF), // Royal Blue color
              ),
            ],
          ),
        ),

        // Markers
        Obx(() => MarkerLayer(markers: controller.markers.toList())),
      ],
    );
  }

  Widget _buildPickupCard() {
    return Positioned(
      bottom: 0, // Anchored to the bottom
      left: 0,
      right: 0,
      child: Container(
        padding: const EdgeInsets.fromLTRB(
          24,
          24,
          24,
          40,
        ), // Extra padding at bottom for safe area
        decoration: const BoxDecoration(
          color: Color(0xFF222222), // Dark card background
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(32), // Rounded top corners
            topRight: Radius.circular(32),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 16,
              offset: Offset(0, -4),
            ),
          ],
        ),
        child: Row(
          children: [
            // Gold Taxi Pin Icon
            Stack(
              alignment: Alignment.center,
              children: [
                const Icon(
                  Icons.location_on,
                  color: Color(0xFFC7A049),
                  size: 54,
                ),
                Positioned(
                  top: 12,
                  child: Icon(Icons.local_taxi, color: Colors.black, size: 22),
                ),
              ],
            ),

            const SizedBox(width: 20),

            // Text Info
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    'Pick Up at',
                    style: TextStyle(
                      color: Color(0xFF9E9E9E), // Grey text
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    controller.pickupAddress, // e.g., "78347 swift village"
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
