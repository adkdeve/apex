import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:get/get.dart';

import '../../../../routes/app_pages.dart';
import '../controllers/dropoff_navigation_controller.dart';

class DropoffNavigationView extends GetView<DropoffNavigationController> {
  const DropoffNavigationView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true, // Allows map to fill screen behind header
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
                const Text(
                  "Client's destination",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                  ),
                ),

                // Empty placeholder to balance the row center alignment
                const SizedBox(width: 40),
              ],
            ),
          ),

          // 3. Gold Navigation Guide Banner (Full Width)
          Positioned(
            top: 110,
            left: 0,
            right: 0,
            child: GestureDetector(
              onTap: () => _showReachDestinationDialog(context),
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 16,
                ),
                decoration: const BoxDecoration(
                  color: Color(0xFFC7A049), // Gold Color
                  // Full width, no rounded corners
                ),
                child: Row(
                  children: [
                    // Turn Icon
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
                            controller.distance, // e.g., "3.2 Km"
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            controller.fullDropoffAddress,
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
          ),

          // 4. Bottom Dropoff Address Detail Card
          _buildDropoffCard(),
        ],
      ),
    );
  }

  Widget _buildMap() {
    return FlutterMap(
      mapController: controller.mapController,
      options: MapOptions(
        initialCenter: controller.currentLocation.value,
        initialZoom: 14.5,
        interactionOptions: const InteractionOptions(
          flags: InteractiveFlag.all & ~InteractiveFlag.rotate,
        ),
      ),
      children: [
        TileLayer(
          urlTemplate:
              'https://{s}.basemaps.cartocdn.com/rastertiles/voyager/{z}/{x}/{y}@2x.png',
          subdomains: const ['a', 'b', 'c', 'd'],
        ),
        Obx(
          () => PolylineLayer(
            polylines: [
              Polyline(
                points: controller.polylines.expand((e) => e.points).toList(),
                strokeWidth: 4.0,
                color: const Color(0xFF2F4EFF), // Royal Blue
              ),
            ],
          ),
        ),
        Obx(() => MarkerLayer(markers: controller.markers.toList())),
      ],
    );
  }

  Widget _buildDropoffCard() {
    return Positioned(
      bottom: 0, // Anchored to bottom
      left: 0,
      right: 0,
      child: Container(
        padding: const EdgeInsets.fromLTRB(24, 24, 24, 40),
        decoration: const BoxDecoration(
          color: Color(0xFF222222), // Dark card background
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(32),
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
                    'Drop off at',
                    style: TextStyle(
                      color: Color(0xFF9E9E9E), // Grey text
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    controller.dropoffAddress,
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

  void _showReachDestinationDialog(BuildContext context) {
    Get.dialog(
      Center(
        child: Container(
          width: 280,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
          decoration: BoxDecoration(
            color: const Color(0xFF1E1E1E),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                'Reach at Destination?',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              Text(
                'Want to end the ride?',
                style: TextStyle(
                  color: Colors.grey[400],
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Get.back(); // Close dialog
                    Get.offAllNamed(Routes.MAIN);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFC0A063),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 12),
                  ),
                  child: const Text(
                    'End Ride',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      barrierColor: Colors.black.withOpacity(0.45),
      barrierDismissible: false,
    );
  }
}
