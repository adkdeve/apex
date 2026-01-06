import 'package:get/get.dart';

import '../controllers/vehicle_checklist_controller.dart';

class VehicleChecklistBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<VehicleChecklistController>(
      () => VehicleChecklistController(),
    );
  }
}


