import 'package:apex/app/modules/rider/point_to_point/controllers/schedule_ride_controller.dart';
import 'package:get/get.dart';

class ScheduleRideBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ScheduleRideController>(
          () => ScheduleRideController(),
    );
  }
}
