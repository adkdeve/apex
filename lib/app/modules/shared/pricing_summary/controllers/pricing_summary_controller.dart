import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../utils/dialogs/searching_driver_dialog.dart';
import '../../../rider/hourly_reservation/views/driver_details_view.dart';

class PricingSummaryController extends GetxController {
  // Data passed from the previous screen
  late String hourlyRate;
  late String bookedHours;
  late String estimatedTotal;

  @override
  void onInit() {
    super.onInit();
    // Retrieve data passed via Get.toNamed(..., arguments: ...)
    // Providing default values for safety in case of direct navigation during testing
    final args = Get.arguments as Map<String, dynamic>? ?? {};
    hourlyRate = args['hourlyRate'] ?? '\$100';
    bookedHours = args['bookedHours'] ?? '3 hours';
    estimatedTotal = args['estimatedTotal'] ?? '\$200,00';
  }

  void confirmBooking() async {
    // 1. Show the "Searching for Driver" Dialog
    Get.dialog(
      const SearchingDriverDialog(),
      barrierDismissible: false, // User cannot click outside to close
      barrierColor: Colors.black.withOpacity(
        0.8,
      ), // Darkens the background significantly
    );

    // 2. Wait for 3 Seconds
    await Future.delayed(const Duration(seconds: 3));

    // 3. Close the Dialog
    if (Get.isDialogOpen ?? false) {
      Get.back();
    }

    Get.to(DriverDetailsView());
  }

  void editDetails() {
    Get.back();
  }
}
