import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:get/get.dart';
import 'package:latlong2/latlong.dart';

import '../../../../../utils/helpers/snackbar.dart';
import '../../../shared/pricing_summary/views/pricing_summary_view.dart';

class HourlyReservationController extends GetxController {
  // --- Controllers ---
  final MapController mapController = MapController();
  final DraggableScrollableController sheetController =
      DraggableScrollableController();

  // --- Form Text Controllers ---
  final TextEditingController durationController = TextEditingController();
  final TextEditingController passengersController = TextEditingController();
  final TextEditingController requestsController = TextEditingController();

  // --- Observables (State) ---
  var sheetHeight = 0.65.obs; // Tracks bottom sheet height
  var pickupLocation = const LatLng(
    51.509364,
    -0.128928,
  ).obs; // Default: London (Example)

  // Form Selection States
  var selectedDate = DateTime.now().obs;
  var selectedTime = TimeOfDay.now().obs;
  var selectedVehicleIndex = 0.obs;

  // Data Sources
  final List<String> vehicleTypes = [
    "Luxury SUV - \$100 per hour",
    "Sedan - \$80 per hour",
    "Limousine - \$150 per hour",
  ];

  @override
  void onInit() {
    super.onInit();
    // Initialize default values if needed
    durationController.text = "3"; // Default 3 hours
    passengersController.text = "1";
  }

  @override
  void onClose() {
    mapController.dispose();
    sheetController.dispose();
    durationController.dispose();
    passengersController.dispose();
    requestsController.dispose();
    super.onClose();
  }

  // --- Actions ---

  // 1. Pick Date
  Future<void> pickDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate.value,
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
      builder: (context, child) {
        // Custom theme for DatePicker to match Dark Mode
        return Theme(
          data: ThemeData.dark().copyWith(
            colorScheme: const ColorScheme.dark(
              primary: Color(0xFFCFA854), // Gold
              onPrimary: Colors.white,
              surface: Color(0xFF1F1F1F),
              onSurface: Colors.white,
            ),
            dialogBackgroundColor: const Color(0xFF0B0B0C),
          ),
          child: child!,
        );
      },
    );
    if (picked != null && picked != selectedDate.value) {
      selectedDate.value = picked;
    }
  }

  // 2. Pick Time
  Future<void> pickTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: selectedTime.value,
      builder: (context, child) {
        return Theme(
          data: ThemeData.dark().copyWith(
            colorScheme: const ColorScheme.dark(
              primary: Color(0xFFCFA854),
              onPrimary: Colors.black,
              surface: Color(0xFF1F1F1F),
              onSurface: Colors.white,
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null && picked != selectedTime.value) {
      selectedTime.value = picked;
    }
  }

  // 3. Select Vehicle
  void selectVehicle(int index) {
    selectedVehicleIndex.value = index;
  }

  // 4. Confirm Booking logic
  void confirmBooking() {
    if (durationController.text.isEmpty || passengersController.text.isEmpty) {
      SnackBarUtils.errorMsg("Please fill in all fields");
      return;
    }

    // Calculate your values here based on user selection
    String rate = "\$100";
    String hours = "${durationController.text} hours";
    // Simple calculation example:
    int total = 100 * (int.tryParse(durationController.text) ?? 0);
    String totalString = "\$${total},00";

    // Navigate and pass arguments
    Get.to(
      () => const PricingSummaryView(),
      arguments: {
        'hourlyRate': rate,
        'bookedHours': hours,
        'estimatedTotal': totalString,
      },
    );
  }
}
