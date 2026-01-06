import 'package:get/get.dart';
import 'package:apex/app/data/models/place_model.dart';

class SearchController extends GetxController {
  var searchQuery = ''.obs;
  var filteredPlaces = <Place>[].obs;

  final List<Place> _allPlaces = [
    Place(
      name: 'Office',
      address: '2972 Westheimer Rd. Santa Ana, Illinois 85486',
      distance: '2.7km',
    ),
    Place(
      name: 'Coffee shop',
      address: '1901 Thornridge Cir. Shiloh, Hawaii 81063',
      distance: '1.1km',
    ),
    Place(
      name: 'Shopping center',
      address: '4140 Parker Rd. Allentown, New Mexico 31134',
      distance: '4.9km',
    ),
    Place(
      name: 'Shopping mall',
      address: '4140 Parker Rd. Allentown, New Mexico 31134',
      distance: '4.0km',
    ),
  ];

  @override
  void onInit() {
    super.onInit();
    filteredPlaces.value = _allPlaces;
  }

  void updateSearch(String query) {
    searchQuery.value = query;
    if (query.trim().isEmpty) {
      filteredPlaces.value = _allPlaces;
    } else {
      filteredPlaces.value = _allPlaces
          .where(
            (place) =>
                place.name.toLowerCase().contains(query.toLowerCase()) ||
                place.address.toLowerCase().contains(query.toLowerCase()),
          )
          .toList();
    }
  }

  void clearSearch() {
    searchQuery.value = '';
    filteredPlaces.value = _allPlaces;
  }

  void clearAllHistory() {
    filteredPlaces.clear();
  }

  void onSelectPlace(Place place) {
    Get.back(result: place.address);
  }

  void onBack() {
    Get.back();
  }
}
