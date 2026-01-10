import 'package:apex/common/widgets/maps/map_component.dart';
import 'package:apex/common/widgets/sheets/draggable_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart'; // Needed for date formatting
import '../../../../core/core.dart';
import '../../search/views/search_view.dart';
import '../controllers/hourly_reservation_controller.dart';
import 'package:apex/common/widgets/label_widget.dart';

class HourlyReservationView extends GetView<HourlyReservationController> {
  const HourlyReservationView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
      ),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Stack(
          children: [
            // 1. BACKGROUND MAP
            Obx(
                  () => MapComponent(
                mapController: controller.mapController,
                initialCenter: controller.pickupLocation.value,
                polylines: controller.routePoints.isNotEmpty
                    ? [
                  // Example polyline if route exists
                  // Polyline(points: controller.routePoints, strokeWidth: 4.0, color: R.theme.secondary)
                ]
                    : [],
                markers: [
                  MapMarkerHelper.pickupMarker(
                    point: controller.pickupLocation.value,
                    size: 50,
                    color: Colors.redAccent,
                  ),
                ],
              ),
            ),

            // 2. TOP BAR
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Back Button (replaces avatar for better UX context, or keep avatar if preferred)
                      GestureDetector(
                        onTap: () => Get.back(),
                        child: Container(
                          width: 40,
                          height: 40,
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(Icons.arrow_back, color: Colors.black),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            // 3. DRAGGABLE FORM SHEET
            DraggableBottomSheet(
              controller: controller.sheetController,
              initialChildSize: 0.65,
              minChildSize: 0.3,
              maxChildSize: 0.85,
              backgroundColor: R.theme.darkBackground,
              onSheetChanged: (height) => controller.sheetHeight.value = height,
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    // --- 1. Pickup Location ---
                    const LabelWidget(text: "Pickup location"),
                    GestureDetector(
                      onTap: () {
                        // Pass a callback or handle result from SearchView
                        Get.to(() => SearchView())?.then((result) {
                          if(result != null) {
                            // Assuming result has lat/lng and address
                            // controller.updatePickupLocation(...);
                          }
                        });
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                        decoration: BoxDecoration(
                          color: R.theme.transparent,
                          border: Border.all(color: R.theme.secondary),
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: Row(
                          children: [
                            const Icon(Icons.radio_button_checked, color: Colors.redAccent, size: 20),
                            const SizedBox(width: 12),
                            Expanded(
                              // Bind to controller text
                              child: TextField(
                                controller: controller.pickupInput,
                                enabled: false, // Make it look like a button
                                style: TextStyle(color: R.theme.grey, fontSize: 14),
                                decoration: const InputDecoration(
                                  border: InputBorder.none,
                                  isDense: true,
                                  contentPadding: EdgeInsets.zero,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),

                    // --- 2. Pickup Date ---
                    const LabelWidget(text: "Pickup Date"),
                    GestureDetector(
                      onTap: () => controller.pickDate(context),
                      child: Obx(() => _buildIconInput(
                        text: DateFormat('MM/dd/yyyy').format(controller.selectedDate.value),
                        icon: Icons.calendar_today_outlined,
                        borderColor: R.theme.secondary,
                      )),
                    ),
                    const SizedBox(height: 16),

                    // --- 3. Pickup Time ---
                    const LabelWidget(text: "Pickup Time"),
                    GestureDetector(
                      onTap: () => controller.pickTime(context),
                      child: Obx(() => _buildIconInput(
                        text: controller.selectedTime.value.format(context),
                        icon: Icons.access_time,
                        borderColor: R.theme.secondary,
                      )),
                    ),
                    const SizedBox(height: 16),

                    // --- 4. Duration ---
                    const LabelWidget(text: "Duration in hours"),
                    _buildTextInput(
                        controller: controller.durationController, // Bound!
                        hint: "3",
                        borderColor: R.theme.secondary,
                        isNumber: true
                    ),
                    const SizedBox(height: 16),

                    // --- 5. Vehicle Type ---
                    const LabelWidget(text: "Vehicle type"),
                    _buildVehicleDropdown(), // Extracted to method below
                    const SizedBox(height: 16),

                    // --- 6. Passengers ---
                    const LabelWidget(text: "Number of passengers"),
                    _buildTextInput(
                        controller: controller.passengersController, // Bound!
                        hint: "1",
                        borderColor: R.theme.secondary,
                        isNumber: true
                    ),
                    const SizedBox(height: 16),

                    // --- 7. Special Requests ---
                    const LabelWidget(text: "Special requests"),
                    _buildTextInput(
                      controller: controller.requestsController, // Bound!
                      hint: "Type here...",
                      borderColor: R.theme.secondary,
                    ),
                    const SizedBox(height: 24),

                    // --- CONFIRM BUTTON ---
                    SizedBox(
                      width: double.infinity,
                      height: 54,
                      child: ElevatedButton(
                        onPressed: controller.confirmBooking, // Bound!
                        style: ElevatedButton.styleFrom(
                          backgroundColor: R.theme.secondary,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                        ),
                        child: Text(
                          "Confirm",
                          style: TextStyle(
                            color: R.theme.white,
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
            ),
          ],
        ),
      ),
    );
  }

  // --- Helper Widgets ---

  Widget _buildTextInput({
    required TextEditingController controller,
    required String hint,
    required Color borderColor,
    bool isNumber = false,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF0B0B0C),
        border: Border.all(color: borderColor),
        borderRadius: BorderRadius.circular(30),
      ),
      child: TextField(
        controller: controller,
        keyboardType: isNumber ? TextInputType.number : TextInputType.text,
        style: const TextStyle(color: Colors.white),
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: const TextStyle(color: Colors.grey, fontSize: 14),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          isDense: true,
        ),
      ),
    );
  }

  Widget _buildIconInput({
    required String text,
    required IconData icon,
    required Color borderColor,
  }) {
    // This is just a display container, clicks are handled by the parent GestureDetector
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        color: const Color(0xFF0B0B0C),
        border: Border.all(color: borderColor),
        borderRadius: BorderRadius.circular(30),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(text, style: const TextStyle(color: Colors.grey, fontSize: 14)),
          Icon(icon, color: borderColor, size: 20),
        ],
      ),
    );
  }

  Widget _buildVehicleDropdown() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: const Color(0xFF0B0B0C), // Dark background matching theme
        border: Border.all(color: R.theme.secondary),
        borderRadius: BorderRadius.circular(30),
      ),
      child: Obx(() => DropdownButtonHideUnderline(
        child: DropdownButton<int>(
          value: controller.selectedVehicleIndex.value,
          dropdownColor: const Color(0xFF1F1F1F), // Dark dropdown menu
          icon: Icon(Icons.arrow_drop_down, color: R.theme.grey),
          isExpanded: true,
          items: List.generate(
            controller.vehicleTypes.length,
                (index) => DropdownMenuItem(
              value: index,
              child: Text(
                controller.vehicleTypes[index],
                style: TextStyle(color: R.theme.grey, fontSize: 14),
              ),
            ),
          ),
          onChanged: (val) {
            if (val != null) controller.selectVehicle(val);
          },
        ),
      )),
    );
  }
}