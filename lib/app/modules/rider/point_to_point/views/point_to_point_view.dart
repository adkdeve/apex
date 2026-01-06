import 'package:apex/app/modules/rider/point_to_point/views/add_label_view.dart';
import 'package:apex/app/modules/rider/search/views/search_view.dart';
import 'package:apex/common/widgets/maps/map_component.dart';
import 'package:apex/common/widgets/forms/route_input_fields.dart';
import 'package:apex/common/widgets/sheets/draggable_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../../../../core/core.dart';
import '../controllers/point_to_point_controller.dart';

class PointToPointView extends GetView<PointToPointController> {
  const PointToPointView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(PointToPointController());

    const Color sheetBg = Color(0xFF0B0B0C);
    const Color textWhite = Colors.white;

    final double screenHeight = MediaQuery.of(context).size.height;

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
        statusBarBrightness: Brightness.dark,
      ),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Stack(
          children: [
            Obx(
              () => MapComponent(
                mapController: controller.mapController,
                initialCenter: controller.pickupLocation,
                polylines: [
                  MapPolylineHelper.routePolyline(
                    points: controller.routePoints.toList(),
                    color: R.theme.secondary,
                    strokeWidth: 5.0,
                  ),
                ],
                markers: [
                  MapMarkerHelper.pickupMarker(
                    point: controller.pickupLocation,
                    size: 50,
                    color: Colors.redAccent,
                  ),
                  MapMarkerHelper.dropoffMarker(
                    point: controller.dropoffLocation.value,
                    size: 50,
                    color: const Color(0xFF27AE60),
                  ),
                ],
              ),
            ),

            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 10,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: 40,
                        height: 40,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                            image: NetworkImage(
                              "https://i.pravatar.cc/150?u=dev",
                            ),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Container(
                        width: 40,
                        height: 40,
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.notifications_none_rounded,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            Obx(() {
              double bottomPadding =
                  (screenHeight * controller.sheetHeight.value) + 20;

              return Positioned(
                bottom: bottomPadding,
                right: 20,
                child: FloatingActionButton(
                  mini: true,
                  backgroundColor: Colors.white,
                  onPressed: () {
                    controller.mapController.move(
                      controller.pickupLocation,
                      15,
                    );
                  },
                  child: const Icon(Icons.my_location, color: Colors.black),
                ),
              );
            }),

            DraggableBottomSheet(
              controller: controller.sheetController,
              initialChildSize: 0.55,
              minChildSize: 0.25,
              maxChildSize: 0.65,
              backgroundColor: sheetBg,
              onSheetChanged: (height) => controller.sheetHeight.value = height,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Where would you like to go?",
                    style: TextStyle(
                      color: textWhite,
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      fontFamily: 'Urbanist',
                    ),
                  ),

                  18.sbh,

                  RouteInputFields(
                    pickupController: controller.pickupInput,
                    dropoffController: controller.dropoffInput,
                    pickupHint: "Choose pick up point",
                    dropoffHint: "Choose your destination",
                    pickupColor: Colors.redAccent,
                    dropoffColor: const Color(0xFF27AE60),
                    borderColor: R.theme.secondary,
                    onPickupTap: () => Get.to(() => SearchView()),
                    onDropoffTap: () => Get.to(() => SearchView()),
                  ),

                  18.sbh,

                  Row(
                    children: [
                      _buildChip(
                        "Home",
                        Icons.bookmark,
                        R.theme.secondary,
                        Colors.white,
                        () => controller.selectSavedPlace("Home"),
                      ),

                      12.sbw,

                      _buildChip(
                        "Office",
                        Icons.bookmark_border,
                        Colors.white,
                        Colors.black,
                        () => controller.selectSavedPlace("Office"),
                      ),

                      12.sbw,

                      InkWell(
                        onTap: () => Get.to(AddLabelView()),
                        borderRadius: BorderRadius.circular(30),
                        child: Container(
                          width: 40,
                          height: 40,
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(Icons.add, color: Colors.black),
                        ),
                      ),
                    ],
                  ),

                  20.sbh,

                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: controller.confirmRide,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: R.theme.secondary,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                      child: const Text(
                        "Confirm",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Urbanist',
                        ),
                      ),
                    ),
                  ),

                  16.sbh,

                  InkWell(
                    onTap: controller.scheduleRide,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      height: 50,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.white24),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: const [
                          Text(
                            "Schedule Ride",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontFamily: 'Urbanist',
                            ),
                          ),
                          Icon(
                            Icons.arrow_forward_ios,
                            color: Colors.white,
                            size: 16,
                          ),
                        ],
                      ),
                    ),
                  ),

                  20.sbh,
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildChip(
    String label,
    IconData icon,
    Color bg,
    Color textC,
    VoidCallback onTap,
  ) {
    return Expanded(
      child: InkWell(
        onTap: onTap,
        child: Container(
          height: 40,
          decoration: BoxDecoration(
            color: bg,
            borderRadius: BorderRadius.circular(30),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, color: textC, size: 18),

              const SizedBox(width: 8),

              Text(
                label,
                style: TextStyle(color: textC, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
