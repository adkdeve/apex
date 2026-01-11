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
  var sheetHeight = 0.50.obs;
  var selectedVehicleIndex = 0.obs;

  // --- Location & Route Data ---
  var pickupAddress = "Current Location".obs;
  var dropoffAddress = "Destination".obs;
  late LatLng pickupLocation;
  late LatLng dropoffLocation;
  var routePoints = <LatLng>[].obs;

  @override
  void onInit() {
    super.onInit();
    _loadDataFromArgs();

    sheetController.addListener(() {
      sheetHeight.value = sheetController.size;
    });
  }

  @override
  void onClose() {
    sheetController.dispose();
    super.onClose();
  }

  void _loadDataFromArgs() {
    if (Get.arguments != null && Get.arguments is Map) {
      final args = Get.arguments as Map;
      pickupAddress.value = args['pickupAddress'] ?? pickupAddress.value;
      dropoffAddress.value = args['dropoffAddress'] ?? dropoffAddress.value;
      pickupLocation = args['pickupLocation'] ?? const LatLng(0, 0);
      dropoffLocation = args['dropoffLocation'] ?? const LatLng(0, 0);
      if (args['routePoints'] != null) {
        routePoints.value = List<LatLng>.from(args['routePoints']);
      }
    }
  }

  // --- ACTIONS ---
  void selectVehicle(int index) {
    selectedVehicleIndex.value = index;
  }

  void findDriver() {
    final bookingData = RideBookingData(
      pickupAddress: pickupAddress.value,
      dropoffAddress: dropoffAddress.value,
      pickupLat: pickupLocation.latitude,
      pickupLng: pickupLocation.longitude,
      dropoffLat: dropoffLocation.latitude,
      dropoffLng: dropoffLocation.longitude,
      rideType: "point-to-point",
      selectedVehicle: getVehicleName(selectedVehicleIndex.value),
      estimatedFare: "20.00", // Replace with actual fare calculation
      estimatedTime: "~44min.", // Replace with actual time
      estimatedDistance: "8.5 km", // Replace with actual distance
    );

    Get.toNamed(Routes.DRIVERS_LIST, arguments: bookingData);
  }

  void centerMapOnRoute() {
    mapController.fitCamera(
      CameraFit.bounds(
        bounds: LatLngBounds(pickupLocation, dropoffLocation),
        padding: const EdgeInsets.all(50),
      ),
    );
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
