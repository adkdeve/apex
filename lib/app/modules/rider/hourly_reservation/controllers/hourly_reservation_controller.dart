import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:get/get.dart';
import 'package:latlong2/latlong.dart';
import 'package:http/http.dart' as http; // Added http

import '../../../../../utils/helpers/snackbar.dart';
import '../../../../core/core.dart';
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

  // Added: Location Input Controllers (to display address text)
  late TextEditingController pickupInput;

  // --- Observables (State) ---
  var sheetHeight = 0.65.obs;

  // Map Data
  var pickupLocation = const LatLng(51.509364, -0.128928).obs; // Default: London
  // For Hourly, we might not have a dropoff, but we can track where the map is focused
  var mapCenter = const LatLng(51.509364, -0.128928).obs;
  var routePoints = <LatLng>[].obs; // Added: For drawing lines on map

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

    // Initialize Input Controllers
    durationController.text = "3"; // Default 3 hours
    passengersController.text = "1";
    pickupInput = TextEditingController(text: "Current Location");

    // Added: Listener for sheet animation
    sheetController.addListener(() {
      sheetHeight.value = sheetController.size;
    });

    // Added: Initial Route Fetch (Optional: could fetch route from garage to pickup)
    fetchRoute();
  }

  @override
  void onClose() {
    mapController.dispose();
    sheetController.dispose();
    durationController.dispose();
    passengersController.dispose();
    requestsController.dispose();
    pickupInput.dispose(); // Dispose new controller
    super.onClose();
  }

  // --- Actions ---

  // 1. Map & Location Updates
  void updatePickupLocation(LatLng newLocation) {
    pickupLocation.value = newLocation;
    mapController.move(newLocation, 14.0); // Move map camera
    fetchRoute(); // Recalculate if needed
  }

  // 2. Fetch Route Logic (Same as PointToPoint)
  Future<void> fetchRoute() async {
    // For Hourly, we might just want to show the pin,
    // but if you want a route (e.g., from a nearby hub to user), here is the logic:
    final start = pickupLocation.value;
    // Example: Route from slightly offset location to simulating "Driver Approach" or just redraw
    final end = LatLng(start.latitude + 0.01, start.longitude + 0.01);

    final url = Uri.parse(
      'http://router.project-osrm.org/route/v1/driving/${start.longitude},${start.latitude};${end.longitude},${end.latitude}?overview=full&geometries=geojson',
    );

    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['routes'] != null && data['routes'].isNotEmpty) {
          final geometry = data['routes'][0]['geometry']['coordinates'] as List;
          final List<LatLng> points = geometry
              .map((coord) => LatLng(coord[1].toDouble(), coord[0].toDouble()))
              .toList();
          routePoints.value = points;
        }
      }
    } catch (e) {
      debugPrint("Error fetching route: $e");
    }
  }

  // 3. Pick Date
  Future<void> pickDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate.value,
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
      builder: (context, child) {
        return Theme(
          data: ThemeData.dark().copyWith(
            colorScheme: ColorScheme.dark(
              primary: R.theme.secondary,
              onPrimary: R.theme.white,
              surface: const Color(0xFF1F1F1F),
              onSurface: R.theme.white,
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

  // 4. Pick Time
  Future<void> pickTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: selectedTime.value,
      builder: (context, child) {
        return Theme(
          data: ThemeData.dark().copyWith(
            colorScheme: ColorScheme.dark(
              primary: R.theme.secondary,
              onPrimary: R.theme.black,
              surface: const Color(0xFF1F1F1F),
              onSurface: R.theme.white,
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

  // 5. Select Vehicle
  void selectVehicle(int index) {
    selectedVehicleIndex.value = index;
  }

  // 6. Confirm Booking logic
  void confirmBooking() {
    if (durationController.text.isEmpty || passengersController.text.isEmpty) {
      SnackBarUtils.errorMsg("Please fill in all fields");
      return;
    }

    // Calculation Logic
    String rate = "\$100";
    String hours = "${durationController.text} hours";
    int total = 100 * (int.tryParse(durationController.text) ?? 0);
    String totalString = "\$${total},00";

    // Navigate and pass arguments (Added Map Coordinates)
    Get.to(
          () => const PricingSummaryView(),
      arguments: {
        'hourlyRate': rate,
        'bookedHours': hours,
        'estimatedTotal': totalString,
        'pickupLat': pickupLocation.value.latitude,
        'pickupLng': pickupLocation.value.longitude,
        'pickupAddress': pickupInput.text,
        'date': selectedDate.value.toString(),
        'time': selectedTime.value.format(Get.context!),
      },
    );
  }
}