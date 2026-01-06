import 'package:get/get.dart';

import '../controllers/rate_driver_controller.dart';

class RateDriverBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RateDriverController>(
      () => RateDriverController(),
    );
  }
}
