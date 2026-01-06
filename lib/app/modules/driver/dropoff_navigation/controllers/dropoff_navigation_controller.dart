import 'package:flutter_map/flutter_map.dart';
import 'package:get/get.dart';
import 'package:latlong2/latlong.dart';
import 'package:flutter/material.dart';

class DropoffNavigationController extends GetxController {
  final MapController mapController = MapController();

  // Current driver location (at pickup point now)
  var currentLocation = const LatLng(19.4424, -99.1310).obs;
  
  // Drop-off location
  final LatLng dropoffLocation = const LatLng(19.4150, -99.1700);

  var markers = <Marker>[].obs;
  var polylines = <Polyline>[].obs;

  // Ride details
  final String dropoffAddress = 'Airport 123 lockwood';
  final String fullDropoffAddress = '105 William St, Chicago, US';
  final String distance = '1.4 Km';

  @override
  void onInit() {
    super.onInit();
    _initializeMap();
  }

  void _initializeMap() {
    // Add current location marker (driver at pickup)
    markers.add(
      Marker(
        point: currentLocation.value,
        width: 50,
        height: 50,
        child: const Icon(
          Icons.navigation,
          color: Color(0xFFC0A063),
          size: 40,
        ),
      ),
    );

    // Add drop-off marker
    markers.add(
      Marker(
        point: dropoffLocation,
        width: 50,
        height: 50,
        child: const Icon(
          Icons.location_pin,
          color: Colors.red,
          size: 40,
        ),
      ),
    );

    // Create route polyline to drop-off
    polylines.add(
      Polyline(
        points: [
          currentLocation.value,
          const LatLng(19.4350, -99.1400),
          const LatLng(19.4280, -99.1550),
          const LatLng(19.4200, -99.1650),
          dropoffLocation,
        ],
        strokeWidth: 4.0,
        color: const Color(0xFF2196F3),
      ),
    );
  }
}
