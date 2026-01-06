import 'package:get/get.dart';

import '../controllers/hourly_reservation_controller.dart';

class HourlyReservationBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HourlyReservationController>(
      () => HourlyReservationController(),
    );
  }
}
