import 'package:apex/common/widgets/maps/map_component.dart';
import 'package:apex/common/widgets/sheets/draggable_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../../search/views/search_view.dart';
import '../controllers/hourly_reservation_controller.dart';

class HourlyReservationView extends GetView<HourlyReservationController> {
  const HourlyReservationView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Ensure controller is loaded
    Get.put(HourlyReservationController());

    // --- Palette based on image ---
    const Color bgDark = Color(0xFF0B0B0C);
    const Color inputFill = Color(0xFF0B0B0C); // Or slightly lighter if needed
    const Color borderGold = Color(0xFFCFA854); // The gold accent
    const Color textWhite = Colors.white;
    const Color textGrey = Colors.grey;

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
                polylines: [], // No route needed for initial setup usually
                markers: [
                  MapMarkerHelper.pickupMarker(
                    point: controller.pickupLocation.value,
                    size: 50,
                    color: Colors.redAccent,
                  ),
                ],
              ),
            ),

            // 2. TOP BAR (User & Notification)
            Positioned(
              top: 0, left: 0, right: 0,
              child: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: 40, height: 40,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                            image: NetworkImage("https://i.pravatar.cc/150?u=dev"),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Container(
                        width: 40, height: 40,
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(Icons.notifications_none_rounded, color: Colors.black),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            // 3. DRAGGABLE FORM SHEET
            DraggableBottomSheet(
              controller: controller.sheetController,
              initialChildSize: 0.65, // Taller default to fit form
              minChildSize: 0.3,
              maxChildSize: 0.85,
              backgroundColor: bgDark,
              onSheetChanged: (height) => controller.sheetHeight.value = height,
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    // --- 1. Pickup Location ---
                    _buildLabel("Pickup location"),
                    GestureDetector(
                      onTap: () {
                        Get.to(SearchView());
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                        decoration: BoxDecoration(
                          color: inputFill,
                          border: Border.all(color: borderGold),
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: Row(
                          children: [
                            const Icon(Icons.radio_button_checked, color: Colors.redAccent, size: 20),
                            const SizedBox(width: 12),
                            const Expanded(
                              child: Text(
                                "Choose pick up point",
                                style: TextStyle(color: textGrey, fontSize: 14),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),

                    // --- 2. Pickup Date ---
                    _buildLabel("Pickup Date"),
                    _buildIconInput(
                      text: "12/12/2025",
                      icon: Icons.calendar_today_outlined,
                      borderColor: borderGold,
                    ),
                    const SizedBox(height: 16),

                    // --- 3. Pickup Time ---
                    _buildLabel("Pickup Time"),
                    _buildIconInput(
                      text: "00:00:00",
                      icon: Icons.access_time,
                      borderColor: borderGold,
                    ),
                    const SizedBox(height: 16),

                    // --- 4. Duration ---
                    _buildLabel("Duration in hours"),
                    _buildTextInput(hint: "3 hours", borderColor: borderGold),
                    const SizedBox(height: 16),

                    // --- 5. Vehicle Type (Dropdown) ---
                    _buildLabel("Vehicle type"),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                      decoration: BoxDecoration(
                        color: inputFill,
                        border: Border.all(color: borderGold),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Row(
                        children: const [
                          Expanded(
                            child: Text(
                              "Luxury SUV - \$100 per hour",
                              style: TextStyle(color: textGrey, fontSize: 14),
                            ),
                          ),
                          Icon(Icons.arrow_drop_down, color: borderGold),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),

                    // --- 6. Passengers ---
                    _buildLabel("Number of passengers"),
                    _buildTextInput(hint: "3", borderColor: borderGold),
                    const SizedBox(height: 16),

                    // --- 7. Special Requests ---
                    _buildLabel("Special requests"),
                    _buildTextInput(hint: "Type here...", borderColor: borderGold),
                    const SizedBox(height: 24),

                    // --- CONFIRM BUTTON ---
                    SizedBox(
                      width: double.infinity,
                      height: 54,
                      child: ElevatedButton(
                        onPressed: () {
                          controller.confirmBooking();
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: borderGold,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                        ),
                        child: const Text(
                          "Confirm",
                          style: TextStyle(
                            color: textWhite,
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

  Widget _buildLabel(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0, left: 4),
      child: Text(
        text,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 14,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  Widget _buildTextInput({required String hint, required Color borderColor}) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF0B0B0C),
        border: Border.all(color: borderColor),
        borderRadius: BorderRadius.circular(30),
      ),
      child: TextField(
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

  Widget _buildIconInput({required String text, required IconData icon, required Color borderColor}) {
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
          Text(
            text,
            style: const TextStyle(color: Colors.grey, fontSize: 14),
          ),
          Icon(icon, color: borderColor, size: 20),
        ],
      ),
    );
  }
}