import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:latlong2/latlong.dart';
import 'package:get/get.dart';
import 'package:apex/app/data/models/saved_place_model.dart';
import 'package:apex/app/data/services/saved_places_service.dart';
import '../../../../routes/app_pages.dart';
import '../views/search_location_view.dart';

class AddLabelController extends GetxController {
  final SavedPlacesService _savedPlacesService = Get.find();

  // Reactive getter for saved places from the service
  List<SavedPlace> get savedPlaces => _savedPlacesService.savedPlaces;

  // 1. Navigation: Go to Search Screen
  void goToSearch() {
    Get.toNamed(Routes.SEARCH_LOCATION);
  }

  // 2. Action: Select a saved place (e.g., to set a destination)
  void selectPlace(SavedPlace place) {
    // This can be used to pass the selected place back to the previous screen
    Get.back(result: place);
  }

  // 3. Action: Select or Update a default place (Home/Work)
  void selectOrUpdatePlace(String label) async {
    final place = _savedPlacesService.getPlace(label);

    // If the place exists and is not a default placeholder
    if (place != null && !place.address.startsWith('Set')) {
      selectPlace(place);
    } else {
      // Navigate to map picker to get a new location
      final result = await Get.toNamed(Routes.MAP_PICKER);

      if (result is LatLng) {
        // Perform reverse geocoding
        final address = await _getPlacemarkFromCoordinates(result);

        if (address != null) {
          final newPlace = SavedPlace(
            name: label,
            address: address,
            location: result,
            isDefault: true,
          );
          _savedPlacesService.addOrUpdatePlace(newPlace);
        }
      }
    }
  }

  // 4. Helper: Reverse Geocoding
  Future<String?> _getPlacemarkFromCoordinates(LatLng coordinates) async {
    final url = Uri.parse(
      'https://nominatim.openstreetmap.org/reverse?format=json&lat=${coordinates.latitude}&lon=${coordinates.longitude}',
    );

    try {
      final response = await http.get(
        url,
        headers: {
          'User-Agent': 'com.example.apex', // Nominatim requires a user agent
        },
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['display_name'] != null) {
          return data['display_name'];
        }
      }
    } catch (e) {
      // Handle exceptions
      print('Error during reverse geocoding: $e');
    }
    return null;
  }
}
