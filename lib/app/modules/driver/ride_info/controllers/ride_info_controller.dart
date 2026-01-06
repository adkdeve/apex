import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:get/get.dart';
import 'package:latlong2/latlong.dart';

class RideInfoController extends GetxController {
  final MapController mapController = MapController();

  final LatLng pickupLocation = const LatLng(19.4424, -99.1310);
  final LatLng dropoffLocation = const LatLng(19.4200, -99.1600);

  var markers = <Marker>[].obs;

  @override
  void onInit() {
    super.onInit();
    _addMarkers();
  }

  void _addMarkers() {
    markers.addAll([
      Marker(
        point: pickupLocation,
        width: 80,
        height: 80,
        child: const Icon(Icons.location_on, color: Colors.blue, size: 40),
      ),
      Marker(
        point: dropoffLocation,
        width: 80,
        height: 80,
        child: const Icon(Icons.location_on, color: Colors.red, size: 40),
      ),
    ]);
  }
}
