import 'package:get/get.dart';

import '../controllers/drivers_list_controller.dart';

class DriversListBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DriversListController>(
      () => DriversListController(),
    );
  }
}
