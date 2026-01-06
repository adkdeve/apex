import 'package:get/get.dart';

import '../controllers/ride_info_controller.dart';

class RideInfoBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RideInfoController>(() => RideInfoController());
  }
}
