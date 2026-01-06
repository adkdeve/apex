import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:get/get.dart';

import '../controllers/request_detail_controller.dart';

class RequestDetailView extends GetView<RequestDetailController> {
  const RequestDetailView({super.key});

  // Color Constants extracted from the image
  static const Color kGoldPrimary = Color(0xFFC6A152); // The main button/text gold
  static const Color kCardBg = Colors.black;           // Main card background
  static const Color kNoteBg = Color(0xFF352F22);      // The dark brownish note background
  static const Color kGreyText = Color(0xFF9E9E9E);    // Secondary text
  static const Color kDivider = Color(0xFF2C2C2C);     // Separator lines
  static const Color kSurface = Color(0xFF1E1E1E);     // Car info box background

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: Stack(
        children: [
          _buildMap(),
          _buildHeader(),
          _buildDraggableSheet(context),
        ],
      ),
    );
  }

  // 1. The Map Layer
  Widget _buildMap() {
    return FlutterMap(
      mapController: controller.mapController,
      options: MapOptions(
        initialCenter: controller.pickupLocation,
        initialZoom: 14.5,
        interactionOptions: const InteractionOptions(
          flags: InteractiveFlag.all & ~InteractiveFlag.rotate,
        ),
      ),
      children: [
        TileLayer(
          // Light theme map tiles to contrast with the black card
          urlTemplate: 'https://{s}.basemaps.cartocdn.com/light_all/{z}/{x}/{y}.png',
          subdomains: const ['a', 'b', 'c', 'd'],
        ),
        Obx(() => MarkerLayer(markers: controller.markers.toList())),
      ],
    );
  }

  // 2. The Header (Back button, Online status, Menu)
  Widget _buildHeader() {
    return Positioned(
      top: 60,
      left: 20,
      right: 20,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Centered Title
          const Text(
            "Online",
            style: TextStyle(
              color: Colors.black87,
              fontSize: 18,
              fontWeight: FontWeight.w700,
            ),
          ),
          // Buttons
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

  // 3. The Draggable Bottom Sheet (The Moveable Card)
  Widget _buildDraggableSheet(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.65, // Card starts at ~65% height (matches image)
      minChildSize: 0.40,     // Collapses to 40%
      maxChildSize: 0.95,     // Expands to full screen
      builder: (BuildContext context, ScrollController scrollController) {
        return Container(
          decoration: BoxDecoration(
            color: kCardBg,
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
          // SingleChildScrollView + scrollController = Draggable Physics
          child: SingleChildScrollView(
            controller: scrollController,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(24, 12, 24, 30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Drag Handle
                  Center(
                    child: Container(
                      width: 40,
                      height: 4,
                      decoration: BoxDecoration(
                        color: Colors.grey[700],
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),

                  // -- Profile Section --
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 24,
                        backgroundImage: NetworkImage(
                          controller.requestData['passengerImage'] as String,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Column(
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
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                            decoration: BoxDecoration(
                              color: kGoldPrimary,
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
                          )
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  const Divider(color: kDivider, thickness: 1),
                  const SizedBox(height: 16),

                  // -- Pickup Location --
                  const Text(
                    "PICK UP",
                    style: TextStyle(
                      color: kGreyText,
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
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
                  const Divider(color: kDivider, thickness: 1),
                  const SizedBox(height: 16),

                  // -- Car Info Box --
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: kSurface,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      children: [
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
                                  'assets/images/car_placeholder.png', // Ensure you have this asset
                                  fit: BoxFit.contain,
                                  errorBuilder: (_,__,___) => const Icon(Icons.directions_car, color: Colors.grey),
                                ),
                              ),
                              const SizedBox(height: 4),
                              // Plate Badge
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
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
                        )
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),

                  // -- Details Grid --
                  _buildDetailRow("Pickup Date", controller.requestData['pickupDate'] as String),
                  const SizedBox(height: 8),
                  _buildDetailRow("Pickup Time", controller.requestData['pickupTime'] as String),
                  const SizedBox(height: 8),
                  _buildDetailRow("Hourly Rate", "\$${controller.requestData['hourlyRate']}"),
                  const SizedBox(height: 8),
                  _buildDetailRow("Booked hours", "${controller.requestData['bookedHours']} hours"),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Estimated total",
                        style: TextStyle(color: kGreyText, fontSize: 13),
                      ),
                      Text(
                        controller.requestData['estimatedTotal'] as String,
                        style: const TextStyle(
                          color: kGoldPrimary,
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),

                  // -- NOTE SECTION (Specific Request) --
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: kNoteBg, // Specific dark brown color
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Note:",
                          style: TextStyle(
                            color: Color(0xFFEAEAEA), // Almost white
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          // Using fallback text from image if controller data is null
                          controller.requestData['note'] ??
                              "Extra time during the ride leads to extra charges in 30 minute blocks at the same rate.",
                          style: const TextStyle(
                            color: Color(0xFFBDBDBD), // Light grey
                            fontSize: 12,
                            height: 1.4,
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 24),

                  // -- Action Buttons --
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton(
                          onPressed: controller.onIgnore,
                          style: OutlinedButton.styleFrom(
                            side: const BorderSide(color: kGoldPrimary),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            padding: const EdgeInsets.symmetric(vertical: 16),
                          ),
                          child: const Text(
                            "Ignore",
                            style: TextStyle(
                              color: kGoldPrimary,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: controller.onAccept,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: kGoldPrimary,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            elevation: 0,
                          ),
                          child: const Text(
                            "Accept",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  // Helper Widgets for cleanliness

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
      child: Icon(icon, color: const Color(0xFFB88E2F), size: 20),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: const TextStyle(color: kGreyText, fontSize: 13),
        ),
        Text(
          value,
          style: const TextStyle(
            color: kGoldPrimary,
            fontSize: 13,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}