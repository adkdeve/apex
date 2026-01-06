import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:get/get.dart';
import 'package:latlong2/latlong.dart';

class DuringRideController extends GetxController {
  final MapController mapController = MapController();

  // Pickup location
  final LatLng pickupLocation = const LatLng(19.4326, -99.1332);

  var markers = <Marker>[].obs;
  var isOnline = true.obs;

  // Timer for ride duration
  var timeLeft = '1h:52 min left'.obs;
  Timer? _rideTimer;

  // Request data
  late Map<String, dynamic> requestData;

  @override
  void onInit() {
    super.onInit();
    requestData = Get.arguments ?? _getDefaultData();
    _initializeMap();
    _startRideTimer();
  }

  @override
  void onClose() {
    _rideTimer?.cancel();
    super.onClose();
  }

  void _initializeMap() {
    markers.add(
      Marker(
        point: pickupLocation,
        width: 50,
        height: 50,
        child: const Icon(
          Icons.location_pin,
          color: Color(0xFFC0A063),
          size: 40,
        ),
      ),
    );
  }

  void _startRideTimer() {
    // Simulate countdown timer
    int totalMinutes = 112; // 1h 52 min
    _rideTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (totalMinutes > 0) {
        totalMinutes--;
        int hours = totalMinutes ~/ 60;
        int minutes = totalMinutes % 60;
        timeLeft.value =
            '${hours}h:${minutes.toString().padLeft(2, '0')} min left';
      } else {
        timer.cancel();
        timeLeft.value = '0h:00 min left';
      }
    });
  }

  Map<String, dynamic> _getDefaultData() {
    return {
      'passengerName': 'Esther Berry',
      'passengerImage': 'https://i.pravatar.cc/150?img=5',
      'pickupAddress': '7958 Swift Village',
      'vehicleName': 'Suzuki Alto',
      'licensePlate': 'APT 238',
      'pickupDate': '18-12-2025',
      'pickupTime': '32:32:00 PM',
      'hourlyRate': '\$100',
      'bookedHours': '3 hours',
      'scheduledEndTime': '2:30:00 PM',
      'estimatedTotal': '\$200.00',
      'note':
          'Extra time during the ride leads to extra charges in 30 minute blocks at the same rate.',
    };
  }

  void onEndRide() {
    // Handle end ride action
  }

  void toggleOnlineStatus() {
    isOnline.value = !isOnline.value;
  }
}
