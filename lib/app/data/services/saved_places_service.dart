import 'package:get/get.dart';
import 'package:latlong2/latlong.dart';
import 'package:apex/app/data/models/saved_place_model.dart';

class SavedPlacesService extends GetxService {
  // Default places
  final _defaultPlaces = [
    SavedPlace(
      name: 'Home',
      address: 'Set home location',
      location: const LatLng(37.7649, -122.4294),
      isDefault: true,
    ),
    SavedPlace(
      name: 'Work',
      address: 'Set work location',
      location: const LatLng(37.7949, -122.3994),
      isDefault: true,
    ),
  ];

  // Reactive list of all saved places
  late final RxList<SavedPlace> savedPlaces;

  SavedPlacesService() {
    savedPlaces = RxList<SavedPlace>.from(_defaultPlaces);
  }

  // Add a new custom place
  void addPlace(SavedPlace place) {
    savedPlaces.add(place);
  }

  // Add or update a place
  void addOrUpdatePlace(SavedPlace place) {
    final index = savedPlaces.indexWhere((p) => p.name == place.name);
    if (index != -1) {
      savedPlaces[index] = place;
    } else {
      savedPlaces.add(place);
    }
  }

  // Get a place by name
  SavedPlace? getPlace(String name) {
    return savedPlaces.firstWhereOrNull((p) => p.name == name);
  }
}
