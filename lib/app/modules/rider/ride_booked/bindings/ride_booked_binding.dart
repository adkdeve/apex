import 'package:get/get.dart';

import '../controllers/ride_booked_controller.dart';

class RideBookedBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RideBookedController>(
      () => RideBookedController(),
    );
  }
}
