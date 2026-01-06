import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:get/get.dart';
import 'package:latlong2/latlong.dart';

class ActiveRideController extends GetxController {
  final MapController mapController = MapController();

  // Current driver location
  var currentLocation = const LatLng(19.4200, -99.1600).obs;

  // Pickup location
  final LatLng pickupLocation = const LatLng(19.4424, -99.1310);

  // Drop-off location
  final LatLng dropoffLocation = const LatLng(19.4150, -99.1700);

  var markers = <Marker>[].obs;
  var polylines = <Polyline>[].obs;

  // Ride details
  final String pickupAddress = '78347 swift village';
  final String dropoffAddress = '105 William St, Chicago, US';
  final String distance = '1.4 Km';
  final String estimatedTime = '5 mins';

  @override
  void onInit() {
    super.onInit();
    _initializeMap();
  }

  void _initializeMap() {
    // Add current location marker
    markers.add(
      Marker(
        point: currentLocation.value,
        width: 50,
        height: 50,
        child: const Icon(Icons.navigation, color: Color(0xFFC0A063), size: 40),
      ),
    );

    // Add pickup marker
    markers.add(
      Marker(
        point: pickupLocation,
        width: 50,
        height: 50,
        child: const Icon(Icons.location_pin, color: Colors.red, size: 40),
      ),
    );

    // Create route polyline
    polylines.add(
      Polyline(
        points: [
          currentLocation.value,
          const LatLng(19.4250, -99.1500),
          const LatLng(19.4350, -99.1400),
          pickupLocation,
        ],
        strokeWidth: 4.0,
        color: const Color(0xFF2196F3),
      ),
    );
  }
}
