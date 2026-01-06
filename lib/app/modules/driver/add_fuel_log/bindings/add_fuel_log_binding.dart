import 'package:get/get.dart';

import '../controllers/add_fuel_log_controller.dart';

class AddFuelLogBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AddFuelLogController>(
      () => AddFuelLogController(),
    );
  }
}


