import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:apex/common/widgets/maps/map_component.dart';
import 'package:apex/common/widgets/sheets/draggable_bottom_sheet.dart';
import 'package:apex/common/widgets/ride/fare_breakdown_row.dart';
import 'package:apex/common/widgets/ride/route_display_section.dart';
import '../../../../core/core.dart';
import '../controllers/ride_booked_controller.dart';

class RideBookedView extends GetView<RideBookedController> {
  const RideBookedView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(RideBookedController());

    const Color routeCardBg = Color(0xFF1F1F1F);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          MapComponent(
            mapController: controller.mapController,
            initialCenter: controller.pickupLocation.value,
            polylines: [
              MapPolylineHelper.routePolyline(
                points: controller.routePoints,
                color: Colors.black,
                strokeWidth: 5.0,
              ),
            ],
            markers: [
              MapMarkerHelper.pickupMarker(
                point: controller.pickupLocation.value,
                size: 40,
                color: const Color(0xFF27AE60),
              ),
              MapMarkerHelper.dropoffMarker(
                point: controller.dropoffLocation.value,
                size: 40,
                color: Colors.redAccent,
              ),
            ],
          ),

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
                child: const Icon(
                  Icons.arrow_back_ios_new,
                  color: Colors.black,
                  size: 20,
                ),
              ),
            ),
          ),

          DraggableBottomSheet(
            controller: controller.sheetController,
            initialChildSize: 0.65,
            minChildSize: 0.40,
            maxChildSize: 0.85,
            backgroundColor: R.theme.darkBackground,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 45,
                      height: 45,
                      decoration: BoxDecoration(
                        color: Colors.grey[800],
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.person,
                        color: Colors.white,
                        size: 30,
                      ),
                    ),
                    const SizedBox(width: 12),

                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Obx(
                            () => Text(
                              controller.driverName.value,
                              style: TextStyle(
                                color: R.theme.white,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          const SizedBox(height: 4),
                          Row(
                            children: [
                              const Icon(
                                Icons.star,
                                color: Color(0xFFFFD700),
                                size: 16,
                              ),
                              const SizedBox(width: 4),
                              Obx(
                                () => Text(
                                  controller.driverRating.value,
                                  style: TextStyle(
                                    color: R.theme.white,
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 4),
                          Obx(
                            () => Text(
                              "${controller.driverName.value} accepted your request for \$${controller.actualFare.value} will arrive in ${controller.arrivalTime.value}.",
                              style: TextStyle(
                                color: Colors.grey[400],
                                fontSize: 12,
                                height: 1.4,
                              ),
                              maxLines: 2,
                              overflow:
                                  TextOverflow.ellipsis, // Prevents overflow
                            ),
                          ),
                        ],
                      ),
                    ),

                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Icon(
                          Icons.directions_car_filled,
                          color: R.theme.white,
                          size: 40,
                        ),
                        const SizedBox(height: 4),
                        Obx(
                          () => Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 4,
                              vertical: 2,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Text(
                              controller.plateNumber.value,
                              style: const TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 12,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 2),
                        Obx(
                          () => Text(
                            controller.carModel.value,
                            style: const TextStyle(
                              color: Colors.grey,
                              fontSize: 12,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),

                const SizedBox(height: 20),
                Divider(color: Colors.grey, thickness: 0.5),
                10.sbh,

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _buildCircleAction(
                      Icons.phone,
                      "Call driver",
                      controller.onCallDriver,
                      R.theme.secondary,
                    ),
                    _buildCircleAction(
                      Icons.chat_bubble,
                      "Message",
                      controller.onMessageDriver,
                      R.theme.secondary,
                    ),
                    _buildCircleAction(
                      Icons.share,
                      "Share Location",
                      controller.onShareLocation,
                      R.theme.secondary,
                    ),
                  ],
                ),
                const SizedBox(height: 20),

                RouteDisplaySection(
                  pickupLocation: "Skate Park",
                  dropoffLocation: "Home",
                  backgroundColor: routeCardBg,
                  pickupColor: const Color(0xFF27AE60),
                  dropoffColor: Colors.redAccent,
                  showStops: true,
                  onStopsTap: () {},
                ),
                const SizedBox(height: 20),

                FareBreakdownRow(
                  label: "Travel time",
                  value: "~44min.",
                  labelColor: R.theme.grey,
                  valueColor: R.theme.secondary,
                ),
                FareBreakdownRow(
                  label: "Base fare",
                  value: "\$9,00",
                  labelColor: R.theme.grey,
                  valueColor: R.theme.secondary,
                ),
                FareBreakdownRow(
                  label: "Distance fare",
                  value: "\$9,00",
                  labelColor: R.theme.grey,
                  valueColor: R.theme.secondary,
                ),
                FareBreakdownRow(
                  label: "Time fare",
                  value: "\$9,00",
                  labelColor: R.theme.grey,
                  valueColor: R.theme.secondary,
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 8.0),
                  child: Divider(color: Colors.grey, thickness: 0.5),
                ),
                FareBreakdownRow(
                  label: "Total Estimate",
                  value: "\$20,00",
                  labelColor: R.theme.white,
                  valueColor: R.theme.secondary,
                  isTotal: true,
                ),

                const SizedBox(height: 20),

                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton.icon(
                    onPressed: () => _showCancelBottomSheet(context),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: R.theme.secondary,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    icon: const Icon(Icons.close, color: Colors.white),
                    label: const Text(
                      "Cancel ride",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
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

  void _showCancelBottomSheet(BuildContext context) {
    Get.bottomSheet(
      Container(
        padding: const EdgeInsets.all(24),
        decoration: const BoxDecoration(
          color: Color(0xFF0B0B0C),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              "Why do you want to cancel?",
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
                fontFamily: 'Urbanist',
              ),
            ),
            const SizedBox(height: 20),
            Obx(
              () => Column(
                children: controller.cancelReasons.map((reason) {
                  final isSelected =
                      controller.selectedCancelReason.value == reason;
                  return InkWell(
                    onTap: () => controller.selectedCancelReason.value = reason,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 12.0),
                      child: Row(
                        children: [
                          Container(
                            width: 24,
                            height: 24,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: isSelected
                                    ? R.theme.goldAccent
                                    : Colors.grey,
                                width: 2,
                              ),
                            ),
                            child: isSelected
                                ? Center(
                                    child: Container(
                                      width: 12,
                                      height: 12,
                                      decoration: BoxDecoration(
                                        color: R.theme.goldAccent,
                                        shape: BoxShape.circle,
                                      ),
                                    ),
                                  )
                                : null,
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Text(
                              reason,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontFamily: 'Urbanist',
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
            const SizedBox(height: 30),
            SizedBox(
              width: double.infinity,
              height: 56,
              child: ElevatedButton(
                onPressed: controller.confirmCancellation,
                style: ElevatedButton.styleFrom(
                  backgroundColor: R.theme.goldAccent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                child: const Text(
                  "Cancel Ride",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Urbanist',
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
      isScrollControlled: true,
    );
  }

  Widget _buildCircleAction(
    IconData icon,
    String label,
    VoidCallback onTap,
    Color color,
  ) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(30),
          child: Container(
            width: 45,
            height: 45,
            decoration: BoxDecoration(color: color, shape: BoxShape.circle),
            child: Icon(icon, color: Colors.white, size: 28),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 12,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}
