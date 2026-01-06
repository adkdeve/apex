import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:apex/common/widgets/forms/route_input_fields.dart';
import 'package:apex/common/widgets/ride/fare_breakdown_row.dart';
import 'package:apex/common/widgets/navigation/back_button_header.dart';
import '../../../../core/core.dart';
import '../controllers/schedule_ride_controller.dart';

class ScheduleRideView extends GetView<ScheduleRideController> {
  const ScheduleRideView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(ScheduleRideController());

    // --- Colors ---
    const Color mainBgColor = Color(0xFF0B0B0C);
    const Color cardBg = Color(0xFF1F1F1F); // New Card Background Color
    const Color primaryGold = Color(0xFFCFA854);
    const Color inputBorder = Color(0xFFCFA854);
    const Color textWhite = Colors.white;
    final Color buttonBg = R.theme.cardBg;

    const TextStyle labelStyle = TextStyle(
      color: textWhite,
      fontSize: 14,
      fontWeight: FontWeight.w600,
      fontFamily: 'Urbanist',
    );

    return Scaffold(
      backgroundColor: mainBgColor,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              // --- Header ---
              BackButtonHeader(title: "Schedule Ride", buttonBg: buttonBg),
              const SizedBox(height: 30),

              // --- Route Inputs ---
              RouteInputFields(
                pickupController: controller.pickupController,
                dropoffController: controller.destController,
                pickupHint: "Choose pick up point",
                dropoffHint: "Choose your destination",
                pickupColor: Colors.redAccent,
                dropoffColor: const Color(0xFF27AE60),
                borderColor: inputBorder,
              ),

              const SizedBox(height: 20),

              // --- Stops ---
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("Add Stops (Optional)", style: labelStyle),
                  TextButton.icon(
                    onPressed: controller.addStop,
                    icon: const Icon(Icons.add, color: textWhite, size: 16),
                    label: const Text(
                      "Add Stop",
                      style: TextStyle(color: textWhite),
                    ),
                    style: TextButton.styleFrom(padding: EdgeInsets.zero),
                  ),
                ],
              ),
              _buildSimpleInput(
                "Stop 1",
                controller.stopController,
                inputBorder,
              ),

              const SizedBox(height: 20),

              // --- Date & Time ---
              const Text("Select Date", style: labelStyle),
              const SizedBox(height: 8),
              InkWell(
                onTap: () => controller.pickDate(context),
                child: _buildIconInput(
                  controller.dateController,
                  Icons.calendar_today_outlined,
                  inputBorder,
                  enabled: false,
                ),
              ),
              const SizedBox(height: 20),

              const Text("Select Time", style: labelStyle),
              const SizedBox(height: 8),
              InkWell(
                onTap: () => controller.pickTime(context),
                child: _buildIconInput(
                  controller.timeController,
                  Icons.access_time,
                  inputBorder,
                  enabled: false,
                ),
              ),
              const SizedBox(height: 20),

              // --- Window ---
              const Text("Pickup Window", style: labelStyle),
              const SizedBox(height: 8),
              Container(
                height: 56,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                  border: Border.all(color: inputBorder),
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Text("5 min", style: TextStyle(color: Colors.white)),
                    Icon(Icons.arrow_drop_down, color: primaryGold),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              // --- Note ---
              const Text("Note for Driver (Optional)", style: labelStyle),
              const SizedBox(height: 8),
              _buildSimpleInput(
                "Anything you want to say to driver...",
                controller.noteController,
                inputBorder,
              ),

              const SizedBox(height: 20),

              // --- CONDITIONAL FARE BREAKDOWN (UPDATED WITH BACKGROUND) ---
              Obx(() {
                if (!controller.isFareCalculated.value)
                  return const SizedBox.shrink();

                return Container(
                  width: double.infinity,
                  margin: const EdgeInsets.only(bottom: 20),
                  padding: const EdgeInsets.all(20), // Padding inside the card
                  decoration: BoxDecoration(
                    color: cardBg, // Dark Grey Background
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Column(
                    children: [
                      FareBreakdownRow(
                        label: "Travel time",
                        value: "~44min.",
                        labelColor: Colors.grey,
                        valueColor: primaryGold,
                      ),
                      FareBreakdownRow(
                        label: "Base fare",
                        value: "\$9,00",
                        labelColor: Colors.grey,
                        valueColor: primaryGold,
                      ),
                      FareBreakdownRow(
                        label: "Distance fare",
                        value: "\$9,00",
                        labelColor: Colors.grey,
                        valueColor: primaryGold,
                      ),
                      FareBreakdownRow(
                        label: "Time fare",
                        value: "\$9,00",
                        labelColor: Colors.grey,
                        valueColor: primaryGold,
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 8.0),
                        child: Divider(color: Colors.grey, thickness: 0.2),
                      ),
                      FareBreakdownRow(
                        label: "Total Estimate",
                        value: "\$20,00",
                        labelColor: Colors.white,
                        valueColor: primaryGold,
                        isTotal: true,
                      ),
                    ],
                  ),
                );
              }),

              // --- ACTION BUTTON ---
              SizedBox(
                width: double.infinity,
                height: 56,
                child: Obx(
                  () => ElevatedButton(
                    onPressed: controller.onMainButtonClick,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: primaryGold,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    child: Text(
                      controller.isFareCalculated.value
                          ? "Find Driver"
                          : "Calculate Fare",
                      style: const TextStyle(
                        color: Colors.white, // White text on gold button
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Urbanist',
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }

  // --- Helper Widgets ---

  Widget _buildSimpleInput(
    String hint,
    TextEditingController controller,
    Color borderColor,
  ) {
    return Container(
      height: 56,
      decoration: BoxDecoration(
        border: Border.all(color: borderColor),
        borderRadius: BorderRadius.circular(30),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: TextField(
        controller: controller,
        style: const TextStyle(color: Colors.white),
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: TextStyle(color: Colors.grey[500], fontSize: 14),
          border: InputBorder.none,
        ),
      ),
    );
  }

  Widget _buildIconInput(
    TextEditingController controller,
    IconData icon,
    Color borderColor, {
    bool enabled = true,
  }) {
    return Container(
      height: 56,
      decoration: BoxDecoration(
        border: Border.all(color: borderColor),
        borderRadius: BorderRadius.circular(30),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: controller,
              enabled: enabled,
              style: const TextStyle(color: Colors.white),
              decoration: const InputDecoration(border: InputBorder.none),
            ),
          ),
          Icon(icon, color: const Color(0xFFCFA854)),
        ],
      ),
    );
  }
}
