import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:get/get.dart';
import 'package:latlong2/latlong.dart';

class MapsController extends GetxController {
  // Online/Offline status
  var isOnline = false.obs;

  // Show status banner temporarily
  var showStatusBanner = false.obs;
  Timer? _bannerTimer;

  // Map controller
  final MapController mapController = MapController();

  // Current driver location
  var currentLocation = const LatLng(
    19.4326,
    -99.1332,
  ).obs; // Mexico City center

  // Map markers
  var markers = <Marker>[].obs;

  // Map circles (zones)
  var circles = <CircleMarker>[].obs;

  // Current navigation index
  var currentNavIndex = 1.obs; // Maps is at index 1

  // Show ride requests
  var showRideRequests = false.obs;

  // Ride requests list
  var rideRequests = <RideRequest>[].obs;

  // TextEditingControllers for fare inputs
  final Map<String, TextEditingController> fareControllers = {};

  @override
  void onInit() {
    super.onInit();
    _initializeMap();
    _loadMockRideRequests();
  }

  void _initializeMap() {
    // Add driver marker (yellow pin at center)
    markers.add(
      Marker(
        point: currentLocation.value,
        width: 50,
        height: 50,
        child: const Icon(
          Icons.location_on,
          color: Color(0xFFFFC107),
          size: 50,
        ),
      ),
    );

    // Add circular zones
    circles.add(
      CircleMarker(
        point: currentLocation.value,
        radius: 80,
        useRadiusInMeter: true,
        color: Colors.grey.withOpacity(0.3),
        borderStrokeWidth: 2,
        borderColor: Colors.grey.withOpacity(0.5),
      ),
    );

    circles.add(
      CircleMarker(
        point: currentLocation.value,
        radius: 150,
        useRadiusInMeter: true,
        color: Colors.grey.withOpacity(0.2),
        borderStrokeWidth: 2,
        borderColor: Colors.grey.withOpacity(0.4),
      ),
    );
  }

  void _loadMockRideRequests() {
    rideRequests.value = [
      RideRequest(
        id: '1',
        passengerName: 'Esther Berry',
        passengerImage: 'https://i.pravatar.cc/150?img=1',
        pickupAddress: '7858 Swift Village',
        dropoffAddress: '105 William St, Chicago, US',
        estimatedTime: '15 min',
        fare: TextEditingController(),
      ),
      RideRequest(
        id: '2',
        passengerName: 'Esther Berry',
        passengerImage: 'https://i.pravatar.cc/150?img=1',
        pickupAddress: '7858 Swift Village',
        dropoffAddress: '105 William St, Chicago, US',
        estimatedTime: '15 min',
        fare: TextEditingController(),
      ),
      RideRequest(
        id: '3',
        passengerName: 'Esther Berry',
        passengerImage: 'https://i.pravatar.cc/150?img=1',
        pickupAddress: '7858 Swift Village',
        dropoffAddress: '105 William St, Chicago, US',
        estimatedTime: '15 min',
        fare: TextEditingController(),
      ),
    ];
    for (var request in rideRequests) {
      fareControllers[request.id] = request.fare;
    }
  }

  void toggleOnlineStatus() {
    isOnline.value = !isOnline.value;

    // Show status banner
    showStatusBanner.value = true;

    // Cancel existing timer if any
    _bannerTimer?.cancel();

    // Hide banner after 3 seconds
    _bannerTimer = Timer(const Duration(seconds: 3), () {
      showStatusBanner.value = false;
    });

    if (isOnline.value) {
      showRideRequests.value = true;

      // When online, add car markers to show nearby cars
      markers.add(
        Marker(
          point: LatLng(
            currentLocation.value.latitude + 0.002,
            currentLocation.value.longitude + 0.002,
          ),
          width: 40,
          height: 40,
          child: const Icon(Icons.directions_car, color: Colors.blue, size: 30),
        ),
      );
    }
  }

  void changeNavIndex(int index) {
    currentNavIndex.value = index;
  }

  void toggleRideRequests() {
    showRideRequests.value = !showRideRequests.value;
  }

  void acceptRideRequest(String requestId) {
    rideRequests.removeWhere((request) => request.id == requestId);
    // Navigate to ride details or update UI
  }

  void ignoreRideRequest(String requestId) {
    rideRequests.removeWhere((request) => request.id == requestId);
  }

  void centerToCurrentLocation() {
    mapController.move(currentLocation.value, 15);
  }

  @override
  void onClose() {
    _bannerTimer?.cancel();
    super.onClose();
  }
}

// Ride Request Model
class RideRequest {
  final String id;
  final String passengerName;
  final String passengerImage;
  final String pickupAddress;
  final String dropoffAddress;
  final String estimatedTime;
  final TextEditingController fare;
  final RxDouble timeLeft = 10.0.obs;

  RideRequest({
    required this.id,
    required this.passengerName,
    required this.passengerImage,
    required this.pickupAddress,
    required this.dropoffAddress,
    required this.estimatedTime,
    required this.fare,
  });
}
