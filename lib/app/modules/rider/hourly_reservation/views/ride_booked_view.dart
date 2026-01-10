import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:apex/common/widgets/maps/map_component.dart';
import 'package:apex/common/widgets/sheets/draggable_bottom_sheet.dart';
import '../../../../core/core.dart';
import '../controllers/ride_booked_controller.dart';

class RideBookedView extends GetView<RideBookedController> {
  const RideBookedView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(RideBookedController());

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          // 1. MAP LAYER
          MapComponent(
            mapController: controller.mapController,
            initialCenter: controller.pickupLocation,
            polylines: [
              MapPolylineHelper.routePolyline(
                points: controller.routePoints,
                color: Colors.black,
                strokeWidth: 5.0,
              ),
            ],
            markers: [
              MapMarkerHelper.pickupMarker(
                point: controller.pickupLocation,
                size: 40,
                color: const Color(0xFF27AE60),
              ),
            ],
          ),

          // 2. BACK BUTTON
          Positioned(
            top: 50,
            left: 20,
            child: InkWell(
              onTap: () => Get.back(),
              child: Container(
                width: 40,
                height: 40,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                  boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 4)],
                ),
                child: const Icon(Icons.arrow_back_ios_new, color: Colors.black, size: 20),
              ),
            ),
          ),

          // 3. BOTTOM SHEET
          DraggableBottomSheet(
            controller: controller.sheetController,
            initialChildSize: 0.55,
            minChildSize: 0.40,
            maxChildSize: 0.85,
            backgroundColor: R.theme.darkBackground,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                // --- Driver Info Section ---
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const CircleAvatar(
                      radius: 25,
                      backgroundImage: NetworkImage("https://i.pravatar.cc/150?u=ben"),
                      backgroundColor: Colors.grey,
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            controller.driverName,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            "Ben accepted your request...",
                            style: TextStyle(color: R.theme.grey, fontSize: 12),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          controller.carModel,
                          style: const TextStyle(color: Colors.white, fontSize: 12),
                        ),
                        const SizedBox(height: 4),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Text(
                            controller.plateNumber,
                            style: const TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 10,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),

                const SizedBox(height: 20),

                // --- Action Buttons ---
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _buildCircleAction(Icons.phone, "Call driver", controller.onCallDriver, R.theme.secondary),
                    _buildCircleAction(Icons.chat_bubble, "Message", controller.onMessageDriver, R.theme.secondary),
                    _buildCircleAction(Icons.share, "Share Location", controller.onShareLocation, R.theme.secondary),
                  ],
                ),

                const SizedBox(height: 20),
                const Divider(color: Colors.white10),
                const SizedBox(height: 10),

                // --- Location Status ---
                Row(
                  children: const [
                    Icon(Icons.circle, color: Color(0xFF27AE60), size: 14),
                    SizedBox(width: 10),
                    Text("Skate Park", style: TextStyle(color: Colors.white, fontSize: 14)),
                  ],
                ),

                const SizedBox(height: 10),

                const Divider(color: Colors.white10),

                const SizedBox(height: 15),

                // --- TIMER BAR (New) ---
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
                  decoration: BoxDecoration(
                    color: R.theme.secondary.withOpacity(0.15),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: R.theme.secondary.withOpacity(0.5)),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.access_time_filled, color: R.theme.secondary, size: 18),
                      const SizedBox(width: 8),
                      Obx(() => Text(
                        controller.timeLeft.value,
                        style: TextStyle(color: R.theme.secondary, fontWeight: FontWeight.bold, fontSize: 16),
                      )),
                    ],
                  ),
                ),

                const SizedBox(height: 20),

                // --- Details List ---
                _buildDetailRow("Pickup Time", controller.pickupTime, R.theme.grey, R.theme.secondary),
                const SizedBox(height: 10),
                _buildDetailRow("Hourly Rate", "\$${controller.hourlyRate.toInt()}", R.theme.grey, R.theme.secondary),
                const SizedBox(height: 10),
                _buildDetailRow("Booked hours", "${controller.initialBookedHours} hours", R.theme.grey, R.theme.secondary),

                // Show Extended Hours only if they exist
                Obx(() {
                  if (controller.extendedHours.value > 0) {
                    return Padding(
                      padding: const EdgeInsets.only(top: 10.0),
                      child: _buildDetailRow(
                          "Extended hours",
                          "${(controller.extendedHours.value * 60).toInt()} mins",
                          R.theme.grey,
                          Colors.redAccent // Highlight extension
                      ),
                    );
                  }
                  return const SizedBox.shrink();
                }),

                const SizedBox(height: 12),
                const Divider(color: Colors.white10),
                const SizedBox(height: 12),

                // --- Total ---
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                        "Estimated total",
                        style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)
                    ),
                    Obx(() => Text(
                      "\$${controller.estimatedTotal.value.toStringAsFixed(2)}",
                      style: TextStyle(color: R.theme.secondary, fontSize: 18, fontWeight: FontWeight.bold),
                    )),
                  ],
                ),

                const SizedBox(height: 25),

                // --- Main Button ---
                SizedBox(
                  width: double.infinity,
                  height: 56,
                  child: ElevatedButton(
                    onPressed: controller.openExtendTimeSheet,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: R.theme.secondary,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                      elevation: 0,
                    ),
                    child: const Text(
                      "Request more Time",
                      style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailRow(String label, String value, Color labelColor, Color valueColor) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: TextStyle(color: labelColor, fontSize: 14)),
        Text(value, style: TextStyle(color: valueColor, fontSize: 14, fontWeight: FontWeight.bold)),
      ],
    );
  }

  Widget _buildCircleAction(IconData icon, String label, VoidCallback onTap, Color primaryColor) {
    return Column(
      children: [
        InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(30),
          child: Container(
            width: 45,
            height: 45,
            decoration: BoxDecoration(
              color: primaryColor, // Transparent Gold
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: R.theme.white, size: 22),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: const TextStyle(color: Colors.grey, fontSize: 10, fontWeight: FontWeight.w500),
        ),
      ],
    );
  }
}