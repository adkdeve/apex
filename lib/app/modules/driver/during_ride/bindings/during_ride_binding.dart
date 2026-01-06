import 'package:get/get.dart';

import '../controllers/during_ride_controller.dart';

class DuringRideBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DuringRideController>(() => DuringRideController());
  }
}
