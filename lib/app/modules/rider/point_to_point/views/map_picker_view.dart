import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../../../../../common/widgets/maps/map_component.dart';
import '../../../../core/core.dart';
import '../controllers/search_location_controller.dart';

class MapPickerView extends GetView<SearchLocationController> {
  const MapPickerView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(SearchLocationController());
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.light,
      ),
      child: Scaffold(
        body: Stack(
          children: [
            // 1. Map Layer
            Obx(
              () => MapComponent(
                mapController: controller.pickerMapController,
                initialCenter: controller.tempPickedLocation.value,
                initialZoom: 15.0,
                onPositionChanged: (pos, hasGesture) {
                  if (hasGesture) {
                    controller.updatePickedLocation(pos.center!);
                  }
                },
              ),
            ),

            // 2. Fixed Center Pin
            Center(
              child: Padding(
                padding: const EdgeInsets.only(bottom: 40),
                child: Icon(
                  Icons.location_on,
                  color: R.theme.goldAccent,
                  size: 50,
                ),
              ),
            ),

            // 3. Back Button
            Positioned(
              top: 50,
              left: 20,
              child: InkWell(
                onTap: () => Get.back(),
                child: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: const BoxDecoration(
                    color: Colors.black54,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.arrow_back, color: Colors.white),
                ),
              ),
            ),

            // 4. Confirm Card at Bottom
            Positioned(
              bottom: 30,
              left: 20,
              right: 20,
              child: Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: R.theme.darkBackground,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
                      "Set location on map",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    const SizedBox(height: 16),
                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: () => Get.back(
                          result: controller.tempPickedLocation.value,
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: R.theme.goldAccent,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: const Text(
                          "Confirm Location",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
