import 'package:apex/app/modules/rider/drivers_list/views/drivers_list_view.dart';
import 'package:apex/app/data/models/ride_booking_data.dart';
import 'package:apex/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class RideSelectionController extends GetxController {
  final MapController mapController = MapController();
  final DraggableScrollableController sheetController =
      DraggableScrollableController();

  // --- STATE ---
  var sheetHeight = 0.50.obs; // Tracks sheet height for button positioning
  var selectedVehicleIndex = 0.obs; // 0: Ride A/C, 1: Taxi, 2: Moto

  // Location data
  var pickupAddress = "Current Location".obs;
  var dropoffAddress = "Destination".obs;
  late LatLng pickupLocation;
  late LatLng dropoffLocation;
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

    // Set default locations
    pickupLocation = const LatLng(37.7749, -122.4194);
    dropoffLocation = const LatLng(37.7849, -122.4094);

    // Get data from previous screen if available
    if (Get.arguments != null && Get.arguments is Map) {
      final args = Get.arguments as Map;
      pickupAddress.value = args['pickupAddress'] ?? pickupAddress.value;
      dropoffAddress.value = args['dropoffAddress'] ?? dropoffAddress.value;
      if (args['pickupLat'] != null && args['pickupLng'] != null) {
        pickupLocation = LatLng(args['pickupLat'], args['pickupLng']);
      }
      if (args['dropoffLat'] != null && args['dropoffLng'] != null) {
        dropoffLocation = LatLng(args['dropoffLat'], args['dropoffLng']);
      }
    }

    sheetController.addListener(() {
      sheetHeight.value = sheetController.size;
    });
  }

  @override
  void onClose() {
    sheetController.dispose();
    super.onClose();
  }

  // --- ACTIONS ---
  void selectVehicle(int index) {
    selectedVehicleIndex.value = index;
  }

  void findDriver() {
    // Create ride booking data
    final bookingData = RideBookingData(
      pickupAddress: pickupAddress.value,
      dropoffAddress: dropoffAddress.value,
      pickupLat: pickupLocation.latitude,
      pickupLng: pickupLocation.longitude,
      dropoffLat: dropoffLocation.latitude,
      dropoffLng: dropoffLocation.longitude,
      rideType: "point-to-point",
      selectedVehicle: getVehicleName(selectedVehicleIndex.value),
      estimatedFare: "20.00",
      estimatedTime: "~44min.",
      estimatedDistance: "8.5 km",
    );

    Get.toNamed(Routes.DRIVERS_LIST, arguments: bookingData);
  }

  String getVehicleName(int index) {
    switch (index) {
      case 0:
        return "Ride A/C";
      case 1:
        return "Taxi";
      case 2:
        return "Moto";
      default:
        return "Vehicle";
    }
  }
}
