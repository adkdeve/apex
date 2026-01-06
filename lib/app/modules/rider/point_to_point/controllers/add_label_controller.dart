import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:apex/app/data/models/saved_place_model.dart';
import '../../../../../utils/helpers/snackbar.dart';
import '../views/map_picker_view.dart';
import '../views/search_location_view.dart';

class AddLabelController extends GetxController {
  // -- State for Map Picker --
  final MapController pickerMapController = MapController();
  final TextEditingController placeNameController = TextEditingController();

  // Track the center of the map picker
  var tempPickedLocation = const LatLng(37.7749, -122.4194);

  // -- List of Saved Places (Reactive) --
  var savedPlaces = <SavedPlace>[].obs;

  @override
  void onClose() {
    placeNameController.dispose();
    super.onClose();
  }

  // 1. Navigation: Go to Search Screen
  void goToSearch() {
    Get.to(() => const SearchLocationView());
  }

  // 2. Navigation: Go to Map Picker
  void goToMapPicker() {
    placeNameController.clear(); // Reset input
    Get.to(() => const MapPickerView());
  }

  // 3. Logic: Update temp location when map drags
  void updatePickedLocation(LatLng pos) {
    tempPickedLocation = pos;
  }

  // 4. Logic: Confirm and Save
  void confirmPickedLocation() {
    if (placeNameController.text.isEmpty) {
      SnackBarUtils.errorMsg("Please name this location");
      return;
    }

    // Add to list
    savedPlaces.add(
      SavedPlace(
        name: placeNameController.text,
        location: tempPickedLocation,
        address:
            "${tempPickedLocation.latitude.toStringAsFixed(4)}, ${tempPickedLocation.longitude.toStringAsFixed(4)}",
      ),
    );

    // Go back to the main Add Label screen (pop twice: MapPicker -> Search -> AddLabel)
    Get.close(2);

    SnackBarUtils.successMsg("Location saved!");
  }
}
