import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:apex/app/data/models/saved_place_model.dart';
import 'package:apex/app/data/services/saved_places_service.dart';
import '../../../../../utils/helpers/snackbar.dart';
import '../views/map_picker_view.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class SearchLocationController extends GetxController {
  final SavedPlacesService _savedPlacesService = Get.find();

  // -- State for Map Picker --
  final MapController pickerMapController = MapController();
  final TextEditingController placeNameController = TextEditingController();
  final TextEditingController searchInputController = TextEditingController();

  // Track the center of the map picker
  var tempPickedLocation = const LatLng(37.7749, -122.4194).obs;
  var searchResults = <dynamic>[].obs;

  @override
  void onInit() {
    super.onInit();
    searchInputController.addListener(() {
      if (searchInputController.text.length > 2) {
        debounce(
          // This is a dummy obs to use the debounce feature
          // The actual value is taken from the controller
          0.obs,
          (_) => searchPlaces(searchInputController.text),
          time: const Duration(milliseconds: 600),
        );
      } else {
        searchResults.clear();
      }
    });
  }

  @override
  void onClose() {
    placeNameController.dispose();
    searchInputController.dispose();
    pickerMapController.dispose();
    super.onClose();
  }

  // 1. Navigation: Go to Map Picker
  void goToMapPicker() async {
    placeNameController.clear();
    // Reset temp location to a default or user's current location
    tempPickedLocation.value = const LatLng(37.7749, -122.4194);
    final result = await Get.to<LatLng>(
      () => const MapPickerView(),
      arguments: {'initialZoom': 15.0},
    );

    if (result != null) {
      final address = await _getAddressFromLatLng(result);
      final newPlace = SavedPlace(
        name: address,
        location: result,
        address: address,
      );
      _savedPlacesService.addPlace(newPlace);
      Get.back(); // Go back from SearchLocationView to AddLabelView
      SnackBarUtils.successMsg("Location '$address' saved!");
    }
  }

  // 2. Logic: Update temp location when map drags
  void updatePickedLocation(LatLng pos) {
    tempPickedLocation.value = pos;
  }

  // 3. Logic: Confirm and Save Picked Location
  void confirmPickedLocation() {
    final name = placeNameController.text;
    if (name.isEmpty) {
      SnackBarUtils.errorMsg("Please name this location");
      return;
    }

    final newPlace = SavedPlace(
      name: name,
      location: tempPickedLocation.value,
      address:
          "${tempPickedLocation.value.latitude.toStringAsFixed(4)}, ${tempPickedLocation.value.longitude.toStringAsFixed(4)}",
    );

    _savedPlacesService.addPlace(newPlace);

    // Go back to the main Add Label screen
    Get.back(); // Close map picker
    Get.back(); // Close search location screen

    SnackBarUtils.successMsg("Location '$name' saved!");
  }

  Future<void> searchPlaces(String query) async {
    final url = Uri.parse(
      'https://nominatim.openstreetmap.org/search?q=$query&format=json&addressdetails=1',
    );
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        searchResults.value = json.decode(response.body);
      }
    } catch (e) {
      debugPrint("Error searching places: $e");
    }
  }

  Future<String> _getAddressFromLatLng(LatLng latLng) async {
    final url = Uri.parse(
      'https://nominatim.openstreetmap.org/reverse?format=json&lat=${latLng.latitude}&lon=${latLng.longitude}',
    );
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return data['display_name'] ?? 'Unknown Location';
      }
    } catch (e) {
      debugPrint("Error getting address: $e");
    }
    return 'Unknown Location';
  }

  // 4. Logic: Select a search result (mocked)
  void selectSearchResult(dynamic place) async {
    final lat = double.parse(place['lat']);
    final lon = double.parse(place['lon']);
    final location = LatLng(lat, lon);
    final address = place['display_name'] ?? 'Unknown Location';

    final newPlace = SavedPlace(
      name: address,
      location: location,
      address: address,
    );

    _savedPlacesService.addPlace(newPlace);
    Get.back(); // Go back from SearchLocationView to AddLabelView
    SnackBarUtils.successMsg("Location '$address' saved!");
  }
}
