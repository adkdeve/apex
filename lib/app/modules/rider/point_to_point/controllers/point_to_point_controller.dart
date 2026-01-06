import 'dart:convert';
import 'package:apex/app/modules/rider/point_to_point/views/ride_selection_view.dart';
import 'package:apex/app/modules/rider/point_to_point/views/schedule_ride_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:http/http.dart' as http;

class PointToPointController extends GetxController {
  final MapController mapController = MapController();

  final DraggableScrollableController sheetController =
      DraggableScrollableController();

  var sheetHeight = 0.55.obs;

  final LatLng pickupLocation = const LatLng(37.7749, -122.4194);
  var dropoffLocation = const LatLng(37.7849, -122.4094).obs;
  var routePoints = <LatLng>[].obs;

  late TextEditingController pickupInput;
  late TextEditingController dropoffInput;

  @override
  void onInit() {
    super.onInit();
    pickupInput = TextEditingController(text: "Current Location");
    dropoffInput = TextEditingController();

    // Add listener to update button position when sheet moves
    sheetController.addListener(() {
      sheetHeight.value = sheetController.size;
    });

    fetchRoute();
  }

  @override
  void onClose() {
    sheetController.dispose(); // Clean up
    pickupInput.dispose();
    dropoffInput.dispose();
    super.onClose();
  }

  void selectSavedPlace(String place) {
    dropoffInput.text = place;
    if (place == "Home")
      updateDestination(const LatLng(37.7649, -122.4294));
    else if (place == "Office")
      updateDestination(const LatLng(37.7949, -122.3994));
  }

  void updateDestination(LatLng newDest) {
    dropoffLocation.value = newDest;
    mapController.move(pickupLocation, 13.5);
    fetchRoute();
  }

  void confirmRide() {
    // Pass location and address data to ride selection
    Get.to(
      RideSelectionView(),
      arguments: {
        'pickupAddress': pickupInput.text,
        'dropoffAddress': dropoffInput.text,
        'pickupLat': pickupLocation.latitude,
        'pickupLng': pickupLocation.longitude,
        'dropoffLat': dropoffLocation.value.latitude,
        'dropoffLng': dropoffLocation.value.longitude,
      },
    );
  }

  void scheduleRide() => Get.to(ScheduleRideView());

  Future<void> fetchRoute() async {
    final start = pickupLocation;
    final end = dropoffLocation.value;
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
      debugPrint("Error: $e");
    }
  }
}
