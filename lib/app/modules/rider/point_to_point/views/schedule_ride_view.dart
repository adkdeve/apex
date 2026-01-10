import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:apex/common/widgets/forms/route_input_fields.dart';
import 'package:apex/common/widgets/ride/fare_breakdown_row.dart';
import 'package:apex/common/widgets/navigation/back_button_header.dart';
import '../../../../../common/widgets/navigation/custom_app_bar.dart';
import '../../../../core/core.dart';
import '../controllers/schedule_ride_controller.dart';

class ScheduleRideView extends GetView<ScheduleRideController> {
  const ScheduleRideView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final TextStyle labelStyle = TextStyle(
      color: R.theme.white,
      fontSize: 14,
      fontWeight: FontWeight.w600,
      fontFamily: 'Urbanist',
    );

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
        statusBarBrightness: Brightness.dark,
      ),
      child: Scaffold(
        backgroundColor: R.theme.darkBackground,
        appBar: CustomAppBar(title: 'Schedule Ride'),
        body: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                // --- Route Inputs ---
                RouteInputFields(
                  pickupController: controller.pickupController,
                  dropoffController: controller.destController,
                  pickupHint: "Choose pick up point",
                  dropoffHint: "Choose your destination",
                  pickupColor: Colors.redAccent,
                  dropoffColor: const Color(0xFF27AE60),
                  borderColor: R.theme.secondary,
                ),

                const SizedBox(height: 20),

                // --- Stops ---
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Add Stops (Optional)", style: labelStyle),
                    TextButton.icon(
                      onPressed: controller.addStop,
                      icon: Icon(Icons.add, color: R.theme.white, size: 16),
                      label: Text(
                        "Add Stop",
                        style: TextStyle(color: R.theme.white),
                      ),
                      style: TextButton.styleFrom(padding: EdgeInsets.zero),
                    ),
                  ],
                ),
                _buildSimpleInput(
                  "Stop 1",
                  controller.stopController,
                  R.theme.secondary,
                ),

                const SizedBox(height: 20),

                // --- Date & Time ---
                Text("Select Date", style: labelStyle),
                const SizedBox(height: 8),
                InkWell(
                  onTap: () => controller.pickDate(context),
                  child: _buildIconInput(
                    controller.dateController,
                    Icons.calendar_today_outlined,
                    R.theme.secondary,
                    enabled: false,
                  ),
                ),
                const SizedBox(height: 20),

                Text("Select Time", style: labelStyle),
                const SizedBox(height: 8),
                InkWell(
                  onTap: () => controller.pickTime(context),
                  child: _buildIconInput(
                    controller.timeController,
                    Icons.access_time,
                    R.theme.secondary,
                    enabled: false,
                  ),
                ),
                const SizedBox(height: 20),

                // --- Window ---
                Text("Pickup Window", style: labelStyle),
                const SizedBox(height: 8),
                Container(
                  height: 56,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  decoration: BoxDecoration(
                    border: Border.all(color: R.theme.secondary),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text("5 min", style: TextStyle(color: Colors.white)),
                      Icon(Icons.arrow_drop_down, color: R.theme.secondary),
                    ],
                  ),
                ),
                const SizedBox(height: 20),

                // --- Note ---
                Text("Note for Driver (Optional)", style: labelStyle),
                const SizedBox(height: 8),
                _buildSimpleInput(
                  "Anything you want to say to driver...",
                  controller.noteController,
                  R.theme.secondary,
                ),

                const SizedBox(height: 20),

                Obx(() {
                  if (!controller.isFareCalculated.value)
                    return const SizedBox.shrink();

                  return Container(
                    width: double.infinity,
                    margin: const EdgeInsets.only(bottom: 20),
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: R.theme.cardBg,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Column(
                      children: [
                        FareBreakdownRow(
                          label: "Travel time",
                          value: "~44min.",
                          labelColor: Colors.grey,
                          valueColor: R.theme.secondary,
                        ),
                        FareBreakdownRow(
                          label: "Base fare",
                          value: "\$9,00",
                          labelColor: Colors.grey,
                          valueColor: R.theme.secondary,
                        ),
                        FareBreakdownRow(
                          label: "Distance fare",
                          value: "\$9,00",
                          labelColor: Colors.grey,
                          valueColor: R.theme.secondary,
                        ),
                        FareBreakdownRow(
                          label: "Time fare",
                          value: "\$9,00",
                          labelColor: Colors.grey,
                          valueColor: R.theme.secondary,
                        ),
                        const Padding(
                          padding: EdgeInsets.symmetric(vertical: 8.0),
                          child: Divider(color: Colors.grey, thickness: 0.2),
                        ),
                        FareBreakdownRow(
                          label: "Total Estimate",
                          value: "\$20,00",
                          labelColor: Colors.white,
                          valueColor: R.theme.secondary,
                          isTotal: true,
                        ),
                      ],
                    ),
                  );
                }),

                SizedBox(
                  width: double.infinity,
                  height: 56,
                  child: Obx(
                    () => ElevatedButton(
                      onPressed: controller.onMainButtonClick,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: R.theme.secondary,
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
      ),
    );
  }

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
