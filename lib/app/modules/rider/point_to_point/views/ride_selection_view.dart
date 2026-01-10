import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:apex/common/widgets/maps/map_component.dart';
import 'package:apex/common/widgets/sheets/draggable_bottom_sheet.dart';
import 'package:apex/common/widgets/ride/fare_breakdown_row.dart';
import 'package:apex/common/widgets/ride/route_display_section.dart';
import '../../../../core/core.dart';
import '../controllers/ride_selection_controller.dart';

class RideSelectionView extends GetView<RideSelectionController> {
  const RideSelectionView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [

          MapComponent(
            mapController: controller.mapController,
            initialCenter: controller.pickupLocation,
            polylines: [
              MapPolylineHelper.routePolyline(
                points: controller.routePoints,
                color: R.theme.black,
                strokeWidth: 4.0,
              ),
            ],
            markers: [
              MapMarkerHelper.pickupMarker(
                point: controller.pickupLocation,
                size: 40,
                color: const Color(0xFF27AE60),
              ),
              MapMarkerHelper.dropoffMarker(
                point: controller.dropoffLocation,
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
                width: 40, height: 40,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                  boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 4)],
                ),
                child: const Icon(Icons.arrow_back_ios_new, color: Colors.black, size: 20),
              ),
            ),
          ),

          Obx(() {
            double bottomPadding = (screenHeight * controller.sheetHeight.value) + 20;
            return Positioned(
              bottom: bottomPadding,
              right: 20,
              child: FloatingActionButton(
                mini: true,
                backgroundColor: Colors.white,
                onPressed: () => controller.mapController.move(controller.pickupLocation, 15),
                child: const Icon(Icons.my_location, color: Colors.black),
              ),
            );
          }),

          DraggableBottomSheet(
            controller: controller.sheetController,
            initialChildSize: 0.50,
            minChildSize: 0.45,
            maxChildSize: 0.75,
            backgroundColor: R.theme.darkBackground,
            onSheetChanged: (height) => controller.sheetHeight.value = height,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _buildVehicleCard(0, "Ride A/C", Icons.directions_car, R.theme.secondary),
                    _buildVehicleCard(1, "Taxi", Icons.local_taxi, R.theme.secondary),
                    _buildVehicleCard(2, "Moto", Icons.two_wheeler, R.theme.secondary),
                  ],
                ),

                24.sbh,

                RouteDisplaySection(
                  pickupLocation: "Skate Park",
                  dropoffLocation: "Home",
                  backgroundColor: const Color(0xFF1F1F1F),
                  pickupColor: const Color(0xFF27AE60),
                  dropoffColor: Colors.redAccent,
                  showStops: true,
                  onStopsTap: () {},
                ),

                20.sbh,

                FareBreakdownRow(label: "Travel time", value: "~44min.", labelColor: R.theme.grey, valueColor: R.theme.secondary),
                FareBreakdownRow(label: "Base fare", value: "\$9,00", labelColor: R.theme.grey, valueColor: R.theme.secondary),
                FareBreakdownRow(label: "Distance fare", value: "\$9,00", labelColor: R.theme.grey, valueColor: R.theme.secondary),
                FareBreakdownRow(label: "Time fare", value: "\$9,00", labelColor: R.theme.grey, valueColor: R.theme.secondary),
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 8.0),
                  child: Divider(color: Colors.grey),
                ),
                FareBreakdownRow(label: "Total Estimate", value: "\$20,00", labelColor: R.theme.white, valueColor: R.theme.secondary, isTotal: true),

                10.sbh,

                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: controller.findDriver,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: R.theme.secondary,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                    ),
                    child: const Text(
                      "Find Driver",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Urbanist',
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


  Widget _buildVehicleCard(int index, String label, IconData icon, Color highlightColor) {
    return Obx(() {
      final isSelected = controller.selectedVehicleIndex.value == index;
      return GestureDetector(
        onTap: () => controller.selectVehicle(index),
        child: Container(
          width: 100,
          height: 80,
          decoration: BoxDecoration(
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(12),
            border: isSelected
                ? Border.all(color: highlightColor, width: 2)
                : Border.all(color: Colors.white10),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Using Icon as placeholder for Car Image
              Icon(icon, color: Colors.white, size: 30),
              const SizedBox(height: 8),
              Text(
                label,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      );
    });
  }

}