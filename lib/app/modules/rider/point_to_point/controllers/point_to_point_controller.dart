import 'dart:convert';
import 'package:apex/app/data/models/saved_place_model.dart';
import 'package:apex/app/data/services/saved_places_service.dart';
import 'package:apex/app/modules/rider/point_to_point/views/add_label_view.dart';
import 'package:apex/app/modules/rider/point_to_point/views/map_picker_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:http/http.dart' as http;
import '../../../../routes/app_pages.dart';

class PointToPointController extends GetxController {
  final SavedPlacesService _savedPlacesService = Get.find();
  final MapController mapController = MapController();
  final DraggableScrollableController sheetController =
      DraggableScrollableController();

  var sheetHeight = 0.55.obs;

  // -- Reactive Location Data --
  var pickupLocation = const LatLng(37.7749, -122.4194).obs;
  var dropoffLocation = Rxn<LatLng>();
  var routePoints = <LatLng>[].obs;
  var selectedLabel = Rxn<String>();
  List<SavedPlace> get savedPlaces => _savedPlacesService.savedPlaces;

  // -- Text Controllers --
  late TextEditingController pickupInput;
  late TextEditingController dropoffInput;

  @override
  void onInit() {
    super.onInit();
    pickupInput = TextEditingController(text: "Current Location");
    dropoffInput = TextEditingController();

    sheetController.addListener(() {
      sheetHeight.value = sheetController.size;
    });

    // Set default selected label to Home
    Future.delayed(const Duration(milliseconds: 100), () {
      if (savedPlaces.isNotEmpty && savedPlaces.any((p) => p.name == 'Home')) {
        selectedLabel.value = 'Home';
      }
    });

    // React to changes in pickup or dropoff location
    ever(pickupLocation, (_) => fetchRoute());
    ever(dropoffLocation, (_) => fetchRoute());
  }

  @override
  void onClose() {
    sheetController.dispose();
    pickupInput.dispose();
    dropoffInput.dispose();
    super.onClose();
  }

  // --- Navigation ---
  void goToRideSelection() {
    if (dropoffLocation.value == null) {
      // Show error or prompt to select destination
      return;
    }
    Get.toNamed(
      Routes.RIDE_SELECTION,
      arguments: {
        'pickupAddress': pickupInput.text,
        'dropoffAddress': dropoffInput.text,
        'pickupLocation': pickupLocation.value,
        'dropoffLocation': dropoffLocation.value,
        'routePoints': routePoints,
      },
    );
  }

  void goToScheduleRide() => Get.toNamed(Routes.SCHEDULE_RIDE);

  void goToAddLabel() async {
    Get.toNamed(Routes.ADD_LABEL);
  }

  void goToSelectPickup() async {
    final result = await Get.to<LatLng>(() => const MapPickerView());
    if (result != null) {
      selectedLabel.value = null;
      updatePickup(
        SavedPlace(
          name: 'Picked Location',
          location: result,
          address:
              '${result.latitude.toStringAsFixed(4)}, ${result.longitude.toStringAsFixed(4)}',
        ),
      );
    }
  }

  void goToSelectDropoff() async {
    final result = await Get.to<LatLng>(() => const MapPickerView());
    if (result != null) {
      selectedLabel.value = null;
      updateDestination(
        SavedPlace(
          name: 'Picked Location',
          location: result,
          address:
              '${result.latitude.toStringAsFixed(4)}, ${result.longitude.toStringAsFixed(4)}',
        ),
      );
    }
  }

  // --- Logic ---
  void updateDestination(SavedPlace place) {
    dropoffInput.text = place.name == 'Picked Location'
        ? place.address
        : place.name;
    dropoffLocation.value = place.location;
    if (place.name == 'Home' || place.name == 'Work') {
      selectedLabel.value = place.name;
    }
    centerMapOnRoute();
  }

  void updatePickup(SavedPlace place) {
    pickupInput.text = place.name == 'Picked Location'
        ? place.address
        : place.name;
    pickupLocation.value = place.location;
    centerMapOnRoute();
  }

  SavedPlace? getSavedPlace(String name) {
    try {
      return _savedPlacesService.savedPlaces.firstWhere((p) => p.name == name);
    } catch (e) {
      return null;
    }
  }

  Future<void> fetchRoute() async {
    if (dropoffLocation.value == null) {
      routePoints.clear();
      return;
    }
    final start = pickupLocation.value;
    final end = dropoffLocation.value!;
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

  void centerMapOnRoute() {
    if (dropoffLocation.value != null) {
      mapController.fitCamera(
        CameraFit.bounds(
          bounds: LatLngBounds(pickupLocation.value, dropoffLocation.value!),
          padding: const EdgeInsets.all(50),
        ),
      );
    } else {
      mapController.move(pickupLocation.value, 15);
    }
  }
}
