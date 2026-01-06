import 'package:apex/common/widgets/navigation/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../ride_booked/views/ride_booked_view.dart';
import '../controllers/driver_details_controller.dart';

class DriverDetailsView extends GetView<DriverDetailsController> {
  const DriverDetailsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(DriverDetailsController());

    const Color bgDark = Color(0xFF0B0B0C);
    const Color cardBg = Color(0xFF1F1F1F);
    const Color primaryGold = Color(0xFFCFA854);
    const Color textWhite = Colors.white;
    const Color textGrey = Colors.grey;

    return Scaffold(
      backgroundColor: bgDark,
      appBar: CustomAppBar(title: 'Driver Details'),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: GestureDetector(
          onTap: () => Get.to(()=> RideBookedView()),
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: cardBg,
              borderRadius: BorderRadius.circular(24),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Driver Avatar
                    const CircleAvatar(
                      radius: 26,
                      backgroundImage: NetworkImage("https://i.pravatar.cc/150?u=ben"),
                      backgroundColor: Colors.grey, // Fallback color
                    ),
                    const SizedBox(width: 12),

                    // Driver Name & Track Button (Expanded takes available space)
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Obx(() => Text(
                            controller.driverName.value,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis, // Prevents text overflow
                            style: const TextStyle(color: textWhite, fontSize: 18, fontWeight: FontWeight.bold),
                          )),
                          const SizedBox(height: 6),

                          // Track Button
                          InkWell(
                            onTap: controller.trackDriver,
                            child: Container(
                              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                              decoration: BoxDecoration(
                                color: primaryGold,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: const [
                                  Icon(Icons.navigation, size: 12, color: textWhite),
                                  SizedBox(width: 4),
                                  Text(
                                    "Track Driver",
                                    style: TextStyle(color: textWhite, fontSize: 10, fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Obx(() => Text(
                          controller.carModel.value,
                          style: const TextStyle(color: textWhite, fontSize: 12),
                        )),
                        const SizedBox(height: 2),

                        Icon(Icons.directions_car_filled, color: Colors.grey[400], size: 35),

                        const SizedBox(height: 2),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Obx(() => Text(
                            controller.carPlate.value,
                            style: const TextStyle(color: Colors.black, fontSize: 10, fontWeight: FontWeight.bold),
                          )),
                        ),
                      ],
                    ),
                  ],
                ),

                const SizedBox(height: 10),
                const Divider(color: Colors.white10),
                const SizedBox(height: 10),

                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Icon(Icons.location_on, color: Colors.redAccent, size: 24),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Pickup location",
                            style: TextStyle(color: textWhite, fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 4),
                          Obx(() => Text(
                            controller.pickupLocation.value,
                            maxLines: 2, // Limit lines
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(color: textGrey, fontSize: 13),
                          )),
                        ],
                      ),
                    )
                  ],
                ),

                const SizedBox(height: 10),
                const Divider(color: Colors.white10),
                const SizedBox(height: 10),

                _buildDetailRow("Pickup Time", controller.pickupTime.value),
                const SizedBox(height: 12),
                _buildDetailRow("Hourly Rate", controller.hourlyRate.value),
                const SizedBox(height: 12),
                _buildDetailRow("Booked hours", controller.bookedHours.value),
                const SizedBox(height: 6),

                const Divider(color: Colors.white10),
                const SizedBox(height: 12),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text("Estimated total", style: TextStyle(color: textWhite, fontSize: 16, fontWeight: FontWeight.bold)),
                    Obx(() => Text(controller.estimatedTotal.value, style: const TextStyle(color: primaryGold, fontSize: 18, fontWeight: FontWeight.bold))),
                  ],
                ),

                const SizedBox(height: 20),

                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    _buildActionButton(Icons.phone, "Call driver", controller.callDriver),
                    const SizedBox(width: 30),
                    _buildActionButton(Icons.chat_bubble_outline, "Message", controller.messageDriver),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: const TextStyle(color: Colors.grey, fontSize: 14)),
        Text(value, style: const TextStyle(color: Color(0xFFCFA854), fontSize: 14, fontWeight: FontWeight.bold)),
      ],
    );
  }

  Widget _buildActionButton(IconData icon, String label, VoidCallback onTap) {
    return Column(
      children: [
        InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(30),
          child: Container(
            width: 45,
            height: 45,
            decoration: const BoxDecoration(
              color: Color(0xFFCFA854),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: Colors.white, size: 24),
          ),
        ),
        const SizedBox(height: 8),
        Text(label, style: const TextStyle(color: Colors.white, fontSize: 12)),
      ],
    );
  }
}