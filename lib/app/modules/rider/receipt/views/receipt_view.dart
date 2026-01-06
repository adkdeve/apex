import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:apex/common/widgets/navigation/custom_app_bar.dart';
import 'package:apex/common/widgets/ride/fare_breakdown_row.dart';
import 'package:apex/common/widgets/ride/driver_info_card.dart';
import 'package:apex/common/widgets/ride/route_display_section.dart';
import '../../../../core/core.dart';
import '../controllers/receipt_controller.dart';
import '../../rate_driver/views/rate_driver_view.dart';

class ReceiptView extends GetView<ReceiptController> {
  const ReceiptView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(ReceiptController());

    return Scaffold(
      backgroundColor: R.theme.darkBackground,
      appBar: CustomAppBar(
        title: "Receipt",
        backgroundColor: R.theme.darkBackground,
        backButtonColor: Colors.white24,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Obx(
              () => RouteDisplaySection(
                pickupLocation: "Pickup",
                pickupSubtitle: controller.pickupAddress.value,
                dropoffLocation: "Dropoff",
                dropoffSubtitle: controller.dropoffAddress.value,
                distance: "1.1km",
                pickupColor: Colors.redAccent,
                dropoffColor: R.theme.secondary,
              ),
            ),

            20.sbh,

            Obx(
              () => DriverInfoCard(
                driverName: controller.driverName.value,
                rating: (controller.activeRideData?.driverRating is num
                    ? (controller.activeRideData!.driverRating as num)
                          .toDouble()
                    : 4.9),
                carModel: controller.activeRideData?.carModel ?? "Unknown",
                plateNumber: controller.activeRideData?.plateNumber ?? "N/A",
                backgroundColor: R.theme.cardBg,
              ),
            ),

            20.sbh,

            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 2),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(24),
                border: Border.all(color: R.theme.secondary),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      style: TextStyle(color: R.theme.white),
                      decoration: InputDecoration(
                        hintText: "Promo Code (if any)",
                        hintStyle: TextStyle(color: R.theme.grey),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: R.theme.secondary,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 5,
                      ),
                      minimumSize: const Size(0, 36),
                    ),
                    child: Text(
                      "Apply",
                      style: TextStyle(
                        color: R.theme.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            20.sbh,

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Payment Method",
                      style: TextStyle(color: R.theme.grey, fontSize: 14),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      "Card",
                      style: TextStyle(
                        color: R.theme.secondary,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    const Icon(
                      Icons.credit_card,
                      color: Colors.white,
                      size: 28,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      "**** 8295",
                      style: TextStyle(color: R.theme.white, fontSize: 16),
                    ),
                    const SizedBox(width: 12),
                    Icon(Icons.edit, color: R.theme.secondary, size: 18),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 12),
            const Divider(color: Colors.grey, thickness: 0.5),
            const SizedBox(height: 12),

            // 5. FARE BREAKDOWN
            Obx(
              () => FareBreakdownRow(
                label: "Travel time",
                value: controller.travelTime.value,
                labelColor: R.theme.grey,
                valueColor: R.theme.secondary,
              ),
            ),
            Obx(
              () => FareBreakdownRow(
                label: "Base fare",
                value: "\$${controller.baseFare.value}",
                labelColor: R.theme.grey,
                valueColor: R.theme.secondary,
              ),
            ),
            Obx(
              () => FareBreakdownRow(
                label: "Distance fare",
                value: "\$${controller.distanceFare.value}",
                labelColor: R.theme.grey,
                valueColor: R.theme.secondary,
              ),
            ),
            Obx(
              () => FareBreakdownRow(
                label: "Time fare",
                value: "\$${controller.timeFare.value}",
                labelColor: R.theme.grey,
                valueColor: R.theme.secondary,
              ),
            ),
            const SizedBox(height: 12),
            Obx(
              () => FareBreakdownRow(
                label: "Total Estimate",
                value: "\$${controller.totalFare.value}",
                labelColor: R.theme.white,
                valueColor: R.theme.secondary,
                isTotal: true,
              ),
            ),

            const SizedBox(height: 40),

            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: () {
                  // Pass active ride data to rate driver screen
                  Get.to(
                    () => const RateDriverView(),
                    arguments: controller.activeRideData,
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: R.theme.secondary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                child: Text(
                  "Pay Now",
                  style: TextStyle(
                    color: R.theme.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
