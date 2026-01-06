import 'package:apex/app/modules/shared/chat/views/chat_view.dart';
import 'package:apex/app/modules/rider/receipt/views/receipt_view.dart';
import 'package:apex/app/data/models/ride_booking_data.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

import '../../../../../utils/helpers/snackbar.dart';

class RideBookedController extends GetxController {
  final MapController mapController = MapController();
  final DraggableScrollableController sheetController =
      DraggableScrollableController();

  late ActiveRideData? activeRideData;

  // --- DYNAMIC DATA (from activeRideData) ---
  var driverName = "".obs;
  var driverRating = "".obs;
  var arrivalTime = "".obs;
  var actualFare = "".obs;
  var carModel = "".obs;
  var plateNumber = "".obs;
  var pickupAddress = "".obs;
  var dropoffAddress = "".obs;

  // Route Data
  var pickupLocation = const LatLng(37.7749, -122.4194).obs;
  var dropoffLocation = const LatLng(37.7849, -122.4094).obs;
  final List<LatLng> routePoints = [
    const LatLng(37.7749, -122.4194),
    const LatLng(37.7755, -122.4180),
    const LatLng(37.7770, -122.4160),
    const LatLng(37.7800, -122.4140),
    const LatLng(37.7849, -122.4094),
  ];

  @override
  void onInit() {
    super.onInit();
    // Get active ride data from previous screen
    activeRideData = Get.arguments as ActiveRideData?;

    if (activeRideData != null) {
      driverName.value = activeRideData!.driverName;
      driverRating.value = activeRideData!.driverRating;
      arrivalTime.value = activeRideData!.arrivalTime;
      actualFare.value = activeRideData!.actualFare;
      carModel.value = activeRideData!.carModel;
      plateNumber.value = activeRideData!.plateNumber;
      pickupAddress.value = activeRideData!.bookingData.pickupAddress;
      dropoffAddress.value = activeRideData!.bookingData.dropoffAddress;
      pickupLocation.value = LatLng(
        activeRideData!.bookingData.pickupLat,
        activeRideData!.bookingData.pickupLng,
      );
      dropoffLocation.value = LatLng(
        activeRideData!.bookingData.dropoffLat,
        activeRideData!.bookingData.dropoffLng,
      );
    }
  }

  // --- CANCELLATION STATE ---
  // The selected reason for cancellation
  var selectedCancelReason = "I don't need this journey.".obs;

  // Available reasons
  final List<String> cancelReasons = [
    "I don't need this journey.",
    "I want to change the details of the journey.",
    "The driver took too long to be appointed.",
    "Other",
  ];

  // --- ACTIONS ---
  void onCallDriver() => _showAction("Calling ${driverName.value}...");
  void onMessageDriver() => Get.to(() => ChatView());
  void onShareLocation() => _showAction("Sharing location...");

  // Called when "Cancel Ride" is clicked inside the options sheet
  void confirmCancellation() {
    Get.back(); // Close bottom sheet
    Get.to(() => ReceiptView(), arguments: activeRideData);
  }

  void _showAction(String msg) {
    SnackBarUtils.successMsg(msg);
  }
}
