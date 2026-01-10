import 'package:apex/common/widgets/maps/map_component.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:get/get.dart';

import '../controllers/accepted_request_controller.dart';

class AcceptedRequestView extends GetView<AcceptedRequestController> {
  const AcceptedRequestView({super.key});

  // Color Constants extracted from design
  static const Color kGoldColor = Color(0xFFC6A152); // Muted Gold/Mustard
  static const Color kDarkBgColor = Color(0xFF1A1A1A);
  static const Color kCardBgColor = Colors.black;
  static const Color kNoteBgColor = Color(0xFF352F22); // Dark brown/gold mix
  static const Color kLightGrey = Color(0xFF9E9E9E);
  static const Color kSurfaceColor = Color(0xFF2C2C2C);
  static const Color kDividerColor = Color(0xFF2C2C2C);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kDarkBgColor,
      extendBodyBehindAppBar: true,
      body: Stack(
        children: [_buildMap(), _buildHeader(), _buildDraggableSheet(context)],
      ),
    );
  }

  Widget _buildMap() {
    return Obx(
      () => MapComponent(
        mapController: controller.mapController,
        initialCenter: controller.pickupLocation,
        initialZoom: 14.5,
        tileLayerUrl:
            'https://{s}.basemaps.cartocdn.com/light_all/{z}/{x}/{y}.png',
        markers: controller.markers.toList(),
        interactionFlags: InteractiveFlag.all & ~InteractiveFlag.rotate,
      ),
    );
  }

  Widget _buildHeader() {
    return Positioned(
      top: 60, // Safe area adjustment
      left: 20,
      right: 20,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // "Online" Title
          const Text(
            "Online",
            style: TextStyle(
              color: Colors.black87,
              fontSize: 18,
              fontWeight: FontWeight.w700,
            ),
          ),
          // Navigation Buttons
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildCircleButton(Icons.chevron_left, () => Get.back()),
              _buildCircleButton(Icons.menu, () {}),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDraggableSheet(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.60, // Starts covering ~60% of screen
      minChildSize: 0.45,
      maxChildSize: 0.95,
      builder: (context, scrollController) {
        return Container(
          decoration: BoxDecoration(
            color: kCardBgColor,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(24),
              topRight: Radius.circular(24),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.5),
                blurRadius: 10,
                offset: const Offset(0, -5),
              ),
            ],
          ),
          child: SingleChildScrollView(
            controller: scrollController,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(24, 12, 24, 30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // 1. Drag Handle
                  Center(
                    child: Container(
                      width: 40,
                      height: 4,
                      margin: const EdgeInsets.only(bottom: 20),
                      decoration: BoxDecoration(
                        color: Colors.grey[700],
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                  ),

                  // 2. Profile Row with "Arrived" Dropdown
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 24,
                        backgroundImage: NetworkImage(
                          controller.requestData['passengerImage'] as String,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              controller.requestData['passengerName'] as String,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 4),
                            // "New" Badge
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 2,
                              ),
                              decoration: BoxDecoration(
                                color: kGoldColor,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: const Text(
                                "New",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      // "Arrived" Dropdown Button
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: kGoldColor,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: const Row(
                          children: [
                            Text(
                              "Arrived",
                              style: TextStyle(
                                color: Colors
                                    .white, // Text inside button is white in image
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            SizedBox(width: 4),
                            Icon(
                              Icons.keyboard_arrow_down,
                              color: Colors.white,
                              size: 16,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 16),
                  const Divider(color: kDividerColor, thickness: 1),
                  const SizedBox(height: 16),

                  // 3. Pickup Location
                  const Text(
                    "PICK UP",
                    style: TextStyle(
                      color: kLightGrey,
                      fontSize: 11,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 0.5,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    controller.requestData['pickupAddress'] as String,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.w400,
                    ),
                  ),

                  const SizedBox(height: 16),
                  const Divider(color: kDividerColor, thickness: 1),
                  const SizedBox(height: 16),

                  // 4. Vehicle & Contact Box
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: kSurfaceColor,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      children: [
                        // Car Info
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                "Suzuki Alto",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 13,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 4),
                              // Car Image
                              SizedBox(
                                height: 30,
                                child: Image.asset(
                                  'assets/images/car_placeholder.png', // Ensure asset exists
                                  fit: BoxFit.contain,
                                  errorBuilder: (_, __, ___) => const Icon(
                                    Icons.directions_car,
                                    color: Colors.grey,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 4),
                              // Plate Number
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 6,
                                  vertical: 2,
                                ),
                                decoration: BoxDecoration(
                                  color: const Color(0xFFE0E0E0),
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                child: const Text(
                                  "APT 238",
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 11,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        // Contact Buttons
                        Row(
                          children: [
                            _buildContactCircle(Icons.call_outlined),
                            const SizedBox(width: 12),
                            _buildContactCircle(Icons.chat_bubble_outline),
                          ],
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 20),

                  // 5. Details List
                  _buildDetailRow("Pickup Date", "18-12-2025"),
                  const SizedBox(height: 8),
                  _buildDetailRow("Pickup Time", "32:32:00 PM"),
                  const SizedBox(height: 8),
                  _buildDetailRow("Hourly Rate", "\$100"),
                  const SizedBox(height: 8),
                  _buildDetailRow("Booked hours", "3 hours"),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Estimated total",
                        style: TextStyle(color: kLightGrey, fontSize: 13),
                      ),
                      const Text(
                        "\$200,00",
                        style: TextStyle(
                          color: kGoldColor,
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 20),

                  // 6. Note Section
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: kNoteBgColor,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Note:",
                          style: TextStyle(
                            color: Color(0xFFEAEAEA), // Off-white
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          "Extra time during the ride leads to extra charges in 30 minute blocks at the same rate.",
                          style: TextStyle(
                            color: Color(0xFFBDBDBD), // Light grey
                            fontSize: 12,
                            height: 1.4,
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 24),

                  // 7. Start Button
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: controller.onStartHourlyRide,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: kGoldColor,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        elevation: 0,
                      ),
                      child: const Text(
                        "Start Hourly Ride",
                        style: TextStyle(
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
        );
      },
    );
  }

  // --- Helper Widgets ---

  Widget _buildCircleButton(IconData icon, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 45,
        width: 45,
        decoration: BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Icon(icon, color: Colors.black, size: 24),
      ),
    );
  }

  Widget _buildContactCircle(IconData icon) {
    return Container(
      height: 40,
      width: 40,
      decoration: const BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
      ),
      // Icon color is gold in the design
      child: Icon(icon, color: kGoldColor, size: 20),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: const TextStyle(color: kLightGrey, fontSize: 13)),
        Text(
          value,
          style: const TextStyle(
            color: kGoldColor, // Values are gold/yellow
            fontSize: 13,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}
