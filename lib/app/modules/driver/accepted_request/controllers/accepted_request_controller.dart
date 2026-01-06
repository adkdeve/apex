import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:get/get.dart';
import 'package:latlong2/latlong.dart';
import '../../../../routes/app_pages.dart';

class AcceptedRequestController extends GetxController {
  final MapController mapController = MapController();

  // Pickup location
  final LatLng pickupLocation = const LatLng(19.4326, -99.1332);

  var markers = <Marker>[].obs;
  var isOnline = true.obs;

  // Request data (will be passed from previous screen)
  late Map<String, dynamic> requestData;

  @override
  void onInit() {
    super.onInit();
    // Get data passed from previous screen
    requestData = Get.arguments ?? _getDefaultData();
    _initializeMap();
  }

  void _initializeMap() {
    // Add pickup location marker
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

  Map<String, dynamic> _getDefaultData() {
    return {
      'type': 'Hourly Ride',
      'passengerName': 'Esther Berry',
      'passengerImage': 'https://i.pravatar.cc/150?img=5',
      'pickupAddress': '7958 Swift Village',
      'pickupDate': '18-12-2025',
      'pickupTime': '12:32:00 PM',
      'hourlyRate': '\$100',
      'bookedHours': '3 hours',
      'scheduledEndTime': '2:30:00 PM',
      'estimatedTotal': '\$200.00',
      'vehicleName': 'Suzuki Alto',
      'licensePlate': 'APT 238',
      'note':
          'Extra mile during the ride leads to extra charges in the same hence at the same rate',
    };
  }

  void onStartHourlyRide() {
    // Navigate to during ride screen with request data
    Get.toNamed(Routes.DURING_RIDE, arguments: requestData);
  }

  void toggleOnlineStatus() {
    isOnline.value = !isOnline.value;
  }
}
