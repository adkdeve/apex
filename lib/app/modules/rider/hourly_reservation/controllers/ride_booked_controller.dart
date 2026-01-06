import 'package:apex/utils/helpers/snackbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import '../../../../../common/widgets/sheets/extend_time_sheet.dart';
import '../../../shared/chat/views/chat_view.dart';

class RideBookedController extends GetxController {
  final MapController mapController = MapController();
  final DraggableScrollableController sheetController =
      DraggableScrollableController();

  // --- MOCK DATA ---
  final driverName = "Ben Stokes";
  final carModel = "Luxury SUV";
  final plateNumber = "APT 238";

  // Status
  final timeLeft = "1h 32 min left".obs;
  final pickupTime = "12:30 PM";
  final double hourlyRate = 100.0;
  final int initialBookedHours = 3;

  // --- EXTENSION STATE ---
  var bookedHours = 3.0.obs;
  var extendedHours = 0.0.obs; // Amount of added time
  var estimatedTotal = 200.00.obs; // Base total

  // 0 = 30min, 1 = 60min, 2 = 90min
  var selectedExtensionOption = 0.obs;

  // Map Data
  final LatLng pickupLocation = const LatLng(37.7749, -122.4194);
  final LatLng dropoffLocation = const LatLng(37.7849, -122.4094);
  final List<LatLng> routePoints = [
    const LatLng(37.7749, -122.4194),
    const LatLng(37.7849, -122.4094),
  ];

  @override
  void onInit() {
    super.onInit();
    // Initialize total based on mock data
    estimatedTotal.value = hourlyRate * initialBookedHours;
  }

  // --- ACTIONS ---
  void onCallDriver() => _showAction("Calling $driverName...");
  void onMessageDriver() => Get.to(() => const ChatView());
  void onShareLocation() => _showAction("Sharing location...");

  // Open the Bottom Sheet to select more time
  void openExtendTimeSheet() {
    Get.bottomSheet(
      const ExtendTimeSheet(),
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
    );
  }

  // Called when "Send" is clicked in the extension sheet
  void confirmExtension() {
    double addedTime = 0.0;
    switch (selectedExtensionOption.value) {
      case 0:
        addedTime = 0.5;
        break; // 30 mins
      case 1:
        addedTime = 1.0;
        break; // 60 mins
      case 2:
        addedTime = 1.5;
        break; // 90 mins
    }

    extendedHours.value += addedTime;

    // Recalculate Total: (Initial + Extended) * Rate
    // Note: Logic depends on your business rule, this is a simple example
    double totalTime = initialBookedHours + extendedHours.value;
    estimatedTotal.value = totalTime * hourlyRate;

    Get.back(); // Close sheet
    SnackBarUtils.successMsg(
      "Time extended successfully by ${addedTime * 60} mins",
    );
  }

  void _showAction(String msg) {
    SnackBarUtils.successMsg(msg);
  }
}
